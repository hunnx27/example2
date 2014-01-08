CREATE TABLE sample(
	num			number,
	subject		varchar2(10),
	pos			number,
	depth			number
)

-- ������ pos�� �������� ��������(position�亯������ġ)
-- depth �鿩����
--���ο� �����͸� �Է½� ���� ���� �������� ��� pos���� 1�� ������Ų��.
--ó�� �ԷµǴ� ������(�θ��)�� ������ pos�� depth�� 0�� �Է¹޴´�.
insert into sample values(1,'aaa', 0, 0);

select * from sample

/*
 * num		subject		pos		depth
 * ---------------------------------------------
 * 1			aaa			0			0
*/
update sample set pos = pos+1;
insert into sample values(2,'bbb', 0, 0);

/*
 * num		subject		pos		depth
 * ---------------------------------------------
 * 1			aaa			1			0
 * 2			bbb			0			0
*/

update sample set pos = pos+1;
insert into sample values(3,'ccc', 0, 0);

/*
 * num		subject		pos		depth
 * ---------------------------------------------
 * 1			aaa			2			0
 * 2			bbb			1			0
 * 3			ccc				0			0          
*/

--1����(aaa)�� ���� �亯�� �޾ƺ���.
--�θ𺸴� ū pos�� 1�� ������Ų��. �亯���� �θ��� pos�� 1�� ���Ѵ�.

update sample set pos = pos+1 where pos > 2;
insert into sample values(4,'aaa_a', 3, 1);

/*
 * num		subject		pos		depth
 * ---------------------------------------------
 * 1			aaa			2			0
 * 2			bbb			1			0
 * 3			ccc				0			0        
 * 4			aaa_a			3			1  
*/

select * from sample order by pos;

--2����(bbb)�� ���� �亯�� �޾ƺ���.
--�θ𺸴� ū pos�� 1�� ������Ų��.(2,4���ۿ� pos 1�� ������Ŵ) �亯���� �θ��� pos�� 1�� ���Ѵ�.

update sample set pos = pos+1 where pos > 1;
insert into sample values(5,'bbb_b', 2, 1);

/*
 * num		subject		pos		depth
 * ---------------------------------------------
 * 1			aaa			3			0
 * 2			bbb			1			0
 * 3			ccc				0			0        
 * 4			aaa_a			4			1  
 * 5			bbb_b			2			1
*/

select * from sample order by pos;

--3����(ccc)�� ���� �亯�� �޾ƺ���.
--1,2,4,5�� �ۿ����� pos�� 1������ , �亯���� �θ��� pos�� 1�����Ѱ��� �ڽ�������

update sample set pos = pos+1 where pos > 0;
insert into sample values(6,'ccc_c', 1, 1);

/*
 * num		subject		pos		depth
 * ---------------------------------------------
 * 1			aaa			4			0
 * 2			bbb			2			0
 * 3			ccc				0			0        
 * 4			aaa_a			5			1  
 * 5			bbb_b			3			1
 * 6			ccc_c			1			1
*/

select * from sample order by pos;

--���ο� 7������ �Է��Ѵ�.
update sample set pos = pos+1;
insert into sample values(7,ddd,0,0);
/*
 * num		subject		pos		depth
 * ---------------------------------------------
 * 1			aaa			5			0
 * 2			bbb			3			0
 * 3			ccc				1			0        
 * 4			aaa_a			6			1  
 * 5			bbb_b			4			1
 * 6			ccc_c			2			1
 * 7			ddd			0			0
*/

--3�����Ǵ亯(ccc_cc)�� ���ϳ� ����
update sample set pos =pos+1 where 
/*
 * num		subject		pos		depth
 * ---------------------------------------------
 * 1			aaa			6			0
 * 2			bbb			4			0
 * 3			ccc				1			0        
 * 4			aaa_a			7			1  
 * 5			bbb_b			5			1
 * 6			ccc_c			3			1
 * 7			ddd			0			0
 * 8			ccc_cc			2			1
*/

--3������ �亯(ccc_c)�� �亯(ccc_c_c)�� �ϳ� ����
/*
 * num		subject		pos		depth
 * ---------------------------------------------
 * 1			aaa			7			0
 * 2			bbb			5			0
 * 3			ccc				1			0        
 * 4			aaa_a			8			1  
 * 5			bbb_b			6			1
 * 6			ccc_c			3			1
 * 7			ddd			0			0
 * 8			ccc_cc			2			1
 * 9			ccc_c_c		4			2
*/

/*num		subject		pos		depth
 * ---------------------------------------------
 * 7			ddd			0			0
 * 3			ccc				1			0 
 * 8			 ccc_cc			2			1
 * 6		  	 ccc_c			3			1
 * 9			  ccc_c_c		4			2
 * 2			bbb			5			0
 * 5			 bbb_b			6			1
 * 1			aaa			7			0
 * 4			 aaa_a			8			1 
 */
-------------------------------------------------------------------------------------
/*
 * group : �θ�۰� �׷κ��� �Ļ��� �ڽı��� ���� ���� ������.
 * seq	: ���� �׷쳻�� �� ���� 
 * level : ���� �׷쳻�� ����
 */

/*
 * num		subject		grp	seq	lev
 * ----------------------------------------------
 * 1			aaa			1		0		0			
 */

/*
 * num		subject		grp	seq	lev
 * ----------------------------------------------
 * 1			aaa			1		0		0	
 * 2			bbb			2		1		0		
 */

/*
 * num		subject		grp	seq	lev
 * ----------------------------------------------
 * 1			aaa			1		0		0	
 * 2			bbb			2		0		0		
 * 3			ccc				3		0		0
 */


--1���ۿ����Ѵ亯������

/*
 * num		subject		grp	seq	lev
 * ----------------------------------------------
 * 1			aaa			1		0		0	
 * 2			bbb			2		0		0		
 * 3			ccc				3		0		0
 * 4			aaa_a			1		1		1
 */

--1���ۿ� ���� �亯(aaa_a)�� �亯(aaa_a_a)�� ����.

/*
 * num		subject		grp	seq	lev
 * ----------------------------------------------
 * 1			aaa			1		0		0	
 * 2			bbb			2		0		0		
 * 3			ccc				3		0		0
 * 4			aaa_a			1		1		1
 * 5			aaa_a_a		1		2		2
 */

--1���ۿ� ���� �亯(aaa_aa)�� ���ϳ� ����.
--�θ��� seq���� ũ�� ���� �׷��� seq�� 1�߰��Ѵ�.
update sample2 set seq = seq+1 where	grp=1 and seq >0;
insert into sample2 values(...);
/*
 * num		subject		grp	seq	lev
 * ----------------------------------------------
 * 1			aaa			1		0		0	
 * 2			bbb			2		0		0		
 * 3			ccc				3		0		0
 * 4			aaa_a			1		2		1
 * 5			aaa_a_a		1		3		2
 * 6			aaa_aa		1		1		1
 */












