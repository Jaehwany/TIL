package com.book.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "Logout", urlPatterns = { "/logout" })
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String userid=(String)session.getAttribute("logOK");
		
		if(userid != null) {
			session.removeAttribute("logOK");
			response.sendRedirect("/bkshop/index.jsp");
		}
//		session.invalidate();  //모든 세션 종료
//		response.sendRedirect("/bkshop/index.jsp");
	}
}
