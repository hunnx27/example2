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
		alert("��й�ȣ��Ʋ�Ƚ��ϴ�.��������");
		history.back();
	</script>
<%
}
%>