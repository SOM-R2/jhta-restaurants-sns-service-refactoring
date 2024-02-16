<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<link rel="shortcut icon" href="/images/logo/png/favicon.ico"image/x-icon">
	<link rel="icon" href="/images/logo/png/favicon.ico" type="image/x-icon">
	<title>Food Street</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
<%@ include file="../common/navbar.jsp" %>
<div class="wrap">
<div class="container">
	<div class="row mb-3">
		<div class="col-12">
			<h1 class="border bg-light p-2 fs-4">새 문의사항 등록</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12">
			<form class="border bg-light p-3" method="post" action="post" >
				<div class="form-group mb-3">
					<label class="form-label">제목</label>
					<input type="text" class="form-control" id="post-title" name="title"  />
				</div>
				<div class="form-group mb-3">
					<label class="form-label">내용</label>
					<textarea rows="5" class="form-control" id="post-content" name="content"  ></textarea>
				</div>
				<div class="text-end">
					<a href="list?page=1" class="btn btn-secondary btn-sm">취소</a>
					<button type="submit" class="btn btn-primary btn-sm">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
</div>
</body>
</html>