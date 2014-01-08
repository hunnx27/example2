package mvcapp.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FrontController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String uri = req.getRequestURI(); // ( /BoardApp/*.app )
		String ctxPath = req.getContextPath(); //������Ʈ�̸������� ��� ( /BoardApp)
		uri = uri.substring(ctxPath.length()+1);
		System.out.println(uri);
		String nextPage = "";
		
		if(uri.equals("/member.app")){
			//ȸ���� ���õ� ó��
		}
		else if(uri.equals("admin.app")){
			//�����ڿ� ���õ� ó��
		}else if(uri.equals("shop.app")){
			//���θ��� ���õ� ó��
		}else if(uri.equals("board.app")){
			nextPage ="/v4/List.jsp";
		}else{
			//������ ���õ� ó��(������ ����ڵ�)
		}
		
		RequestDispatcher view = req.getRequestDispatcher(nextPage);
		view.forward(req, resp);
	}

}
