<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring Web MVC</title>
</head>
<body>
<div align="center">
<h3>Spring Web MVC</h3>
<a href="${root}/hello">1. Hello Spring</a><br>
<a href="${root}/hellomvc">2. Hello Spring Web MVC</a><br>
<a href="${root}/parameter">3. parameter</a><br>
</div>
</body>
</html>