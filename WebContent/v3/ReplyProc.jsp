<%@page import="mybean.board.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>

<jsp:useBean id="dto" class="mybean.board.BoardDto"/><!-- �ڽı�(�亯������) -->
<jsp:useBean id="dao" class="mybean.board.BoardDao"/>
<jsp:setProperty property="*" name="dto"/>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDto board = dao.getBoard(num);  //�θ��� dto=board
	dao.replyUpPos(board); 
	dto.setPos(board.getPos());       //�ڽıۿ� �θ��� �������Է�
	dto.setDepth(board.getDepth());//�ڽıۿ� �θ��� �������Է�
	dao.replyBoard(dto);
	response.sendRedirect("/v3/ReplyProc.jsp");
%>
