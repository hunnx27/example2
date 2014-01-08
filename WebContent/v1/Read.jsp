<%@page import="mybean.board.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
%>
<html>
<head><title>JSPBoard</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
function list(){
	document.list.action="List.jsp";
 	document.list.submit();
 } 
</script>
</head>
<jsp:useBean id="dao" class="mybean.board.BoardDao_bak1"/>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String keyField = request.getParameter("keyField");//����Ʈ���������ѱ涧�����ϱ����Ͽ�
	String keyWord = request.getParameter("keyWord");
	
	System.out.println(num);
	BoardDto dto =	dao.getBoard(num);
	String name = dto.getName();
	String email = dto.getEmail();
	String homepage = dto.getHomepage();
	String subject =dto.getSubject();
	String regdate = dto.getRegdate();
	String content = dto.getContent();
	String ip = dto.getIp();
	int count = dto.getCount();
%>
<body>
<br><br>
<table align=center width=70% border=0 cellspacing=3 cellpadding=0>
 <tr>
  <td bgcolor=9CA2EE height=25 align=center class=m>���б�</td>
 </tr>
 <tr>
  <td colspan=2>
   <table border=0 cellpadding=3 cellspacing=0 width=100%> 
    <tr> 
	 <td align=center bgcolor=#dddddd width=10%> �� �� </td>
	 <td bgcolor=#ffffe8><%=name %></td>
	 <td align=center bgcolor=#dddddd width=10%> ��ϳ�¥ </td>
	 <td bgcolor=#ffffe8><%=regdate %></td>
	</tr>
    <tr>
	 <td align=center bgcolor=#dddddd width=10%> �� �� </td>
	 <td bgcolor=#ffffe8 ><%=email %></td> 
	 <td align=center bgcolor=#dddddd width=10%> Ȩ������ </td>
	 <td bgcolor=#ffffe8 ><a href="http://" target="_new">http://<%=homepage %></a></td> 
	</tr>
    <tr> 
     <td align=center bgcolor=#dddddd> �� ��</td>
     <td bgcolor=#ffffe8 colspan=3> <%=subject %></td>
   </tr>
   <tr> 
    <td colspan=4><br><%=content %><br></td>
   </tr>
   <tr>
    <td colspan=4 align=right>
     <%=ip %>�� ���� ���� ����̽��ϴ�./  ��ȸ��  : <%=count %>
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td align=center colspan=2> 
	<hr size=1>
	[ <a href="javascript:list()">�� ��</a> | 
	<a href="Update.jsp?num=<%=num%>">�� ��</a> |
	<a href="Delete.jsp?num=<%=num %>">�� �� </a>]<br>
  </td>
 </tr>
</table>
<form name="list" method="post">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="keyField" value="<%=keyField%>">
<input type="hidden" name="keyWord" value="<%=keyWord%>">
</form>
</body>
</html>
