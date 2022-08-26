<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Cookie[] cook=request.getCookies(); //쿠키 가져오기
	if(cook != null){
		for(int i=0; i<cook.length; i++){
%>
			Cookie Name: <%=cook[i].getName()%><br>
			Cookie Value: <%=cook[i].getValue()%><br><br>
<%		
			if(cook[i].getName().equals("log1")){
				cook[i].setMaxAge(0);                  // 쿠키 설정시간을 0으로 변경(쿠키제거)
				response.addCookie(cook[i]);
			}
		}
	}
%>
<a href="testCookie2.jsp">다음으로 이동</a>
</body>
</html>