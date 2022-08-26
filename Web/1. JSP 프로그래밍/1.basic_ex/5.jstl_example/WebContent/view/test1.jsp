<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- <%
	String title=(String)request.getAttribute("title");
	String name=(String)request.getAttribute("irum");
	int age=(Integer)request.getAttribute("nai");
%>
<%=title%><br>
이름: <%=name %><br>
나이: <%=age %><br> --%>

${title}<br>
이름: ${irum}<br>
나이: ${nai}<br>
<a href="index.html">처음으로</a>
</body>
</html>




