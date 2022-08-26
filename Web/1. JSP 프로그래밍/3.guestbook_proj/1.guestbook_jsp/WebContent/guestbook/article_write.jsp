<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.study.util.*,java.sql.*"%>
<%!
	private DBUtil dbUtil;

	@Override
	public void init() {
		dbUtil = DBUtil.getInstance();
	}
%>

<%
	//1. 아이디, 제목, 내용 get
	request.setCharacterEncoding("utf-8");
	String userid = request.getParameter("userid");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");

	//2. Logic - > DB에 insert
	Connection conn = null;
	PreparedStatement pstmt = null;
	int cnt = 0;
	try {
		conn = dbUtil.getConnection();
		String sql = "insert into guestbook (userid, subject, content) \n";
		sql += "values (?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, subject);
		pstmt.setString(3, content);
		cnt = pstmt.executeUpdate();
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		dbUtil.close(pstmt, conn);
	}
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>글목록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#mvListBtn").click(function() {
			location.href = "/guestbook/guestbook/article_list.jsp";
		});
		$("#mvRegisterBtn").click(function() {
			location.href = "/guestbook/guestbook/write_form.jsp";
		});
	});
</script>
</head>

<body>
	<div class="container text-center mt-3">
		<div class="col-lg-8 mx-auto">
			<%
				if (cnt != 0) {
			%>
			<div class="jumbotron">
				<h1 class="text-primary">글작성 성공 ^^</h1>
				<p class="mt-4">
					<button type="button" id="mvListBtn" class="btn btn-outline-dark">글목록
						페이지로 이동</button>
				</p>
			</div>
			<%
				} else {
			%>
			<div class="jumbotron">
				<h1 class="text-danger">글작성 실패 T.T</h1>
				<p class="mt-4">
					<button type="button" id="mvRegisterBtn"
						class="btn btn-outline-dark">글쓰기 페이지로 이동</button>
				</p>
			</div>
			<%
				}
			%>
		</div>
	</div>
</body>

</html>