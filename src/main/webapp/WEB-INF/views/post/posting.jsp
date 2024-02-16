<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>         
<!DOCTYPE html>
<html lang="ko">
<head>
	<link rel="shortcut icon" href="/images/logo/png/favicon.ico"image/x-icon">
	<link rel="icon" href="/images/logo/png/favicon.ico" type="image/x-icon">
    <title>Food Street</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<style type="text/css">
		#offcanvasExample {
		    width: 40%;
		}
		.card-image {
			width: 270px;
			height: 270px;
			object-fit:cover;
		}
		
	</style>
</head>
<body>
<%@ include file="../common/navbar.jsp" %>
<div class="wrap mt-2"> 
	<div class="container mt-3" style="width:1320px;">
		<div class="row text-center border-top mt-3 bg-light border-bottom" style="width:1320px;">
			<div class="col-12 mt-5">
				<h2><strong>${post.post.title}</strong></h2>
				<h4 class="text-secondary">" ${post.post.subTitle} "</h4>
			</div>
			<div class="d-flex justify-content-end">
					<div class="text-center" style="width: 80px;">
						<img id="userImage-nav" onclick="location.href='/user/details?id=${post.post.customer.id}'" src="/images/user/png/${post.post.customer.username }"
											 class="rounded-circle shadow-sm object-fit-cover border mb-1 me-1" 
											 onerror="this.onerror=null; this.src='/images/user/png/user-default-image.png';" alt="User Image" style="width: 50px; height: 50px;"/><br>
						<div class="btn badge text-bg-success bg-opacity-50 text-secondary-emphasis fw-light rounded-pill mb-1" onclick="location.href='/user/details?id=${post.post.customer.id}'"><strong >${post.post.customer.username }</strong></div>
					</div>
			</div>
		</div>
	</div>
	<div class="container mt-2">
		<c:forEach var="data" items="${post.postDatas }">
			<div class="row border-bottom" style="width:1320px;">
				<div class="col-4 my-5">
					<div class="text-center text-light font-weight-bold" onclick="location.href='/store/detail?id=${data.storeId}'" style=" cursor: pointer;">
						<img src="/images/post/jpeg/${data.pictureFile }" class="card-image" alt="...">
					</div>
				</div>
				<div class="col-6 my-5 text-left">
					<div class="d-flex">
						<h3 onclick="location.href='/store/detail?id=${data.storeId}'" style=" cursor: pointer;">${data.storeName }</h3>
						<h3 class="ms-3" style="color:#FF8200;"><strong><fmt:formatNumber value="${data.averageRating }" pattern="#.#" /></strong></h3>
						
					</div>
					<p class="text-secondary">${data.storeAddress }</p>
					<p>${data.content }</p>
				</div>
				<div class="bookmark col-2 my-5 position-relative" id="box-${data.storeId}" >
					
					<button class="btn ms-3 position-absolute" id="box">
						<i class="bi ${not empty data.bookmark ? 'bi-star-fill' : 'bi-star'}" id="star-${data.storeId}" index-id ="${data.storeId}" style="color:gold; font-size:28px;" ></i>
					</button>
						
				</div>
			</div>
		</c:forEach>
		
		<div class="row my-3 justify-content-center" style="width:1320px;">
			<div class="col-11 text-end">
				<div style="bottom:0;right:0;">
					<button class="btn btn-lg" name="showReviewsButton" style="bottom:0; font-size:22px;" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample" aria-controls="offcanvasExample" data-store-id="${data.store.id}">
						<i class="bi bi-chat-text"></i>
						<span class="visually-hidden">댓글</span>
					</button>
					<div class="offcanvas offcanvas-end offcanvas-size-xl" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
					  	<div class="offcanvas-header">
					    	<h5 class="offcanvas-title" id="offcanvasExampleLabel">Comment</h5>
					    	<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
					  	</div>
					  	<div class="offcanvas-body">
							<div class="col-12 border-top  my-3"></div>
								<sec:authorize access="isAuthenticated()">
									<div class="col-12  border-bottom my-3">
										<form id="postComment" method="post" action="/post/commentRegister">
											<input type="hidden" name="postId" value="${post.post.id }"/>
											<sec:authentication property="principal.user.id" var="userId"/>
											<div class="text-start">
			                                    <textarea placeholder="댓글을 작성하세요" class="form-control-plaintext"
			                                                          name="content" style="min-height:2rem"></textarea>
		                                    </div> 
		                                    <button class="btn btn-outline-secondary btn-sm my-2">작성</button>
										</form>
									</div>
								</sec:authorize>
							
							<c:forEach var="comment" items="${post.postComments }">
								<div class="col-12  border-bottom my-3">
									
									<div class="row my-3">
										<div class="col-2 text-center">
											<div class="d-flex justify-content-center align-items-center">
										      <img id="userImage" src="/images/user/png/${comment.customer.username}" onerror="this.onerror=null; this.src='/images/user/png/user-default-image.png';" alt="User Image" class="rounded-circle shadow-sm object-fit-cover ms-2 mt-2" style="width: 60px; height: 60px;"/>
										    </div>
											<div class="card-text mt-1 ms-2">
												<span class="btn badge text-bg-success bg-opacity-50 text-secondary-emphasis rounded-pill" onclick="location.href='/user/details?id=${comment.customer.id}'"><strong >${comment.customer.username }</strong></span>
											</div>
										</div>
										
										<div class="col-10">
											<div class="row mb-2">
												<div class="col text-start">
													<div class="card-text text-muted" style="font-size: small; ">  
														<span><fmt:formatDate value="${comment.updateDate }" pattern="yyyy/MM/dd HH:mm"></fmt:formatDate></span>
													</div>
													<div class="card-text" style="white-space: normal; word-wrap: break-word;">
														<div>${comment.content }</div>
													</div>
													
												</div>
												
											</div>
											<div class="row">
												<div class="col">
													<sec:authorize access="isAuthenticated()">
															<c:if test="${userId eq comment.customer.id }">
																<form id="postComment" method="post" action="/post/deleteComment">
																<div class="text-end">
																	<sec:authentication property="principal.user.id" var="userId" />
																	<input type="hidden" name="postId" value="${post.post.id }"/>
																	<input type="hidden" name="commentId" value="${comment.id }"/>
																	<button type="button" class="btn deleteComment-button" style="color:#EB0000" onclick="confirmDelete('${comment.id }')" data-comment-id="${comment.id }">
																		<i class="bi bi-trash3"></i>
																		<span class="visually-hidden">삭제</span>
																	</button>
																</div>
																</form>
															</c:if>
													</sec:authorize>
												</div>
											</div>
										</div>
									</div>	
								</div>
							</c:forEach>
					  	</div>
					</div>
					<button type="button" class="btn btn-lg" >
						<sec:authorize access="isAuthenticated()">
							<sec:authentication property="principal.user.id" var="userId" />
						</sec:authorize>
			            <i id="heart" class="bi ${post.post.id eq post.postLikeDto.postId && userId eq post.postLikeDto.customerId ? 'bi-heart-fill' : 'bi-heart'}" data-post-id="${post.post.id }" style="font-size: 22px; color:#EB0000;"></i>
			            <span class="visually-hidden">추천</span>
			        </button>
			        <sec:authorize access="isAuthenticated()">
		        		<sec:authentication property="principal.user.id" var="userId" />	
			        	<c:if test="${userId eq post.post.customer.id }">
					        <button type="button" class="btn btn-lg delete-button" style="font-size: 22px; color:#EB0000" data-post-id="${post.post.id}">
								<i class="bi bi-trash3"></i>
								<span class="visually-hidden">삭제</span>
							</button>
			        	</c:if>
			        </sec:authorize>
			        <div class="modal fade" id="confirmDeleteModal" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
					  <div class="modal-dialog" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="confirmDeleteModalLabel">게시물 삭제 확인</h5>
					      </div>
					      <div class="modal-body text-start">
					        게시물을 삭제하시겠습니까?
					      </div>
					      <div class="mb-2 me-2">
					        <button type="button" class="btn btn-secondary" id="confirmCancel">Cancel</button>
					        <button type="button" class="btn btn-danger" id="confirmDelete">Delete</button>
					      </div>
					    </div>
					  </div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	<%@ include file="../common/footer.jsp" %>
</div>

<script type="text/javascript">

	const myOffcanvas = document.getElementById("offcanvasExample");
	myOffcanvas.addEventListener("hide.bs.offcanvas", function() {
		$(".offcanvas-backdrop").remove();
	})
	
	myOffcanvas.addEventListener("shown.bs.offcanvas", function() {
	    document.body.style.overflow = "hidden";
	});
	
	myOffcanvas.addEventListener("hidden.bs.offcanvas", function() {
	    document.body.style.overflow = "auto";
	});
	
	$("[id^=box-]").on('click', '[id^="star-"]', function(){
		
	    // Spring Security에서 제공하는 principal을 사용하여 로그인 상태 확인
	    if (${pageContext.request.userPrincipal != null}) {

	    	let bookmarkIdd = $(this).attr('index-id');
			//fill -> blank
			if ($(this).hasClass('bi-star-fill')) {
					$(this).removeClass('bi-star-fill').addClass('bi-star')
					$.getJSON('/bookmark/delete', {storeId : bookmarkIdd});
			//blank -> fill		
			} else {
				$(this).removeClass('bi-star').addClass('bi-star-fill')
				$.getJSON('/bookmark/insert', {storeId : bookmarkIdd});

			}
	    } else {
	       // 로그인되지 않은 경우, 로그인 페이지 열기
	        window.location.href = "/user/login";
	    }
	});
	
	$("#heart").click( function(){
		
	    // Spring Security에서 제공하는 principal을 사용하여 로그인 상태 확인
	    if (${pageContext.request.userPrincipal != null}) {
			//로그인 했을 때
	    	let postId = $(this).attr('data-post-id');;
			//like- fill -> blank
			if ($(this).hasClass('bi-heart-fill')) {
					$(this).removeClass('bi-heart-fill').addClass('bi-heart')
					$.getJSON('/post/like/delete', {postId : postId});
			//like- blank -> fill		
			} else {
				$(this).removeClass('bi-heart').addClass('bi-heart-fill')
				$.getJSON('/post/like/insert', {postId : postId});

			}
	    } else {
	       // 로그인되지 않은 경우, 로그인 페이지 열기
	       	alert("로그인이 필요합니다");
	        window.location.href = "/user/login?error=anonymous";
	    }
	});
	
	$(".delete-button").click(function () {
	    let postId = $(this).data("post-id");
	    // 모달 표시
	    $('#confirmDeleteModal').modal('show');

	    // 확인 버튼 클릭 시
	    $('#confirmDelete').click(function() {
	        $.ajax({
	            url: '/post/detail/delete',
	            type: 'POST',
	            data: { id: postId },
	            success: function () {
	                // 서버 요청이 성공할 때 실행할 코드
	                $('#confirmDeleteModal').modal('hide');
	                window.history.back();
	            },
	            error: function () {
	                // 서버 요청이 실패할 때 실행할 코드
	                alert('게시물 삭제 중 오류가 발생했습니다.');
	                $('#confirmDeleteModal').modal('hide');
	            }
	        });
	    });

	    $('#confirmCancel').click(function(){
	        $('#confirmDeleteModal').modal('hide');
	    });
	});
     
     
     $(".deleteComment-button").click(function () {
    	    let commentId = $(this).data("comment-id");
    	  
    	    // 모달 표시
    	    $('#confirmDeleteModal').modal('show');
    	    
    	    // 확인 버튼 클릭 시
    	    $('#confirmDelete').click(function() {
    	        // 서버로 삭제 요청 보내기
    	        $.getJSON('/post/deleteComment', {commentId : commentId});
	            $('#confirmDeleteModal').modal('hide');
	            window.location.reload();
    	    });
    	  
    	    $('#confirmCancel').click(function(){
    	        // 취소 버튼 클릭 시, 모달 닫기
    	        $('#confirmDeleteModal').modal('hide');
    	    })
    	});
</script>
</body>
</html>