<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<p>**국가별 감사합니다 **</p>
한국어:
<jsp:include page="greeting.jsp">
	<jsp:param value="kor" name="country"/>
</jsp:include><br><br>

중국어:
<jsp:include page="greeting.jsp">
	<jsp:param value="chn" name="country"/>
</jsp:include><br><br>

일본어:
<jsp:include page="greeting.jsp">
	<jsp:param value="jpn" name="country"/>
</jsp:include><br><br>
</body>
</html>