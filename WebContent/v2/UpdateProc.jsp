<%@page import="mybean.board.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="dto" class="mybean.board.BoardDto"/>
<jsp:useBean id="dao" class="mybean.board.BoardDao_bak1"/>
<jsp:setProperty property="*" name="dto"/>

<%//�����̸��ϼ�����Ʈ����Ʈ
int num =Integer.parseInt(request.getParameter("num"));
BoardDto board = dao.getBoard(num);
String inputPass = dto.getPass(); //�Էµ��н�����
String storedPass = board.getPass();

if(!inputPass.equals(storedPass)){
%>
	<script type="text/javascript">
		alert("�Է��Ͻź�й�ȣ�� Ʋ���̽��ϴ�.");
		history.back;
	</script>
<%	
}
else{
	dao.updateBoard(dto);
	response.sendRedirect("List.jsp");
}
%>