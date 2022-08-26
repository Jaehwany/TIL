package com.study.method;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "GET", urlPatterns = { "/get.do" })
public class GetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.한글처리(UTF-8, EUC-KR등)
		response.setContentType("text/html;charset=UTF-8");
		
		//2.데이터가져오기
		String name=request.getParameter("irum");
		String pwd=request.getParameter("amho");
		
		//3.출력
		response.getWriter().append("<html><head><title></title></head>");
		response.getWriter().append("<body>");
		
		response.getWriter().append("이름:" + name +"<br>");
		response.getWriter().append("암호:" + pwd +"<br>");
		
		response.getWriter().append("<a href='/servlet/exam/getTest.html'>처음으로</a>");
		response.getWriter().append("</body></html>");
		
	}

}
