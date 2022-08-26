-- subquery
-- 사번이 100인 사원의 부서이름
-- join
select department_name
from employees e 
join departments d on e.department_id = d.department_id
where e.employee_id=100;

-- 1)
select department_id
from employees
where employee_id = 100;

-- 2)
select department_name
from departments
where department_id = 90;

-- result) 1+2
select department_name
from departments
where department_id=(select department_id
					from employees
					where employee_id=100
                    );

-- 부서가 ‘seattle’(대소문자 구분X)에 있는 부서의 부서 번호, 부서 이름.
-- 단일행
select department_id, department_name
from departments
where location_id = (
					select location_id
					from locations
					where binary upper(city) = upper('seattle')
                    );

-- 전체 사원의 평균 급여보다 많이 받는 사원의 사번, 이름, 급여.
-- 급여순 정렬
select employee_id,first_name, salary
from employees
where salary > (select avg(salary) from employees)
order by 3 desc;

-- ‘adam’과 같은 부서에 근무하는 사원의 사번, 이름, 부서번호.
select employee_id,first_name, department_id
from employees
where department_id=(
					select department_id
					from employees
                    where first_name='adam'
);

-- 근무 도시가 ‘seattle’(대소문자 구분X)인 사원의 사번, 이름.
-- 다중행 (in)
select employee_id, first_name
from employees
where department_id in (
					select department_id
                    from departments
                    where location_id = (
										select location_id
                                        from locations
                                        where upper(city) =upper('seATtle')
                                        )
					 );

						
-- 모든 사원 중 적어도(최소급여자보다) 30번 부서에서 근무하는 사원의 급여보다 많이 받는 사원의 사번, 이름, 급여, 부서번호
-- 다중행 (any)
select employee_id, first_name,salary,department_id
from employees
where salary> any (
			  select salary
              from employees
              where department_id=30
              );

-- 30번 부서에서 근무하는 모든(최대급여자보다) 사원들보다 급여를 많이 받는 사원의 사번, 이름, 급여, 부서번호.
-- 다중행 (all)
select employee_id, first_name,salary,department_id
from employees
where salary> all (
			  select salary
              from employees
              where department_id=30
              );
              
-- 다중열
-- 커미션을 받는 사원중 매니저 사번이 148인 사원의 급여와 부서번호가 일치하는 사원의 사번, 이름

select employee_id,first_name
from employees
where (salary,department_id) in (
								select salary, department_id
								from employees
								where commission_pct is not null 
                                and manager_id=148
                                );
		