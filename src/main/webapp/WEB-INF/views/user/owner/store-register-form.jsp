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
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8dc99e5108c8ac0f59f4315f77a45f84&libraries=services,clusterer,drawing"></script>
</head>
<style>
    .nav-link.my-3.active {
        font-weight: lighter;
        background-color: #AEAEAE;
    }
</style>
<body>
<div class="container-fluid">
    <div class="row justify-content-center align-items-center">
        <div class="col-md-6 col-sm-8">
            <div class="card shadow my-4 menu-input-group py-3">
                <div class="row p-3">
                    <div class="col-4">
                        <nav id="register-navbar" class="h-100 flex-column align-items-stretch pe-4 border-end">
                            <nav class="nav nav-pills flex-column fw-lighter">
                                <a class="nav-link my-3 text-secondary" href="#item-1">Store</a>
                                <a class="nav-link my-3 text-secondary" href="#item-2">Address</a>
                                <a class="nav-link my-3 text-secondary" href="#item-3">Menu</a>
                                <a class="nav-link my-3 text-secondary" href="#item-4">Hours</a>
                            </nav>
                        </nav>
                        <div type="button" onclick="window.history.back()">
                            <i class="bi bi-arrow-left-square fw-lighter fs-6" style="color: #838383"> Back</i>
                        </div>
                    </div>
                    <div class="col-8">
                        <div data-bs-spy="scroll" data-bs-target="#register-navbar" data-bs-smooth-scroll="false"
                             class="shadow-sm rounded p-3 " tabindex="0" style="height: 550px; overflow-y: scroll;">
                            <div>
                                <div id="store-info-input-area" class="mb-5">
                                    <div class="row my-4 p-2" id="item-1">
                                        <div class="col-8 fw-lighter fs-3 d-flex my-1">Store</div>
                                    </div>
                                    <div>
                                        <div class="form-floating my-3">
                                            <input type="text" class="form-control-plaintext" name="name" id="name"
                                                   placeholder=""/>
                                            <label class="fw-lighter d-flex" for="name">Name
                                                <div class="ms-auto">
                                                    <div class="validation name mx-2 text-danger"
                                                         style="display: none;">
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="form-floating my-3">
                                            <input type="text" class="form-control-plaintext" name="phone" id="phone"
                                                   placeholder=""/>
                                            <label class="fw-lighter d-flex" for="name">Phone
                                                <div class="ms-auto">
                                                    <div class="validation phone mx-3 text-danger"
                                                         style="display: none;">
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="form-floating my-3">
                                            <input type="text" class="form-control-plaintext" name="businessLicense"
                                                   id="businessLicense" placeholder=""/>
                                            <label class="fw-lighter d-flex" for="businessLicense">Business License
                                                <div class="ms-auto">
                                                    <div class="validation businessLicense mx-3 text-danger"
                                                         style="display: none;">
                                                        <i class="bi bi-check-lg mx-2 text-success"></i>
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="my-3 p-3">
                                            <label class="fw-lighter d-flex" for="description"><span style="font-size: .9rem;">Description</span>
                                                <div class="ms-auto">
                                                    <div class="validation description mx-3 text-danger"
                                                         style="display: none;">
                                                    </div>
                                                </div>
                                            </label>
                                            <textarea type="text" class="form-control-plaintext" name="description"
                                                      id="description" placeholder="" style="height: 150px"></textarea>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="form-floating my-2">
                                            <input type="text" class="form-control-plaintext" name="category"
                                                   id="category" placeholder="" disabled/>
                                            <label class="fw-lighter d-flex" for="description">Category
                                                <div class="ms-auto">
                                                    <div class="validation description mx-3 text-success"
                                                         style="display: block;">
                                                        (choose one)
                                                    </div>
                                                </div>
                                            </label>
                                            <div id="categories" class="fs-6 mx-3 my-1">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <hr class="my-5">
                                <div id="address-input-area" class="mb-5">
                                    <div class="row my-4 p-2" id="item-2">
                                        <div class="col-8 fw-lighter fs-3 d-flex my-1">Address</div>
                                        <div class="col-4 d-flex justify-content-end my-1">
                                            <i type="button" id="addressLookupIcon" class="bi bi-search my-2"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="form-floating my-3">
                                            <input type="text" class="form-control-plaintext" name="zipCode"
                                                   id="zipCode" placeholder=" " disabled/>
                                            <label class="fw-lighter d-flex" for="zipCode">Postal Code
                                                <div class="ms-auto">
                                                    <div class="validation zipCode mx-3 text-danger"
                                                         style="display: none;">
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="form-floating my-3">
                                            <input type="text" class="form-control-plaintext" name="address"
                                                   id="address"
                                                   placeholder=" " disabled/>
                                            <label class="fw-lighter d-flex" for="address">Address
                                                <div class="ms-auto">
                                                    <div class="validation address mx-3 text-danger"
                                                         style="display: none;">
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="form-floating my-3">
                                            <input type="text" class="form-control-plaintext" name="addressDetail"
                                                   id="addressDetail" placeholder=""/>
                                            <label class="fw-lighter d-flex" for="addressDetail">Additional address
                                                <div class="ms-auto">
                                                    <div class="validation addressDetail mx-3 text-danger"
                                                         style="display: none;">
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                    <input id="longitude" type="hidden" name="longitude">
                                    <input id="latitude" type="hidden" name="latitude">
                                </div>
                                <hr class="my-5">
                                <div id="menu-input-area" class="mb-5" style="height: 200px">
                                    <div class="row my-4 p-2" id="item-3">
                                        <div class="col-8 fw-lighter fs-3 d-flex my-1">Add Menu</div>
                                        <div class="col-4 d-flex justify-content-end my-1">
                                            <i type="button" id="foodAddIcon" class="bi bi-plus-circle my-2"></i>
                                        </div>
                                    </div>
                                    <div id="foodOutputArea">
                                    </div>
                                </div>
                                <hr class="my-5">
                                <div id="operation-time-input-area" class="mb-5" style="height: 200px">
                                    <div class="row my-4 p-2" id="item-4">
                                        <div class="col-8 fw-lighter fs-3 d-flex my-1">Opening Hours</div>
                                        <div class="col-4 d-flex justify-content-end my-1">
                                            <i type="button" id="hourAddIcon" class="bi bi-plus-circle my-2"
                                               style="display: block"></i>
                                        </div>
                                    </div>
                                    <div id="hourOutputArea">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="text-center">
                            <div id="storeSubmitButton" class="btn btn-outline-secondary btn-sm mt-5 mb-3 mx-2 disabled">
                                <span id="submitButtonMessage" class="fw-lighter">
                                    submit
                                </span>
                                <div id="submitLoadingSpinner" class="spinner-border spinner-border-sm text-primary m-1" role="status" style="display: none;">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
<div class="toast-container position-fixed bottom-0 end-0 p-4">
    <div id="successfulToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
    <div id="menuAddToast" class="toast toast-add-menu" role="alert" aria-live="assertive" aria-atomic="true"
         data-bs-autohide="false">
        <div class="toast-body">
            <div class="row">
                <div class="col">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="fw-lighter fs-4">Menu</div>
                        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div>
                        <label class="fw-lighter d-flex" for="foodName">Name
                            <div id="foodNameValidationMessage" class="text-danger mx-2" style="display: none;"></div>
                        </label>
                        <input class="form-control-plaintext" id="foodName" name="foodName">
                    </div>
                    <div>
                        <label class="fw-lighter d-flex" for="foodName">Price
                            <div id="foodPriceValidationMessage" class="text-danger mx-2" style="display: none;"></div>
                        </label>
                        <input class="form-control-plaintext" id="foodPrice" name="foodPrice">
                    </div>
                </div>
                <div class="d-flex justify-content-end align-items-end">
                    <i type="button" id="foodAddRequestIcon" class="bi bi-pencil-square fs-6 m-1"
                       style="color: #838383; display: none"></i>
                </div>
            </div>
        </div>
    </div>
    <div id="hourAddToast" class="toast toast-add-hour" role="alert" aria-live="assertive" aria-atomic="true"
         data-bs-autohide="false">
        <div class="toast-body">
            <div class="row">
                <div class="col">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="fw-lighter fs-4">Opening hours</div>
                        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div>
                        <div class="fw-lighter d-flex" for="day">Day
                        </div>
                        <div class="fs-6 mx-3 my-2" id="days">
                            <div type="button" class="badge rounded-pill text-bg-light day-button">Mon</div>
                            <div type="button" class="badge rounded-pill text-bg-light day-button">Tue</div>
                            <div type="button" class="badge rounded-pill text-bg-light day-button">Wed</div>
                            <div type="button" class="badge rounded-pill text-bg-light day-button">Thu</div>
                            <div type="button" class="badge rounded-pill text-bg-light day-button">Fri</div>
                            <div type="button" class="badge rounded-pill text-bg-light day-button">Sat</div>
                            <div type="button" class="badge rounded-pill text-bg-light day-button">Sun</div>
                        </div>
                    </div>
                    <div>
                        <div class="fw-lighter d-flex mt-4" for="foodName">Hour
                            <div id="hourValidationMessage" class="text-danger mx-2" style="display: none;"></div>
                        </div>
                        <div class="fs-6 mx-3 my-2" id="hours">
                            <div class="my-3">
                                <div class="my-1">
                                    <label for="openingTime" class="fw-lighter fs-6">opening</label>
                                    <input id="openingTime" class="form-control-plaintext fw-light" type="time"
                                           name="openingTime">
                                </div>
                                <div class="my-1">
                                    <label for="closingTime" class="fw-lighter fs-6">closing</label>
                                    <input id="closingTime" class="form-control-plaintext fw-light" type="time"
                                           name="closingTime">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-end align-items-end">
                    <i type="button" id="hourAddRequestIcon" class="bi bi-pencil-square fs-6 m-1"
                       style="color: #838383; display: none"></i>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {

        // TODO: when reload, clear all the inputs and data in session of resource server

        const scrollSpy = new bootstrap.ScrollSpy(document.body, {
            target: '#register-navbar'
        })

        let businessValidationServiceKey = null;

        const categoriesDiv = document.getElementById('categories')

        const nameInput = document.querySelector('input[name="name"]')
        const phoneInput = document.querySelector('input[name="phone"]')
        const businessLicenseInput = document.querySelector('input[name="businessLicense"]')
        const descriptionInput = document.querySelector('textarea[name="description"]')
        const addressInput = document.querySelector('input[name="address"]')
        const zipCodeInput = document.querySelector('input[name="zipCode"]')
        const addressDetailInput = document.querySelector('input[name="addressDetail"]')

        let longitude = document.getElementById('longitude')
        let latitude = document.getElementById('latitude')
        let categoryInput = null

        const phonePattern = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;

        const requiredStoreInputs = [
            nameInput, phoneInput, businessLicenseInput, descriptionInput, addressInput, zipCodeInput, addressDetailInput
        ]

        const addressLookupIcon = document.getElementById('addressLookupIcon')
        const foodAddIcon = document.getElementById('foodAddIcon')
        const foodAddRequestIcon = document.getElementById('foodAddRequestIcon')

        const foodNameInput = document.querySelector('input[name="foodName"]')
        const foodPriceInput = document.querySelector('input[name="foodPrice"]')

        const foodOutputArea = document.getElementById('foodOutputArea');

        let foodValidationStatus = {
            foodName: false,
            foodPrice: false
        }

        const hourAddIcon = document.getElementById('hourAddIcon')
        const hourAddRequestIcon = document.getElementById('hourAddRequestIcon')

        const daysDiv = document.getElementById('days')
        const dayButtons = document.querySelectorAll('.day-button')

        const openingTime = document.getElementById('openingTime')
        const closingTime = document.getElementById('closingTime')

        const hourOutputArea = document.getElementById('hourOutputArea')

        const storeSubmitButton = document.getElementById('storeSubmitButton')
        const submitLoadingSpinner = document.getElementById('submitLoadingSpinner')

        let hourValidationStatus = {
            days: false,
            hours: false
        }

        const selectedDays = {};
        dayButtons.forEach(button => {
            const dayName = button.textContent;
            selectedDays[dayName] = null;
        })

        const selectedHours = {
            openingTime: null,
            closingTime: null
        };

        const storeInputsValidationStatus = {
            name: false,
            phone: false,
            businessLicense: false,
            description: false,
            category: false,
            zipCode: false,
            address: false,
            addressDetail: false
        }

        fetch('/owner/business-validation-service-key', {
            method: "GET"
        }).then(response => {
            if (response.ok) {
                return response.text();
            }
        }).then(data => {
            businessValidationServiceKey = data;
        });


        fetch('/owner/store-categories', {
            method: "GET"
        }).then(response => {
            if (response.ok) {
                return response.json()
            }
        }).then(data => {
            data.forEach(datum => {
                categoriesDiv.innerHTML += `
                    <div type="button" class="badge rounded-pill text-bg-light category-button">\${datum.toLowerCase()}</div>
                `
            })

            const categoryButtons = document.querySelectorAll('.category-button')
            categoriesDiv.addEventListener('click', function (event) {

                // clearance previous inputs
                if (categoryInput != null) {
                    categoryInput = null;
                    storeInputsValidationStatus.category = false;
                }

                if (event.target.classList.contains('category-button')) {

                    // clearance previous inputs
                    categoryButtons.forEach(button => {
                        if (button.classList.contains('text-bg-light')) {
                            enableButton(button);
                        }
                    });

                    const selectedCategoryButton = event.target;
                    const selectedCategoryName = selectedCategoryButton.textContent.trim();

                    selectedCategoryButton.classList.toggle('text-bg-primary');
                    selectedCategoryButton.classList.toggle('text-bg-light');

                    if (selectedCategoryButton.classList.contains('text-bg-primary')) {
                        categoryInput = selectedCategoryName;
                        storeInputsValidationStatus.category = true;

                        categoryButtons.forEach(button => {
                            if (button.classList.contains('text-bg-light')) {
                                disableButton(button);
                            }
                        });
                    }
                }
                flushSubmitButton()
            });
        })

        requiredStoreInputs.forEach(input => {
            input.addEventListener('blur', function () {

                removeErrorMessage(this);
                removeSuccessMessage(this);

                let currentInputName = this.name;

                if (this.value.trim() === '') {

                    displayErrorMessage(this, "Required.");
                    storeInputsValidationStatus[currentInputName] = false;

                } else if (this.name === 'phone' && !phonePattern.test(this.value.trim())) {

                    displayErrorMessage(this, "Not a valid form of phone number.");
                    storeInputsValidationStatus[currentInputName] = false;

                } else if (this.name === 'businessLicense') {

                    let businessLicense = this.value.trim();
                    if (businessLicense.length !== 10) {
                        displayErrorMessage(this, "Should be 10 only digits");
                        storeInputsValidationStatus[currentInputName] = false;
                    } else {
                        const commandData = {
                            "b_no": [
                                businessLicense
                            ]
                        }

                        fetch(`https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=\${businessValidationServiceKey}`, {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/json"
                            },
                            body: JSON.stringify(commandData),
                        }).then(response => {
                            if (response.ok) {
                                return response.json();
                            }
                        }).then(data => {
                            if(data.data[0].tax_type === '국세청에 등록되지 않은 사업자등록번호입니다.') {
                                displayErrorMessage(this, "Not a valid license data.")
                                storeInputsValidationStatus[currentInputName] = false;
                            }
                            else {
                                displaySuccessMessage(this)
                                storeInputsValidationStatus[currentInputName] = true;
                            }
                        })
                    }
                } else {
                    displaySuccessMessage(this);
                    storeInputsValidationStatus[currentInputName] = true;
                }
                flushSubmitButton()
            });
        });

        addressLookupIcon.addEventListener("click", function () {
            new daum.Postcode({
                oncomplete: function (data) {

                    let address = '';
                    let addressDetail = '';

                    if (data.userSelectedType === 'R') {
                        address = data.roadAddress;
                    } else {
                        addressDetail = data.jibunAddress;
                    }

                    if (data.userSelectedType === 'R') {
                        if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                            addressDetail += data.bname;
                        }
                        if (data.buildingName !== '' && data.apartment === 'Y') {
                            addressDetail += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        if (addressDetail !== '') {
                            addressDetail = ' (' + addressDetail + ')';
                        }

                        document.getElementById("addressDetail").value = addressDetail;

                    } else {
                        document.getElementById("addressDetail").value = '';
                    }

                    var geocoder = new kakao.maps.services.Geocoder();
                    geocoder.addressSearch(address, function (result, status) {

                        if (status === kakao.maps.services.Status.OK) {

                            var x = result[0].road_address.x
                            var y = result[0].road_address.y

                            document.getElementById('longitude').value = x;
                            document.getElementById('latitude').value = y;
                        }
                    });

                    storeInputsValidationStatus.address = true;
                    storeInputsValidationStatus.zipCode = true;
                    flushSubmitButton()

                    document.getElementById('zipCode').value = data.zonecode;
                    document.getElementById("address").value = address;
                    document.getElementById("addressDetail").focus();
                }
            }).open();
        })

        foodAddIcon.addEventListener("click", function () {
            let menuAddToast = document.getElementById('menuAddToast')
            const menuAddToastBootstrap = bootstrap.Toast.getOrCreateInstance(menuAddToast)
            menuAddToastBootstrap.show()
        })

        foodNameInput.addEventListener("blur", function () {
            if (this.value.trim() === '') {
                foodValidationStatus.foodName = false;
            } else {
                const foodName = encodeURIComponent(this.value.trim())

                fetch(`/owner/unique-food?foodName=\${foodName}`, {
                    method: "GET"
                }).then(response => {
                    if (response.ok) {
                        // unique food name
                        foodValidationStatus.foodName = true;
                        document.getElementById("foodNameValidationMessage").style.display = "none";

                    } else {
                        // already exists
                        foodValidationStatus.foodName = false;

                        response.text().then(message => {
                            document.getElementById("foodNameValidationMessage").textContent = message;
                            document.getElementById("foodNameValidationMessage").style.display = "block";
                        });
                    }
                })
            }
            updateFoodAddRequestIcon();
        })

        foodPriceInput.addEventListener("input", function () {
            if (!/^[0-9]+$/.test(this.value.trim())) {
                foodValidationStatus.foodPrice = false;
                document.getElementById("foodPriceValidationMessage").textContent = "(numeric values only)";
                document.getElementById("foodPriceValidationMessage").style.display = "block";
            } else {
                foodValidationStatus.foodPrice = true;
                document.getElementById("foodPriceValidationMessage").style.display = "none";
            }
            updateFoodAddRequestIcon();
        })

        foodAddRequestIcon.addEventListener("click", function () {
            this.style.display = 'none';
            foodAddRequest(foodNameInput.value.trim(), foodPriceInput.value.trim());
            this.style.display = 'block'
        });

        function foodAddRequest(foodName, foodPrice) {
            const commandData = {
                foodName: foodName,
                foodPrice: foodPrice
            }

            fetch('/owner/register-food', {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(commandData)
            }).then(response => {
                if (response.ok) {
                    clearFoodInputs()
                    showMessagingToast("successfully added menu :)")

                    return response.json();
                }
            }).then(data => {
                const food = data

                foodOutputArea.innerHTML += `
                    <span id="\${food.foodName}" class="position-relative badge rounded-pill text-bg-light mx-1">
                        \${food.foodName}
                        <span type="button" data-food-name="\${food.foodName}" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-secondary-subtle text-danger remove-food-btn">
                            x
                        </span>
                    </span>
                `;
            });

            storeInputsValidationStatus.menu = true
        }

        foodOutputArea.addEventListener('click', function (event) {
            if (event.target.classList.contains('remove-food-btn')) {

                const foodName = event.target.getAttribute('data-food-name')
                const foodSpan = document.getElementById(foodName)
                foodSpan?.remove()

                fetch(`/owner/remove-food?foodName=\${foodName}`, {
                    method: "POST"
                })
                    .then(response => {
                        if (response.ok) {
                            // do nothing
                        }
                    });
            }
        });

        hourAddIcon.addEventListener('click', function () {
            let hourAddToast = document.getElementById('hourAddToast')
            const hourAddToastBootstrap = bootstrap.Toast.getOrCreateInstance(hourAddToast)
            hourAddToastBootstrap.show()
        })

        daysDiv.addEventListener('click', function (event) {
            if (event.target.classList.contains('day-button')) {
                const dayButton = event.target;
                const dayName = dayButton.textContent.trim();

                dayButton.classList.toggle('text-bg-primary');
                dayButton.classList.toggle('text-bg-light');

                console.log(dayButton)

                if (dayButton.classList.contains('text-bg-primary')) {
                    selectedDays[dayName] = true;
                } else {
                    selectedDays[dayName] = false;
                }

                console.log(selectedDays)

                fetch(`/owner/unique-day?dayName=\${dayName}`, {
                    method: "GET"
                }).then(response => {
                    // 1. if unique, then add the day in the session
                    if (response.ok) {
                        hourValidationStatus.days = Object.values(selectedDays).some(selected => selected === true);

                        fetch(`/owner/register-day?dayName=\${dayName}`, {
                            method: "POST"
                        }).then(response => {
                            if (response.ok) {
                                updateHourAddRequestIcon()
                            }
                        })
                    }
                    // 2. if not unique, then remove the day in the session
                    else {
                        hourValidationStatus.days = Object.values(selectedDays).some(selected => selected === true);

                        fetch(`/owner/remove-day?dayName=\${dayName}`, {
                            method: "POST"
                        }).then(response => {
                            if (response.ok) {
                                updateHourAddRequestIcon()
                            }
                        })
                    }
                })
            }
        });

        openingTime.addEventListener('input', function () {
            selectedHours['openingTime'] = this.value
            hourValidationStatus.hours = Object.values(selectedHours).every(selected => !!selected);

            updateHourAddRequestIcon()
        })

        closingTime.addEventListener('input', function () {
            selectedHours['closingTime'] = this.value
            hourValidationStatus.hours = Object.values(selectedHours).every(selected => !!selected);

            updateHourAddRequestIcon()
        })

        hourAddRequestIcon.addEventListener('click', function () {
            fetch(`/owner/register-hour`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(selectedHours)
            }).then(response => {
                if (response.ok) {
                    clearHourInputs()
                    showMessagingToast("successfully added hours :)")

                    return response.json();
                }
            }).then(data => {
                data.forEach(datum => {
                    hourOutputArea.innerHTML += `
                        <span id="\${datum.day}" class="position-relative badge rounded-pill text-bg-light m-4">
                            \${datum.day}
                            <span class="position-absolute top-100 start-100 translate-middle badge rounded-pill bg-secondary-subtle text-secondary my-1">
                                \${datum.openingTime} ~ \${datum.closingTime}
                                <span type="button" data-day-name="\${datum.day}" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-secondary-subtle text-danger remove-hour-btn" style="font-size: 0.6rem">
                                    x
                                </span>
                            </span>
                        </span>
                    `
                })
            })

            storeInputsValidationStatus.hours = true
        })

        hourOutputArea.addEventListener('click', function (event) {
            if (event.target.classList.contains('remove-hour-btn')) {

                const dayName = event.target.getAttribute('data-day-name')
                const daySpan = document.getElementById(dayName)
                daySpan?.remove()

                fetch(`/owner/remove-day?dayName=\${dayName}`, {
                    method: "POST"
                }).then(response => {
                    if (response.ok) {
                        // do nothing
                    }
                })
            }

            dayButtons.forEach(dayButton => flushDayButtons(dayButton))
        })

        storeSubmitButton.addEventListener('click', function () {

            storeSubmitButton.querySelector('#submitButtonMessage').textContent = "";
            submitLoadingSpinner.style.display = "block"

            const commandData = {
                name: nameInput.value.trim(),
                phone: phoneInput.value.trim(),
                businessLicense: businessLicenseInput.value.trim(),
                description: descriptionInput.value.trim(),
                category: categoryInput,
                address: addressInput.value.trim(),
                zipCode: zipCodeInput.value.trim(),
                addressDetail: addressDetailInput.value.trim(),
                longitude: longitude.value.trim(),
                latitude: latitude.value.trim()
            };

            fetch('/owner/register', {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(commandData)
            }).then(response => {
                if (response.ok) {
                    window.location.href = "/owner/my-page?registration=success"
                } else {
                    storeSubmitButton.querySelector('#submitButtonMessage').textContent = "submit";
                    submitLoadingSpinner.style.display = "none"
                }
            })
        })

        function flushDayButtons(dayButton) {

            const dayName = dayButton.textContent.trim();

            fetch(`/owner/unique-day?dayName=\${dayName}`, {
                method: "GET"
            }).then(response => {
                if (!response.ok) {
                    disableButton(dayButton)
                } else {
                    enableButton(dayButton)
                }
            });
        }

        function showMessagingToast(message) {
            const successfulToast = document.getElementById('successfulToast');
            const toastBody = successfulToast.querySelector('.toast-body');

            toastBody.textContent = message;

            const successfulToastBootstrap = bootstrap.Toast.getOrCreateInstance(successfulToast);
            successfulToastBootstrap.show();
        }

        function clearFoodInputs() {
            document.querySelector('input[name="foodName"]').value = '';
            document.querySelector('input[name="foodPrice"]').value = '';
            foodValidationStatus.foodName = false;
            foodValidationStatus.foodPrice = false;

            foodAddRequestIcon.style.display = 'none';
            new bootstrap.Toast(document.querySelector('.toast.toast-add-menu')).hide();

            updateFoodAddRequestIcon();
        }

        function clearHourInputs() {

            dayButtons.forEach(dayButton => flushDayButtons(dayButton))

            openingTime.value = ''
            closingTime.value = ''

            hourValidationStatus.days = false;
            hourValidationStatus.hours = false;

            hourAddRequestIcon.style.display = 'none';
            new bootstrap.Toast(document.querySelector('.toast.toast-add-hour')).hide();

            updateHourAddRequestIcon();
        }

        function updateFoodAddRequestIcon() {
            const isValid = Object.values(foodValidationStatus).every(status => status === true);
            foodAddRequestIcon.style.display = isValid ? 'block' : 'none';
        }

        function updateHourAddRequestIcon() {
            const isValid = Object.values(hourValidationStatus).every(status => status === true);

            console.log(isValid)
            console.log(hourValidationStatus)

            hourAddRequestIcon.style.display = isValid ? 'block' : 'none';
        }

        function displayErrorMessage(input, message) {

            const parentLabel = input.parentElement;
            const nameValidationDiv = parentLabel.querySelector(`.validation.\${input.name}`);

            if (nameValidationDiv) {
                nameValidationDiv.style.display = 'block'
                nameValidationDiv.innerHTML = message;
            }
        }

        function removeErrorMessage(input) {

            const parentLabel = input.parentElement;
            const nameValidationDiv = parentLabel.querySelector(`.validation.\${input.name}`);

            if (nameValidationDiv) {
                nameValidationDiv.innerHTML = '';
            }
        }

        function displaySuccessMessage(input) {
            const parentLabel = input.parentElement;
            const nameValidationDiv = parentLabel.querySelector(`.validation.\${input.name}`);

            if (nameValidationDiv) {
                nameValidationDiv.style.display = 'block'
                nameValidationDiv.innerHTML = '<i class="bi bi-check-lg text-success"></i>'
            }
        }

        function removeSuccessMessage(input) {
            const parentLabel = input.parentElement;
            const nameValidationDiv = parentLabel.querySelector(`.validation.\${input.name}`);

            if (nameValidationDiv) {
                nameValidationDiv.innerHTML = '';
            }
        }

        function flushSubmitButton() {

            const allValid = Object.values(storeInputsValidationStatus).every(status => status === true)

            if (allValid) {
                storeSubmitButton.classList.remove('disabled');
            } else {
                storeSubmitButton.classList.add('disabled');
            }
        }

        function disableButton(button) {
            button.style.pointerEvents = "none";
            button.classList.add('text-bg-disabled', 'text-secondary');
            button.classList.remove('text-bg-primary');
        }

        function enableButton(button) {
            button.removeAttribute('style')
            button.classList.remove('text-bg-disabled', 'text-secondary')
            button.classList.add('text-bg-light')
        }
    });
</script>
</body>
</html>