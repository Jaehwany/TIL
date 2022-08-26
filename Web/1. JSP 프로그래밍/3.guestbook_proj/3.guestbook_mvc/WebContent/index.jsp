<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/include/header.jsp" %>


	<div align="center">
		<h3>방명록!!!</h3>
		<c:if test="${empty userInfo}">
			<a href="${root}/user?act=mvregister">회원가입</a>
			<a href="${root}/user?act=mvlogin">로그인</a>
		</c:if>
		
		<c:if test="${!empty userInfo}">
			<strong>${userInfo.userName}(${userInfo.userId})</strong>님 안녕하세요
			<a href="${root}/user?act=logout">로그아웃</a>
			<br>
			<a href="${root}/article?act=list&pg=1&key=&word=">글목록</a>	
		</c:if>	
	</div>
	
	
<%@ include file="/include/footer.jsp" %>