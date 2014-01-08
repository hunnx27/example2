<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="dao" class="mybean.board.BoardDao_bak1"></jsp:useBean>

<%
String pass = request.getParameter("pass");
String storPass =request.getParameter("storPass");
int num = Integer.parseInt(request.getParameter("num"));

if(pass.equals(storPass)){
	dao.delBoard(num);
	response.sendRedirect("List.jsp");
}
else{
%>
	<script type="text/javascript">
		alert("비밀번호가틀렸습니다.삭제실패");
		history.back();
	</script>
<%
}
%>