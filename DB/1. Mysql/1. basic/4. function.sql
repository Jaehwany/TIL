-- [10]내장 함수
-- 1. 숫자함수 : mod(나머지), round(반올림), trunc(내림), ceil(올림),truncate(숫자를 기준으로 버림)
-- 2. 문자함수 : lower, upper, length, substr, ltrim, rtrim, trim
-- -----------------------------------------------------------------

-- ex1)절댓값:abs
select abs(-5), abs(0), abs(+5)
from dual;

-- ex2)10을 3으로 나눈 나머지 구하시오(mod)
select mod(10,3) from dual;   -- dual:가상테이블

-- ex3)올림(ceil)
select ceil(12.2), ceiling(12.2), ceil(-12.2), ceiling(-12.2)
from dual;

-- ex4) 내림(foor)
select floor(12.6), floor(-12.2)
from dual;

-- ex4)반올림(round)
select round(1526.159), round(1526.159, 0), round(1526.159, 1), 
round(1526.159, 2), round(1526.159, -1), round(1526.159, -3)
from dual;

-- ex4)숫자를 기준으로 버림(truncate)
select truncate(1526.159, 0), truncate(1526.159, 1), truncate(1526.159, 2), 
truncate(1526.159, -1), truncate(1526.159, -3)
from dual;

-- ex4.5) format(컬럼명,소수점이하 자리수) : 소수이하는 절삭,세자리마다 콤마(,)
select format(avg(salary),0) as "사원급여평균"
from employees;

-- ex5)거듭제곱(pow)
select pow(2,3), power(2,3)
from dual;

-- ex6)나머지(mod)
select mod(8, 3), 8 % 3
from dual;

-- ex7)최댓값(greatest), 최솟값(least)
select greatest(4, 3, 7, 5, 9), least(4, 3, 7, 5, 9)
from dual;

-- ex8)Ascii코드
select ASCII('0'), ASCII('A'), ASCII('a')
from dual;

-- ex9)100번 사원의 이름 Steven King
select concat(employee_id, '번 사원의 이름 ', first_name,' ' , last_name)
from employees
where employee_id = 100;

-- ex10)hello ssafy !!!
select insert('helloabc!!!', 6, 0, ' ssafy ')
from dual;

-- ex11) 바꾸기(replace)
select replace('helloabc!!!', 'abc', ' ssafy ')
from dual;

-- ex12) 문자열의 위치(instr)
select instr('hello ssafy !!!', 'ssafy')
from dual;

-- ex13)위치부터 갯수만큼리턴(mid, substring)
select mid('hello ssafy !!!', 7, 5), substring('hello ssafy !!!', 7, 5)
from dual;

-- ex14)반대로 나열(reverse)
select reverse('!!! yfass olleh')
from dual;

-- ex15)소문자로 바꾸기(lower, lcase)
select lower('hELlo SsaFy !!!'), lcase('hELlo SsaFy !!!')
from dual;

-- ex16)대문자로 바꾸기(upper, ucase)
select upper('hELlo SsaFy !!!'), ucase('hELlo SsaFy !!!')
from dual;

-- ex17)왼쪽에서 개수만큼추출(left),  오른쪽에서 개수만큼추출(right)
select left('hello ssafy !!!', 5), right('hello ssafy !!!', 6)
from dual;

-- ex18)
select now(), sysdate(), current_timestamp()
from dual;

-- ex19)
select curdate(), current_date(), curtime(), current_time()
from dual;

-- ex20)
select now() 현재시간, 
date_add(now(), interval 5 second) 5초후,
date_add(now(), interval 5 hour) 5시간후, 
date_add(now(), interval 5 day) 5일후
from dual;

-- ex21)
select year(now()), month(now()), monthname(now()), 
dayname(now()), dayofmonth(now()), dayofweek(now()), 
weekday(now()), dayofyear(now()), week(now())
from dual;

-- ex22)
select now(), 
date_format(now(), '%Y %M %e %p %l %i %S'),
date_format(now(), '%y-%m-%d %H:%i:%s'),
date_format(now(), '%y.%m.%d %W'), 
date_format(now(), '%H시%i분%s초')
from dual;

-- ex23)if(논리식, 값1, 값2): 논리식이 참이면 값1이 리턴, 거짓이면 값2 리턴
--     ifnull(값1, 값2): 값1이 NULL이면 값2로 대치, NULL이 아니면 값1리턴
--     nullif(값1, 값2): 값1 = 값2이 TRUE이면 NULL이 그렇지 않으면 값1이 리턴
select if(3 > 2, '크다', '작다'), if(3 > 5, '크다', '작다'),
nullif(3, 3), nullif(3, 5),
ifnull(null, 'b'), ifnull('a', 'b')
from dual;

-- ex24)사원의 총수, 급여의 합, 급여의 평균, 최고급여, 최저급여
select count(employee_id), sum(salary), avg(salary), 
max(salary), min(salary)
from employees;

-- -----------------------------------------------------------------
-- [11]문제풀기
-- 1)테이블명 : student
-- idx, 숫자(5), 기본키, 자동값증가 / name, 문자(10), 널허용X / kor, 숫자(5) / eng, 숫자(5) / mat, 숫자(5)
drop table student;
show tables;

create table student(
idx int(5) primary key auto_increment,
name varchar(10) not null,
kor int(5),
eng int(5),
mat int(5));

-- 2)데이타 : 둘리, 90, 80,95
--         또치, 75, 90,65
--         고길동, 100,95,90
--         마이콜, 60,60,60
--         도우넛, 75,80,75
--         희동이, 80,78,90
-- idx는 자동으로 1씩증가값을 넣으시오
insert into student(name, kor,eng,mat) values('둘리', 80, 80, 95);
insert into student(name, kor,eng,mat) values('또치', 75,90,65);
insert into student(name, kor,eng,mat) values('고길동', 100,95,90);
insert into student(name, kor,eng,mat) values('마이콜', 60,60,60);
insert into student(name, kor,eng,mat) values('도우넛', 75,80,75);
insert into student(name, kor,eng,mat) values('희동이', 80, 78, 90);
commit;

select * from student;

-- 3)select문으로 다음과 같이 출력하시오
-- 조건1)평균별 내림차순 정렬하시오
-- 조건2)평균은 소수점이하 2째자리까지 출력하시오
-- 조건3)타이틀은 아래와 같이 처리해 주시오

-- 학번     이름    국어   영어   수학    총점   평균
-- -----------------------------------------------------
--  1      둘리    90     80     96       266    88.66
select idx as "학번", name as "이름", kor as "국어", eng as "영어", mat as "수학", 
       (kor+eng+mat) as "총점", 
       round((kor+eng+mat)/3, 2)  as "평균" 
from student         
order by 7 desc;








