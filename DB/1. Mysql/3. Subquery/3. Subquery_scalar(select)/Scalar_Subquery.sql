-- scalar subquery
-- 직급 아이디가 IT_PROG인 사원의 사번, 이름, 직급아이디, 부서이름
select e.employee_id, e.first_name, job_id,
	   (select department_name from departments d where e.department_id = d.department_id) department_name
from employees e
where job_id = 'IT_PROG';

-- 60번 부서에 근무하는 사원의 사번, 이름, 급여, 부서번호, 60번부서의 평균급여
select e.employee_id, e.first_name, salary, department_id,
	   (select avg(salary) from employees where department_id = 60) as avg60
from employees e
where department_id = 60;

-- 부서번호가 50인 부서의 총급여, 60인 부서의 평균급여, 90인 부서의 최고급여, 90인 부서의 최저급여
select
	(select sum(salary) from employees where department_id = 50) sum50,
    (select avg(salary) from employees where department_id = 60) avg60,
    (select max(salary) from employees where department_id = 90) max90,
    (select min(salary) from employees where department_id = 90) min90
from dual;