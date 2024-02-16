<%--TODO: 1. Sorting and pagination over registered stores --%>
<%--TODO: 2. Store detail modification page --%>
<%--TODO: 3. Socials drop and replace with another content --%>
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
</head>
<body>
<%@ include file="../../common/navbar.jsp" %>
<div class="container">
    <div class="row my-5">
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
                    </div>
                    <div class="card-body">
                        <div class="row mx-2">
                            <div class="col-sm-4 my-1 fw-lighter">
                                <label for="fullName" class="col-sm-2 col-form-label"><span style="white-space: nowrap">Full Name</span></label>
                            </div>
                            <div class="col-sm-8 my-1">
                                <p class="form-control-plaintext" id="fullName"> ${ owner.fullName } </p>
                            </div>
                        </div>
                        <div class="row mx-2">
                            <div class="col-sm-4 my-1 fw-lighter">
                                <label for="nickName" class="col-sm-2 col-form-label"><span style="white-space: nowrap">Nickname</span></label>
                            </div>
                            <div class="col-sm-8 my-1">
                                <p class="form-control-plaintext" id="nickName"> ${ owner.nickname } </p>
                            </div>
                        </div>
                        <div class="row mx-2">
                            <div class="col-sm-4 my-1 fw-lighter">
                                <label for="email" class="col-sm-2 col-form-label"><span
                                        style="white-space: nowrap">Email</span></label>
                            </div>
                            <div class="col-sm-8 my-1">
                                <p class="form-control-plaintext" id="email"> ${ owner.email } </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card shadow-sm border border-0 mt-3">
                    <div class="fw-lighter m-3 p-1">
                        <div class="row">
                            <div class="col-8 fs-4">Socials</div>
                            <div class="col-4 d-flex justify-content-end">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" role="switch"
                                           id="socialVisibilityInput">
                                    <label class="form-check-label" for="socialVisibilityInput">Private</label>
                                </div>
                            </div>
                        </div>
                        <div class="row my-2">
                            <div class="col text-end">
                                <div id="followersToastButton" type="button"
                                     class="badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill position-relative mx-2">
                                    followers
                                    <span id="followersCount"
                                          class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"></span>
                                </div>
                                <div id="followingsToastButton" type="button"
                                     class="badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill position-relative mx-2">
                                    followings
                                    <span id="followingsCount"
                                          class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="p-2 m-3">
                            <div id="pendingRequests"
                                 type="button"
                                 class="badge bg-primary-subtle border border-primary-subtle text-primary-emphasis rounded-pill ">
                                Pending
                            </div>
                            <div id="acceptedRequests"
                                 type="button"
                                 class="badge bg-success-subtle border border-success-subtle text-success-emphasis rounded-pill ">
                                Accepted
                            </div>
                            <div id="declinedRequests"
                                 type="button"
                                 class="badge bg-danger-subtle border border-danger-subtle text-danger-emphasis rounded-pill ">
                                Declined
                            </div>
                            <div id="sentRequests"
                                 type="button"
                                 class="badge bg-warning-subtle border border-warning-subtle text-warning-emphasis rounded-pill">
                                Sent
                            </div>
                            <hr/>
                            <div id="requestsOutputArea" class="overflow-scroll" style="max-height: 200px">
                            </div>
                            <div class="text-center">
                                <div class="btn border border-0 disabled">
                                    <div id="requestLoadingSpinner"
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
        <div class="col-md-7 my-5">
            <div class="fw-lighter m-3 p-1">
                <div class="row">
                    <div class="col-4 fs-4">My Stores</div>
                    <div class="col-8 d-flex justify-content-end">
                        <div class="pb-2 my-1 border-bottom text-end">
                                <span class="badge bg-primary-subtle border border-primary-subtle text-primary-emphasis rounded-pill my-2"
                                      type="button"
                                      onclick="window.location.href=`/owner/register`">
                                    Add your store!
                                </span>
                            <span id="storesButton"
                                  type="button"
                                  class="badge bg-success-subtle border border-success-subtle text-success-emphasis rounded-pill mx-1">
                                    My stores
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div id="contentOutputArea">
                </div>
                <div class="text-center">
                    <div class="btn border border-0 disabled">
                        <div id="storeLoadingSpinner"
                             class="spinner-border spinner-border-sm text-primary m-1" role="status"
                             style="display: none;">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="toast-container position-fixed bottom-0 end-0 p-4">
        <div id="successfulToast" class="toast text-bg-primary" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                        data-bs-dismiss="toast" aria-label="Close"></button>
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
</div>
</body>
<script>

    const followersToastButton = document.getElementById('followersToastButton')
    const followersLoadingSpinner = document.getElementById('followersLoadingSpinner')

    let followersToast = document.getElementById('followersToast')
    let followersOutputArea = document.getElementById('followersOutputArea');

    const followingsToastButton = document.getElementById('followingsToastButton')
    const followingsLoadingSpinner = document.getElementById('followingsLoadingSpinner')

    let followingsToast = document.getElementById('followingsToast')
    let followingsOutputArea = document.getElementById('followingsOutputArea');

    let pageOnFollower = 0
    let isFollowerFetching = false;
    let isFollowerLast = false;

    let pageOnFollowing = 0
    let isFollowingFetching = false;
    let isFollowingLast = false;

    const socialVisibilityInput = document.getElementById('socialVisibilityInput')
    socialVisibilityInput.addEventListener('click', function () {
        fetch(`/user/visibility`, {method: "POST"})
    })

    fetch('/user/visibility')
        .then(response => response.text())
        .then(responseText => {
            if (responseText === 'PRIVATE') {
                socialVisibilityInput.checked = true;
            } else {
                socialVisibilityInput.checked = false;
            }
        })

    const getFollowers = page => {
        return fetch(`/user/followers?page=\${page}&limit=7`).then(response => response.json());
    }

    function fetchAndRenderFollowers(page) {
        if (isFollowerFetching || isFollowerLast) {
            return;
        }
        isFollowerFetching = true;
        followersLoadingSpinner.style.display = 'block';
        getFollowers(page).then(data => {
            if (data.length === 0) {
                followersOutputArea.innerHTML += `<span class=fw-lighter m-3>No followers yet.</span>`
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
    })

    const getFollowings = page => {
        return fetch(`/user/followings?page=\${page}&limit=7`).then(response => response.json());
    }

    function fetchAndRenderFollowings(page) {
        if (isFollowingFetching || isFollowingLast) {
            return;
        }
        isFollowingFetching = true;
        followingsLoadingSpinner.style.display = 'block';
        getFollowings(page).then(data => {
            if (data.length === 0) {
                followingsOutputArea.innerHTML += `<span class=fw-lighter m-3>No followings yet.</span>`
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
    })

    followingsToastButton.addEventListener("click", function () {
        let followingsToast = document.getElementById('followingsToast')
        const followingsToastBootstrap = bootstrap.Toast.getOrCreateInstance(followingsToast)
        followingsToastBootstrap.show()
    })

    addEventListener('click', function (event) {
        if (event.target.classList.contains('userDetailEntry')) {
            const button = event.target;
            const userId = button.getAttribute('data-user-id')

            window.location.href = `/user/details?id=\${userId}`
        }
    })

    let isRequestLast = false;
    let isRequestsFetching = false;
    let pageOnRequests = 0
    let requestFetchingOption = 'pending'

    const requestLoadingSpinner = document.getElementById('requestLoadingSpinner')
    const requestsOutputArea = document.getElementById('requestsOutputArea')

    const getRequests = (option, page) => {
        return fetch(`/user/requests?option=\${option}&page=\${page}&limit=5`).then(response => response.json())
    }

    function fetchAndRenderRequests(option, page) {
        isRequestsFetching = true
        requestLoadingSpinner.style.display = 'block';

        getRequests(option, page).then(data => {

            if (data.length < 5) {
                isRequestLast = true;
                isRequestsFetching = false;
                requestLoadingSpinner.style.display = 'none';
            }

            data.forEach(datum => {

                function getStatusClasses(status) {
                    switch (status) {
                        case 'PENDING':
                            return 'badge bg-primary-subtle text-primary-emphasis rounded-pill my-1 requestStatusButton';
                        case 'ACCEPTED':
                            return 'badge bg-success-subtle text-success-emphasis rounded-pill my-1 requestStatusButton';
                        case 'DECLINED':
                            return 'badge bg-danger-subtle text-danger-emphasis rounded-pill my-1 requestStatusButton';
                        default:
                            return 'badge bg-warning-subtle text-warning-emphasis rounded-pill my-1';
                    }
                }

                const statusClasses = getStatusClasses(datum.followRequest.status);

                requestsOutputArea.innerHTML += `
                <div class="border rounded p-2 my-2 d-flex align-items-center">
                    <div class="fw-light mx-1 userDetailEntry" type="button"  data-user-id="\${datum.user.id}">\${datum.user.nickname}</div>
                    <div class="ms-auto">
                        <span type="button"
                              data-request-id="\${datum.followRequest.id}"
                              class="\${statusClasses}">\${datum.followRequest.status}</span>
                    </div>
                </div>

                `
                requestLoadingSpinner.style.display = 'none';
                isRequestsFetching = false;
            })
        })
    }

    fetchAndRenderRequests(requestFetchingOption, pageOnRequests);

    document.getElementById('pendingRequests').addEventListener('click', function () {
        requestsOutputArea.innerHTML = ''

        pageOnRequests = 0
        isRequestLast = false;
        requestFetchingOption = 'pending'
        fetchAndRenderRequests(requestFetchingOption, pageOnRequests);
    })

    document.getElementById('acceptedRequests').addEventListener('click', function () {
        requestsOutputArea.innerHTML = ''

        pageOnRequests = 0
        isRequestLast = false;
        requestFetchingOption = 'accepted'
        fetchAndRenderRequests(requestFetchingOption, pageOnRequests);
    })

    document.getElementById('declinedRequests').addEventListener('click', function () {
        requestsOutputArea.innerHTML = ''

        pageOnRequests = 0
        isRequestLast = false;
        requestFetchingOption = 'declined'
        fetchAndRenderRequests(requestFetchingOption, pageOnRequests);
    })

    document.getElementById('sentRequests').addEventListener('click', function () {
        requestsOutputArea.innerHTML = ''

        pageOnRequests = 0
        isRequestLast = false;
        requestFetchingOption = 'sent'
        fetchAndRenderRequests(requestFetchingOption, pageOnRequests);
    })

    requestsOutputArea.addEventListener('scroll', function () {

        const scrollPos = this.scrollTop + this.clientHeight;
        const scrollHeight = this.scrollHeight;

        if (scrollPos + .5 >= scrollHeight) {
            if (isRequestsFetching || isRequestLast) {
                // do nothing
            } else {
                pageOnRequests += 1;
                fetchAndRenderRequests(requestFetchingOption, pageOnRequests);
            }

        }
    })

    document.addEventListener('click', function (event) {
        if (event.target.classList.contains('requestStatusButton')) {
            const button = event.target;
            const requestId = button.getAttribute('data-request-id')

            fetch(`/user/requests-modify?requestId=\${requestId}`, {
                method: "POST"
            })
                .then(response => response.text())
                .then(status => {

                    function getStatusClasses(status) {
                        switch (status) {
                            case 'PENDING':
                                return 'badge bg-primary-subtle text-primary-emphasis rounded-pill my-1 requestStatusButton';
                            case 'ACCEPTED':
                                return 'badge bg-success-subtle text-success-emphasis rounded-pill my-1 requestStatusButton';
                            case 'DECLINED':
                                return 'badge bg-danger-subtle text-danger-emphasis rounded-pill my-1 requestStatusButton';
                            default:
                                return 'badge bg-warning-subtle text-warning-emphasis rounded-pill my-1';
                        }
                    }

                    const newStatusClasses = getStatusClasses(status);

                    button.textContent = status;
                    button.className = newStatusClasses;

                    updateFollowersCount();
                })
        }
    })

    const storeLoadingSpinner = document.getElementById('storeLoadingSpinner')
    const contentOutputArea = document.getElementById('contentOutputArea')

    let pageOnStore = 0;
    let isStoreFetching = false;
    let isStoreLast = false;

    let currentFetchingOption = null;

    const getStores = page => {
        return fetch(`/owner/stores?page=\${page}&limit=3`).then(response => response.json());
    }

    function fetchAndRenderStores(page) {
        isStoreFetching = true
        storeLoadingSpinner.style.display = 'block';

        getStores(page).then(data => {

            if (data.length === 0) {
                storeLoadingSpinner.style.display = 'none'
            }

            if (data.last) {
                isStoreLast = true;
                storeLoadingSpinner.style.display = 'none'
            }

            data.forEach(datum => {

                function removeSecondsFromTime(timeString) {
                    return timeString.split(':').slice(0, 2).join(':');
                }

                let foodBadges = '';
                datum.foods.forEach(food => {
                    const foodBadge = `
                        <span class="badge bg-light-subtle border border-light-subtle text-light-emphasis rounded-pill mx-1">
                            \${food.name}
                        </span>
                    `;
                    foodBadges += foodBadge;
                });

                let openTimesBadges = '';
                datum.openTimes.forEach(openTime => {
                    const openTimesBadge = `
                        <span class="badge bg-light-subtle border border-light-subtle text-light-emphasis rounded-pill position-relative mx-4 my-2">
                            \${openTime.day}
                            <span class="position-absolute top-100 start-100 translate-middle badge rounded-pill bg-secondary-subtle text-secondary my-1">
                                \${removeSecondsFromTime(openTime.openTime)} ~ \${removeSecondsFromTime(openTime.closeTime)}
                            </span>
                        </span>
                    `
                    openTimesBadges += openTimesBadge;
                })

                let wishersBadges = '';
                datum.wishers.forEach(wisher => {
                    const wishersBadge = `
                        <span type="button"
                              class="badge bg-warning-subtle border border-warning-subtle text-warning-emphasis rounded-pill my-2 userDetailEntry"
                              data-user-id=\${wisher.id}>
                            \${wisher.nickname}
                        </span>
                    `
                    wishersBadges += wishersBadge;
                })

                contentOutputArea.innerHTML += `
                        <div class="bg-light rounded-3 p-3 my-4 shadow-sm">
                            <div class="row d-flex align-items-center justify-content-center">
                                <div class="col-lg-9">
                                    <span type="button" class="fs-3 fw-lighter storeDetailsEntry" data-store-id="\${datum.store.id}">
                                        \${datum.store.name}
                                    </span>
                                    <span class="badge bg-light-subtle border border-light-subtle text-light-emphasis rounded-pill ">
                                        \${datum.store.address}
                                    </span>
                                </div>
                                <div class="col-lg-3">
                                    <div class="text-end">
                                        <span class="badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill mx-1">
                                            \${datum.store.category}
                                        </span>
                                        <span
                                            type="button"
                                            class="badge bg-danger-subtle border border-danger-subtle text-danger-emphasis rounded-pill deleteStoreButton"
                                            data-store-id=\${datum.store.id}>
                                            delete
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="fw-light shadow-sm rounded-2 bg-white my-3 p-4 overflow-auto" style="white-space: pre-line;">
                                \${datum.store.description}
                            </div>
                            <div class="my-4 px-4">
                                \${foodBadges}
                            </div>
                            <div class="my-3">
                                \${openTimesBadges}
                            </div>
                            <div class="m-4 pt-3">
                                <span class="fw-lighter fs-6">Bookmarked by..</span>
                                <div class="border-top">
                                    \${wishersBadges}
                                </div>
                            </div>
                        </div>
                `
                isStoreFetching = false;
                storeLoadingSpinner.style.display = 'none';
            })
        })
    }

    // initial loading
    fetchAndRenderStores(pageOnStore);
    currentFetchingOption = (page) => {
        return fetchAndRenderStores(page)
    }

    document.getElementById('storesButton').addEventListener('click', function () {

        contentOutputArea.innerHTML = '';

        pageOnStore = 0;
        isStoreFetching = false;
        isStoreLast = false;

        fetchAndRenderStores(pageOnStore);
        currentFetchingOption = (page) => {
            return fetchAndRenderStores(page)
        }
    })

    addEventListener('click', function (event) {
        if (event.target.classList.contains('storeDetailsEntry')) {
            const button = event.target;
            const storeId = button.getAttribute('data-store-id')

            window.location.href = `/store/detail?id=\${storeId}`
        }
    })

    addEventListener('click', function (event) {
        if (event.target.classList.contains('userDetailEntry')) {
            const button = event.target;
            const userId = button.getAttribute('data-user-id')

            window.location.href = `/user/details?id=\${userId}`
        }
    })

    window.onscroll = function () {

        if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight + 95.5) {
            if (isStoreFetching || isStoreLast) {
                // do nothing
            } else {
                pageOnStore += 1;
                currentFetchingOption(pageOnStore);
            }
        }
    }

    document.addEventListener('click', function (event) {

        if (event.target.classList.contains('deleteStoreButton')) {
            const button = event.target;
            const storeId = button.getAttribute('data-store-id')

            fetch(`/store/delete?id=\${storeId}`, { method: "POST" })
                .then(response => {
                    if (response.ok) {
                        window.location.reload();
                    }
                })
        }
    })

    const updateFollowersCount = () => {
        fetch(`/user/followers-count`)
            .then(response => response.text())
            .then(data => {
                document.getElementById('followersCount').textContent = data;
            });
    };
    updateFollowersCount();

    const updateFollowingsCount = () => {
        fetch(`/user/followings-count`)
            .then(response => response.text())
            .then(data => {
                document.getElementById('followingsCount').textContent = data;
            });
    };
    updateFollowingsCount();

    const params = new URLSearchParams(window.location.search);

    if (params.get("registration") === "success") {
        showMessagingToast("Successfully registered :)");
    }

    function showMessagingToast(message) {
        const successfulToast = document.getElementById('successfulToast');
        const toastBody = successfulToast.querySelector('.toast-body');

        toastBody.textContent = message;

        const successfulToastBootstrap = bootstrap.Toast.getOrCreateInstance(successfulToast);
        successfulToastBootstrap.show();
    }

    function handleImageClick() {
        document.getElementById('fileInput').click();
    }

    function handleFileSelect() {
        const fileInput = document.getElementById('fileInput');
        const userImage = document.getElementById('userImage');

        // Check if a file is selected
        if (fileInput.files && fileInput.files[0]) {
            const selectedFile = fileInput.files[0];

            // Create a FileReader to read the selected file
            const reader = new FileReader();

            reader.onload = function(e) {
                // Set the image source to the selected file
                userImage.src = e.target.result;

                sendFileToServer(selectedFile)
            };

            reader.readAsDataURL(selectedFile);
        }
    }

    function sendFileToServer(file) {

        const formData = new FormData();
        formData.append('imageFile', file);

        fetch(`/images/user-post/png`, {
            method: "POST",
            body: formData
        })
    }

    function fetchUserImage() {
        const userImage = document.getElementById('userImage');
        const userImageSrc = "/images/user/png/${owner.username}"

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
