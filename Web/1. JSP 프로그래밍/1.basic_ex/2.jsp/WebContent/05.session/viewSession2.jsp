<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Enumeration ob=session.getAttributeNames();
	while(ob.hasMoreElements()){
		String name=(String)ob.nextElement();             
		String value=(String)session.getAttribute(name);  
%>		
		세션이름: <%=name%><br>
		세션 값: <%=value%><br>
		세션 id: <%=session.getId()%><br><br>
<%		
	}
%>
</body>
</html>