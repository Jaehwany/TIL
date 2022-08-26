-- [ VIEW ]
--  : 다른 테이블이나 뷰에 포함된 맞춤표현(virtual table)
--    join하는 테이블의 수가 늘어나거나 질의문이 길고 복잡해지면 작성이 어려워지고 유지보수가 어려울수 있다. 
--    이럴때 스크립트를 만들어두거나 stored query를 사용해서
--    데이터베이스 서버에 저장해두면 필요할때 마다 호출해서 사용할수 있다

--   - 자체적으로 데이터를 포함하지 않는다
--   - 베이스테이블(Base table) : 뷰를 통해 보여지는 실제테이블
--   - 선택적인 정보만 제공 가능

-- [형식]
-- create [or  replace] [force | noforce ] view  뷰이름 [(alias [,alias,.....)]
-- as 서브쿼리
-- [with check option [constraint 제약조건이름]]
-- [with read only [constraint 제약조건이름]]

--  - create or replace : 지정한 이름의 뷰가 없으면 새로생성, 동일이름이 있으면 수정
--   - force | noforce
--          force  : 베이스테이블이 존재하는 경우에만 뷰생성가능
--          noforce: 베이스테이블이 존재하지 않아도 뷰생성가능
--  - alias  
--        뷰에서 생성할 표현식 이름(테이블의 컬럼이름 의미)
--        생략하면 서브쿼리의 이름적용
--        alias의 갯수는 서브쿼리의 갯수와 동일해야함
--  - 서브쿼리 : 뷰에서 표현하는 데이터를 생성하는 select구문
--  - 제약조건 
--        with check option : 뷰를 통해 접근가능한 데이터에 대해서만 DML작업가능
--        with read only : 뷰를 통해 DML작업안됨
--        제약조건으로 간주되므로 별도의 이름지정가능
-- ===============================================================================

-- ex1) 사원테이블에서 부서가 90인 사원들을 v_view1으로 뷰테이블을 만드시오
--     (사원ID,사원이름,급여,부서ID만 추가)
create or replace view v_view1(사원ID,사원이름,급여,부서ID)
as select employee_id, last_name, salary, department_id
   from employees
   where department_id=90;


-- ex2) 사원테이블에서 급여가  5000이상 10000이하인 사원들만 v_view2으로 뷰를 만드시오 --43건
--    (사원ID , 사원이름, 급여, 부서ID)
create or replace view v_view2(사원ID , 사원이름, 급여, 부서ID)
as select employee_id, last_name, salary, department_id
    from employees
    where salary between 5000 and 10000;
    
    
-- ex3) v_view2 테이블에서  103사원의 급여를 9000.00에서 12000.00으로 수정하시오
update v_view2 
set 급여=12000 where 사원ID=103;
select * from v_view2;

-- ex4)사원테이블과 부서테이블에서 사원번호,사원명,부서명을 v_view3로 뷰테이블을만드시오
--     조건1) 부서가 10,90인 사원만 표시하시오
--     조건2) 타이틀은  사원번호, 이름, 부서이름으로 출력하시오
--     조건3) 사원번호로 오름차순정렬하시오
create or replace view v_view3(사원번호, 이름, 부서이름)
as select employee_id, last_name, department_name
   from employees
   left join departments using(department_id)
   where department_id in(10,90)
   order by 1 asc;

-- ex5) 부서ID가 10,90번 부서인 사원들의 부서 위치를 표시하시오
--     조건1) v_view4로 뷰테이블을 만드시오
--     조건2) 타이틀을  사원번호,사원명,급여,입사일,부서명,부서위치(city)로 표시하시오
--     조건3) 사원번호순으로 오름차순정렬하시오
--     조건4) 급여는 천단위절삭하고,세자리마다 콤마와 '달러'을 표시하시오
--     조건5) 입사일은  '2004년 10월 02일' 형식으로 표시하시오  
create or replace view v_view4(사원번호, 사원명,급여, 입사일,부서명,부서위치)
as select employee_id, last_name,
          concat(format(truncate(salary,-3),0),'달러'),
          date_format(hire_date,'%Y년%m월%d일'),
          department_name,
          city
    from employees          
    left join departments using(department_id)
    left join locations using(location_id)
    where department_id in (10,90)
    order by employee_id;

-- ex6) 
-- 사원테이블을 가지고 부서별 평균급여를 뷰(v_view5)로 작성하시오
-- 조건1) 반올림해서 1000단위까지 구하시오
-- 조건2) 타이틀은  부서ID,부서평균
-- 조건3) 부서별로 오름차순정렬하시오
-- 조건4) 부서ID가 없는 경우 5000으로 표시하시오
create or replace view v_view5(부서ID, 부서평균)
as select nullif(department_id,5000), round(avg(salary),-3)
   from employees
   group by department_id
   order by department_id asc;
   
   
   
-- ex1) employees, departments테이블로 test1테이블을 만드시오
-- [조건1] employees, departments 테이블을 조인하여 쿼리를 만드시오
-- [조건2] 급여가  7000이상이면 '고급'  3000이상이면 '중급'  3000미만이면 '초급'으로 grade 컬럼으로 만드시오
--          (case when이용)
-- [조건3]   
--                last_name    department_name    salary       grade
--              -----------------------------------------------------
--                 King            Executive       24000        고급
create or replace view test1
as select  last_name,department_name,salary,
           case when salary>=7000 then '고급'
                when salary>=3000 then '중급'
                else '초급'
           end as "grade"
     from employees
     left join departments using(department_id)
     order by 4 desc;
     

-- ex2) departments, locations2테이블로 test2테이블을 만드시오
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

    
