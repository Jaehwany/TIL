-- tracnsation처리
-- commit: 일의 시작과 끝이 완벽하게 마무리가 되면 테이블에 적용
-- rollback: 처리도중 인터럽트(interrupt:장애)가 발생하면 되돌아옴
-- -------------------------------------------------------------------------------
-- ex1) 테이블생성과 시퀀스적용
-- 테이블명 : book
-- num      int    p.k  자동값증가
-- subject  varchar(50)
-- price    int
-- year     date
use ssafydb;
drop table book;

create table book(
num int primary key auto_increment,
subject varchar(50),
price int,
year date);

show tables;

-- ex2) 데이터 추가
-- 오라클 무작정 따라하기, 10000, 오늘날짜
-- 자바 3일 완성,15000, 2019-01-12
-- JSP 달인되기,25000, 2021-04-05
-- 자동 커밋해제: set autocommit=0; / 자동 커밋설정: set autocommit=1;
set autocommit=1;

insert into book(subject,price,year) values('오라클 무작정따라하기',10000, now());
insert into book(subject,price,year) values('자바 3일 완성',15000, '2017-01-12');
insert into book(subject,price,year) values('JSP 달인되기',25000,'2021-04-05');
insert into book(subject,price,year) values('MySQL따라하기',35000,'2020-05-05');
commit;
select * from book;

-- 트랜젝션 처리를 안했을 경우 오류 상황
-- 콘솔창에서
update book set subject='JSP 20일 완성' where num=1;

-- 이클립스창 또는  MySQL Workbench에서
update book set subject='JSP 마스터북' where num=1;


