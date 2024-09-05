        select IFNULL(max(idx)+1, 1) as idx from tblBoard      


-- tblBoard --
create table tblBoard(
	idx int not null,
	memID varchar(20) not null,  
	title varchar(100) not null,
	content varchar(2000) not null,
	writer varchar(30) not null,
	indate datetime default current_timestamp,
	count int default 0,
	boardGroup int,
	boardSequence int,
	boardLevel int,
	boardAvailable int,
	primary key (idx)
);
select * from tblBoard where idx=4
drop table tblBoard

select max(boardSequence) from tblBoard; -- NULL -> 1 , 2+1->3
select IFNULL(max(idx)+1, 1) from tblBoard;

insert into tblBoard
select IFNULL(max(idx)+1, 1),'bit01','게시판연습','게시판연습','관리자',
now(),0, IFNULL(max(boardGroup)+1, 0), 0, 0, 1
from tblBoard;
select * from tblBoard 
insert into tblBoard
select IFNULL(max(idx)+1, 1),'bit02','게시판연습','게시판연습','박매일',
now(),0, IFNULL(max(boardGroup)+1, 0), 0, 0, 1
from tblBoard;

insert into tblBoard
select IFNULL(max(idx)+1, 1),'bit03','게시판연습','게시판연습','홍길동',
now(),0, IFNULL(max(boardGroup)+1, 0), 0, 0, 1
from tblBoard;
    select * from tblMember where meidx=3;
SELECT  NOW()as date
FROM tblMember
select * from tblBoard;
	select * from			tblMember;
	drop table tblMember
create table tblMember(
  meidx int not null ,
  memID varchar(50) , -- 회원ID
  memPwd varchar(50) , -- 회원비번
  memName varchar(50) , -- 회원이름
  memPhone varchar(50) , -- 회원전화번호
  memAddr varchar(100), -- 회원주소
  latitude decimal(13,10), -- 현재위치위도
  longitude decimal(13,10), -- 현재위치경도
 date datetime default NOW(),
  primary key(memID)
);
insert into tblMember(memID, memPwd)
union all
select "test01","test01" from DUAL;
drop table tblMember;
insert into tblMember(memID, memPwd, memName, memPhone)
values('test01','test01','관리자','010-1111-1111');
insert into tblMember(memID, memPwd, memName, memPhone)
values('test02','test02','테스터','010-2222-2222');
insert into tblMember(memID, memPwd, memName, memPhone)
values('test03','test03','홍길동','010-3333-3333');
insert into tblMember(memID, memPwd, memName, memPhone)
values('test','test','홍길동','010-3333-3333');

insert into tblMember(memID,memPwd,memName)values(#{memID},#{memPwd},#{memName})

delete from tblMember where memID='test03';
select * from tblMember where memID='test02'
select * from tblMember;
	update tblMember set memID="test", memPwd="test"
      where memID="test01"
select * from tblBoard;

        select IFNULL(max(idx)+1, 1) as idx,
               IFNULL(max(boardGroup)+1, 0) as boardGroup
        from tblBoard 
select * from tblBoard where idx=2
