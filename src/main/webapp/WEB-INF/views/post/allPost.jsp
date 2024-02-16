<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<%@ include file="../common/navbar.jsp" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.
    googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

    <style type="text/css">
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
		    font-size:18px;
		}
    </style>
    <link rel="shortcut icon" href="/images/logo/png/favicon.ico"image/x-icon">
	<link rel="icon" href="/images/logo/png/favicon.ico" type="image/x-icon">
    <title>Food Street</title>
</head>
<body>
<div class="wrap">
    <div class="container border-top mt-5 bg-light">
        <div class="row text-center border-bottom">
            <div class="col-12 my-5">
                <h2>All Posts</h2>
                <h4 class="text-secondary">( 최근 포스트를 확인해보세요! )</h4>
            </div>
        </div>
    </div>
    <div class="container justify-content-center align-items-center">
        <div id="postsOutputArea" class="row mt-4 mb-3">
        </div>
        <div class="text-center">
            <div class="btn disabled border border-0">
                <div id="postsLoadingSpinner"
                     class="spinner-border spinner-border-sm text-primary m-1" role="status"
                     style="display: none;">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">

    let isPostFetching = false;
    let isPostLast = false;
    const postsLoadingSpinner = document.getElementById('postsLoadingSpinner')

    let pageOnPosts = 1;

    const getPosts = (page) => {
        return fetch(`/post/get/allPost?page=\${page}&limit=9`).then(response => response.json());
    }

    function fetchAndRenderPosts(currentPage) {

        isPostFetching = true;
        postsLoadingSpinner.style.display = 'block';

        getPosts(currentPage).then(data => {

            if (data.length < 9) {
                isPostLast = true;
                postsLoadingSpinner.style.display = 'none';
            }

            data.forEach(datum => {
                document.getElementById('postsOutputArea').innerHTML += `
            					<div class="col-md-4 my-3">
            						<div class="cards text-center text-light font-weight-bold shadow" onclick="location.href='detail?id=\${datum.id}'" style=" cursor: pointer;">
            							<img src="/images/post/jpeg/\${datum.pictureFile}" class="card-image" alt="...">
            							<div class="card-img-overlay">
            								<div class="title-text">
	            								<strong>\${datum.title}</strong><br>
	            								<div class="text-white" style="opacity:80%;">( \${datum.subTitle} )</div>
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
	        	isPostFetching = false;
            })
        })
    }

    window.onscroll = function () {
        console.log(window.innerHeight)
        console.log(window.scrollY)
        console.log(document.body.offsetHeight)

        if ((window.innerHeight + window.scrollY) + 1.2 >= document.body.offsetHeight) {

            if (isPostFetching || isPostLast) {
                // do nothing;
            } else {
                pageOnPosts += 1;
                fetchAndRenderPosts(pageOnPosts);
            }
        }
    }

    // initial fetching and rendering
    fetchAndRenderPosts(pageOnPosts);

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