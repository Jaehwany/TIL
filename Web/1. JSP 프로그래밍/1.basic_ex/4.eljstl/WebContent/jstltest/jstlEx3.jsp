<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<fmt:requestEncoding value="UTF-8"/>
<form action="jstlEx3.jsp" method="post">
	반복하고 싶은 문구: <input type="text" name="str" value="${param.str}"><br>
	반복하고 싶은 횟수: <input type="text" name="num" value="${param.num}"><br>
	<input type="submit" value="실행">
</form><br>

<c:forEach begin="1" end="${param.num}">
   ${param.str}<br>
</c:forEach>
</body>
</html>