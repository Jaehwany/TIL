package com.study.exam;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "Test3", urlPatterns = { "/test3" })
public class TestServlet3 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] color= {"red","green","blue"};
		int num=10;
		
		request.setAttribute("title", "[테스트 화면 3]");
		request.setAttribute("color", color);
		request.setAttribute("num", num);
		
		RequestDispatcher rd=request.getRequestDispatcher("view/test3.jsp");
		rd.forward(request, response);
	}
}
/*
[테스트화면 3]
red
green
blue

1 2 3 4 5 6 7 8 9 10
*/
