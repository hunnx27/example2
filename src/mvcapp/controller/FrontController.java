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
		String ctxPath = req.getContextPath(); //프로젝트이름까지의 경로 ( /BoardApp)
		uri = uri.substring(ctxPath.length()+1);
		System.out.println(uri);
		String nextPage = "";
		
		if(uri.equals("/member.app")){
			//회원에 관련된 처리
		}
		else if(uri.equals("admin.app")){
			//관리자와 관련되 처리
		}else if(uri.equals("shop.app")){
			//쇼핑몰과 관련된 처리
		}else if(uri.equals("board.app")){
			nextPage ="/v4/List.jsp";
		}else{
			//오류와 관련된 처리(일종의 방어코드)
		}
		
		RequestDispatcher view = req.getRequestDispatcher(nextPage);
		view.forward(req, resp);
	}

}
