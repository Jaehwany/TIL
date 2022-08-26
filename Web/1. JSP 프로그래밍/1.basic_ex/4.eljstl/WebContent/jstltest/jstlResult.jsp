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
이름 : ${param.name}<br>
나이 : ${param.age}
<c:if test="${param.age >= 19}">
	(성인)
</c:if>
<c:if test="${param.age < 19}">
	(청소년)
</c:if><br>

좋아하는 색상 : 
<c:choose>
	<c:when test="${param.color=='red'}">빨간색</c:when>
	<c:when test="${param.color=='green'}">초록색</c:when>
	<c:when test="${param.color=='blue'}">파란색</c:when>
	<c:when test="${param.color=='magenta'}">보라색</c:when>
	<c:otherwise>기타색</c:otherwise>
</c:choose><br>
취미 : 
<c:forEach items="${paramValues.hobby}" var="ob">
	${ob}&nbsp;&nbsp;&nbsp;
</c:forEach><br><br>

<%-- 
${paramValues.hobby[0]}
${paramValues.hobby[1]}
${paramValues.hobby[2]}
${paramValues.hobby[3]}<br>

${paramValues['hobby'][0]}
${paramValues['hobby'][1]}
${paramValues['hobby'][2]}
${paramValues['hobby'][3]}
 --%>
</body>
</html>