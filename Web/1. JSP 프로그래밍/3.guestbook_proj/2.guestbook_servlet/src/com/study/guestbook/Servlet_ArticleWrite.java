package com.study.guestbook;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.study.util.DBUtil;

@WebServlet("/articlewrite")
public class Servlet_ArticleWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private DBUtil dbUtil;
	
	@Override
	public void init() {
		dbUtil = DBUtil.getInstance();
	}
 
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		process(request, response);
	}

	
	protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//1. 아이디, 제목, 내용 get
		String userid = request.getParameter("userid");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		//2. Logic - > DB에 data insert
		Connection conn = null;
		PreparedStatement pstmt = null;
		int cnt = 0;
		try {
			//1.DB 연결
			conn = dbUtil.getConnection();
			//2.DB 실행준비
			String sql = "insert into guestbook (userid, subject, content) \n";
			sql += "values (?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, subject);
			pstmt.setString(3, content);
			//3.DB 실행
			cnt = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//4.DB 종료
			dbUtil.close(pstmt, conn);
		}
		
//		3. 응답페이지작성 (response page >> html)
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("    <meta charset=\"UTF-8\">");
		out.println("    <title>SSAFY - 글목록</title>");
		out.println("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
		out.println("    <link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css\">");
		out.println("    <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js\"></script>");
		out.println("    <script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js\"></script>");
		out.println("    <script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js\"></script>");
		out.println("    <script type=\"text/javascript\">");
		out.println("        $(document).ready(function () {");
		if(cnt != 0) {
			out.println("            $(\"#mvListBtn\").click(function () {");
			out.println("                location.href = \"/guestbook/articlelist\";");
			out.println("            });");
		} else {
			out.println("            $(\"#mvRegisterBtn\").click(function () {");
			out.println("                location.href = \"/guestbook/guestbook/article_write.html\";");
			out.println("            });");
		}
		out.println("        });");
		out.println("    </script>");
		out.println("</head>");
		out.println("<body>");
		out.println("    <div class=\"container text-center mt-3\">");
		out.println("        <div class=\"col-lg-8 mx-auto\">");
		if(cnt != 0) {
			out.println("            <div class=\"jumbotron\">");
			out.println("                <h1 class=\"text-primary\">글작성 성공 ^^</h1>");
			out.println("                <p class=\"mt-4\"><button type=\"button\" id=\"mvListBtn\" class=\"btn btn-outline-dark\">글목록 페이지로 이동</button>");
			out.println("                </p>");
			out.println("            </div>");
		} else {
			out.println("            <div class=\"jumbotron\">");
			out.println("                <h1 class=\"text-danger\">글작성 실패 T.T</h1>");
			out.println("                <p class=\"mt-4\"><button type=\"button\" id=\"mvRegisterBtn\" class=\"btn btn-outline-dark\">글쓰기 페이지로 이동</button>");
			out.println("                </p>");
			out.println("            </div>");
		}
		out.println("        </div>");
		out.println("    </div>");
		out.println("</body>");
		out.println("</html>");
	}

}













