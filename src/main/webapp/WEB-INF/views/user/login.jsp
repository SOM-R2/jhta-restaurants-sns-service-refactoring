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
</head>
<body>
<%@ include file="../common/navbar.jsp" %>
<div class="container">
    <div class="row my-5 justify-content-center align-items-center">
        <div class="col-md-5 my-5">
            <div class="card shadow my-5">
                <div class="fw-lighter m-4 p-2">
                    <span class="fs-3">로그인</span>
                </div>
                <div class="card-body">
                    <div class="row p-2">
                        <form method="post" action="login">
                            <div class="form-floating my-2">
                                <input id="username-input" type="text" class="form-control-plaintext my-1"
                                       name="username" placeholder="username">
                                <label for="username-input">username</label>
                            </div>
                            <div class="form-floating my-2">
                                <input id="password-input" type="password" class="form-control-plaintext"
                                       name="password" placeholder="password">
                                <label for="username-input">password</label>
                            </div>
                            <div class="text-end my-2">
                                <button id="login-btn" class="btn btn-sm border-light-subtle" disabled>
                                    <span id="loginRequest" class="fw-light">login</span>
                                    <div id="loginLoadingSpinner"
                                         class="spinner-border spinner-border-sm text-primary m-1" role="status" style="display: none;">
                                        <span class="visually-hidden">Loading...</span>
                                    </div>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="toast-container position-fixed bottom-0 end-0 p-4">
        <div id="badCredentialsToast" class="toast align-items-center text-bg-secondary border-0"
             role="alert"
             aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    로그인 정보가 올바르지 않습니다.
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                        data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
        <div id="authenticationEntryToast" class="toast align-items-center text-bg-primary border-0"
             role="alert"
             aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    로그인을 먼저 해주세요 :)
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                        data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
        <div id="deniedToast" class="toast align-items-center text-bg-secondary border-0"
             role="alert"
             aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    접근할 수 없는 페이지입니다 😢
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                        data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>

</div>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const params = new URLSearchParams(window.location.search);

        const usernameInput = document.querySelector('input[name="username"]');
        const passwordInput = document.querySelector('input[name="password"]');
        const loginButton = document.getElementById('login-btn');
        const buttonMessage = document.getElementById("loginRequest");
        const loginSpinner = document.getElementById('loginLoadingSpinner')

        let validationStatus = {
            usernameInput: false,
            passwordInput: false
        }

        if (params.get("error") === "fail") {
            badCredentialsToast();
        } else if (params.get("error") === "anonymous") {
            authenticationEntryToast();
        } else if (params.get("error") === "denied") {
            deniedToast();
        }

        usernameInput.addEventListener("blur", function () {
            if (this.value.trim() === '') {
                validationStatus.usernameInput = false;
            } else if (this.value.trim().includes(' ')) {
                validationStatus.usernameInput = false;
            } else {
                validationStatus.usernameInput = true;
            }
            updateLoginButton();
        })

        passwordInput.addEventListener("blur", function () {
            if (this.value.trim() === '') {
                validationStatus.passwordInput = false;
            } else if (this.value.trim().includes(' ')) {
                validationStatus.passwordInput = false;
            } else {
                validationStatus.passwordInput = true;
            }
            updateLoginButton();
        })

        loginButton.addEventListener("click", function (event) {
            event.preventDefault();

            if (Object.values(validationStatus).some(status => status === false)) {
                // do nothing
            } else {
                loginButton.setAttribute("disabled", "disabled");
                buttonMessage.textContent = "";
                loginSpinner.style.display = "block"

                fetch("/user/login", {
                    method: "POST",
                    headers: {
                        "Connection": "keep-alive",
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: new URLSearchParams({
                        "username": usernameInput.value,
                        "password": passwordInput.value
                    }).toString()
                }).then(response => {
                    if (response.ok) {
                        window.history.back();
                    } else {
                        loginSpinner.style.display = "none";
                        buttonMessage.textContent = "login";

                        // response from `RestAuthenticationFailureHandler`
                        badCredentialsToast()

                        usernameInput.value = "";
                        passwordInput.value = "";
                    }
                })
            }
        })

        function updateLoginButton() {
            if (Object.values(validationStatus).every(status => status === true)) {
                loginButton.removeAttribute("disabled");
            } else {
                loginButton.setAttribute("disabled", "disabled");
            }
        }

        function badCredentialsToast() {
            let badCredentialsToast = document.getElementById('badCredentialsToast')
            const toastSentBootstrap = bootstrap.Toast.getOrCreateInstance(badCredentialsToast)
            toastSentBootstrap.show()
        }

        function authenticationEntryToast() {
            let authenticationEntryToast = document.getElementById('authenticationEntryToast')
            const toastSentBootstrap = bootstrap.Toast.getOrCreateInstance(authenticationEntryToast)
            toastSentBootstrap.show()
        }

        function deniedToast() {
            let deniedToast = document.getElementById('deniedToast')
            const toastSentBootstrap = bootstrap.Toast.getOrCreateInstance(deniedToast)
            toastSentBootstrap.show()
        }
    })
</script>
</body>
</html>