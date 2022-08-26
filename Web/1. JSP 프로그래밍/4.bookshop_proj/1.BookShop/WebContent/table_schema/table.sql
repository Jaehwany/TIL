use ssafydb;

drop table member;

create table member(
userid varchar(8) primary key,
userpwd varchar(10) not null) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into member(userid,userpwd) values('admin','1234');
insert into member(userid,userpwd) values('abcd','5678');
commit

select * from member;
-------------------------------------------------------------------
drop table bookshop;   

create table bookshop(
isbn varchar(15) primary key,   
title varchar(50) not null, 
author varchar(10) not null,         
company varchar(50),          
price int) ENGINE=InnoDB DEFAULT CHARSET=utf8;       

insert into bookshop(isbn,title, author,company,price) values(10000,'HTML3일완성','이순신','야메루출판사',12000);
insert into bookshop(isbn,title, author,company,price) values(10001,'JSP무작정따라하기','강호동','공갈닷컴',12000);
insert into bookshop(isbn,title, author,company,price) values(10002,'HTML3일완성','홍길동','디지탈박스',12000);

select * from bookshop;
commit;
show tables;           

















