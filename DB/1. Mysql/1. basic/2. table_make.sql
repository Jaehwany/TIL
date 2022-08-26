-- [2] 테이블 생성/수정/복사 
-- 1.테이블생성
-- create table 테이블명(컬럼명1   컬럼타입  [제약조건],컬럼명2  컬럼타입  [제약조건],.....);

--  -  문자로 시작: 영문 대소문자,숫자,특수문자( _ , $ , # ),한글
--  -  중복되는 이름은 사용안됨
--  -  예약어(create, table, column등)은 사용할수 없다

--  -  자료형
--    varchar(M):  문자,문자열(가변형) ==> M은 1~255
--    char(M)   :  문자,문자열(고정형) ==> M은 1~65535
--    text(M)   :  문자,문자열        ==> 최대 65535 
--    int(M)    :  정수형 숫자
--    float / double(M,D) : 실수형 숫자
--    datetime :    YYYY-MM-DD HH:MM:SS('1001-01-01 00:00:00' ~ '9999-12-31 23:59:59')
--    timestamp(M) : 1970-01-01 ~ 2037년 임의 시간(1970-01-01 00:00:00 를 0으로 해서 1초단위로 표기

--  - 제약조건
--     not null:  해당컬럼에 NULL을 포함되지 않도록 함 
--     unique:  해당컬럼 또는 컬럼 조합값이 유일하도록 함
--     primary key: 각 행을 유일하게 식별할수 있도록함(P.K:기본키)
--     foreign key: references를 이용하여 어떤 컬럼에 어떤 데이터를 참조하는지 반드시 지정(F.K:참조키,외래키)
--     default: NULL값이 들어올 경우 기본 설정되는 값을 지정
--     check : 해당컬럼에 특정 조건을 항상 만족시키도록함
--             MySQL의 경우 작성은 가능하지만(에러발생 x) 적용은 안됨

--     [참고]  primary key = unique + not null

--     ex)       idx          int          auto_increment    자동 값증가   
--               userid       varchar(16)  not null          아이디 
--               username     varchar(20)                    이름
-- 	             userpwd      varchar(16)                    비밀번호
--               emailid      varchar(16)                    이메일아이디
--               emaildomain  varchar(16)                    이메일도메인
--               joindate     timestamp    current_timestamp 가입일 
-- -----------------------------
-- 2.테이블수정
-- (1)테이블 내용 수정
-- alter  table 테이블명 
-- add    컬럼명  데이터타입 [제약조건]
-- add    constraint  제약조건명  제약조건타입(컬럼명)
-- modify 컬럼명 데이터타입 
-- drop   column  컬럼명 [cascade constraints]
-- drop   primary key [cascade] | union (컬럼명,.....) [cascade] .... | constraint 
-- 제약조건명 [cascade]

-- (2)테이블 이름변경
-- alter table  기존테이블명  rename to  새테이블명
-- rename  기존테이블명  to 새테이블명

-- (3)테이블 컬럼이름 변경
-- alter table 테이블명 rename column  기존컬럼명 to 새컬럼명
-- alter table 테이블명 rename constraint 기존제약조건명 to 새제약조건명
-- ---------------------------------------------------------------------------------
-- [4]추가하기: insert
-- : 테이블에 데이터(새로운 행)추가 -- 행의 수가 변경

-- insert into 테이블명 [ (column1, column2, .....)]   values (value1,value2,.....)
--  -  column과 values의 순서일치
--  -  column과 values의 개수 일치
-- ---------------------------------------------------------------------------------
-- [5]수정하기: update
-- : 테이블에 포함된 기존 데이터수정 -- 행의 수가 변경되지 않음
--   전체 데이터 건수(행수)는 달라지지 않음
--   조건에 맞는 행(또는 열)의 컬럼값을 갱신할수 있다

-- update 테이블명  set  컬럼명1=value1, 컬럼명2=value2 ..... [where  조건절]
--   - where 이 생략이 되면 전체행이 갱신
--   - set절은 서브쿼리사용가능, default옵션 사용가능 
-- ---------------------------------------------------------------------------------
-- [6]삭제하기:delete
--  : 테이블에 포함된 기존데이터를 삭제  -- 행의 수가 변경
--    행 단위로 삭제되므로 전체행수가 달라짐
   
-- delete [from] 테이블명 [where  조건절];
-- - where을 생략하면 전체행이 삭제됨
--  - 데이터는 삭제되고 테이블 구조는 유지됨

use ssafydb;
-- 회원 정보 table 생성.
-- table name : ssafy_member
-- column
-- idx			int			auto_increments		PK
-- userid		varchar(16)	not null
-- username		varchar(20)
-- userpwd		varchar(16)
-- emailid		varchar(20)
-- emaildomain	varchar(50)
-- joindate		timestamp	default	current_timestamp

create table member(
	idx			int			auto_increment,
    userid		varchar(16)	not null,
	username	varchar(20),
	userpwd		varchar(16),
	emailid		varchar(20),
	emaildomain	varchar(50),
	joindate	timestamp	default	current_timestamp,
	primary key(idx)
);

select *
from member;

-- 회원 정보 등록
-- 'kimssafy', '김싸피', '1234', 'kimssafy', 'ssafy.com' 등록시간
insert into member(userid, username,userpwd,emailid,emaildomain,joindate)
values ('kimssafy', '김싸피', '1234', 'kimssafy', 'ssafy.com', now());

-- '최싸피','choissafy', '1234' 
insert into member(username, userid, userpwd)
values ('최싸피','choissafy', '1234' );

select *
from member;

-- '이싸피', 'leessafy', '1234'
-- '박싸피', 'parkssafy', '9876'

insert into member(username, userid, userpwd)
values ('이싸피', 'leessafy', '1234'),
	   ('박싸피', 'parkssafy', '9876');

select *
from member;

-- userid가 kimssafy인 회원의 비번을 9876, 이메일 도메인을 ssafy.co.kr으로 변경.
update member
set userpwd='9876', emaildomain='ssafy.co.kr'
where userid='kimssafy';

commit;

rollback;
-- userid가 kimssafy 회원 탈퇴
delete from member
where userid = 'kimssafy';



- ex2) departments, locations2테이블로 test2테이블을 만드시오
--
--       departments(location_id) , locations2(loc_id)      
--      부서ID    부서명             도시
--      -----------------------------------------------------
--      60	      IT	             Southlake
--      50	     Shipping	         South San Francisco
--      10	     Administration	     Seattle
create table test2
as select department_id as "부서ID", department_name as "부서명", city as "도시"
    from departments
    left join locations2 on(location_id = loc_id);


-- ex3) employees테이블로 test3테이블을 만드시오
-- [조건1] self 조인을 이용하여 사원과 관리자를 연결하시오
-- [조건2] 모든 사원을 표시하시오
--
--        사원번호   사원이름      관리자
--        ----------------------------------
--        101          Kochhar       King   
create table test3
as select e.employee_id as "사원번호", e.last_name as "사원이름", m.last_name as "관리자"
    from employees e
    left join employees m on(e.manager_id = m.employee_id);

-- ex4)employees테이블로 test4테이블을 만드시오
-- [조건1] 업무 id가 'SA_MAN'또는 ‘SA_REP'이면 'Sales Dept' 그 외 부서이면 'Another'로 표시
-- [조건2] case when을 이용하여 완성하시오
--        직무          분류
--       --------------------------
--       SA_MAN      Sales Dept
--       SA_REP      Sales Dept
--       IT_PROG      Another
create table test4
as select job_id as "직무", 
          case job_id when 'SA_MAN' then 'Sales Dept'
                      when 'SA_REP' then 'Sales Dept'
                      else               'Another'
          end as "분류"
   from employees;



    
