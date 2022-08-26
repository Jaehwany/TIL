-- [3]검색하기(select)
-- [형식]
-- select [distinct] [컬럼1,컬럼2,.....][as 별명][*]  --- 6
-- from 테이블명     --- 1
-- [where 조건절]    --- 2
-- [group by컬럼명]  --- 3
-- [having 조건절]   --- 4
-- [order by 컬럼명 asc|desc ]  --- 5

-- [조건]
-- distinct: 중복제거
-- *: 모든
-- 조건절 : and,or,like,in,between and,is null,is not null

-- [연산자]
-- =  : 같다
-- !=,  ^=,  <> : 같지않다
-- >=, <=, >, < : 크거나같다,작거나같다,크다,작다
-- and, or, between and, in, like, is null/is not null

-- [정렬]
-- order by 정렬방법
--          asc  - 오름차순(생략가능)
--          desc - 내림차순
-- 컬럼명 : 숫자로도 가능

-- [그룹과 조건]
-- group by : 그룹함수(max,min,sum,avg,count..)와 같이 사용
-- having : 묶어놓은 그룹의 조건절


use ssafydb;

-- 모든 사원의 모든 정보 검색.
select *
from employees;

-- 사원이 근무하는 부서의 부서번호 검색.(중복o)
select department_id
from employees;

-- 사원이 근무하는 부서의 부서번호 검색.(중복제거)
select distinct department_id
from employees;

-- 회사에 존재하는 모든 부서.
select department_id
from departments;

-- 모든 사원의 사번, 이름, 급여 검색.
select employee_id,first_name,salary
from employees;

-- 모든 사원의 사번, 이름, 급여, 급여 * 12 (연봉) 검색.
select employee_id 사번, first_name "이 름", salary as 급여, salary*12 연봉
from employees;

-- 모든 사원의 사번, 이름, 급여, 급여 * 12 (연봉), 커미션, 커미션포함 연봉 검색.
select employee_id 사번, first_name "이 름", salary as 급여, salary*12 연봉, ifnull(commission_pct,0) "커미션",salary *(1+ ifnull(commission_pct,0))*12 "커미션포함연봉"
from employees;

-- 연결연산자(concat): 컬럼을 연결해서 출력
-- 일반적인 DBMS에서는 ||로 문자열을 연결하지만 MySQL에서는 ||을 사용할수 없다. 
-- concat()사용해야 한다.
-- first_name과  last_name을 연결해서 출력하시오
select concat(first_name,concat('  ',last_name)) as "이  름"
from employees;

-- 모든 사원의 사번, 이름, 급여, 급여에 따른 등급표시 검색.
-- 급여에 따른 등급
--   15000 이상 “고액연봉“      
--   8000 이상 “평균연봉”      
--   8000 미만 “저액연봉＂
select employee_id,first_name,salary,
	case when salary >= 15000
		then '고액연봉'
        when salary >= 8000
        then '평균연봉'
        else '저액연봉'
	end 등급
from employees;

-- 부서번호가 50인 사원중 급여가 7000이상인 사원의
-- 사번, 이름, 급여, 부서번호
select employee_id,first_name,salary, department_id
from employees
where department_id=50
and salary >= 7000;

-- 근무 부서번호가 50, 60, 70에 근무하는 사원의 사번, 이름, 부서번호
select employee_id,first_name,salary, department_id
from employees
where department_id=50
or department_id=60
or department_id=70;

select employee_id,first_name,salary, department_id
from employees
where department_id in(50,60,70);

-- 근무 부서번호가 50, 60, 70이 아닌 사원의 사번, 이름, 부서번호
select employee_id,first_name,salary, department_id
from employees
where department_id!=50
or department_id!=60
or department_id!=70;

select employee_id,first_name,salary, department_id
from employees
where department_id not in(50,60,70);

-- 급여가 6000이상 10000이하인 사원의 사번, 이름, 급여
select employee_id,first_name,salary, department_id
from employees
where salary >= 6000
and salary <=10000;

select employee_id,first_name,salary, department_id
from employees
where salary between 6000 and 10000;

-- 근무 부서가 지정되지 않은(알 수 없는) 사원의 사번, 이름, 부서번호 검색.
select employee_id,first_name,salary, department_id
from employees
where department_id=null;

-- 커미션을 받는 사원의 사번, 이름, 급여, 커미션
select employee_id,first_name,salary, department_id
from employees
where commission_pct is not null;

-- 커미션을 받지 않는 사원들의 이름과 급여,커미션을 출력하시오 -- 72건
select last_name,salary,commission_pct
from employees
where commission_pct is null;

-- 사원의 모든 컬럼을 표시하시오
select * 
from employees
where last_name='King'; -- 문자열 검색할 때 대.소문자를 구분         

select *
from employees
where upper(last_name)='KING'; -- 문자열을 대문자로

select *
from employees
where lower(last_name)='king';   -- 문자열을 소문자로

-- 이름에 'x'가 들어간 사원의 사번, 이름
select employee_id,first_name,salary, department_id
from employees
where first_name like '%x%';

-- 이름의 끝에서 3번째 자리에 'x'가 들어간 사원의 사번, 이름
select employee_id,first_name,salary, department_id
from employees
where first_name like '%x__';

-- 모든 사원의 사번, 이름, 급여
-- 단 급여순 정렬(내림차순)
select employee_id,first_name,salary, department_id
from employees
order by salary desc;


-- case [value] when  표현식  then  구문1
--              when  표현식  then  구문2
--                       :
--              else  구문3
-- end

-- 업무 id가 'SA_MAN'또는'SA_REP'이면 'Sales Dept' 그 외 부서이면 'Another'로 표시
-- 조건) 분류별로 내림차순정렬
--        직무          분류
--       --------------------------
--       SA_MAN    Sales Dept
--       SA_REP    Sales Dept
--       IT_PROG   Another
select job_id as "직무",
       case job_id when 'SA_MAN' then 'Sales Dept'
                   when 'SA_REP' then 'Sales Dept'
                   else               'Another'
       end as "분류"
from employees
order by 2 desc;       

-- 급여가 10000미만이면 초급, 20000미만이면 중급 그 외이면 고급을 출력하시오 
-- 조건1) 컬럼명은  '구분'으로 하시오
-- 조건2) 제목은 사원번호, 사원명, 구  분
-- 조건3) 구분(오름차순)으로 정렬하고, 구분값이 같으면 사원명(오름차순)으로 정렬하시오
select employee_id as "사원번호", last_name as "사원명",
       case when salary < 10000 then '초급'
            when salary < 20000 then '중급'
            else '고급' 
       end as "구분"
 from employees
 order by 3, 2;



-- group by: 그룹함수(max,min,sum,avg,count..)와 같이 사용
-- having: 묶어놓은 그룹의 조건절

-- 부서별 급여평균을 구해서 평균급여가  6000이상인 부서만 출력  (8건)
-- (평균급여는 소수점 이하 절삭)
--      부서ID   평균급여
--     -----------------------
--        NULL    7000
--        20      9500
select department_id, floor(avg(salary))
from employees
group by department_id
having avg(salary)>=6000;


-- 부서별 급여평균을 구하시오 (9건)
--    조건1) 소수이하는 반올림
--    조건2) 세자리마다콤마, 화페단위 ￦를 표시
--    조건3)  부서코드        평균급여
--           ---------------------------
--            NULL    ￦7,000
--            20      ￦9,500
--    조건4) 부서별로 오름차순정렬하시오 
--    조건5) 평균급여가 5000이상인 부서만 표시하시오

select  department_id as "부서코드",
        concat('￦', format(round(avg(salary),0),0)) as "평균급여"
from employees  
group by department_id
having avg(salary)>=5000
order by department_id asc;  


-- having절 (where + group by + having)
-- 10과 20 부서에서 최대급여를 받는사람의 급여를 구하시오.  --1건
-- [조건1] 부서별로 오름차순 정렬하시오
-- [조건2] 최대급여가 5000이상인 부서만 출력하시오
--         department_id     max_salary
--         -----------------------------------
--           20               13000 
select department_id, max(salary) as "max_salary"
from employees
where department_id in(10,20)  
group by department_id
having max(salary)>=5000
order by 2 asc;

