<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="shortcut icon" href="/images/logo/png/favicon.ico"image/x-icon">
	<link rel="icon" href="/images/logo/png/favicon.ico" type="image/x-icon">
	<title>Food Street</title>
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
				<h1 class="border bg-light p-2 fs-4 mt-4">문의하기</h1>
			</div>
		</div>
		<div class="row mb-3">
			<div class="col-12">
				<table class="table">
					<thead>
						<tr>
							<th style="width: 10%;">번호</th>
							<th style="width: 35%;">제목</th>
							<th style="width: 10%;">조회수</th>
							<th style="width: 10%;">댓글수</th>
							<th style="width: 20%;">작성자</th>
							<th style="width: 15%;">등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty result.boards}">
								<c:forEach items="${result.boards}" var="board">
									<tr>
										<td>${board.no}</td>
										<td><a href="detail?no=${board.no}" >${board.title}</a></td>
										<td>${board.readCount}</td>
										<td>${board.reviewCount}</td>
										<td>${board.user.email}</td>
										<td><fmt:formatDate value="${board.createDate}" pattern="yyyy년 M월 d일"/></td>
									</tr>
								</c:forEach>
							
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6" class="text-center">게시글이 존재하지 않습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<sec:authorize access="isAuthenticated()">
					<div class="text-end">
						<a href="/inquiry/post" class="btn btn-primary btn-sm">새 게시글</a>
					</div>
				</sec:authorize>
				
			</div>
		</div>
		<div class="row mb-3" >
			<div class="col-12">
			<c:if test="${result.pagination.totalRows gt 0 }">
				<c:set var="currentPage" value="${result.pagination.page }" />
				<c:set var="first" value="${result.pagination.first }"/>
				<c:set var="last" value="${result.pagination.last }"/>
				<c:set var="prePage" value="${result.pagination.prePage }"/>
				<c:set var="nextPage" value="${result.pagination.nextPage }"/>
				<c:set var="beginPage" value="${result.pagination.beginPage }"/>
				<c:set var="endPage" value="${result.pagination.endPage }"/>
				<nav>
						<ul class="pagination justify-content-center">
							<li class="page-item ${first ? 'disabled' : ''}">
								<a href="list?page=${prePage }" class="page-link" >이전</a>
							</li>
									
							<c:forEach var="num" begin="${beginPage }" end="${endPage }">
								<li class="page-item ${currentPage eq num ? 'active' : '' }">
									<a href="list?page=${num }" class="page-link" >${num }</a>
								</li>
							</c:forEach>
									
							<li class="page-item ${last ? 'disabled' : ''}">
								<a href="list?page=${nextPage }" class="page-link" >다음</a>
							</li>
						</ul>
				</nav>
			</c:if>
				
			</div>
		</div>
	</div>
<%@ include file="../common/footer.jsp"%>
</div>
</body>
</html>