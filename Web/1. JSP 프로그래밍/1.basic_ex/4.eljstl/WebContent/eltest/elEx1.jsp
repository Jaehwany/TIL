<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>** 간단한 표현언어(EL) **</h3>
<table border="1">
	<tr>
		<td>표현식</td><td>값</td>
	</tr>
	<tr>
		<td>\${2+5}</td><td>${2+5}</td>
	</tr>
	<tr>
		<td>\${4/5}</td><td>${4/5}</td>
	</tr>
	<tr>
		<td>\${7 mod 5}</td><td>${7 mod 5}</td>
	</tr>
	<tr>
		<td>\${2 &lt; 5}</td><td>${2 < 5}</td>
	</tr>
	<tr>
		<td>\${2 gt 5}</td><td>${2 gt 5}</td>
	</tr>
	<tr>
		<td>\${(5>3)?5:3}</td><td>${(5>3)?5:3}</td>
	</tr>
	<tr>
		<td>\${header['host']}</td><td>${header['host']}</td>
	</tr>
</table>
</body>
</html>