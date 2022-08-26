<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String name=request.getParameter("name");
	String color=request.getParameter("color");
	String colName=null;
	
	if(color.equals("skyblue")){
		colName="하늘색";
	}else if(color.equals("yellow")){
		colName="노랑색";
	}else if(color.equals("orange")){
		colName="오렌지색";
	}else{
		color="white";
		colName="없음";
	}
%>
<body bgcolor="<%=color%>">
<%=name%>님이 좋아하는 색상은 <%=colName%>입니다
</body>
</html>