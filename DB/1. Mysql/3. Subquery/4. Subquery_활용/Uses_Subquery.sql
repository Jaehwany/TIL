-- ※ 스칼라 서브 쿼리 (Scalar Subquery)
-- 서브 쿼리를 이용해서 CREATE, INSERT, UPDATE, DELETE를 할수 있다.

-- -------------------------------------------------------------------
-- 서브쿼리를 이용한 create.
-- employees table을 emp_copy라는 이름으로 복사(컬럼 이름 동일).
create table emp_copy
select * from employees;

-- employees table의 구조만 emp_blank라는 이름으로 생성(컬럼 이름 동일).
create table emp_blank
select * from employees
where 1 = 0;

-- 50번 부서의 사번(eid), 이름(name), 급여(sal), 부서번호(did)만 emp50이라는 이름으로 생성.
create table emp50
select employee_id eid, first_name name, salary sal, department_id did
from employees
where department_id = 50;

-- 서브쿼리를 이용한 insert.
-- employees table에서 부서번호가 80인 사원의 모든 정보를 emp_blank에 insert
insert into emp_blank
select * from employees
where department_id = 80;

-- 서브쿼리를 이용한 update.
-- employees table의 모든 사원의 평균 급여보다 적게 받는 emp50 table의 사원의 급여를 500 인상.
update emp50
set sal = sal + 500
where sal < (select avg(salary) from employees);

-- 서브쿼리를 이용한 delete.
-- employees table의 모든 사원의 평균 급여보다 적게 받는 emp50 table의 사원은 퇴사.
delete from emp50
where sal < (select avg(salary) from employees);
-- -------------------------------------------------------------------


-- -------------------------------------------------------------------
-- employees table을 emp_copy라는 이름으로 복사 하시오
-- (단, 컬럼 이름은 동일하게 복사한다)
create table emp_copy
select * from employees;

show tables;
select * from emp_copy;

-- employees table의 구조만 emp_blank라는 이름으로 생성하시오
-- (단, 컬럼 이름은 동일하게 복사한다)
create table emp_blank
select * from employees
where 1 = 0;

select * from emp_blank;

-- 50번 부서의 사번(eid), 이름(name), 급여(sal), 부서번호(did)만 emp50 이라는 이름으로 생성하시오
create table emp50
select employee_id as "eid", first_name name, salary sal, department_id did
from employees
where department_id = 50;

select * from emp50;

-- employees table에서 부서번호가 80인 사원의 모든 정보를 emp_blank에 insert하시오
insert into emp_blank
select * from employees
where department_id = 80;

select * from emp_blank;

-- employees table의 모든 사원의 평균 급여보다 적게 받는 emp50 table의 사원의 급여를 500 인상하시오.
update emp50
set sal = sal + 500
where sal < (select avg(salary) from employees);

select * from emp50;

-- employees table의 모든 사원의 평균 급여보다 적게 받는 emp50 table의 사원은 퇴사처리 하시오.
delete 
from emp50
where sal < (select avg(salary) from employees);
-- -------------------------------------------------------------------
