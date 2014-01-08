CREATE TABLE sample(
	num			number,
	subject		varchar2(10),
	pos			number,
	depth			number
)

-- 정렬은 pos를 기준으로 오름차순(position답변글의위치)
-- depth 들여쓰기
--새로운 데이터를 입력시 먼저 기존 데이터의 모든 pos값을 1씩 증가시킨다.
--처음 입력되는 데이터(부모글)은 무조건 pos와 depth는 0을 입력받는다.
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

--1번글(aaa)에 대한 답변을 달아본다.
--부모보다 큰 pos는 1씩 증가시킨다. 답변글은 부모의 pos에 1을 더한다.

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

--2번글(bbb)에 대한 답변을 달아본다.
--부모보다 큰 pos는 1씩 증가시킨다.(2,4번글에 pos 1씩 증가시킴) 답변글은 부모의 pos에 1을 더한다.

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

--3번글(ccc)에 대한 답변을 달아본다.
--1,2,4,5번 글에대한 pos가 1씩증가 , 답변글은 부모의 pos에 1을더한값을 자신이증가

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

--새로운 7번글을 입력한다.
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

--3번글의답변(ccc_cc)을 또하나 달자
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

--3번글의 답변(ccc_c)에 답변(ccc_c_c)을 하나 달자
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
 * group : 부모글과 그로부터 파생된 자식글은 같은 값을 가진다.
 * seq	: 같은 그룹내의 글 순서 
 * level : 같은 그룹내의 깊이
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


--1번글에대한답변을달자

/*
 * num		subject		grp	seq	lev
 * ----------------------------------------------
 * 1			aaa			1		0		0	
 * 2			bbb			2		0		0		
 * 3			ccc				3		0		0
 * 4			aaa_a			1		1		1
 */

--1번글에 대한 답변(aaa_a)에 답변(aaa_a_a)을 달자.

/*
 * num		subject		grp	seq	lev
 * ----------------------------------------------
 * 1			aaa			1		0		0	
 * 2			bbb			2		0		0		
 * 3			ccc				3		0		0
 * 4			aaa_a			1		1		1
 * 5			aaa_a_a		1		2		2
 */

--1번글에 대한 답변(aaa_aa)을 또하나 달자.
--부모의 seq보다 크고 같은 그룹인 seq를 1추가한다.
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












