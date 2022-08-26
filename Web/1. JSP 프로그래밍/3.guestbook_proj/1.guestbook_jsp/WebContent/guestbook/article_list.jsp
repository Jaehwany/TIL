<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.study.util.*, java.sql.*"%>
    
<%!
	private DBUtil dbUtil;

	@Override
	public void init() {
		dbUtil = DBUtil.getInstance();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SSAFY - 글목록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#mvRegisterBtn").click(function() {
		location.href = "/guestbook/guestbook/write_form.jsp";
	});
});
</script>
</head>

<body>
	<div class="container text-center mt-3">
		<div class="col-lg-8 mx-auto">
			<h2 class="p-3 mb-3 shadow bg-light">글목록</h2>
			<div class="m-3 text-right">
				<button type="button" id="mvRegisterBtn" class="btn btn-link"><mark class="sky">글작성</mark></button>
			</div>
	
		<%
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				//1.DB 연결
				conn = dbUtil.getConnection();
				//2.DB 실행준비
				String sql = "select articleno, userid, subject, content, regtime \n";
				sql += "from guestbook \n";
				sql += "order by articleno desc";
				pstmt = conn.prepareStatement(sql);
				//3.DB 실행
				rs = pstmt.executeQuery();
				while(rs.next()) {
		%>
		
				<table class="table table-active text-left">
				<tbody>
					<tr class="table-info">
						<td>작성자 : <%= rs.getString("userid")%></td>
						<td class="text-right">작성일 : <%=rs.getString("regtime")%> </td>
					</tr>
					<tr>
						<td colspan="2" class="table-danger">
						<strong><%=rs.getInt("articleno")%>. <%=rs.getString("subject")%></strong>
						</td>
					</tr>
					<tr>
						<td class="p-4" colspan="2"> <%=rs.getString("content")%></td>
					</tr>
				</tbody>
				</table>
		<%
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				dbUtil.close(rs, pstmt, conn);
			}
		%>
			
			
		</div>
	</div>
</body>

</html>		