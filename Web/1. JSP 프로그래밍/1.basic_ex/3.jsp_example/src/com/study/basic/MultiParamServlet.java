package com.study.basic;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/multiparam")
public class MultiParamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		process(request, response);
	}
	
	protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		1. data get
		String name = request.getParameter("username");
		String id = request.getParameter("userid");
		String[] fruit = request.getParameterValues("fruit");
		
//		2. logic 
		
//		3. response page
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("	<body>");
		out.print(name + "(" + id + ")님이 좋아하는 과일은 ");
		if(fruit != null) {
			int len = fruit.length;
			for(int i=0;i<len;i++) {
				out.print(fruit[i]);
				if(i != len - 1)
					out.print(", ");
			}
			out.println("입니다.");
		} else {
			out.println("없습니다.");
		}
		out.println("	</body>");
		out.println("</html>");
	}

}
