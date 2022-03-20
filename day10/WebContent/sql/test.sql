select * from all_tables;
drop table board;


select * from pboard;
truncate table pboard;

create table pboard(
	bid int primary key,
	writer varchar(20) not null,
	title varchar(30) not null,
	content varchar(50) not null
);
insert into pboard values(1, '작성자','제목','내용');
insert into pboard values(3, '작성자','제목3','내용3');

drop table melonchart;
truncate table melonchart;
select * from melonchart;


create table melonchart(
	mid int primary key,
	rank varchar(10) not null,
	about varchar(70) not null,
	singer varchar(70) not null,
	album varchar(70) not null
);
