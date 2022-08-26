package com.study.basic;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.study.util.DBUtil;

@WebServlet("/counter")
public class CounterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private DBUtil dbUtil;
	
	@Override
	public void init() {
		dbUtil = DBUtil.getInstance();
	}

	//	당신은 XXXXXXXX번째 방문자입니다.
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		1. data get
		int cnt = 0;
		int totalLen = 8;
		int zeroLen = 0;
		
//		DB Logic
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			//DB 연결
			conn = dbUtil.getConnection();
			
			//1. DB 실행 준비
			String sql = "select cnt from counter";
			pstmt = conn.prepareStatement(sql);
			
			//1. DB 실행
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1);
			
			//1. 실행 종료
			pstmt.close();
			
			//2. DB 실행준비
			sql = "update counter set cnt = cnt + 1";
			pstmt = conn.prepareStatement(sql);
			//2. DB 실행
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null)
					rs.close();
				if(pstmt != null)
					pstmt.close();
				if(conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
//		Business Logic
		String cntStr = cnt + ""; //"138"
		int cntLen = cntStr.length(); // 3
		zeroLen = totalLen - cntLen;
		
//		3. response page
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("	<body>");
		out.println("		<div align=\"center\">");
		out.print("당신은 ");
		for(int i=0;i<zeroLen;i++)
			out.print("<img src=\"/basic/img/img_0.png\" width=\"80\">");
		for(int i=0;i<cntLen;i++)
			out.print("<img src=\"/basic/img/img_" + cntStr.charAt(i) + ".png\" width=\"80\">");
		out.println("번째 방문자입니다.");
		out.println("		</div>");
		out.println("	</body>");
		out.println("</html>");
	}

}
