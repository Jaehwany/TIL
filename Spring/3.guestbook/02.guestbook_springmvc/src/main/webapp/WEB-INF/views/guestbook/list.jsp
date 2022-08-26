<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<c:if test="${empty userinfo}">
	<script type="text/javascript">
		alert("로그인 후 이용 가능한 페이지입니다.");
		location.href = "${root}/user/login";
	</script>
</c:if>
<c:if test="${!empty userinfo}">
	<c:if test="${!empty msg}">
	<script>
	alert("${msg}");
	</script>
	</c:if>
    <script type="text/javascript">
        $(document).ready(function () {
        	
        	if("${key}")
        		$("#skey").val("${key}").prop("selected", true);
        	
        	$("#mvRegisterBtn").click(function () {
                location.href = "${root}/guestbook/register";
            });
        	
        	$("#searchBtn").click(function () {
                var word = $("#sword").val();
                if(word == "") {
                	alert("모든 목록 조회!!!");
                }
                $("#searchform").attr("action", "${root}/guestbook/list").submit();
            });
        	
        	$(".page-item").click(function() {
				$("#pg").val(($(this).attr("data-pg")));
				$("#pageform").attr("action", "${root}/guestbook/list").submit();
			});
        });
    </script>

	<form name="pageform" id="pageform" method="GET" action="">
		<input type="hidden" name="pg" id="pg" value="">
		<input type="hidden" name="key" id="key" value="${key}">
		<input type="hidden" name="word" id="word" value="${word}">
	</form>
    <div class="container text-center mt-3">
        <div class="col-lg-8 mx-auto">
        	<%@ include file="/WEB-INF/views/include/confirm.jsp" %>
            <h2 class="p-3 mb-3 shadow bg-light"><mark class="sky">글목록</mark></h2>
            <div class="m-3 text-right">
                <button type="button" id="mvRegisterBtn" class="btn btn-link">글작성</button>
            </div>
            <div class="m-3 row justify-content-end">
            	<form id="searchform" class="form-inline" method="get">
            		<input type="hidden" name="pg" value="1">
	            	<select id="skey" name="key" class="form-control">
	            		<option value="userid"> 아이디
	            		<option value="articleno"> 글번호
	            		<option value="subject"> 제목
	            	</select>
	            	<input type="text" class="ml-1 form-control" id="sword" name="word" value="${word}">
	            	<button type="button" id="searchBtn" class="ml-1 btn btn-outline-primary">검색</button>
            	</form>
            </div>
		<c:if test="${!empty articles}">
			<c:forEach var="article" items="${articles}">
			<table class="table table-active text-left">
				<tbody>
					<tr class="table-info">
						<td>작성자 : ${article.userName}</td>
						<td class="text-right">작성일 : ${article.regTime}</td>
					</tr>
					<tr>
						<td colspan="2" class="table-danger">
							<strong>${article.articleNo}. ${article.subject}</strong>
						<c:if test="${userinfo.userId eq article.userId}">
							<a href="${root}/guestbook/modify?articleno=${article.articleNo}">수정</a>
							<a href="${root}/guestbook/delete?articleno=${article.articleNo}">삭제</a>
						</c:if>
						</td>
					</tr>
					<tr>
						<td class="p-4" colspan="2">
							${article.content}
						</td>
					</tr>
				</tbody>
			</table>
			</c:forEach>
			<div>${navigation.navigator}</div>
		</c:if>
		<c:if test="${empty articles}">
			<table class="table table-active text-center">
				<tr class="table-info">
					<td>작성한 글이 없습니다.</td>
				</tr>
			</table>
		</c:if>
		</div>
    </div>
</body>
</html>
</c:if>