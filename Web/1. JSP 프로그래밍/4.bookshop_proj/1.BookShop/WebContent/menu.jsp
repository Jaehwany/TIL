<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	p{	color:green;font-weight: bold;	font-size: 30px;}
	body { margin: 0; padding: 0; }
	#menu { height: 100px; background-color: #eee;	}
	a { display:inline-block;  margin-top:40px; text-decoration: none; font: bold;  
	    width: 100px; text-align: center; }
	#login_info { font-size: 12px; }
</style>
</head>
<body>
<div id="menu">
<a href="/bkshop/index.jsp">HOME</a>
<%
	String userid=(String)session.getAttribute("logOK");
	if(userid==null){
%>
		<a href="/bkshop/login/login.jsp">로그인 화면</a>
<%		
	}else{
%>
		<a href="/bkshop/book/bookInsert.jsp">도서등록</a>
		<a href="/bkshop/listBook">도서목록</a>
		<a href="/bkshop/logout">로그아웃</a>
		<span id="login_info"><b><%=userid%></b>님이 로그인 하셨습니다</span>
<%		
	}
%>
</div>
<hr>














