-- 인라인뷰(Inline View)
-- 모든 사원의 평균 급여보다 적게 받는 사원들과 같은 부서에서 근무하는 사원의 사번, 이름, 급여, 부서번호
select employee_id,first_name, salary,a.department_id
from employees e join (
					select department_id
					from employees
					where salary <(select avg(Salary) from employees)
                    ) a
on e.department_id = a.department_id;

-- 부서별 최대급여를 받는 사원의 부서명,최대급여를 출력하시오(단, null은 제외)
select department_name, max(salary)
from (select department_id, department_name
	  from departments) d 
left join employees using(department_id)
group by department_name
having max(salary) is not null;
		
		
-- TopN 질의
-- 모든 사원의 사번, 이름, 급여를 출력.(단 아래의 조건 참조)
--   1. 사원 정보를 급여순으로 정렬.
--   2. 한 페이지당 5명이 출력.
--   3. 현재페이지가 3페이지라고 가정. (급여 순 11등 ~ 15등까지 출력)
set @pageno = 3;
select b.rn, b.employee_id, b.first_name, b.salary
from (
	  select @rownum := @rownum + 1 as rn, a.*
	  from (
		    select employee_id, first_name, salary
		    from employees
		    order by salary desc
		   ) a, (select @rownum := 0) tmp
	 ) b
where b.rn > (@pageno * 5 - 5) and b.rn <= (@pageno * 5);

-- MySQL은 limit로 해결.
select first_name, salary
from employees
order by salary desc limit 10,5;


-- Top N분석
-- 급여를 가장많이 받는 사원3명의 이름,급여를 표시하시오
select last_name, salary
from (select last_name, salary 
		from employees 
		order by 2 desc
        ) e limit 0, 3;

--  최고급여를 받는 사원1명을 구하시오
select last_name, salary, @rownum := @rownum + 1
from (select last_name, salary 
		from employees, (select @rownum := 0) tmp 
        order by 2 desc
        ) e limit 0, 1;


-- 급여의 순위를 내림차순정렬했을때, 3개씩 묶어서 2번째 그룹을 출력하시오
--      (4,5,6 순위의 사원출력  ==> 페이징처리기법) 
--        employee_id      last_name      salary
--        --------------------------------------
--         145             John       14000.00
--         146             Karen      13500.00
--         201             Michael    13000.00
-- 방법1)
select a.*
from (select  employee_id, first_name, salary
     from employees e
     order by salary desc
    )a limit 3, 3;
    
-- 방법2)
select e.employee_id,e.first_name,salary, e.page
from(select  tt.*, ceil(@rownum := @rownum + 1/3) as page
	 from (select * 
			from employees, (select @rownum := 0) tmp  
            order by salary desc
            ) tt
	) e
where page=2; 


-- 사원들의 연봉을 구한후 최하위 연봉자 5명을 추출하시오
-- 조건1) 연봉 = 급여*12+(급여*12*커미션)
-- 조건2) 타이틀은  사원이름 , 부서명, 연봉
-- 조건3) 연봉은  $25,000 형식으로 하시오
-- 사원이름        부서명       연봉
-- -------------------------------
-- Olson	    Shipping     $25,200
-- Markle       Shipping     $26,400
-- Philtanker   Shipping     $26,400
-- Gee          Shipping     $28,800
-- Landry       Shipping     $28,800

select d.last_name as "사원이름", d.department_name as "부서명", d.totsal as "연봉"
from (select last_name, department_name,
         concat('$',format((salary*12+(salary*12* ifnull(commission_pct, 0))),0)) as totsal
      from employees
      left join departments using(department_id)
      order by salary asc
      )d  limit 0,5;

      
select salary*12* ifnull(commission_pct, 0) from employees;

