<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
${title}<br>
<c:forEach items="${color}" var="ob">
	${ob}<br>
</c:forEach><br>

<c:forEach var="n" begin="1" end="${num}">
	${n}&nbsp;&nbsp;&nbsp;
</c:forEach><br>

<a href="index.html">처음으로</a>
</body>
</html>