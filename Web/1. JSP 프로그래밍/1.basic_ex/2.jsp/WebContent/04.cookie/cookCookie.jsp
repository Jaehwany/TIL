<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Cookie cook1=new Cookie("log1", "apple");
	Cookie cook2=new Cookie("log2", "orange");

	/*쿠키 등록*/
	response.addCookie(cook1);
	response.addCookie(cook2);
%>
쿠키가 생성되었습니다<br>
쿠키 확인은 <a href="testCookie1.jsp">여기로</a>
</body>
</html>