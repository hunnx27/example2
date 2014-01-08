<%@page import="mybean.board.BoardDto"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=euc-kr" %>
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
%>
<HTML>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function check(){
		if(document.search.keyWord.value == ""){
			alert("검색어를 입력하세요.");
			document.search.keyWord.focus();
			return;
		}
		document.search.submit();
	}

	function list(){
		document.list.action = "List.jsp";
		document.list.submit();
	}

	function read(value){
		document.read.action = "Read.jsp";
		document.read.num.value = value;	// 해당 게시글 번호
		document.read.submit();
	}
</script>
<BODY>
<jsp:useBean id="dao" class="mybean.board.BoardDao_bak1"/>
<%!
	String keyWord="", keyField=""; //한번 초기화후 초기화하지않음.
%>
<%
	if(request.getParameter("keyWord") != null){
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	
	if(request.getParameter("reload")!= null){
		if(request.getParameter("reload").equals("true")){
			keyField = "";
			keyWord = "";
		}
	}
	Vector v = dao.getBoardList(keyField, keyWord);
%>
<center><br>
<h2>JSP Board</h2>

<table align=center border=0 width=80%>
<tr>
	<td align=left>Total :  Articles(
		<font color=red>  1 / 10 Pages </font>)
	</td>
</tr>
</table>

<table align=center width=80% border=0 cellspacing=0 cellpadding=3>
<tr>
	<td align=center colspan=2>
		<table border=0 width=100% cellpadding=2 cellspacing=0>
			<tr align=center bgcolor=#D0D0D0 height=120%>
				<td> 번호 </td>
				<td> 제목 </td>
				<td> 이름 </td>
				<td> 날짜 </td>
				<td> 조회수 </td>
			</tr>
			<%
				if(v.isEmpty()){
			%>
					등록된 글이 없습니다.
			<%
				}
				else{
					for(int i=0;i<v.size();i++){
						BoardDto dto = (BoardDto)v.get(i);  //벡터에저장된 dto를 한개씩 배서 변수에 넣는다.
						int num = dto.getNum(); 
						String subject = dto.getSubject();
						String name = dto.getName();
						String regdate = dto.getRegdate();
						int count = dto.getCount();
						String email = dto.getEmail();
			%>
				<tr>
					<td align=center><%=num %></td>
					<td align="center"><a href="javascript:read('<%=num%>')"><%=subject %></a></td>  <!-- 글번호 서브젝트로가져다주기 -->
					<td><a href="mailto:<%=email%>"><%=name %></a></td>
					<td align=center><%=regdate %></td>
					<td align=center><%=count %></td>
				</tr>
			<%
					}
				}
			%>
			
		</table>
	</td>
</tr>
<tr>
	<td><BR><BR></td>
</tr>
<tr>
	<td align="left">Go to Page </td>
	<td align=right>
		<a href="Post.jsp">[글쓰기]</a>
		<a href="javascript:list()">[처음으로]</a>
	</td>
</tr>
</table>
<BR>
<form action="List.jsp" name="search" method="post">
	<table border=0 width=527 align=center cellpadding=4 cellspacing=0>
		<tr>
			<td align=center valign=bottom>
				<select name="keyField" size="1">
					<option value="name"> 이름
					<option value="subject"> 제목
					<option value="content"> 내용
				</select>

				<input type="text" size="16" name="keyWord" >
				<input type="button" value="찾기" onClick="check()">
				<input type="hidden" name="page" value= "0">
			</td>
		</tr>
	</table>
</form>

<form name="read" method="post">
	<input type="hidden" name="num">
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord"value="<%=keyWord%>">
</form>

<form name="list" method="post">
	<input type="hidden" name="reload" value="true">
</form>
</center>	
</BODY>
</HTML>