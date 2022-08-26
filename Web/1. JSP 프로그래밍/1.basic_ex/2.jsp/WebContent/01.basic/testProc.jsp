<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String[] ho=request.getParameterValues("hobby");
	if(ho != null){
%>
		<h3>** 당신의 취미 **</h3>		
<%		
		for(int i=0; i<ho.length; i++){
%>
			<li><%=ho[i]%></li>
<%			
		}
	}
	//----------------------------------------------------------------------
%>
	<h3>** 당신의 좋아하는것 **</h3>		
<%	
	Enumeration e=request.getParameterNames();
	while(e.hasMoreElements()){
		String title=(String)e.nextElement();
		String[] value=request.getParameterValues(title);
		
		if(title.equals("hobby")) {
			continue;
		}
		
		for(int i=0; i<value.length; i++){
%>
			<li><%=title%>: <%=value[i]%></li>
<%			
		}
	}
%>
</body>
</html>











