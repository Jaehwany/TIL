-- [1] MySQL 데이터베이스 생성/삭제/사용
-- 1. 데이터베이스 생성
-- create database 데이터베이스명;
-- create database 데이터베이스명 default character set 값 collate 값;
--    --특정 문자 셋에 의해 데이터베이스에저장된 값들을 비교검색하거나 정렬 등의
--      작업을 위해 문자들을 서로 ＇비교＇ 할 때 사용하는 규칙들의 집합을 의미
--    -- 예) 다국어 처리(utf8mb3)  
--           create database dbtest
--           default character set utf8mb3 collate utf8mb3_general_ci;

-- 2. 데이터베이스 변경
-- alter database 데이터베이스명 default character set 값 collate 값;  

-- 3. 데이터베이스 삭제
-- drop database 데이터베이스명;

-- 4. 데이터베이스 사용
-- use 데이터베이스명;

-- 5. 테이블 목록확인
-- show tables;


create database dbtest
default character set utf8mb3 collate utf8mb3_general_ci;
-- ---------------------------------------------------
use dbtest;

create table test(
	val varchar(10)
);

insert into test (val)
values ('a');

select *
from test;

drop database dbtest;

-- ---------------------------------------------------
create database dbtest
default character set utf8mb4 collate utf8mb4_general_ci;

use dbtest;

create table test(
	val varchar(10)
);

insert into test (val)
values ('a');

insert into test (val)
values ('😊');

select *
from test;

drop database dbtest;


-- ---------------------------------------------------
