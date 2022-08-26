<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String str="Korea";
%>
<!-- 주석처리 부분입니다. '소스보기' 에서 보이지요? -->
<%--
	이 부분은 JSP페이지에서만 보이고 '소스보기'를 해도 보이지 않습니다
	브라우저로 내보내지 않는 문장입니다
--%>

<!-- <%=str%> 주석 안에서도 보이는 변수 --> 
<%=str /* 표현식 안에서도 주석처리가 가능합니다.*/ %>
</body>
</html>