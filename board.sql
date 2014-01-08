create table tblboard(
	num			number,
	name			varchar2(20),
	email			varchar2(50),
	homepage	varchar2(50),
	subject		varchar2(50),
	content		varchar2(4000),
	pass			varchar2(10),
	count			number,
	ip				varchar2(50),
	regdate		date,
	pos			number,
	depth			number,
	constraint pkpk_num PRIMARY KEY(num)
);

drop sequence seq_num;
create Sequence seq_num;

select * from tblboard;

delete from tblboard;
