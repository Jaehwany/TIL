<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../menu.jsp"%>    
<%
	request.setCharacterEncoding("UTF-8");
%>
<form action="/log/emp" method="post">
	<input type="hidden" name="action" value="updateemp">
	<table border="0" width="300" align="center">
		<tr>
			<td>사원번호</td>
			<td><input type="text" name="eno" value="<%=request.getParameter("eno") %>" readonly></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="ename" value="<%=request.getParameter("ename") %>" readonly></td>
		</tr>
		<tr>
			<td>연락처</td>
			<td><input type="text" name="phone" value="<%=request.getParameter("phone") %>"></td>
		</tr>
		<tr>
			<td>부서명</td>
			<td><input type="text" name="dept" value="<%=request.getParameter("dept") %>"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="수정하기">
				<input type="button" value="취소하기" onclick="javascript:history.go(-1)">
			</td>
		</tr>
	</table>
</form>
</body>
</html>