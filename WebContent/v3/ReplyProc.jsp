<%@page import="mybean.board.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>

<jsp:useBean id="dto" class="mybean.board.BoardDto"/><!-- 자식글(답변글정보) -->
<jsp:useBean id="dao" class="mybean.board.BoardDao"/>
<jsp:setProperty property="*" name="dto"/>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDto board = dao.getBoard(num);  //부모의 dto=board
	dao.replyUpPos(board); 
	dto.setPos(board.getPos());       //자식글에 부모의 포스값입력
	dto.setDepth(board.getDepth());//자식글에 부모의 뎁스값입력
	dao.replyBoard(dto);
	response.sendRedirect("/v3/ReplyProc.jsp");
%>
