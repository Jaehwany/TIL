<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(request.getParameter("country").equals("kor")){
%>
		감사합니다
<%		
	}else if(request.getParameter("country").equals("chn")){
%>
		谢谢
<%		
	}else if(request.getParameter("country").equals("jpn")){
%>
		ありがとうございます
<%		
	}
%>
