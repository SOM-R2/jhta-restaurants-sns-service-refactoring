<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="/images/logo/png/favicon.ico"image/x-icon">
<link rel="icon" href="/images/logo/png/favicon.ico" type="image/x-icon">
<title>Food Street</title>
<%@ include file="common/navbar.jsp" %>
<style type="text/css">
	.cards {
		position: relative;
		align-text:center;
	}
	
	.card-image-overlay {
		position: absolute;
	}
	
	.title-text {
	   	position: absolute;
	   	width: 100%;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    text-align:center;
	    font-size:18px;
	}
	
	.keywords{
		position: absolute;
	   	width: 100%;
	    bottom: 0%;
	    right: 1%;
	    font-size:18px;
	}
	
	.card-image {
		width: 100%;
		height: 250px;
		object-fit:cover;
		filter: brightness(70%);
	}
		
	.search-bar {
  		width: 800px;
	}
	
	h4{
		color:#FF8200;
	}
	
</style>
</head>
<body>

<div class="wrap">
	<div class="container">
		<div class="row mt-3">
			<div class="col">
				<h4 class="my-3"><strong>Recent Post</strong></h4>
			</div>
			<div class="col text-end">
				<button type="button" class="btn text-muted my-3" onclick="location.href='/post/allPosts'"> more</button>
			</div>
		</div>
		<div class="row mb-3 border-bottom">
			
			<c:forEach var="recentPostdata" items="${recentPosts }" >
				<c:set var="sysYear"><fmt:formatDate value="${recentPostdata.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></c:set>
				<div class="col-md-4 mb-4">
					<div class="cards text-center text-light font-weight-bold" onclick="location.href='post/detail?id=${recentPostdata.id}'" style=" cursor: pointer;">
						<img src="images/post/jpeg/${recentPostdata.pictureFile}" class="card-image" alt="...">
	
						<div class="card-img-overlay">
							<div class="title-text">
								<strong>${recentPostdata.title }</strong><br>
								<div class="text-white" style="opacity:80%;">( ${recentPostdata.subTitle } )</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<span class="btn badge text-bg-success bg-opacity-50 text-secondary-emphasis fw-light rounded-pill" onclick="location.href='user/details?id=${recentPostdata.customerId}'"><strong >${recentPostdata.userName }</strong></span>
							<%-- <sec:authorize access="isAuthenticated()">
								<sec:authentication property="principal.user.id" var="loggedInUserId" />
								<c:if test="${recentPostdata.customerId ne loggedInUserId}">
										<span id="followRequestButton-${recentPostdata.id }" 
		                                     	     class="btn userFollow badge bg-primary-subtle border border-primary-subtle text-primary-emphasis rounded-pill" data-user-id="${recentPostdata.customerId }">FOLLOW</span>
								</c:if>
							</sec:authorize> --%>
						</div>
						<div class="col text-end">
							<input type="hidden" id="dateInput-${recentPostdata.id }" type="text" value="${sysYear }" >
							<p class="text-end text-secondary" id="dateValue-${recentPostdata.id }"></p>
						</div>
					</div>
				</div>
			</c:forEach>
			
		</div>
		
		<sec:authorize access="isAuthenticated()">
			<div class="row mt-3">
				<div class="col">
					<h4 class="my-3"><strong>Following Post</strong></h4>
				</div>
				<div class="col text-end">
					<button type="button" class="btn text-muted my-3" onclick="location.href='/post/followerPosts'"> more</button>
				</div>
			</div>
			<div class="row mb-3 border-bottom">
				
				<c:choose>
					<c:when test="${recentPostsOfFollower.size() > 0 }">
						<c:forEach var="followerPostData" items="${recentPostsOfFollower }" >
							<c:set var="sysYear"><fmt:formatDate value="${followerPostData.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></c:set>
							<div class="col-md-4 mb-4">
								<div class="cards text-center text-light font-weight-bold" onclick="location.href='post/detail?id=${followerPostData.id}'" style=" cursor: pointer;">
									<img src="images/post/jpeg/${followerPostData.pictureFile}" class="card-image" alt="...">
				
									<div class="card-img-overlay">
										<div class="title-text">
											<strong>${followerPostData.title }</strong><br>
											<div class="text-white" style="opacity:80%;">( ${followerPostData.subTitle } )</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col">
										<span class="btn badge text-bg-success bg-opacity-50 text-secondary-emphasis fw-light rounded-pill " onclick="location.href='user/details?id=${followerPostData.customerId}'"><strong >${followerPostData.userName }</strong></span>
										<%-- <sec:authorize access="isAuthenticated()">
											<span id="followRequestButton-${followerPostData.id }" 
			                                          class="btn userFollow badge bg-primary-subtle border border-primary-subtle text-primary-emphasis rounded-pill" data-user-id="${followerPostData.customerId }">Follow</span>
										</sec:authorize> --%>
									</div>
									<div class="col text-end">
										<input type="hidden" id="dateInput-${followerPostData.id }" type="text" value="${sysYear }" >
										<p class="text-end text-secondary" id="dateValue-${followerPostData.id }"></p>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="d-flex justify-content-center align-items-center"  style="height:200px;">
							<div class="text-muted">
								팔로우를 해보세요!
							</div>
						</div>
					</c:otherwise>
				</c:choose>
				
				
			</div>
		</sec:authorize>
			<div class="row mt-3">
				<div class="col">
					<h4 class="my-3"><strong>Recent Review</strong></h4>
				</div>
				<div class="col text-end">
					<button type="button" class="btn text-muted my-3" onclick="location.href='/review/allReviews'"> more</button>
				</div>
			</div>
			<div class="row mb-3">
				<c:forEach var="recentReviewData" items="${recentReviews }" >
					<c:set var="sysYear"><fmt:formatDate value="${recentReviewData.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></c:set> 
					<div class="col-md-4 mb-4">
						<div class="cards text-center text-light font-weight-bold" onclick="location.href='/review/detail?id=${recentReviewData.id}'" style=" cursor: pointer;">
							<img src="/images/review/jpeg/${recentReviewData.pictureName }" class="card-image" alt="...">
		
							<div class="card-img-overlay">
								<div class="title-text">
									<strong>${recentReviewData.storeName }</strong><br>
								</div>
								<div class="keywords text-end">
									<div>
										<c:choose>
											<c:when test="${recentReviewData.rating eq 5}">
												 <span class="badge text-bg-success bg-opacity-50 fw-lighter m-1" style="background-color:#edcfb4">맛있어요</span>
											</c:when>
											<c:when test="${recentReviewData.rating eq 3}">
												 <span class="badge text-bg-warning bg-opacity-50 fw-lighter m-1" style="background-color:#edcfb4">괜찮아요</span>
											</c:when>
											<c:when test="${recentReviewData.rating eq 1}">
												 <span class="badge text-bg-danger bg-opacity-50 fw-lighter m-1" style="background-color:#edcfb4">별로에요</span>
											</c:when>
										</c:choose>
									</div>
									<c:forEach var="keywordData" items="${recentReviewData.keywords }" >
										<span class="badge text-bg-secondary bg-opacity-50 fw-lighter m-1">${keywordData.keyword}</span>
									</c:forEach>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<span class="btn badge text-bg-success bg-opacity-50 text-secondary-emphasis fw-light rounded-pill " onclick="location.href='user/details?id=${recentReviewData.customerId}'"><strong >${recentReviewData.userName }</strong></span>
								<%-- <sec:authorize access="isAuthenticated()">
									<span id="followRequestButton-${recentReviewData.id }" 
	                                          class="btn userFollow badge bg-primary-subtle border border-primary-subtle text-primary-emphasis rounded-pill" data-user-id="${recentReviewData.customerId }">Follow</span>
								</sec:authorize> --%>
							</div>
							<div class="col text-end">
								<input type="hidden" id="dateInput-${recentReviewData.id }" type="text" value="${sysYear }" >
								<p class="text-end text-secondary" id="dateValue-${recentReviewData.id }"></p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		<sec:authorize access="isAuthenticated()">
			<div class="border-top"></div>
			<div class="row mt-3">
				<div class="col">
					<h4 class="my-3"><strong>Following Review</strong></h4>
				</div>
				<div class="col text-end">
					<button type="button" class="btn text-muted my-3" onclick="location.href='/review/followerReviews'"> more</button>
				</div>
			</div>
			<div class="row mb-3">
				<c:choose>
					<c:when test="${recentFollowerReivews.size() > 0 }">
						<c:forEach var="recentFollowerReivewData" items="${recentFollowerReivews }" >
							<c:set var="sysYear"><fmt:formatDate value="${recentFollowerReivewData.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></c:set> 
							<div class="col-md-4 mb-4">
								<div class="cards text-center text-light font-weight-bold" onclick="location.href='/review/detail?id=${recentFollowerReivewData.id}'" style=" cursor: pointer;">
									<img src="/images/review/jpeg/${recentFollowerReivewData.pictureName }" class="card-image" alt="...">
				
									<div class="card-img-overlay">
										<div class="title-text">
											<strong>${recentFollowerReivewData.storeName }</strong><br>
										</div>
										<div class="keywords text-end">
											<div>
												<c:choose>
													<c:when test="${recentFollowerReivewData.rating eq 5}">
														 <span class="badge text-bg-success bg-opacity-50 fw-lighter m-1" style="background-color:#edcfb4">맛있어요</span>
													</c:when>
													<c:when test="${recentFollowerReivewData.rating eq 3}">
														 <span class="badge text-bg-warning bg-opacity-50 fw-lighter m-1" style="background-color:#edcfb4">괜찮아요</span>
													</c:when>
													<c:when test="${recentFollowerReivewData.rating eq 1}">
														 <span class="badge text-bg-danger bg-opacity-50 fw-lighter m-1" style="background-color:#edcfb4">별로에요</span>
													</c:when>
												</c:choose>
											</div>
											<c:forEach var="keywordData" items="${recentFollowerReivewData.keywords }" >
												<span class="badge text-bg-secondary bg-opacity-50 fw-lighter m-1">${keywordData.keyword}</span>
											</c:forEach>
											
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col">
										<span class="btn badge text-bg-success bg-opacity-50 text-secondary-emphasis fw-light rounded-pill " onclick="location.href='user/details?id=${recentFollowerReivewData.customerId}'"><strong >${recentFollowerReivewData.userName }</strong></span>
										<%-- <sec:authorize access="isAuthenticated()">
											<span id="followRequestButton-${recentFollowerReivewData.id }" 
			                                          class="btn userFollow badge bg-primary-subtle border border-primary-subtle text-primary-emphasis rounded-pill" data-user-id="${recentFollowerReivewData.customerId }">Follow</span>
										</sec:authorize> --%>
									</div>
									<div class="col text-end">
										<input type="hidden" id="dateInput-${recentFollowerReivewData.id }" type="text" value="${sysYear }" >
										<p class="text-end text-secondary" id="dateValue-${recentFollowerReivewData.id }"></p>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="d-flex justify-content-center align-items-center"  style="height:200px;">
							<div class="text-muted">
								팔로우를 해보세요!
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</sec:authorize>
		
		<%-- <div class="row mt-3">
			<div class="col">
				<h4 class="my-3">Popular Stores</h4>
			</div>
			<div class="col text-end">
				<button type="button" class="btn btn-outline-secondary my-3"> more</button>
			</div>
		</div>
		<div class="row mb-3 border-bottom">
			<c:forEach var="store" items="popularStores">
				<div class="col-md-4 mb-4">
					<div class="cards text-center text-light font-weight-bold shadow" onclick="location.href='post'" style=" cursor: pointer;">
						<img src="../resources/image/cafe1.jpg" class="card-image" alt="...">
	
						<div class="card-img-overlay">
							<div class="title-text">
								<strong>${store.name }</strong><br>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			
		</div> --%>
	</div>
	<!-- <div id="messagingToast" class="toast align-items-center text-bg-primary border-0 position-fixed bottom-0 end-0" role="alert"
         aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>	 -->
</div>
<%@ include file="common/footer.jsp" %>
<script type="text/javascript">
	function timeForToday(value) {
	    const today = new Date();
	    const timeValue = new Date(value);
	    const betweenTime = Math.floor((today.getTime() - timeValue.getTime()) / 1000 / 60);
	
	    if (betweenTime < 1) return '방금전';
	    if (betweenTime < 60) {
	        return `\${betweenTime}분전`;
	    }
	
	    const betweenTimeHour = Math.floor(betweenTime / 60);
	    if (betweenTimeHour < 24) {
	        return `\${betweenTimeHour}시간전`;
	    }
	
	    const betweenTimeDay = Math.floor(betweenTime / 60 / 24);
	    if (betweenTimeDay < 365) {
	        return `\${betweenTimeDay}일전`;
	    }
	
	    return `\${Math.floor(betweenTimeDay / 365)}년전`;
	}
	
	$("[id^=dateInput]").each(function (index, input) {
	    let value = $(input).val();
	    let elapsed = timeForToday(value);
	    $(input).next().text(elapsed);
	})
	
	/* addEventListener('click', function (event) {
        if (event.target.classList.contains('userFollow')) {
            const button = event.target
            const userId = button.getAttribute('data-user-id')

            fetch(`/user/follow?recipientId=\${userId}`, {
	            method: "POST"
	        }).then(response => {
	            if (response.ok) {
	                showMessagingToast("Successfully done!");
	            } else {
	                showMessagingToast("Already requested.");
	            }
	        })
        }
    })
	
    function showMessagingToast(message) {
        const messagingToast = document.getElementById('messagingToast');
        const toastBody = messagingToast.querySelector('.toast-body');

        toastBody.textContent = message;

        const messagingToastBootstrap = bootstrap.Toast.getOrCreateInstance(messagingToast);
        messagingToastBootstrap.show();
    } */
</script>
</body>
</html>