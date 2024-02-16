<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    
    <style type="text/css">
    	.cardratting{
    		position: absolute;
    		top:80%;
  			font-size: 20px;
    	}
    	
    	.card-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            filter: brightness(70%);
        }

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
		    font-size:22px;
		}
		
		.keywords{
			position: absolute;
		   	width: 100%;
		    bottom: 0%;
		    right: 1%;
		    font-size:18px;
		}
    </style>
<link rel="shortcut icon" href="/images/logo/png/favicon.ico"image/x-icon">
<link rel="icon" href="/images/logo/png/favicon.ico" type="image/x-icon">    
<title>Food Street</title>
</head>
<body>
<%@ include file="common/navbar.jsp" %>
<div class="wrap">
	<div class="container border-top mt-5 bg-light" >
		<div class="row text-center border-bottom">
			<div class="col-12 my-5">
				<h2>Following Review</h2>
				<h4 class="text-secondary">( 내가 팔로우한 사람들의 리뷰를 확인해보세요! )</h4>
			</div>
		</div>
	</div>
	<div class="container justify-content-center align-items-center">
        <div id="reviewsOutputArea" class="row mt-4 mb-3">
        </div>
        <div class="text-center">
            <div class="btn disabled border border-0">
                <div id="reviewsLoadingSpinner"
                     class="spinner-border spinner-border-sm text-primary m-1" role="status"
                     style="display: none;">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>
        </div>
    </div>
	<%@ include file="common/footer.jsp" %>
</div>
<script type="text/javascript">
	let isReviewFetching = false;
	let isReviewLast = false;
	const reviewsLoadingSpinner = document.getElementById('reviewsLoadingSpinner')
	
	let pageOnReviews = 1;
	
	const getReviews = (page) => {
	    return fetch(`/review/get/followerReview?page=\${page}&limit=9`).then(response => response.json());
	}
	
	const getKeywordsByReviewId = (reviewId) => {
		return fetch(`/review/get/keywords?reviewId=\${reviewId}`).then(response => response.json());
	}
	
	function fetchAndFindKeywords(reviewId){
		
		getKeywordsByReviewId(reviewId).then(reviewData => {
			
			reviewData.forEach(reviewDatum => {
				
				document.getElementById(`id-\${reviewId}`).innerHTML += `
					<span class="badge text-bg-secondary bg-opacity-50 fw-lighter m-1">\${reviewDatum.keyword}</span>
				`
			})
			
		})
		
	}
	
	function fetchAndRenderReviews(currentPage) {
	
	    isReviewFetching = true;
	    reviewsLoadingSpinner.style.display = 'block';
	
	    getReviews(currentPage).then(data => {
			console.log(data)
	        if (data.length < 9) {
	            isReviewLast = true;
	            reviewsLoadingSpinner.style.display = 'none';
	        }
	
	        data.forEach(datum => {
	        	
	        	fetchAndFindKeywords(datum.id)
	        	
	            document.getElementById('reviewsOutputArea').innerHTML += `
	        					<div class="col-md-4 my-3">
	        						<div class="cards text-center text-light font-weight-bold" onclick="location.href='/review/detail?id=\${datum.id}'" style=" cursor: pointer;">
	        							<img src="/images/review/jpeg/\${datum.pictureName }" class="card-image" alt="...">
	        							<div class="card-img-overlay">
	        								<strong class="title-text">\${datum.storeName}</strong>
	        								<div class="keywords text-end" id="id-\${datum.id}">
	        									<div id="rating-\${datum.id}"></div>
	        								</div>
	        							</div>
	        						</div>
	        						<div class="row">
	        							<div class="col">
	        								<span class="btn badge text-bg-success bg-opacity-50 text-secondary-emphasis rounded-pill" onclick="location.href='/user/details?id=\${datum.customerId}'"><strong >\${datum.userName}</strong></span>
	        							</div>
	        							<div class="col text-end">
	        								\${timeForToday(datum.createDate)}
	        							</div>
	        						</div>
	        					</div>
	            `
	            
	            let rating = document.getElementById(`rating-\${datum.id}`);
	            
				if (datum.rating === 5) {
				    rating.innerHTML = `<span class="badge text-bg-success bg-opacity-50 fw-lighter m-1" style="background-color:#edcfb4">맛있어요</span>`;
				} else if (datum.rating === 3) {
					 rating.innerHTML = `<span class="badge text-bg-warning bg-opacity-50 fw-lighter m-1" style="background-color:#edcfb4">괜찮아요</span>`;
				} else {
					rating.innerHTML = `<span class="badge text-bg-danger bg-opacity-50 fw-lighter m-1" style="background-color:#edcfb4">별로에요</span>`;
				}
				
			    isReviewFetching = false;
	        })
	    })
	}
	
	window.onscroll = function () {
	    console.log(window.innerHeight)
	    console.log(window.scrollY)
	    console.log(document.body.offsetHeight)
	
	    if ((window.innerHeight + window.scrollY) + 1.2 >= document.body.offsetHeight) {
	
	        if (isReviewFetching || isReviewLast) {
	            // do nothing;
	        } else {
	            pageOnReviews += 1;
	            fetchAndRenderReviews(pageOnReviews);
	        }
	    }
	}
	
	fetchAndRenderReviews(pageOnReviews);
	
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
</script>
</body>
</html>