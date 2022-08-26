<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String str=request.getParameter("str");
	int num=Integer.parseInt(request.getParameter("num"));
	
	int cnt=0;
	while(cnt < num)
	{
		++cnt;
%>
		<%=str%><br>
<%		
	}
%><br>
<a href="/lab/example/whileExample.html">뒤로</a>
</body>
</html>