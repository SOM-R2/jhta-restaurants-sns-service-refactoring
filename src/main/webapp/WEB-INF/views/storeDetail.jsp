<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8dc99e5108c8ac0f59f4315f77a45f84&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8dc99e5108c8ac0f59f4315f77a45f84"></script>
<style type="text/css">
	.border-opacity-10.active {
	    color: #ff792a;
	}
	.img-thumbnail {
        max-height: 250px;
        object-fit: cover;
    }
</style>
</head>
<body>
<%@ include file="common/navbar.jsp" %>
<div class="wrap">
    <div class="container">
        <div class="row row-cols-5 object-fit-cover border rounded" style="cursor: pointer; margin-top: 15px;" id="review-img-thumbnail">
            <c:forEach var="recentReview" items="${recentReviews}">
                <img class="img-thumbnail" src="/images/review/jpeg/${recentReview.reviewPictures[0].pictureName }" data-review-id="${recentReview.id }" id="review-img-${recentReview.id }" alt="Thumbnail 1" onclick="openModal(this)">
            </c:forEach>
        </div>
        <c:forEach var="recentReview" items="${recentReviews }" >
	        <div id="myModal-${recentReview.id }" class="modal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); overflow: auto; z-index: 1000;">
	            <span class="close" onclick="closeModal(${recentReview.id })" style="position: absolute; top: 10px; right: 10px; font-size: 32px; color: white; cursor: pointer;">&times;</span>
	            <div class=" d-flex justify-content-center align-items-center" style="height: 100%;">
	                <div style="width: 100px;" class=" d-flex justify-content-center align-items-center">
	                    <!-- <button class="modal-nav-button" id="prevButton" onclick="changeImage(-1)" style="font-size: 2em; background: none; border: none; cursor: pointer; color: white;">
	                        &#10094;
	                    </button> -->
	                </div>
	                <div class="text-center" style="background-color: black; width: 60%;">
					    <div class="fotorama" data-nav="thumbs">
					        <img class="modal-content" id="modalImg-${recentReview.id }" style="width: auto; height: auto; max-width: 100%; max-height: 80vh; margin: auto; display: block;">
					    </div>
					</div>
	                <div style="width: 400px;" class="2">
	                    <div class="card" style="width:80%; height: 80vh; overflow: hidden;">
	                        <div class="card-body d-flex flex-column align-items-start">
	                            <div class="d-flex align-items-center mb-2">
	                                <img src="/images/user/png/${recentReview.customerName}"  onerror="this.onerror=null; this.src='/images/user/png/user-default-image.png';" alt="User Image" class="img-thumbnail rounded-circle " style="width: 60px; height: 60px;" alt="..." onclick="location.href='/user/details?id=${recentReview.customerId}'">
	                                <div class="ml-2">
	                                    <span style="font-size: medium; font-weight: bold;" id="modal-review-nickname">${recentReview.nickname }</span>
	                                </div>
	                                <div class="p-2 ml-auto">
	                                    <span class="badge bg-primary-subtle text-primary-emphasis rounded-pill" id="modal-review-rating">
	                                    <script>
									        var rating = ${recentReview.rating};
									        switch (rating) {
									            case 5:
									                document.write('맛있어요');
									                break;
									            case 3:
									                document.write('괜찮아요');
									                break;
									            case 1:
									                document.write('별로에요');
									                break;
									            default:
									                document.write(rating);
									                break;
									        }
									    </script>
								    	</span>
	                                </div>
	                            </div>         
								<div class="review" id="modal-review-content"> ${recentReview.content } </div>
	                        </div>
	                    </div>
	                </div>
	                <div style="width: 100px;" class=" d-flex justify-content-center align-items-center">
	                    <!-- <button class="modal-nav-button" id="nextButton" onclick="changeImage(1)" style="font-size: 2em; background: none; border: none; cursor: pointer; color: white;">
	                        &#10095;
	                    </button> -->
	                </div>
	            </div>
	        </div>
        </c:forEach>
        <div class="row m-4">
            <div class="col-md-8">
                <div>
                    <header>
                    <div class="row">
                        <div class="col-8">
                            <p class="restaurants_name my-3">
                                <span class="fs-4 fw-lighter">${store.name}</span>
                                <span class="rate-point mx-3 fs-3 fw-lighter" style="color: #ff792a;"><fmt:formatNumber value="${storeAvg.storeReviewAvg }" pattern="#.#" /></span>
                            </p>
                        </div>
                            <div class="col-4">
						       <span class="float-end">
							       <sec:authorize access="isAuthenticated()">
							            <sec:authentication property="principal.user.id" var="loginId"/>
							            <c:if test="${store.owner.id ne loginId}">
							                <button type="button" class="btn" style="color: #ff792a;" onclick="location.href='/review?storeId=${param.id }'">
							                    리뷰<i class="bi bi-brush"></i>
							                </button>
							                <button class="btn" id="btn-bookmark" data-store-id="${store.id }">
							                    <i id="bookmark-${store.id }" class="bi ${not empty bookmark ? 'bi-star-fill' : 'bi-star'}" style="color: gold; font-size: 28px;"></i>
							                </button>
							            </c:if>
							       </sec:authorize>
							        <sec:authorize access="!isAuthenticated()">
							            <button type="button" class="btn" style="color: #ff792a;" onclick="location.href='/review?storeId=${param.id }'">
							                리뷰<i class="bi bi-brush"></i>
							            </button>
							            <button class="btn" id="btn-bookmark" data-store-id="${store.id }">
							                <i id="bookmark-${store.id }" class="bi ${not empty bookmark ? 'bi-star-fill' : 'bi-star'}" style="color: gold; font-size: 28px;"></i>
							            </button>
							        </sec:authorize>
								</span>
							</div>
						</div>
                        <div>
                            <i class="bi bi-eye-fill" style="color: #C0C0C0;"></i><span style=" display: inline-block; margin: -6px 10px 0 0; vertical-align: middle; color: #C0C0C0;">${store.readCount }</span>
                            <i class="bi bi-pen-fill" style="color: #C0C0C0;"></i><span style=" display: inline-block; margin: -6px 10px 0 0; vertical-align: middle; color: #C0C0C0;">${reviewCount }</span>
                            <i class="bi bi-star-fill" style="color: #C0C0C0;"></i> <span style=" display: inline-block; margin: -6px 10px 0 0; vertical-align: middle; color: #C0C0C0;">${bookmarkCount }</span>
                        </div>
                        <table class="table">
                        	<tr>
                                <th style="width: 120px;"><i class="bi bi-person"></i><span class="fw-lighter mx-2">사장님</span></th>
                                <td><a class="badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill link-offset-2 link-underline link-underline-opacity-0" href="/user/details?id=${store.owner.id} ">${store.owner.username }</a></td>
                            </tr>
                            <tr>
                                <th style="width: 120px;"><i class="bi bi-geo-alt"></i><span class="fw-lighter mx-2">주소</span></th>
                                <td>${store.address}</td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-telephone"></i><span class="fw-lighter mx-2">전화번호</span></th>
                                <td>${store.phone}</td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-shop"></i><span class="fw-lighter mx-2">가게 소개</span></th>
                                <td class="small" style="white-space: pre-line;">${store.description}</td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-tag"></i><span class="fw-lighter mx-2">음식 종류</span></th>
                                <td>${store.category}</td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-alarm"></i><span class="fw-lighter mx-2">영업시간</span></th>
                                <td id="daysArea">
                                </td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-list"></i><span class="fw-lighter mx-2">메뉴</span></th>
                                <td>
                                    <c:forEach var="food" items="${foods}">
                                        <div class="col my-2 d-flex justify-content-between w-50" >
                                            <span class="food-name d-inline-block" ><c:out value="${food.name}"/></span> 
                                            <span class="food-price badge bg-secondary-subtle text-secondary-emphasis rounded-pill"><c:out value="${food.price}"/>원</span>
                                        </div>
                                    </c:forEach>
                                </td>
                            </tr>
                        </table>
                    </header>
                </div>
                <div class="row">
				    <div class="col-4">
				        <span class="fs-4 fw-lighter">리뷰</span>
				        <span class="fs-4 fw-lighter" style="color: #adb5bd;">(${reviewCount })</span>
				    </div>
				    <div class="col-8 p-1 text-end">
				        <button id="btn-review-all" type="button" class="btn border-opacity-10 active" style="background: none; border: none;">전체(${reviewSummary.total })
				        </button>
				        <button id="btn-review-good" type="button" class="btn border-opacity-10 " style="background: none; border: none;">맛있어요(${reviewSummary.good })
				        </button>
				        <button id="btn-review-soso" type="button" class="btn border-opacity-10" style="background: none; border: none;">괜찮아요(${reviewSummary.soso })
				        </button>
				        <button id="btn-review-bad" type="button" class="btn border-opacity-10" style="background: none; border: none;">별로에요(${reviewSummary.bad })
				        </button>
				    </div>
		            <div id="review-list">
		                <div id="reviewOutputArea"></div>
		            </div>    
				</div>
            </div>
            <div class="col-md-4 ps-5" style="position: relative;">
            	<div style="position: sticky; top: 0;">
	                <div id="map" style="width: 400px; height: 350px; cursor: pointer;"></div>
		                <div class=" pt-4">
		                <div class="row">
		                	<c:forEach var="closestStore" items="${closestStores }">
			                    <div class="mb-3">
			                        <h5 style="color: #ff792a;"><strong>주변 맛집 추천</strong></h5>
			                        <div class="card m-1" id="cardId" style="border-top: none; border-left: none; border-right: none; height: 120px;">
			                            <div class="d-flex align-items-start">
			                                <c:choose>
							                    <c:when test="${not empty closestStore.pictureName}">
							                        <img src="/images/review/jpeg/${closestStore.pictureName}" class="card-img" style="width: 100px; height: 100px; cursor: pointer;" onclick="location.href='/store/detail?id=${closestStore.id}'">
							                    </c:when>
							                    <c:otherwise>
							                        <img src="https://www.technol.si/wp-content/uploads/2018/11/default-image1.jpg" class="card-img" style="width: 100px; height: 100px; cursor: pointer;" onclick="location.href='/store/detail?id=${closestStore.id}'">
							                    </c:otherwise>
							                </c:choose>
			                                <div class="ml-3">
			                                    <h5 class="card-title mt-0" style="white-space: nowrap; margin-left: 5px; cursor: pointer; color: black; transition: color 0.3s; display: flex; align-items: center; "onclick="location.href='/store/detail?id=${closestStore.id }'"onmouseover="this.style.color='#ff792a';" onmouseout="this.style.color='black';"> 
			                                    	${closestStore.name } 
			                                    	<span class="badge bg-dark-subtle border border-dark-subtle text-dark-emphasis rounded-pill"><fmt:formatNumber value="${closestStore.averageRating }" pattern="#.#" /></span>
			                                    </h5>
			                                    <p class="card-text text-sm ml-1" style="white-space: nowrap;">
			                                        <span style="font-size: 12px; margin-left: 10px; display: block; height: 25px;"><strong>카테고리:</strong> ${closestStore.category }</span>
			                                        <span style="font-size: 12px; margin-left: 10px; display: block; height: 25px;"><strong>가게주소:</strong> ${closestStore.address }</span>
			                                        <span style="font-size: 12px; margin-left: 10px; display: block; height: 25px;"><strong>전화번호:</strong> ${closestStore.phone } </span>
			                                    </p>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
		                	</c:forEach>
		                	<sec:authorize access="isAuthenticated()">
		                	<c:if test="${not empty follows}">
			                	<h5 style="color: #ff792a;"><strong>리뷰 작성한 친구</strong></h5>
			                	<div style="width: 400px;">
								    <c:forEach var="follow" items="${follows}">
								        <div class="text-center" style="display: inline-block; margin-right: 10px;">
								            <img src="/images/user/png/${follow.username}" class="img-thumbnail rounded-circle" style="width: 50px; height: 50px; cursor: pointer;" alt="..." onclick="location.href='/user/details?id=${follow.id}'">
								            <br>
								            <span class="badge bg-secondary-subtle text-secondary-emphasis rounded-pill">${follow.username }</span>
								        </div>
								    </c:forEach>
								</div>              
							</c:if>
		                	</sec:authorize>
		                </div>
		            </div>
	            </div>
            </div>
        </div>
    </div>
    <!-- 지도 모달 -->
    <div class="row">
        <div class="modal fade" id="mapModal" tabindex="-1" role="dialog" aria-labelledby="mapModalLabel" aria-hidden="true">
            <div class="col-12">
                <span class="close" onclick="closeMapModal()" style="position: absolute; top: 10px; right: 10px; font-size: 32px; color: white; cursor: pointer;">&times;</span>
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <div class="modal-body">
                                <div id="largeMap" style="width: 100%; height: 800px;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="common/footer.jsp" %>
</div>
<script>
    const storeId = ${store.id};
    const loginUserId = '${pageContext.request.userPrincipal != null ? pageContext.request.userPrincipal.principal.user.id : ''}';
    
    $("#review-list").on('click', '[id^="recommend-"]', function(){
        console.log("heart-clicked");
        // Spring Security에서 제공하는 principal을 사용하여 로그인 상태 확인
        if (${pageContext.request.userPrincipal != null}) {
          //로그인 했을 때
           const reviewId = $(this).attr('review-id');
          //star- fill -> blank
          if ($(this).hasClass('bi-heart-fill')) {
                $(this).removeClass('bi-heart-fill').addClass('bi-heart')
                $.getJSON('/like/delete', {reviewId : reviewId}, function(reviews){
					$("span[review-id=" + reviewId + "]").text(reviews);
				});
          //star- blank -> fill      
          } else {
             $(this).removeClass('bi-heart').addClass('bi-heart-fill')
             $.getJSON('/like/insert', {reviewId : reviewId}, function(reviews){
					$("span[review-id=" + reviewId + "]").text(reviews);
				});
          }
        } else {
            // 로그인되지 않은 경우, 로그인 페이지 열기
            alert("로그인이 필요합니다");
            window.location.href = "/user/login?error=anonymous";
        }
    });
    

    $("#review-list").on('click', '[id^="button-add-comment-"]', function () {
        if (${pageContext.request.userPrincipal != null}) {

            const reviewId = $(this).attr('id-index');
            const commentAddButton = document.getElementById("button-add-comment-" + reviewId);
            const cardAndTextarea = document.getElementById('cardAndTextarea-' + reviewId);
            const submitButton = document.getElementById('button-addon2-' + reviewId);
			
            if ($(cardAndTextarea).css("display") == 'block') {
                cardAndTextarea.style.display = 'none';
                $(submitButton).prop("disabled", true)
            } else {
                cardAndTextarea.style.display = 'block'; // 답글 작성 영역 보임
                $(submitButton).prop("disabled", true);

                submitButton.addEventListener('click', () => {
                    cardAndTextarea.style.display = 'none';
                });
            }

        } else {
            // 로그인되지 않은 경우, 로그인 페이지 열기
            alert("로그인이 필요합니다");
            window.location.href = "/user/login?error=anonymous";
        }
    });
    
    $("#review-list").on('click', '[id^="button-view-comment-"]', function () {
        const reviewId = $(this).attr('id-index');
        const reviewCommentsOutputArea = document.getElementById('reviewCommentsOutputArea-' + reviewId);
        const commentViewButton = document.getElementById("button-view-comment-" + reviewId);

        if (reviewCommentsOutputArea.style.display === 'block') {
            reviewCommentsOutputArea.style.display = 'none';
        } else {
            reviewCommentsOutputArea.style.display = 'block';
        }
    });

    $("#review-list").on("input", '[id^="replyTextarea"]', function() {
    	
        // textarea 내용 가져오기
        let textareaContent = $(this).val().trim();
        
        // 리뷰 올리기 버튼 활성화/비활성화
        if (textareaContent === "") {
            $("button.btn-outline-secondary").prop("disabled", true);
        } else {
            $("button.btn-outline-secondary").prop("disabled", false);
        }
    });

    $("#review-list").on('click', '[id^="review-popover-"]', function(){
        	const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
    		const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl))
    })

    
    
	const reviewOutputArea = document.getElementById('reviewOutputArea');

    let pageOnReview = 1;
    let isReviewsFetching = false;
	let isReviewsLast = false;
    let reviewFetchingOption = 'all';
	let fetchedReviews = [];
    
	const getReviews = (option, page) => {
	    return fetch(`/store/detail/reviews?id=\${storeId}&page=\${page}&limit=5&option=\${option}`).then(response => response.json());
	}
	
    fetchAndRenderReviews('all', 1);

    function fetchAndRenderReviews(reviewFetchingOption, pageOnReview) {
		console.log("reviewFetchingOption:" + reviewFetchingOption)

	    isReviewsFetching = true;
	    getReviews(reviewFetchingOption, pageOnReview).then(data => {
	
	        if (data.length < 5) {
	            isReviewsLast = true;
	        }
	        
	        var item = {
	        	index: pageOnReview,
	        	data: data
	        }	 
	        fetchedReviews.push(item);
	        
	        displayReviews();

        
             isReviewsFetching = false;
         })
	}
	
	function  displayReviews() {
		reviewOutputArea.innerHTML = "";
		let sortedReviews = fetchedReviews.sort(function(item1, item2) {
			return item1.index - item2.index;
		});
		
		let reviews = [];
		sortedReviews.forEach(function(item) {
			reviews.push(...item.data)
		})
		
	    reviews.forEach(datum => {
        	/* let images = null; */
			let like;
			if(datum.isLiked==='y'){ like = 'bi-heart-fill';}
			if(datum.isLiked==='n'){ like = 'bi-heart';}
			console.info(like);
			
			let text = `
				<div class="card mb-3" style="border-top: none; border-left: none; border-right: none; border-radius: 0; box-shadow: none;" data-review-rating=\${datum.rating}>
				    <div class="card-body">
				        <div class="row">
				            <div class="col-2">
				                <div class="text-center card-title my-1">
				                    <div class="ratio ratio-1x1">
				                        <img src="/images/user/png/\${datum.customerName}" onerror="this.onerror=null; this.src='/images/user/png/user-default-image.png';" alt="User Image" class="img-thumbnail rounded-circle" onclick="location.href='/user/details?id=\${datum.customerId}'" style="cursor: pointer;">
				                    </div>
				                    <span style="white-space: nowrap; font-size: medium; font-weight: bold;" id="review-nickname-\${datum.id}">\${datum.nickname !== null ? datum.nickname : datum.customerName}</span>
				                    <span style="font-size: small; font-weight: bold; color: #ff792a;">(\${datum.reviewAvg === null ? '' : datum.reviewAvg.toFixed(1) })</span>
	                                    <span class="badge rounded-pill text-dark fw-light fs-6 my-2" style="background-color: rgba(255, 131, 7, 0.3);" id="review-rating-\${datum.id}" nclick="location.href='/review/detail?id=\${datum.id}'" style="cursor: pointer;">
	                                        \${(() => {
	                                            switch (datum.rating) {
	                                            case 5:
	                                                return '맛있어요';
	                                            case 3:
	                                                return '괜찮아요';
	                                            case 1:
	                                                return '별로에요';
	                                            default:
	                                                return datum.rating;
	                                            }
	                                        })()}
	                                   </span>
	                               </div>
	                           </div>
	                           <div class="col-10">
	                               <div class="row mb-2">
	                                   <div class="col-12" style="cursor: pointer;">
	                                       <p class="col card-text" style="font-size: small; color: #adb5bd;">\${(new Date(datum.createDate)).toISOString().slice(0, 10)}</p>
	                                       <p class="col card-text" onclick="location.href='/review/detail?id=\${datum.id}'" id="review-content-\${datum.id}">\${datum.content}</p>
	                                   </div>
	                               </div>
	                               
                                <div class="d-flex flex-nowrap overflow-auto" id="picturesOutputArea-\${datum.id}"></div>
                                <div class="d-flex flex-nowrap " id="reviewKeywordsOutputArea-\${datum.id}"></div>
                                <form action="/review/store/register" method="post" id="reviewCommentForm">
                                <input type="hidden" name="reviewId" value="\${datum.id }"/>
                               	<input type="hidden" name="storeId" value="${param.id }"/>
                                <div class="row">
                                    <div class="col" id="review-comment">
                                        <span class="float-end mt-1">
                                        	<button type="button" class="btn btn-light btn-sm text-danger position-relative mx-1">
                                      			<i id="recommend-\${datum.id}" review-id="\${datum.id}" class="bi \${like}" style="font-size: 15px;"></i> <span class="visually-hidden">추천</span>
                                        	 	<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" review-id="\${datum.id}" >
                                        	    \${datum.likedCount}
                                        	    <span class="visually-hidden"> 좋아요 수</span>
                                       		</button>
                                        	<button id="button-view-comment-\${datum.id}" id-index="\${datum.id}" type="button" class="btn btn-sm btn-light position-relative mx-1">
                                        		<i class="bi bi-chat-text"></i><span class="visually-hidden">댓글</span>
                                        		<span class="position-absolute top-0 start-100 translate-middle badge bg-primary-subtle text-primary-emphasis rounded-pill">
                                        	    \${datum.commentCount}
                                        	    <span class="visually-hidden">댓글 수</span>
                                            </button>
                                        	<button id="button-add-comment-\${datum.id}" id-index="\${datum.id}" type="button" class="btn btn-light btn-sm mx-1" style="color: #838383">
                                            	<i class="bi bi-pencil-square"></i> <span class="visually-hidden">작성</span>
                                        	</button>`;
                               
                                        if (loginUserId && parseInt(loginUserId) == datum.customerId) {
        									text += `
        										<a href="/review/del?storeId=\${storeId}&reviewId=\${datum.id}" class="btn btn-light btn-sm" style="color: #838383">
                                            		<i class="bi bi-trash3"></i> <span class="visually-hidden">삭제</span>
                                        		</a>`
        								}
        text += `
                                        </span>
                                    </div>
                                </div>
                                <div class="row">
							        <div class="col-12">
							            <div class="card"id="cardAndTextarea-\${datum.id}" id-index="\${datum.id}" style="display: none;">
							                <div class="card-body d-flex flex-row justify-content-between align-items-start">
							                    <textarea class="form-control" placeholder="리뷰에 대한 답글을 작성해주세요" aria-label="답글 작성란" aria-describedby="button-addon2" id="replyTextarea" name="content"></textarea>
							                    <button class="btn btn-outline-secondary submit-reply-button " type="submit" id="button-addon2-\${datum.id}" ><i class="bi bi-pencil"></i></button>
							                </div>
							            </div>
							            <div class="col-12" id="reviewCommentsOutputArea-\${datum.id}" style="display: none;"></div>
							        </div>
						    	</div>
						    	</form>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <div class="modal fade" id="exampleModal-\${datum.id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog d-flex justify-content-center align-items-center cursor: pointer;" style="height: 100vh;">
                            <img class="modalImg-\${datum.id}" style="max-width: 170%; max-height: 70vh;"></img>
                        </div>
                    </div>
                </div>
                `
                
                reviewOutputArea.innerHTML += text;
                
                const picturesOutputArea = document.getElementById('picturesOutputArea-' + datum.id)
                if (datum.reviewPictures) {
                    datum.reviewPictures.forEach(picture => {
                        picturesOutputArea.innerHTML += `
                            <img src="/images/review/jpeg/\${picture.pictureName}" alt="Image" class="object-fit-cover img-thumbnail review-img-\${datum.id}" style="height: 120px; width: 120px" data-bs-toggle="modal" data-bs-target="#exampleModal-\${datum.id}">
                        `
                    })
                 }
                
                 let modalImages = document.querySelectorAll(`.review-img-\${datum.id}`)
                 document.querySelector(`.modalImg-\${datum.id}`).src = modalImages[0].src;

                 let currentIndex = 0;


                 function changeReviewImages(n) {
                     currentIndex += n;
                     if (currentIndex <0) {
                         currentIndex = modalImages.length - 1;
                     } else if (currentIndex >= modalImages.length) {
                         currentIndex = 0; // 마지막 이미지로 돌아감
                     }
                     document.querySelector(`.modalImg-\${datum.id}`).src = modalImages[currentIndex].src;
                     console.log(currentIndex + ":" + modalImages[currentIndex].src);
                 }
                 
            	 document.addEventListener("keydown", function (event) {
                     if (event.keyCode === 37) {
                         changeReviewImages(-1);
                     } else if (event.keyCode === 39) {
                         changeReviewImages(1);
                     }
                 }); 

            	 
            	 const reviewKeywordsOutputArea = document.getElementById('reviewKeywordsOutputArea-' + datum.id)
            	 if(datum.reviewKeywords) {
            		 datum.reviewKeywords.forEach(keyword => { 
            			 reviewKeywordsOutputArea.innerHTML += `
            			 <span class="badge badge-sm  bg-secondary-subtle text-secondary-emphasis badge-rounded-pill fw-lighter m-2 p-1">\${keyword.keyword}</span>
            			 `
            		 })
            	 }
                
                
                 const reviewCommentsOutputArea = document.getElementById('reviewCommentsOutputArea-' + datum.id)
                 if (datum.reviewComments) {
                 	datum.reviewComments.forEach(Comment => {
                 		
                 		let commenttext = `
                 		    <div class="col-12  border-bottom my-3" id="reviewCommentsOutputArea-\${datum.id}">
                            <div class="row my-3">
                                <div class="col-1 mt-3"><i class="bi bi-arrow-return-right d-flex justify-content-end align-items-center" style="color: #b8b6b6; font-size: 30px;"></i></div>
                                <div class="col-2">
                                    <img src="/images/user/png/\${Comment.username}" onerror="this.onerror=null; this.src='/images/user/png/user-default-image.png';" alt="User Image" onclick="location.href='/user/details?id=\${Comment.userId}'" class="img-thumbnail rounded-circle shadow-sm object-fit-cover mx-2" style="cursor: pointer; width: 70px; height: 70px;">
                                    <div class="text-center card-title my-1">
                                    	<span class="btn badge rounded-pill text-dark rounded-pill" style="background-color: rgba(255, 131, 7, 0.3);" onclick="location.href='/user/details?id=\${Comment.userId}'"><strong >\${Comment.nickname !== null ? Comment.nickname : Comment.username}</strong></span>
                                    </div>
                                </div>
                                <div class="col-9 position-relative ">
                                    <div class="row">
                                    	<div class="col text-start">
                                        	<div class="card-text text-muted" style="font-size: small; ">  
                                            	<span>평균별점 \${Comment.reviewAvg === null? '' : Comment.reviewAvg.toFixed(1) } </span>
                                          		<span class="float-end">\${(new Date(Comment.createDate)).toISOString().slice(0, 10)}</span>
                                       	   	</div>
                                        <div class="card-text">
                                            <span>\${Comment.content}</span>
                                        </div>
                                    </div>
                                </div>`;
                              	if (loginUserId && parseInt(loginUserId) == Comment.userId) {
                                    commenttext += `   
                                    	<div class="row position-absolute" style="bottom:0;right:20px;">
                                        	<div class="col">
                                            	<span class="text-end">
                                             		<a href="/review/store/comment/del?storeId=\${storeId}&reviewId=\${datum.id}&reviewCommentId=\${Comment.id}" class="btn btn-light btn-sm" style="color: #838383">
                                                	<i class="bi bi-trash3" style="color:#EB0000"></i>
                                                <span class="visually-hidden">삭제</span>
                                            </a>
                                        </span>
                                    </div>
                                </div>`
								}
		commenttext += `				
								</div>
								</div>	`
        
                 		reviewCommentsOutputArea.innerHTML += commenttext;

                 	})
                 }
                 
         	})
        
	} 	

	let isCurrentReviewPicturesShowing = false;
	
 	// 모달과 이미지 요소를 가져옴
    // var modal = document.getElementById("myModal");
    
    var images = document.querySelectorAll("#review-img-thumbnail .img-thumbnail");
    console.log("사진갯수", images.length)
    var currentIndex; // 현재 이미지의 인덱스를 저장하는 변수

    // 모달을 열 때 호출되는 함수
    function openModal(image) {
    	isCurrentReviewPicturesShowing = true;
        
    	let reviewId = image.getAttribute("data-review-id");
        
 		var modal = document.getElementById("myModal-" + reviewId);
 		var modalImg = document.getElementById("modalImg-" + reviewId);
        modal.style.display = "block"; // 모달을 보이게 함
        modalImg.src = image.src; // 모달 이미지 요소의 소스를 클릭한 이미지의 소스로 설정

        // 클릭한 이미지의 데이터 속성에서 리뷰 ID를 가져옴
 
        // 해당 리뷰 ID에 해당하는 리뷰 내용을 가져와 모달 내용에 설정
        // let reviewContent = document.getElementById("review-content-" + reviewId).textContent;
        // document.getElementById("modal-review-content").textContent = reviewContent;

        // 클릭한 이미지의 인덱스를 현재 인덱스로 설정하고, 네비게이션 버튼 업데이트
        // currentIndex = Array.from(images).indexOf(image);
        // updateNavButtons();
        
     	// 리뷰 작성자의 닉네임 가져오기
        // let reviewNickname = document.getElementById("review-nickname-" + reviewId).textContent;
        // document.getElementById("modal-review-nickname").textContent = reviewNickname;

        // 리뷰 작성자의 rating 가져오기
        // let ratingText = document.getElementById("review-rating-" + reviewId).textContent.trim();
        // document.getElementById("modal-review-rating").textContent = ratingText;
    }

    // 모달을 닫을 때 호출되는 함수
    function closeModal(id) {
    	isCurrentReviewPicturesShowing = false;
    	// document.getElementById('myModal-' + id).style.display = "none"; // 모달을 숨김
    	var elements = document.querySelectorAll('[id^="myModal"]');

    	// Loop through the elements and set their display property to "none"
    	for (var i = 0; i < elements.length; i++) {
    	  elements[i].style.display = "none";
    	}
    }

    // 이미지 변경 함수 (좌우 버튼 클릭 시 호출)
    function changeImage(n) {
        if (isCurrentReviewPicturesShowing) {
            currentIndex += n; // 현재 인덱스에 n을 더해 다음 이미지 인덱스 설정
            if (currentIndex < 0) {
                currentIndex = images.length - 1; // 처음 이미지로 돌아감
            } else if (currentIndex >= images.length) {
                currentIndex = 0; // 마지막 이미지로 돌아감
            }
            modalImg.src = images[currentIndex].src; // 모달 이미지 요소의 소스를 변경된 이미지로 설정
            
        // 이미지 변경할 때 리뷰 내용 업데이트
        let reviewId = images[currentIndex].getAttribute("data-review-id");
        let reviewContent = document.getElementById("review-content-" + reviewId).textContent;
        document.getElementById("modal-review-content").textContent = reviewContent;
        
    	// 리뷰 작성자의 닉네임 가져오기
        let reviewNickname = document.getElementById("review-nickname-" + reviewId).textContent;
        document.getElementById("modal-review-nickname").textContent = reviewNickname;

        // 리뷰 작성자의 rating 가져오기
        let ratingText = document.getElementById("review-rating-" + reviewId).textContent.trim();

        document.getElementById("modal-review-rating").textContent = ratingText;

        // 네비게이션 버튼 업데이트
        updateNavButtons();
    	}
    }

    // 네비게이션 버튼 업데이트 함수
    function updateNavButtons() {
        var prevButton = document.getElementById("prevButton");
        var nextButton = document.getElementById("nextButton");
        if (images.length <= 1) {
            // 이미지가 1장 이하면 네비게이션 버튼을 숨김
            prevButton.style.display = "none";
            nextButton.style.display = "none";
        } else {
            // 이미지가 2장 이상이면 네비게이션 버튼을 표시
            prevButton.style.display = "block";
            nextButton.style.display = "block";
        }
    }

    document.addEventListener("keydown", function (event) {
        if (event.keyCode === 27) {
            closeModal(); 
        } 
          /* else if (event.keyCode === 37) {
            openModal(image); 
        } else if (event.keyCode === 39) {
            openModal(1); 
        } */
    });
    
    // localStorage에 가게 id저장
    let store_id = `${param.id}`
    if (store_id) {

        let value = localStorage.getItem("store_history");
        let store_history = JSON.parse(value); //  JSON 형식의 문자열을 JavaScript 객체로 변환하는 메서드입니다.

        if (store_history != null) {
            let exist = store_history.includes(store_id);

            if (exist) {
                let findIndex = store_history.indexOf(store_id);
                store_history.splice(findIndex, 1);
            }
            store_history.unshift(store_id);
        } else {
            store_history = [];
            store_history.unshift(store_id);
        }
        value = JSON.stringify(store_history);
        localStorage.setItem("store_history", value);

    }

    const daysArea = document.getElementById('daysArea')
    const daysMap = {
        Mon: false,
        Tue: false,
        Wed: false,
        Thu: false,
        Fri: false,
        Sat: false,
        Sun: false
    }

    const days = fetch(`/store/open-times?id=\${store_id}`, {
        method: "GET"
    })
        .then(response => {
            if (response.ok) {
                return response.json();
            }
        })
        .then(data => {
            data.map(datum => {
                daysArea.innerHTML += `
    	            <div class="w-50 d-flex justify-content-between my-1">
    	                <span class="d-inline-block" style="width: 50px;">\${datum.day}</span>
    	                <span class="badge bg-secondary-subtle text-secondary-emphasis rounded-pill">\${datum.openTime} ~ \${datum.closeTime}</span>
    	            </div>
    	        `;
                daysMap[datum.day] = true;
                return datum;
            });
        })
        .then(data => {
            Object.keys(daysMap)
                .filter(day => !daysMap[day])
                .forEach(daysOff => {
                    console.log(daysOff);
                    daysArea.innerHTML += `
                    	<div class="w-50 d-flex justify-content-between">
    	                    <span class="d-inline-block" style="width: 50px;"> \${daysOff}</span>
    	                    <span class="badge bg-danger-subtle text-danger-emphasis rounded-pill"> 쉬는날</span>
    	                </div>
    	            `;
                });
        });
	
	// initial fetching
    //fetchAndRenderReviews(reviewFetchingOption, pageOnReview);

    document.getElementById('btn-review-all').addEventListener('click', function() {
    	fetchedReviews = [];
        reviewOutputArea.innerHTML = '';

        isReviewsLast = false;
        isReviewsFetching = false;
        pageOnReview = 1;
        reviewFetchingOption = 'all';
        fetchAndRenderReviews(reviewFetchingOption, pageOnReview)
    })

    document.getElementById('btn-review-good').addEventListener('click', function() {
    	fetchedReviews = [];
        reviewOutputArea.innerHTML = '';

        isReviewsLast = false;
        isReviewsFetching = false;
        pageOnReview = 1;
        reviewFetchingOption = 'good';
        fetchAndRenderReviews(reviewFetchingOption, pageOnReview)
    })

    document.getElementById('btn-review-soso').addEventListener('click', function() {
    	fetchedReviews = [];
        reviewOutputArea.innerHTML = '';

        isReviewsLast = false;
        isReviewsFetching = false;
        pageOnReview = 1;
        reviewFetchingOption = 'soso';
        fetchAndRenderReviews(reviewFetchingOption, pageOnReview)
    })

    document.getElementById('btn-review-bad').addEventListener('click', function() {
    	fetchedReviews = [];
        reviewOutputArea.innerHTML = '';

        isReviewsLast = false;
        isReviewsFetching = false;
        pageOnReview = 1;
        reviewFetchingOption = 'bad';
        fetchAndRenderReviews(reviewFetchingOption, pageOnReview)
    })

	document.addEventListener("DOMContentLoaded", function() {
	    window.scrollTo(0, 0); // 스크롤 위치를 0, 0으로 설정
	});

    window.onscroll = function () {
    	// console.log("window -> ", window.innerHeight, "scroll -> ", window.scrollY +.5, "documnet -> ", document.body.offsetHeight)
        if ((window.innerHeight + window.scrollY +.5) >= document.body.offsetHeight) {

            if (isReviewsFetching || isReviewsLast) {
                // do nothing
            } else {
                pageOnReview += 1;
                fetchAndRenderReviews(reviewFetchingOption, pageOnReview)
            }
        }

    }
    
    $("#btn-bookmark").click(function() {
        // 로그인 여부 확인
        if (${pageContext.request.userPrincipal != null}) {
            let storeId = $(this).attr("data-store-id");
            let $icon = $(this).find('i');
            let $bookmark = $("#bookmark-count");
            let currentBookmarkCount = parseInt($bookmark.text());

            let add = "Y";
            if ($icon.hasClass("bi-star-fill")) {
                add = "N";
            } else {
                add = "Y";
            }

            // bookmark?storeId=21&job=Y
            $.post("bookmark", {storeId:storeId, job:add}, function(result) {
                if ($icon.hasClass("bi-star-fill")) {
                    currentBookmarkCount--;
                    $icon.removeClass("bi-star-fill").addClass("bi-star");
                } else {
                    currentBookmarkCount++;
                    $icon.removeClass("bi-star").addClass("bi-star-fill");
                }
                $bookmark.text(currentBookmarkCount);
            });
        } else {
            // 로그인되지 않은 경우, 로그인 페이지 열기
            window.location.href = "/user/login";
        }
    });

    
    
    $("#btn-review-all").click(function () {
        $("#review-list .card").show();
    });
    $("#btn-review-good").click(function () {
        $("#review-list .card").hide();
        $("#review-list .card[data-review-rating=5]").show();
    });
    $("#btn-review-soso").click(function () {
        $("#review-list .card").hide();
        $("#review-list .card[data-review-rating=3]").show();
    });
    $("#btn-review-bad").click(function () {
        $("#review-list .card").hide();
        $("#review-list .card[data-review-rating=1]").show();
    });


    var container = document.getElementById('map');
    var options = {
        // latitude,longitude 순으로 입력
        center: new kakao.maps.LatLng(${store.latitude}, ${store.longitude}),
        level: 4
    };

    var map = new kakao.maps.Map(container, options);

    // 마우스 드래그와 모바일 터치를 이용한 지도 이동을 막는다
    map.setDraggable(false);

    // 마우스 휠과 모바일 터치를 이용한 지도 확대, 축소를 막는다
    map.setZoomable(false);

    // 마커가 표시될 위치입니다
    var markerPosition = new kakao.maps.LatLng(${store.latitude}, ${store.longitude});


    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);

    // 아래 코드는 지도 위의 마커를 제거하는 코드입니다
    // marker.setMap(null);

    document.getElementById('map').addEventListener('click', function () {
        $('#mapModal').modal('show');
    });

    // 모달 열릴 때 큰 지도 초기화 및 표시
    $('#mapModal').on('shown.bs.modal', function () {
        var container = document.getElementById('largeMap');
        var options = {
            center: new kakao.maps.LatLng(${store.latitude}, ${store.longitude}), // 지도 중심 좌표
            level: 3 // 지도 확대 레벨
        };
        var map = new kakao.maps.Map(container, options);
        // 마커 추가 (예시)
        var markerPosition = new kakao.maps.LatLng(${store.latitude}, ${store.longitude});

        var marker = new kakao.maps.Marker({
            position: markerPosition
        });

        marker.setMap(map);
    });

    function closeMapModal() {
        $('#mapModal').modal('hide');
    }

    // 모달 닫힐 때 큰 지도 초기화
    $('#mapModal').on('hidden.bs.modal', function () {
        // 지도를 삭제하여 초기화
        var mapContainer = document.getElementById('largeMap');
        mapContainer.innerHTML = '';
    });

    $('#star').click(function () {
        if ($(this).hasClass('bi-star-fill')) {
            $(this).removeClass('bi-star-fill').addClass('bi-star')
        } else {
            $(this).removeClass('bi-star').addClass('bi-star-fill')
        }
    });

    $('.bi-heart').click(function () {
        if ($(this).hasClass('bi-heart-fill')) {
            $(this).removeClass('bi-heart-fill').addClass('bi-heart');
        } else {
            $(this).removeClass('bi-heart').addClass('bi-heart-fill');
        }
    });

    $(function() {
        // 페이지 로드 시 초기 선택값을 설정합니다.
        $('.border-opacity-10').first().addClass('active').css('color', '#ff792a');

        // '.emoji-btn' 클래스를 가진 버튼을 클릭할 때 실행되는 함수를 정의합니다.
        $('.border-opacity-10').click(function() {
            // 모든 버튼에 있는 'active' 클래스를 제거하고 색을 초기화합니다.
            $('.border-opacity-10').removeClass('active').css('color', '#000');
            
            // 클릭한 버튼에만 'active' 클래스를 추가하고 텍스트 색을 설정합니다.
            $(this).addClass('active').css('color', '#ff792a'); // 선택한 버튼의 텍스트 색 변경
        });
    });
    

</script>
</body>
</html>