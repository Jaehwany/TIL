package com.study.exam;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "Test1", urlPatterns = { "/test1" })
public class TestServlet1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name="개나리";
		int age=22;
		
		request.setAttribute("title","[테스트 화면1]");
		request.setAttribute("irum",name);
		request.setAttribute("nai",age);
		
		RequestDispatcher rd=request.getRequestDispatcher("view/test1.jsp");
		rd.forward(request, response);
	}
}
/* 
[테스트화면 1]
이름: 개나리
나이: 22살

처음화면
*/