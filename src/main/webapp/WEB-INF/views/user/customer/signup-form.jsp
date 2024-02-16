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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<%@ include file="../../common/navbar.jsp" %>
<div class="container">
    <div class="row my-5 justify-content-center align-items-center">
        <div class="col-md-6">
            <div class="card shadow my-5">
                <div class="fw-light text-center my-3">손님 회원 가입</div>
                <div class="card-body">
                    <div class="row my-1 p-1">
                        <form method="post" action="signup" modelAttribute="userCommand">
                            <div class="form-floating my-3">
                                <input type="text" class="form-control" name="username" id="username" placeholder=""/>
                                <label class="fw-lighter d-flex" for="username">유저 아이디
                                    <div class="ms-auto">
                                        <div id="usernameLoadingSpinner"
                                             class="spinner-border spinner-border-sm text-primary m-1" role="status"
                                             style="display: none;">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </div>
                                </label>
                            </div>
                            <div class="form-floating my-3">
                                <input type="password" class="form-control" name="password" id="password"
                                       placeholder=""/>
                                <label class="fw-lighter" for="password">비밀번호</label>
                            </div>
                            <div class="form-floating my-3">
                                <input type="text" class="form-control" name="fullName" id="fullName" placeholder=""/>
                                <label class="fw-lighter" for="fullName">성함</label>
                            </div>
                            <div class="form-floating my-3">
                                <input type="email" class="form-control" name="email" id="email" placeholder=""/>
                                <label class="fw-lighter d-flex" for="email">이메일
                                    <div class="ms-auto">
                                        <div id="emailLoadingSpinner"
                                             class="spinner-border spinner-border-sm text-primary m-1" role="status"
                                             style="display: none;">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </div>
                                </label>
                            </div>
                            <div class="form-floating my-3">
                                <input type="text" class="form-control" name="phone" id="phone" placeholder=""/>
                                <label class="fw-lighter d-flex" for="phone">전화번호
                                    <div class="ms-auto">
                                        <div id="phoneLoadingSpinner"
                                             class="spinner-border spinner-border-sm text-primary m-1" role="status"
                                             style="display: none;">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </div>
                                </label>
                            </div>
                            <div class="form-floating my-3">
                                <input type="text" class="form-control" name="nickname" id="nickname" placeholder=""/>
                                <label class="fw-lighter d-flex" for="username">닉네임
                                    <div class="ms-auto">
                                        <div id="nicknameLoadingSpinner"
                                             class="spinner-border spinner-border-sm text-primary m-1" role="status"
                                             style="display: none;">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </div>
                                </label>
                            </div>
                            <div class="form-group my-3">
                                <div class="row">
                                    <div class="col">
                                        <div class="row">
                                            <div class="col-8">
                                                <input type="date" class="form-control fw-lighter" name="birthday"/>
                                            </div>
                                            <div class="col-4">
                                                <select class="form-select fw-lighter" name="gender">
                                                    <option value="">성별</option>
                                                    <option value="male">남</option>
                                                    <option value="female">여</option>
                                                    <option value="other">그 외</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="text-center my-3 pt-4">
                                <button id="signupButton" class="btn btn-light btn-sm" disabled>
                                    <span id="otpRequest" class="fw-lighter">
                                        OTP
                                    </span>
                                    <div id="otpLoadingSpinner"
                                         class="spinner-border spinner-border-sm text-primary m-1" role="status"
                                         style="display: none;">
                                        <span class="visually-hidden">Loading...</span>
                                    </div>
                                </button>
                            </div>
                            <div class="toast-container position-fixed bottom-0 end-0 p-4">
                                <div id="failedToast" class="toast align-items-center text-bg-secondary border-0"
                                     role="alert"
                                     aria-live="assertive" aria-atomic="true">
                                    <div class="d-flex">
                                        <div class="toast-body">
                                            OTP가 일치하지 않습니다. 다시 한 번 확인해주세요.
                                        </div>
                                        <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                                data-bs-dismiss="toast" aria-label="Close"></button>
                                    </div>
                                </div>
                                <div id="successfulToast" class="toast align-items-center text-bg-primary border-0" role="alert" aria-live="assertive" aria-atomic="true">
                                    <div class="d-flex">
                                        <div class="toast-body">
                                            OTP를 발송하였습니다. 이메일을 확인해주세요 :)
                                        </div>
                                        <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                                data-bs-dismiss="toast" aria-label="Close"></button>
                                    </div>
                                </div>
                                <div id="otpInputToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="false">
                                        <div class="toast-body">
                                            <div class="row">
                                                <div class="col">
                                                    <label class="fw-lighter" for="otp">OTP</label>
                                                    <input class="form-control-plaintext" id="otp" name="otp">
                                                    <div class="d-flex justify-content-end align-items-end">
                                                        <i type="button" id="otpRequestIcon" class="fs-6 bi bi-send m-1" style="color: #838383"></i>
                                                        <div id="otpRequestLoadingSpinner" class="spinner-border spinner-border-sm text-primary m-1" role="status" style="display: none;">
                                                            <span class="visually-hidden">Loading...</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {

        const signupButton = document.getElementById("signupButton");

        const usernameInput = document.querySelector('input[name="username"]');
        const passwordInput = document.querySelector('input[name="password"]');
        const fullNameInput = document.querySelector('input[name="fullName"]');
        const emailInput = document.querySelector('input[name="email"]');
        const phoneInput = document.querySelector('input[name="phone"]');
        const nicknameInput = document.querySelector('input[name="nickname"]');
        const birthdayInput = document.querySelector('input[name="birthday"]');
        const genderInput = document.querySelector('select[name="gender"]');

        const usernameSpinner = usernameInput.parentElement.querySelector('.spinner-border')
        const nicknameSpinner = nicknameInput.parentElement.querySelector('.spinner-border')
        const emailSpinner = emailInput.parentElement.querySelector('.spinner-border');
        const phoneSpinner = phoneInput.parentElement.querySelector('.spinner-border');

        const otpValidationRequestIcon = document.querySelector('#otpRequestIcon');

        let validationStatus = { // default to false
            usernameInput: false,
            passwordInput: false,
            fullNameInput: false,
            emailInput: false,
            phoneInput: false,
            nicknameInput: false,
            birthdayInput: false,
            genderInput: false
        }

        usernameInput.addEventListener("blur", function () {
            removeErrorMessage(this);
            if (this.value.trim() === '') {
                displayErrorMessage(this, "필수 입력 사항입니다.");
                validationStatus.usernameInput = false;
            } else if (this.value.trim().includes(' ')) {
                displayErrorMessage(this, "사용자 이름에 공백을 포함할 수 없습니다.");
                validationStatus.usernameInput = false;
            } else {
                const username = encodeURIComponent(this.value.trim())
                usernameSpinner.style.display = "block";

                fetch(`/user/check-username?username=\${username}`, {
                    method: "GET"
                }).then(response => {
                    usernameSpinner.style.display = "none";
                    if (response.ok) {
                        removeSuccessMessage(this);
                        displaySuccessMessage(this);

                        validationStatus.usernameInput = true;
                        updateSubmitButton();
                    } else {
                        removeErrorMessage(this)
                        displayErrorMessage(this, "이미 사용 중인 사용자 이름입니다.");
                        validationStatus.usernameInput = false;
                        updateSubmitButton();
                    }
                })
            }
            updateSubmitButton();
        });

        passwordInput.addEventListener("blur", function () {
            removeErrorMessage(this);
            if (this.value.trim() === '') {
                displayErrorMessage(this, "필수 입력 사항입니다.");
                validationStatus.passwordInput = false;
            } else if (this.value.trim().includes(' ')) {
                displayErrorMessage(this, "사용자 비밀번호에 공백을 포함할 수 없습니다.");
                validationStatus.usernameInput = false;
            } else {
                removeSuccessMessage(this);
                displaySuccessMessage(this);

                validationStatus.passwordInput = true;
            }
            updateSubmitButton();
        });

        fullNameInput.addEventListener("blur", function () {
            const koreanNamePattern = /^[가-힣]{2,5}$/;

            removeErrorMessage(this);
            if (this.value.trim() === '') {
                displayErrorMessage(this, "필수 입력 사항입니다.")
                validationStatus.fullNameInput = false;
            } else if (!koreanNamePattern.test(this.value.trim())) {
                displayErrorMessage(this, "올바른 형식의 성함을 적어주세요.");
                validationStatus.fullNameInput = false;
            } else {
                removeSuccessMessage(this);
                displaySuccessMessage(this);

                validationStatus.fullNameInput = true;
            }
            updateSubmitButton();
        })

        emailInput.addEventListener("blur", function () {

            removeErrorMessage(this);
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(this.value.trim())) {
                displayErrorMessage(this, "올바른 형식의 이메일을 적어주세요.");
                validationStatus.emailInput = false;
            } else {
                const email = encodeURIComponent(this.value.trim())
                emailSpinner.style.display = "block";

                fetch(`/user/check-email?email=\${email}`, {
                    method: "GET"
                }).then(response => {
                    emailSpinner.style.display = "none";
                    if (response.ok) {
                        removeSuccessMessage(this);
                        displaySuccessMessage(this);

                        validationStatus.emailInput = true;
                        updateSubmitButton();
                    } else {
                        removeErrorMessage(this)
                        displayErrorMessage(this, "이미 사용 중인 이메일 주소입니다.");
                        validationStatus.emailInput = false;
                        updateSubmitButton();
                    }
                })
            }
            updateSubmitButton();
        });

        phoneInput.addEventListener("blur", function () {
            const phonePattern = /^010-[0-9]{4}-[0-9]{4}$/;

            removeErrorMessage(this);
            if (this.value.trim() === '') {
                displayErrorMessage(this, "필수 입력 사항입니다.");
                validationStatus.phoneInput = false;
            } else if (!phonePattern.test(this.value.trim())) {
                displayErrorMessage(this, "올바른 형식의 전화번호를 적어주세요.");
                validationStatus.phoneInput = false;
            } else {
                const phone = this.value.trim();
                phoneSpinner.style.display = "block";

                fetch(`/user/unique-phone?phone=\${phone}`, {
                    method: "GET"
                }).then(response => {
                    phoneSpinner.style.display = "none";

                    if (response.ok) {
                        removeSuccessMessage(this);
                        displaySuccessMessage(this);

                        validationStatus.phoneInput = true;
                        updateSubmitButton();
                    } else {
                        removeErrorMessage(this)
                        displayErrorMessage(this, "이미 사용 중인 전화번호입니다.");
                        validationStatus.emailInput = false;
                        updateSubmitButton();
                    }
                })
            }
            updateSubmitButton();
        });

        nicknameInput.addEventListener("blur", function () {
            removeErrorMessage(this);
            if (this.value.trim() === '') {
                displayErrorMessage(this, "필수 입력 사항입니다.");
                validationStatus.nicknameInput = false;
            } else if (this.value.trim().includes(' ')) {
                displayErrorMessage(this, "닉네임에 공백을 포함할 수 없습니다.");
                validationStatus.nicknameInput = false;
            } else {
                const nickname = encodeURIComponent(this.value.trim())
                nicknameSpinner.style.display = "block";

                fetch(`/user/check-nickname?nickname=\${nickname}`, {
                    method: "GET"
                }).then(response => {
                    nicknameSpinner.style.display = "none";
                    if (response.ok) {
                        removeSuccessMessage(this);
                        displaySuccessMessage(this);

                        validationStatus.nicknameInput = true;
                        updateSubmitButton();
                    } else {
                        removeErrorMessage(this)
                        displayErrorMessage(this, "이미 사용 중인 닉네임입니다.");
                        validationStatus.nicknameInput = false;
                        updateSubmitButton();
                    }
                })
            }
            updateSubmitButton();
        });

        birthdayInput.addEventListener("blur", function () {
            removeErrorMessage(this);
            if (this.value.trim() === '') {
                displayErrorMessage(this, "필수 입력 사항입니다.");
                validationStatus.birthdayInput = false;
            } else {
                removeSuccessMessage(this);
                displaySuccessMessage(this);

                validationStatus.birthdayInput = true;
            }
            updateSubmitButton();
        });

        genderInput.addEventListener("blur", function () {
            removeErrorMessage(this);
            if (this.value === '') {
                displayErrorMessage(this, "성별을 선택해주세요.");
                validationStatus.genderInput = false;
            } else {
                removeSuccessMessage(this);
                displaySuccessMessage(this);

                validationStatus.genderInput = true;
            }
            updateSubmitButton();
        });

        signupButton.addEventListener("click", function (event) {
            event.preventDefault();
            const errorMessages = document.querySelectorAll('.invalid-feedback');
            const buttonMessage = document.getElementById("otpRequest");
            const otpSpinner = document.getElementById("otpLoadingSpinner")

            if (Object.values(validationStatus).some(status => status === false)) {
                // do nothing

            } else if (errorMessages.length > 0) {
                // do nothing

            } else {
                signupButton.setAttribute("disabled", "disabled");

                buttonMessage.textContent = "";
                otpSpinner.style.display = "block";

                const formData = {
                    username: usernameInput.value.trim(),
                    password: passwordInput.value.trim(),
                    fullName: fullNameInput.value.trim(),
                    email: emailInput.value.trim(),
                    phone: phoneInput.value.trim(),
                    nickname: nicknameInput.value.trim(),
                    birthday: birthdayInput.value,
                    gender: genderInput.value
                };

                fetch("/customer/signup", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify(formData)
                })
                    .then(response => {
                        if (response.ok) {

                            const email = encodeURIComponent(formData.email);

                            fetch(`/customer/otp?email=\${email}`, {
                                method: "GET"
                            }).then(response => {
                                if (response.ok) {
                                    otpSpinner.style.display = "none";
                                    buttonMessage.innerHTML = "<i class='bi bi-check' style='color: #838383'></i>"

                                    // initialization needed, clearing all the previously given input data..
                                    let successfulToast = document.getElementById('successfulToast')
                                    const successfulToastBootstrap = bootstrap.Toast.getOrCreateInstance(successfulToast)
                                    successfulToastBootstrap.show()

                                    let otpInputToast = document.getElementById('otpInputToast')
                                    const otpToastBootstrap = bootstrap.Toast.getOrCreateInstance(otpInputToast)
                                    otpToastBootstrap.show()

                                } else {

                                    let failedToast = document.getElementById('failedToast')
                                    const toastSentBootstrap = bootstrap.Toast.getOrCreateInstance(failedToast)
                                    toastSentBootstrap.show()
                                }
                            });
                        } else {
                            // TODO: handle signup errors
                        }
                    })
            }
        });

        otpValidationRequestIcon.addEventListener("click", function () {
            this.style.display = 'none';

            const requestLoadingIcon = document.getElementById('otpRequestLoadingSpinner')
            requestLoadingIcon.style.display = 'block'

            const email = document.querySelector('input[name="email"]').value.trim();
            const otpCode = document.querySelector('#otp').value;

            otpValidationRequest(email, otpCode);
        });

        function updateSubmitButton() {

            // if checked, uncheck the otp request button
            const otpRequestElement = document.getElementById("otpRequest");
            const biCheckElement = otpRequestElement.querySelector("i.bi.bi-check[style='color: #838383']");
            if (biCheckElement) {
                otpRequestElement.innerHTML = "OTP";
            }

            const submitButton = document.getElementById("signupButton");
            if (Object.values(validationStatus).every(status => status === true)) {
                submitButton.removeAttribute("disabled");
            } else {
                submitButton.setAttribute("disabled", "disabled");
            }
        }

        function displayErrorMessage(input, message) {

            input.classList.add('is-invalid');

            const errorDiv = document.createElement('div');
            errorDiv.className = 'invalid-feedback';
            errorDiv.textContent = message;

            const parentDiv = input.parentElement;
            parentDiv.appendChild(errorDiv);
        }

        function removeErrorMessage(input) {

            input.classList.remove('is-invalid');

            const parentDiv = input.parentElement;
            const errorDiv = parentDiv.querySelector('.invalid-feedback');
            if (errorDiv) {
                parentDiv.removeChild(errorDiv);
            }
        }

        function displaySuccessMessage(input) {
            input.classList.add("is-valid");
        }

        function removeSuccessMessage(input) {
            input.classList.remove("is-valid");
        }

        function otpValidationRequest(email, otpCode) {

            const formData = {
                email: email,
                otpCode: otpCode
            }

            fetch(`/customer/otp-check`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(formData)
            }).then(response => {
                if (response.ok) {
                    window.location.href = "/"
                } else {

                    // clear and erase toasts
                    otpValidationRequestIcon.style.display = 'block';
                    const otpInput = document.getElementById('otp');
                    otpInput.value = '';
                    const requestLoadingIcon = document.getElementById('otpRequestLoadingSpinner')
                    requestLoadingIcon.style.display = 'none'

                    const toastElList = document.querySelectorAll('.toast')
                    const toastList = [...toastElList]
                        .map(toastEl => new bootstrap.Toast(toastEl))
                        .map(toast => toast.hide());

                    let failedToast = document.getElementById('failedToast')
                    const toastSentBootstrap = bootstrap.Toast.getOrCreateInstance(failedToast)
                    toastSentBootstrap.show()

                    updateSubmitButton()
                }
            })
        }
    });


</script>
</body>
</html>