<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="../menu.jsp"/> 

<c:if test="${!empty booklist}">
		<table border="1" align="center" width="600">
			<tr>
				<td>도서코드</td>
				<td>책이름</td>
				<td>저자</td>
				<td>출판사</td>
				<td>가격</td>
				<td>수정</td>
				<td>삭제</td>
			</tr>
			<c:forEach items="${booklist}" var="ob">
			<tr>
				<td>${ob.isbn}</td>
				<td>${ob.title}</td>
				<td>${ob.author}</td>
				<td>${ob.company}</td>
				<td><fmt:formatNumber value="${ob.price}" groupingUsed="true"/>원</td>
				<td>
					<form action="/bkshop/book/bookUpdate.jsp" method="post">
						<input type="hidden" name="isbn" value="${ob.isbn}">
						<input type="hidden" name="title" value="${ob.title}">
						<input type="hidden" name="author" value="${ob.author}">
						<input type="hidden" name="company" value="${ob.company}">
						<input type="hidden" name="price" value="${ob.price}">
						<input type="submit" value="수정">						         
					</form>
				</td>
				<td>
					<form action="/bkshop/deleteBook" method="post">
						<input type="hidden" name="isbn" value="${ob.isbn}">
						<input type="submit" value="삭제" onclick="return confirm('삭제할까요?')">	
					</form>
				</td>
			</tr>		
		</c:forEach>
		</table>
</c:if>
</body>
</html>