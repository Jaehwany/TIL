package com.study.method;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 강력새로고침: ctrl + shift + r
@WebServlet(name = "POST", urlPatterns = { "/post.do" })
public class PostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.한글처리(UTF-8, EUC-KR등)
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");    // POST방식의 한글처리
		
		//2.데이터가져오기
		String name=request.getParameter("name");
		int score=Integer.parseInt(request.getParameter("score"));
		String result=null;
		
		if(score>=60) {
			result="합격";
		}else {
			result="불합격";
		}
		
		//3.출력
		response.getWriter().append("<html><head><title></title></head>");
		response.getWriter().append("<body>");
		
		response.getWriter().append("이름:"+ name + "<br>");
		response.getWriter().append("점수:"+ score + "<br>");
		response.getWriter().append("결과:"+ result + "<br>");
		
		response.getWriter().append("<a href='exam/postTest.html'>처음으로</a>");
		response.getWriter().append("</body></html>");
	}
}
