<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>second.jsp</title>
</head>
<body>
<h3>3초후에 페이지가 넘어갑니다</h3>
<%
	response.setHeader("Refresh", "3;url=third.jsp");  //3초후에 third.jsp로 이동
%>
</body>
</html>


