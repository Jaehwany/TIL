-- 데이터베이스 생성
drop database ssafyweb;

create database ssafyweb
default character set utf8mb3 collate utf8mb3_general_ci;
-- databases developer를 Disconnect --> Connect 할것
-- Database: ssafyweb
-- URL:jdbc:mysql://127.0.0.1:3306/ssafyweb?serverTimezone=UTC&useUniCode=yes&characterEncoding=UTF-8
use ssafyweb;
show tables;

create table users(
id varchar(10) primary key,
pwd varchar(10) not null,
name varchar(20) not null,
point float) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into users(id,pwd,name,point) values('admin','1111','어드민',35.34);
insert into users(id,pwd,name,point) values('abcd','1111','테스트',65.78);

select * from users;
-------------------------------------------------
drop table emp;

create table emp(
eno int primary key auto_increment,        
ename varchar(10)not null,  
phone varchar(15),          
dept varchar(20)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

select * from emp;


















