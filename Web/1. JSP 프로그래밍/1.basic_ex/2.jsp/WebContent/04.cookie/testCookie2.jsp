<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Cookie[] cook=request.getCookies(); //쿠키 가져오기
	if(cook != null){
		for(int i=0; i<cook.length; i++){
%>
			쿠키이름: <%=cook[i].getName()%><br>
			쿠키 값: <%=cook[i].getValue()%><br><br>
<%			
		}
	}
%>
</body>
</html>