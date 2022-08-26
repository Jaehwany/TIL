<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String str="Korea Fighting";
%>
JSP명령어로 작성한 <%=str%><br><br> 

<%!
	int a=5;
	int b=3;
	
	public int plusMethod(){
		return a+b;
	}
%>
a + b = <%=plusMethod() %><br><br>

<%
	String[] color={"red","green","blue"};
%>
	<table border='1' width='200px'>
<%	
	for(int i=0; i<color.length; i++){
%>		
		<tr><td><%=i%></td>
		<td><%=color[i]%></td></tr>
<%		
	}
%>
	</table>

<%--
	String[] color={"red","green","blue"};
	out.print("<table border='1' width='200px'>");
	for(int i=0; i<color.length; i++){
		out.print("<tr><td>" + i + "</td>");
		out.print("<td>" + color[i] + "</td></tr>");
	}
	out.print("</table>");
--%>
</body>
</html>