package com.book.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.dao.LoginDao;
import com.book.dao.LoginDaoImpl;

@WebServlet(name = "Login", urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String userid=request.getParameter("userid");
		String userpwd=request.getParameter("userpwd");
//		System.out.println(userid +"  " +userpwd);
		
		LoginDao dao=LoginDaoImpl.getLoginDao();
		boolean ck=dao.getLoginUser(userid, userpwd);
		
		if(ck==true) {
			/*세션설정*/
			HttpSession session=request.getSession();
			session.setAttribute("logOK", userid);
			response.sendRedirect("/bkshop/login/loginOK.jsp");
		}else {
			response.sendRedirect("/bkshop/login/fail.jsp");
		}
	}
}

















