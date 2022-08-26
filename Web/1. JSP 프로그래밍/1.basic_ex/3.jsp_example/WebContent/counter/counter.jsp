<%@page import="com.study.util.DBUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>

<%!private DBUtil dbUtil;

	@Override
	public void init() {
		dbUtil = DBUtil.getInstance();
	}
%>

<%
	//1. data get
	int cnt = 0;
	int totalLen = 8;
	int zeroLen = 0;

	//DB Logic
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
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	//Business Logic
	String cntStr = cnt + ""; //"138"
	int cntLen = cntStr.length(); // 3
	zeroLen = totalLen - cntLen;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
		<h2>JSP로 만든 카운터</h2>
		<%
			for (int i = 0; i < zeroLen; i++) {
		%>
		<img src="/basic/img/img_0.png" width="80">
		<%
			}
			for (int i = 0; i < cntLen; i++) {
		%>
		<img src="/basic/img/img_<%=cntStr.charAt(i)%>.png" width="80">
		<%
			}
		%>
	</div>
</body>
</html>



















