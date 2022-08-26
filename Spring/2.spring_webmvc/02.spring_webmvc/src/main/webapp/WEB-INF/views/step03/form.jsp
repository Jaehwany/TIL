<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>SSAFY-파라미터전달</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="col-lg-6">
			<h5 class="text-center">Spring을 이용한 파라미터 전달(Single)</h5>
			<form name="paramform" method="get" action="${root}/sendparam">
				<div class="form-group">
					<label for="userid">아이디:</label> <input type="text"
						class="form-control" placeholder="아이디 입력" name="userid">
				</div>
				<div class="form-group">
					<label for="username">이름:</label> <input type="text"
						class="form-control" placeholder="이름 입력" name="username">
				</div>
				<div class="form-group">
					<label for="area">지역:</label> <select name="area"
						class="custom-select">
						<option value="0">서울</option>
						<option value="1" selected>대전</option>
						<option value="2">구미</option>
						<option value="3">광주</option>
						<option value="4">부울경</option>
					</select>
				</div>
				<button type="submit" class="btn btn-primary">전송</button>
			</form>
		</div>
		<hr>
		<div class="col-lg-6">
			<h5 class="text-center">Spring을 이용한 파라미터 전달(Multi)</h5>
			<form name="paramform" method="post" action="${root}/sendparam">
				<div class="form-group">
					<label for="userid">아이디:</label> <input type="text"
						class="form-control" placeholder="아이디 입력" name="userid">
				</div>
				<div class="form-group">
					<label for="username">이름:</label> <input type="text"
						class="form-control" placeholder="이름 입력" name="username">
				</div>
				<div class="form-group">
					<label for="">좋아하는 과일:</label>
				</div>
				<div class="form-group form-check">
					<div class="form-check-inline">
						<label class="form-check-label"> <input type="checkbox"
							name="fruit" class="form-check-input" value="딸기">딸기
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label"> <input type="checkbox"
							name="fruit" class="form-check-input" value="수박">수박
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label"> <input type="checkbox"
							name="fruit" class="form-check-input" value="포도">포도
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label"> <input type="checkbox"
							name="fruit" class="form-check-input" value="사과">사과
						</label>
					</div>
				</div>
				<button type="submit" class="btn btn-primary">Submit</button>
			</form>
		</div>
	</div>
</body>
</html>