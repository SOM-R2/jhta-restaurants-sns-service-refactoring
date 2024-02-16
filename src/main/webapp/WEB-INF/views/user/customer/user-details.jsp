<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .square-div {
            aspect-ratio: 1 / 1;
        }
    </style>
</head>
<body>
<%@ include file="../../common/navbar.jsp" %>
<div class="container">
    <div class="row my-5 px-5">
        <div class="col-md-5 my-5">
            <div class="position-sticky" style="top: 5rem;">
                <div class="card shadow-sm border border-0 my-3">
                    <div class="fw-lighter m-3 p-1">
                        <div class="row">
                            <div class="col-8 fs-4 my-2">
                                <div class="my-2">About Me</div>
                            </div>
                            <div class="col-4 d-flex justify-content-end">
                                <div id="userIcon" class="mx-2 my-1">
                                    <img type="button" id="userImage"
                                         class="rounded-circle shadow-sm object-fit-cover mx-1"
                                         style="width: 70px; height: 70px;" onclick="handleImageClick()"/>
                                    <input type="file" id="fileInput" style="display: none" accept="image/*"
                                           onchange="handleFileSelect()">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col text-end">
                                <div id="postsToastButton" type="button"
                                     class="badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill position-relative mx-2">
                                    posts
                                    <span id="postsCount"
                                          class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"></span>
                                </div>
                                <div id="reviewsToastButton" type="button"
                                     class="badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill position-relative mx-2">
                                    reviews
                                    <span id="reviewsCount"
                                          class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row mx-2">
                            <div class="col-sm-4 my-1 fw-lighter">
                                <label for="fullName" class="col-sm-2 col-form-label"><span style="white-space: nowrap">Full Name</span></label>
                            </div>
                            <div class="col-sm-8 my-1">
                                <p class="form-control-plaintext" id="fullName"> ${ customer.fullName } </p>
                            </div>
                        </div>
                        <div class="row mx-2">
                            <div class="col-sm-4 my-1 fw-lighter">
                                <label for="nickName" class="col-sm-2 col-form-label"><span style="white-space: nowrap">Nickname</span></label>
                            </div>
                            <div class="col-sm-8 my-1">
                                <p class="form-control-plaintext" id="nickName"> ${ customer.nickname } </p>
                            </div>
                        </div>
                        <div class="row mx-2">
                            <div class="col-sm-4 my-1 fw-lighter">
                                <label for="email" class="col-sm-2 col-form-label"><span
                                        style="white-space: nowrap">Email</span></label>
                            </div>
                            <div class="col-sm-8 my-1">
                                <p class="form-control-plaintext" id="email"> ${ customer.email } </p>
                            </div>
                        </div>
                        <div class="row mx-2">
                            <div class="col-sm-4 my-1 fw-lighter">
                                <label for="preferenceOutputArea" class="col-sm-2 col-form-label">
                                    <span style="white-space: nowrap">Preference</span>
                                </label>
                            </div>
                            <div class="col-sm-8 my-1">
                                <div id="preferenceOutputArea" class="form-control-plaintext">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card shadow-sm border border-0 mt-3">
                    <div class="fw-lighter m-3 p-1">
                        <div class="row">
                            <div class="col-8 fs-4">Socials</div>
                            <div class="col-4 d-flex justify-content-end">
                            </div>
                        </div>
                        <div class="row d-flex my-4">
                            <div class="col-md-3">
                                <div class="text-start">
                                    <span id="followRequestButton" type="button"
                                          class="badge bg-primary-subtle border border-primary-subtle text-primary-emphasis rounded-pill">Follow</span>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="text-end">
                                    <div id="followersToastButton" type="button"
                                         class="badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill position-relative mx-1">
                                        followers
                                        <span id="followersCount"
                                              class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"></span>
                                    </div>
                                    <div id="followingsToastButton" type="button"
                                         class="badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill position-relative mx-1">
                                        followings
                                        <span id="followingsCount"
                                              class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-7 my-5 px-4">
            <div class="pb-2 my-1 border-bottom text-end">
                <span id="postPicturesButton"
                      type="button"
                      class="badge bg-primary-subtle text-primary-emphasis rounded-pill mx-1">
                    Post Pictures
                </span>
                <span id="reviewPicturesButton"
                      type="button"
                      class="badge bg-success-subtle text-success-emphasis rounded-pill mx-1">
                    Review Pictures
                </span>
            </div>
            <div id="pictureDataOutputArea" class="row row-cols-1 row-cols-lg-3 align-items-stretch g-4 py-4">
            </div>
            <div class="text-center">
                <div class="btn border border-0 disabled">
                    <div id="picturesLoadingSpinner"
                         class="spinner-border spinner-border-sm text-primary m-1" role="status"
                         style="display: none;">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
<div class="toast-container position-fixed bottom-0 end-0 p-4">
    <div id="messagingToast" class="toast align-items-center text-bg-primary border-0" role="alert"
         aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
    <div id="postsToast" class="toast toast-add-menu" role="alert" aria-live="assertive" aria-atomic="true"
         data-bs-autohide="false">
        <div class="toast-body bg-light-subtle rounded-3">
            <div class="row">
                <div class="col">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="fw-lighter fs-4">Posts
                            <div class="btn border border-0 disabled">
                                <div id="postsLoadingSpinner"
                                     class="spinner-border spinner-border-sm text-primary m-1" role="status"
                                     style="display: none;">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>
                        </div>
                        <button id="postsCloseButton" type="button" class="btn-close" data-bs-dismiss="toast"
                                aria-label="Close"></button>
                    </div>
                </div>
            </div>
            <div id="postsOutputArea" class="bg-light-subtle my-2 p-1" style="max-height: 400px; overflow-y: auto;">
            </div>
        </div>
    </div>
    <div id="reviewsToast" class="toast toast-add-menu" role="alert" aria-live="assertive" aria-atomic="true"
         data-bs-autohide="false">
        <div class="toast-body bg-light-subtle rounded-3">
            <div class="row">
                <div class="col">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="fw-lighter fs-4">Reviews
                            <div class="btn border border-0 disabled">
                                <div id="reviewsLoadingSpinner"
                                     class="spinner-border spinner-border-sm text-primary m-1" role="status"
                                     style="display: none;">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>
                        </div>
                        <button id="reviewsCloseButton" type="button" class="btn-close" data-bs-dismiss="toast"
                                aria-label="Close"></button>
                    </div>
                </div>
            </div>
            <div id="reviewsOutputArea" class="bg-light-subtle my-2 p-1" style="max-height: 400px; overflow-y: auto;">
            </div>
        </div>
    </div>
    <div id="followersToast" class="toast toast-add-menu" role="alert" aria-live="assertive" aria-atomic="true"
         data-bs-autohide="false">
        <div class="toast-body bg-light-subtle rounded-3">
            <div class="row">
                <div class="col">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="fw-lighter fs-4">Followers

                            <div class="btn border border-0 disabled">
                                <div id="followersLoadingSpinner"
                                     class="spinner-border spinner-border-sm text-primary m-1" role="status"
                                     style="display: none;">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>
                        </div>
                        <button id="followersCloseButton" type="button" class="btn-close" data-bs-dismiss="toast"
                                aria-label="Close"></button>
                    </div>
                </div>
            </div>
            <div id="followersOutputArea" class="my-2 p-1" style="max-height: 400px; overflow-y: auto;">
            </div>
        </div>
    </div>
    <div id="followingsToast" class="toast toast-add-menu" role="alert" aria-live="assertive" aria-atomic="true"
         data-bs-autohide="false">
        <div class="toast-body bg-light-subtle rounded-3">
            <div class="row">
                <div class="col">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="fw-lighter fs-4">Followings
                            <div class="btn border border-0 disabled">
                                <div id="followingsLoadingSpinner"
                                     class="spinner-border spinner-border-sm text-primary m-1" role="status"
                                     style="display: none;">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>
                        </div>
                        <button id="followingsCloseButton" type="button" class="btn-close" data-bs-dismiss="toast"
                                aria-label="Close"></button>
                    </div>
                </div>
            </div>
            <div id="followingsOutputArea" class="my-2 p-1" style="max-height: 400px; overflow-y: auto;">
            </div>
        </div>
    </div>
</div>
</body>
<script>

    document.addEventListener("DOMContentLoaded", function () {

        const params = new URLSearchParams(window.location.search);
        const userId = params.get("id");

        const followersToastButton = document.getElementById('followersToastButton')
        const followersLoadingSpinner = document.getElementById('followersLoadingSpinner')
        const followersCloseButton = document.getElementById('followersCloseButton');

        let followersToast = document.getElementById('followersToast')
        let followersOutputArea = document.getElementById('followersOutputArea');

        const followingsToastButton = document.getElementById('followingsToastButton')
        const followingsLoadingSpinner = document.getElementById('followingsLoadingSpinner')
        const followingsCloseButton = document.getElementById('followingsCloseButton');

        let followingsToast = document.getElementById('followingsToast')
        let followingsOutputArea = document.getElementById('followingsOutputArea');

        const postsToastButton = document.getElementById('postsToastButton')
        const postsLoadingSpinner = document.getElementById('postsLoadingSpinner')
        let postsToast = document.getElementById('postsToast')
        let postOutputArea = document.getElementById('postsOutputArea');

        const reviewsToastButton = document.getElementById('reviewsToastButton')
        const reviewsLoadingSpinner = document.getElementById('reviewsLoadingSpinner')
        let reviewsToast = document.getElementById('reviewsToast')
        let reviewsOutputArea = document.getElementById('reviewsOutputArea');

        let pageOnFollower = 0
        let isFollowerFetching = false;
        let isFollowerLast = false;

        let pageOnFollowing = 0
        let isFollowingFetching = false;
        let isFollowingLast = false;

        let pageOnPost = 0
        let isPostFetching = false;
        let isPostLast = false;

        let pageOnReview = 0
        let isReviewFetching = false;
        let isReviewLast = false;

        const getReviewKeywords = fetch(`/review/keywords-by-user?id=\${userId}`).then(response => response.json())

        function fetchAndRenderReviewKeywords() {

            getReviewKeywords.then(data => {
                if (data.length > 0) {
                    data.forEach(datum => {
                        document.getElementById('preferenceOutputArea').innerHTML += `
                        <span class="badge bg-light-subtle border border-light-subtle text-light-emphasis rounded-pill">
                            \${datum}
                        </span>
                    `
                    })
                }
            })
        }

        fetchAndRenderReviewKeywords();

        const getFollowers = page => {
            return fetch(`/user/followers?id=\${userId}&page=\${page}&limit=7`).then(response => response.json());
        }

        function fetchAndRenderFollowers(page) {
            if (isFollowerFetching || isFollowerLast) {
                return;
            }
            isFollowerFetching = true;
            followersLoadingSpinner.style.display = 'block';
            getFollowers(page).then(data => {
                if (data.length === 0) {
                    followersLoadingSpinner.style.display = 'none'
                    isFollowerFetching = false;
                }

                // where 7 is the limit of the number of response on each request
                if (data.length < 7) {
                    isFollowerLast = true;
                }

                data.forEach(datum => {

                    const typeClass = datum.type === 'CUSTOMER' ?
                        'badge bg-success-subtle text-success-emphasis rounded-pill' :
                        'badge bg-warning-subtle text-warning-emphasis rounded-pill';

                    followersOutputArea.innerHTML += `
                        <div class="shadow-sm border border-light rounded-4 m-3">
                            <div class="p-3">
                                <img type="button" id="userImage" src="/images/user/png/\${datum.username}" onerror="this.onerror=null; this.src='/images/user/png/user-default-image.png';" alt="User Image" class="rounded-circle shadow-sm object-fit-cover userDetailEntry mx-1" data-user-id="\${datum.id}" style="width: 40px; height: 40px;"/>
                                <div class="fw-medium badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill userDetailEntry mx-1" type="button" data-user-id="\${datum.id}"> \${datum.nickname}</div>
                                <div class="fw-medium \${typeClass} mx-1">\${datum.type.toLowerCase()}</div>
                            </div>
                        </div>
                    `
                    followersLoadingSpinner.style.display = 'none'
                    isFollowerFetching = false;
                })
            })
        }

        followersToastButton.addEventListener("click", function () {
            const followersToastBootstrap = bootstrap.Toast.getOrCreateInstance(followersToast)

            visibility.then(public => {
                follow.then(follow => {
                    if (public || follow) {
                        // initial loading
                        fetchAndRenderFollowers(pageOnFollower)

                        // infinite scrolling (scroll pagination)
                        followersOutputArea.addEventListener('scroll', function () {
                            const scrollPos = this.scrollTop + this.clientHeight;
                            const scrollHeight = this.scrollHeight

                            if (scrollPos === scrollHeight) {
                                pageOnFollower += 1;
                                fetchAndRenderFollowers(pageOnFollower)
                            }
                        })

                        followersToastBootstrap.show()
                    } else {
                        showMessagingToast("This is a private profile. To see the details, you need to follow first :)")
                    }
                })
            })
        })

        const getFollowings = page => {
            return fetch(`/user/followings?id=\${userId}&page=\${page}&limit=7`).then(response => response.json());
        }

        function fetchAndRenderFollowings(page) {
            if (isFollowingFetching || isFollowingLast) {
                return;
            }
            isFollowingFetching = true;
            followingsLoadingSpinner.style.display = 'block';
            getFollowings(page).then(data => {
                if (data.length === 0) {
                    followingsLoadingSpinner.style.display = 'none'
                    isFollowingFetching = false;
                }

                // where 7 is the limit of the number of response on each request
                if (data.length < 7) {
                    isFollowingLast = true;
                }

                data.forEach(datum => {

                    const typeClass = datum.type === 'CUSTOMER' ?
                        'badge bg-success-subtle text-success-emphasis rounded-pill' :
                        'badge bg-warning-subtle text-warning-emphasis rounded-pill';

                    followingsOutputArea.innerHTML += `
                        <div class="shadow-sm border border-light rounded-4 m-3">
                            <div class="p-3">
                                <img type="button" id="userImage" src="/images/user/png/\${datum.username}" onerror="this.onerror=null; this.src='/images/user/png/user-default-image.png';" alt="User Image" class="rounded-circle shadow-sm object-fit-cover userDetailEntry mx-1" data-user-id="\${datum.id}" style="width: 40px; height: 40px;"/>
                                <div class="fw-medium badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill userDetailEntry mx-1" type="button" data-user-id="\${datum.id}"> \${datum.nickname}</div>
                                <div class="fw-medium \${typeClass} mx-1">\${datum.type.toLowerCase()}</div>
                            </div>
                        </div>
                    `
                    followingsLoadingSpinner.style.display = 'none'
                    isFollowingFetching = false;
                })
            })
        }

        followingsToastButton.addEventListener("click", function () {
            const followingsToastBootstrap = bootstrap.Toast.getOrCreateInstance(followingsToast)

            visibility.then(public => {
                follow.then(follow => {
                    if (public || follow) {
                        // initial loading
                        fetchAndRenderFollowings(pageOnFollowing)

                        // infinite scrolling (scroll pagination)
                        followingsOutputArea.addEventListener('scroll', function () {
                            const scrollPos = this.scrollTop + this.clientHeight;
                            const scrollHeight = this.scrollHeight

                            if (scrollPos === scrollHeight) {
                                pageOnFollowing += 1;
                                fetchAndRenderFollowings(pageOnFollowing)
                            }
                        })

                        followingsToastBootstrap.show()
                    } else {
                        showMessagingToast("This is a private profile. To see the details, you need to follow first :)")
                    }
                })
            })
        })

        addEventListener('click', function (event) {
            if (event.target.classList.contains('userDetailEntry')) {
                const button = event.target;
                const userId = button.getAttribute('data-user-id')

                window.location.href = `/user/details?id=\${userId}`
            }
        })

        const getPosts = page => {
            return fetch(`/customer/posts?id=\${userId}&page=\${page}&limit=7`).then(response => response.json());
        }

        function fetchAndRenderPosts(page) {
            if (isPostFetching || isPostLast) {
                return;
            }
            isPostFetching = true;
            postsLoadingSpinner.style.display = 'block';
            getPosts(page).then(data => {

                if (data.totalElements === 0) {
                    postOutputArea.innerHTML += `<span class=fw-lighter m-3>No posts published yet.</span>`
                    postsLoadingSpinner.style.display = 'none'
                    isPostFetching = false;
                }

                isPostLast = data.last;
                data.content.forEach(datum => {
                    postOutputArea.innerHTML += `
                        <div class="shadow-sm border border-light rounded m-3">
                            <div class="p-3">
                                <div class="fw-medium postDetailEntry" type="button" data-post-id="\${datum.id}"> \${datum.title}</div>
                                \${datum.subTitle}
                            </div>
                        </div>
                    `;
                    postsLoadingSpinner.style.display = 'none'
                    isPostFetching = false;
                })
            })
        }

        addEventListener('click', function (event) {
            if (event.target.classList.contains('postDetailEntry')) {
                const button = event.target
                const postId = button.getAttribute('data-post-id')

                window.location.href = `/post/detail?id=\${postId}`
            }
        })

        postsToastButton.addEventListener("click", function () {
            const postsToastBootstrap = bootstrap.Toast.getOrCreateInstance(postsToast)

            visibility.then(public => {
                follow.then(follow => {
                    if (public || follow) {
                        // initial loading
                        fetchAndRenderPosts(pageOnPost);

                        // infinite scrolling (scroll pagination)
                        postOutputArea.addEventListener('scroll', function () {
                            const scrollPos = this.scrollTop + this.clientHeight;
                            const scrollHeight = this.scrollHeight;

                            if (scrollPos === scrollHeight) {
                                pageOnPost += 1;
                                fetchAndRenderPosts(pageOnPost);
                            }
                        })

                        postsToastBootstrap.show()
                    } else {
                        showMessagingToast("This is a private profile. To see the details, you need to follow first :)")
                    }
                })
            })
        })

        const getReviews = page => {
            return fetch(`/customer/reviews?id=\${userId}&page=\${page}&limit=7`).then(response => response.json());
        }

        function fetchAndRenderReviews(page) {
            if (isReviewFetching || isReviewLast) {
                return;
            }
            isReviewFetching = true;
            reviewsLoadingSpinner.style.display = 'block';
            getReviews(page).then(data => {

                if (data.totalElements === 0) {
                    reviewsOutputArea.innerHTML += `<span class=fw-lighter m-3>No reviews published yet.</span>`
                    reviewsLoadingSpinner.style.display = 'none'
                    isReviewFetching = false;
                }

                isReviewLast = data.last;
                data.content.forEach(datum => {

                    let typeClass = null;
                    switch (datum.rating) {
                        case 5:
                            typeClass = 'badge bg-warning-subtle text-warning-emphasis rounded-pill';
                            break;
                        case 3:
                            typeClass = 'badge bg-light-subtle text-light-emphasis rounded-pill';
                            break;
                        case 1:
                            typeClass = 'badge bg-dark-subtle text-dark-emphasis rounded-pill';
                            break;
                        default:
                            typeClass = 'badge bg-light-subtle text-light-emphasis rounded-pill';
                    }

                    const truncatedContent = (datum.content.split(' ').length > 30)
                        ? `\${datum.content.split(' ').slice(0, 50).join(' ')} (...)`
                        : datum.content;

                    reviewsOutputArea.innerHTML += `
                        <div class="shadow-sm border border-light rounded m-3">
                            <div class="p-2" type="button">
                                <div>
                                    <span class="badge bg-success-subtle text-success-emphasis rounded-pill fw-light storeDetailsEntry" data-store-id="\${datum.store.id}">
                                        \${datum.store.name}
                                    </span>
                                    <span class="\${typeClass} fw-light">\${ getRatingText(datum.rating) }
                                </div>
                                <p class="rounded-4 bg-body-tertiary mt-3 p-3 storeDetailsEntry" data-store-id="\${datum.store.id}">
                                    \${truncatedContent}
                                </p>
                            </div>
                        </div>
                    `;
                    reviewsLoadingSpinner.style.display = 'none'
                    isReviewFetching = false;
                })
            })
        }

        reviewsToastButton.addEventListener("click", function () {
            const reviewsToastBootstrap = bootstrap.Toast.getOrCreateInstance(reviewsToast)

            visibility.then(public => {
                follow.then(follow => {
                    if (public || follow) {
                        // initial loading
                        fetchAndRenderReviews(pageOnReview);

                        // infinite scrolling (scroll pagination)
                        reviewsOutputArea.addEventListener('scroll', function () {
                            const scrollPos = this.scrollTop + this.clientHeight;
                            const scrollHeight = this.scrollHeight;

                            if (scrollPos === scrollHeight) {
                                pageOnReview += 1;
                                fetchAndRenderReviews(pageOnReview);
                            }
                        })

                        reviewsToastBootstrap.show()
                    } else {
                        showMessagingToast("This is a private profile. To see the details, you need to follow first :)")
                    }
                })
            })
        })
    });

    const params = new URLSearchParams(window.location.search);
    const userId = params.get("id");

    const visibility = fetch(`/user/visibility?id=\${userId}`)
        .then(response => response.text())
        .then(responseText => responseText === 'PUBLIC');

    const follow = fetch(`/user/follow?id=\${userId}`)
        .then(response => response.text())
        .then(responseText => responseText === "YES")

    addEventListener('click', function (event) {
        if (event.target.classList.contains('storeDetailsEntry')) {
            const button = event.target;
            const storeId = button.getAttribute('data-store-id')

            window.location.href = `/store/detail?id=\${storeId}`
        }
    })

    let isRequestLast = false;
    let isRequestsFetching = false;
    let pageOnRequests = 0
    let requestFetchingOption = 'pending'

    const requestLoadingSpinner = document.getElementById('requestLoadingSpinner')
    const requestsOutputArea = document.getElementById('requestsOutputArea')

    const picturesLoadingSpinner = document.getElementById('picturesLoadingSpinner')
    const pictureDataOutputArea = document.getElementById('pictureDataOutputArea');

    let pageOnPictureData = 0;
    let isPictureDataLast = false;
    let isPictureDataFetching = false;

    let currentFetchingOption = null;

    const getPostData = page => {
        return fetch(`/customer/postData?id=\${userId}&page=\${page}&limit=9`).then(response => response.json());
    }

    const getReviewData = page => {
        return fetch(`/customer/reviewData?id=\${userId}&page=\${page}&limit=9`).then(response => response.json());
    }

    function fetchAndRenderPostData(page) {
        isPictureDataFetching = true;
        picturesLoadingSpinner.style.display = 'block';

        getPostData(page).then(data => {

            if (data.totalElements === 0) {
                picturesLoadingSpinner.style.display = 'none'

                pictureDataOutputArea.innerHTML = `
                    <div class="row text-center ">
                        <div class="fw-lighter fs-5">No pictures yet.</div>
                    </div>
                `
            }

            if (data.last) {
                isPictureDataLast = true;
                picturesLoadingSpinner.style.display = 'none';
            }

            data.content.forEach(datum => {
                pictureDataOutputArea.innerHTML += `
                    <div class="col-4 my-3">
                        <div class=" rounded-4 text-bg-light shadow-sm border border-0">
                            <img type="button" src="/images/post/jpeg/\${datum.pictureFile}" alt="Image"  class="object-fit-cover storeDetailsEntry" style="height: 200px; width: 100%" data-store-id="\${datum.store.id}">
                        </div>
                    </div>
                `
                picturesLoadingSpinner.style.display = 'none'
                isPictureDataFetching = false;
            })
        })
    }

    function fetchAndRenderReviewData(page) {
        isPictureDataFetching = true;
        picturesLoadingSpinner.style.display = 'block';

        getReviewData(page).then(data => {

            if (data.totalElements === 0) {
                picturesLoadingSpinner.style.display = 'none'

                pictureDataOutputArea.innerHTML = `
                    <div class="row text-center ">
                        <div class="fw-lighter fs-5">No pictures yet.</div>
                    </div>
                `
            }

            if (data.last) {
                isPictureDataLast = true;
                picturesLoadingSpinner.style.display = 'none';
            }

            data.content.forEach(datum => {
                pictureDataOutputArea.innerHTML += `
                    <div class="col-4 my-3">
                        <div class=" rounded-4 text-bg-light shadow-sm border border-0">
                            <img src="/images/review/jpeg/\${datum.pictureName}" alt="Image"  class="object-fit-cover storeDetailsEntry" data-store-id="\${datum.review.store.id}" style="height: 200px; width: 100%">
                        </div>
                    </div>
                `
                picturesLoadingSpinner.style.display = 'none'
                isPictureDataFetching = false;
            })
        })
    }

    visibility.then(public => {
        follow.then(follow => {
            if (public || follow) {
                // initial loading
                fetchAndRenderPostData(pageOnPictureData);
                currentFetchingOption = (page) => {
                    return fetchAndRenderPostData(page)
                }
            } else {
                showMessagingToast("This is a private profile. To see the details, you need to follow first :)")
            }
        })
    })

    document.getElementById('postPicturesButton').addEventListener('click', function () {

        visibility.then(public => {
            follow.then(follow => {
                if (public || follow) {
                    pictureDataOutputArea.innerHTML = ''
                    pageOnPictureData = 0
                    isPictureDataLast = false;
                    isPictureDataFetching = false;

                    fetchAndRenderPostData(pageOnPictureData)
                    currentFetchingOption = (page) => {
                        return fetchAndRenderPostData(page)
                    }
                } else {
                    showMessagingToast("This is a private profile. To see the details, you need to follow first :)")
                }
            })
        })
    })

    document.getElementById('reviewPicturesButton').addEventListener('click', function () {

        visibility.then(public => {
            follow.then(follow => {
                if (public || follow) {

                    pictureDataOutputArea.innerHTML = ''
                    pageOnPictureData = 0
                    isPictureDataLast = false;
                    isPictureDataFetching = false;

                    fetchAndRenderReviewData(pageOnPictureData)
                    currentFetchingOption = (page) => {
                        return fetchAndRenderReviewData(page)
                    }
                } else {
                    showMessagingToast("This is a private profile. To see the details, you need to follow first :)")
                }
            })
        })
    })

    window.onscroll = function () {

        if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight + 96) {

            if (isPictureDataFetching || isPictureDataLast) {
                // do nothing
            } else {
                pageOnPictureData += 1;
                currentFetchingOption(pageOnPictureData);
            }
        }
    }

    document.getElementById('followRequestButton').addEventListener('click', function () {
        fetch(`/user/follow?recipientId=\${userId}`, {
            method: "POST"
        }).then(response => {
            if (response.ok) {

                visibility.then(public => {
                    follow.then(follow => {

                        if (public || follow) {
                            updateFollowersCount()
                        } // else: do nothing
                    })
                })
                showMessagingToast("Successfully done!");
            } else {
                showMessagingToast("Already requested.");
            }
        })
    })

    function showMessagingToast(message) {
        const messagingToast = document.getElementById('messagingToast');
        const toastBody = messagingToast.querySelector('.toast-body');

        toastBody.textContent = message;

        const messagingToastBootstrap = bootstrap.Toast.getOrCreateInstance(messagingToast);
        messagingToastBootstrap.show();
    }

    visibility.then(public => {
        follow.then(follow => {
            if (public || follow) {
                // do nothing
            } else {
                showMessagingToast("This is a private profile. To see the details, you need to follow first :)")
            }
        })
    })

    visibility.then(public => {
        follow.then(follow => {
            if (public || follow) {
                updateFollowersCount();
            } else {
                showMessagingToast("This is a private profile. To see the details, you need to follow first :)")
            }
        })
    })


    visibility.then(public => {
        follow.then(follow => {
            if (public || follow) {
                updateFollowingsCount();
            } else {
                showMessagingToast("This is a private profile. To see the details, you need to follow first :)")
            }
        })
    })

    visibility.then(public => {
        follow.then(follow => {
            if (public || follow) {
                updatePostsCount();
            } else {
                showMessagingToast("This is a private profile. To see the details, you need to follow first :)")
            }
        })
    })

    visibility.then(public => {
        follow.then(follow => {
            if (public || follow) {
                updateReviewsCount();
            } else {
                showMessagingToast("This is a private profile. To see the details, you need to follow first :)")
            }
        })
    })

    const updateFollowingsCount = () => {
        fetch(`/user/followings-count?id=\${userId}`)
            .then(response => response.text())
            .then(data => {
                document.getElementById('followingsCount').textContent = data;
            });
    };

    const updateFollowersCount = () => {
        fetch(`/user/followers-count?id=\${userId}`)
            .then(response => response.text())
            .then(data => {
                document.getElementById('followersCount').textContent = data;
            });
    };

    const updatePostsCount = () => {
        fetch(`/customer/posts-count?id=\${userId}`)
            .then(response => response.text())
            .then(data => {
                document.getElementById('postsCount').textContent = data;
            })
    }

    const updateReviewsCount = () => {
        fetch(`/customer/reviews-count?id=\${userId}`)
            .then(response => response.text())
            .then(data => {
                document.getElementById('reviewsCount').textContent = data;
            })
    }

    function getRatingText(rating) {
        switch (rating) {
            case 5:
                return '맛있어요 😋'
            case 3:
                return '괜찮아요 🙂'
            case 1:
                return '별로에요 🥲'
        }
    }

    function fetchUserImage() {
        const userImage = document.getElementById('userImage');
        const userImageSrc = "/images/user/png/${customer.username}"

        fetch(userImageSrc)
            .then(response => {
                if (response.ok) {
                    return response.blob();
                } else {
                    // Default image
                    userImage.src = '/images/user/png/user-default-image.png';
                }
            })
            .then(imageBlob => {
                return URL.createObjectURL(imageBlob);
            })
            .then(imageUrl => {
                userImage.src = imageUrl;
            })
    }

    fetchUserImage();

</script>
</html>
