select * from all_tables;

create table member(
	mid varchar(20) primary key,
	mpw varchar(20) not null,
	mname varchar(15) not null
);

select * from MEMBER;

create table cboard(
	bid int primary key,
	mid varchar(20) not null,
	msg varchar(50) not null,
	favcnt int default 0
);

select * from cboard;
delete from cboard where bid=2;

create table reply(
	rid int primary key,
	bid int not null,
	mid varchar(20) not null,
	rmsg varchar(30) not null,
	constraint cboard_fk foreign key(bid) references cboard(bid) on delete cascade
);

select * from reply;


insert into cboard values(1,'작성자','게시글내용',0);
TRUNCATE table cboard;
select * from cboard;
insert into reply values(1,1,'작성자','댓글내용');
select * from reply;
TRUNCATE table reply;
drop table cboard;
delete from cboard where bid=1;


insert into cboard values(1,'아이디1','메시지1',0);
insert into cboard values(2,'아이디2','메시지2',0);
insert into cboard values(3,'아이디3','메시지3',0);

insert into reply values(1,1,'아이디4','댓글예시4');
insert into reply values(2,1,'아이디5','댓글예시5');
insert into reply values(3,3,'아이디6','댓글예시6');
insert into reply values(4,1,'아이디1','댓글예시1');