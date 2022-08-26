<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파라미터전송결과</title>
</head>
<body>
<div align="left">
${data.username}(${data.userid})님이 좋아하는 과일은
<c:if test="${!empty data.fruit}">
	<c:set var="len" value="${data.fruit.size()}"/>
	<c:forEach varStatus="idx" var="fruit" items="${data.fruit}">
	${fruit}<c:if test="${idx.index ne len - 1 }">, </c:if>
	</c:forEach>입니다.
</c:if>
<c:if test="${empty data.fruit}">없습니다.</c:if>
</div>
</body>
</html>