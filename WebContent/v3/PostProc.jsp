<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="dto" class="mybean.board.BoardDto"/>
<jsp:useBean id="dao" class="mybean.board.BoardDao"/>
<jsp:setProperty property="*" name="dto"/>
<%
	dao.insertBoard(dto);
	response.sendRedirect("List.jsp");
%>