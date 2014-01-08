<%@page import="mybean.board.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="dto" class="mybean.board.BoardDto"/>
<jsp:useBean id="dao" class="mybean.board.BoardDao_bak1"/>
<jsp:setProperty property="*" name="dto"/>

<%//네임이메일서브젝트콘텐트
int num =Integer.parseInt(request.getParameter("num"));
BoardDto board = dao.getBoard(num);
String inputPass = dto.getPass(); //입력된패스워드
String storedPass = board.getPass();

if(!inputPass.equals(storedPass)){
%>
	<script type="text/javascript">
		alert("입력하신비밀번호는 틀리셨습니다.");
		history.back;
	</script>
<%	
}
else{
	dao.updateBoard(dto);
	response.sendRedirect("List.jsp");
}
%>