<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8dc99e5108c8ac0f59f4315f77a45f84&libraries=services,clusterer,drawing"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8dc99e5108c8ac0f59f4315f77a45f84"></script>
<link rel="shortcut icon" href="/images/logo/png/favicon.ico"image/x-icon">
<link rel="icon" href="/images/logo/png/favicon.ico" type="image/x-icon">    
<title>Food Street</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
.emoji-btn.active {
  	color: #ff792a;
} 
.buttons {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding: 10px;
}

</style>
</head>
<body>
<%@ include file="common/navbar.jsp" %>
<div class="wrap">
	<div class="container mt-5">
	    <div class="restaurant-name">
		   <div id="restaurant-name-placeholder"> <strong style="color: #ff792a;">${store.name}</strong>
		   에 대한 솔직한 리뷰를 써주세요.</div>
		</div>
	<form id="reviewForm" method="post" enctype="multipart/form-data" action="">
   		<input type="hidden" name="storeId" value="${param.storeId }"/>
   		<sec:authentication property="principal.user.id" var="userId"/>
	<div class="review-section mt-3" >
		<div class="row">
			<div class="col-12">
				<div class="card p-3">
	          		<div class="emoji-buttons" >
	              		<ul style="list-style-type: none; padding: 0;">
	                  		<li style="display: inline-block;">
	                      		<button type="button" class="emoji-btn active" data-recommend-type="5" style="background: none; border: none;">
	                          		<i class="bi bi-emoji-heart-eyes" style="font-size: 25px;"></i>
	                          		맛있어요
	                      		</button>
	                  		</li>
			                <li style="display: inline-block;">
			                	<button type="button" class="emoji-btn" data-recommend-type="3" style="background: none; border: none;">
			                    	<i class="bi bi-emoji-smile" style="font-size: 25px;"></i>
			                    	괜찮아요
			              		</button>
			     			</li>
			                <li style="display: inline-block;">
			               		<button type="button" class="emoji-btn" data-recommend-type="1" style="background: none; border: none;">
			                		<i class="bi bi-emoji-expressionless" style="font-size: 25px;"></i>
			                        별로에요
			                	</button>
			             	</li>
	              		</ul>
	          		</div>
	          		<input type="hidden" name="rating" value="5"/>
	        		<textarea id="textLength" name="content" rows=20 class="form-control border-0" style="height: 250px; position: relative;" placeholder="리뷰를 작성해주세요"></textarea>
		        	<p style="text-align: right;"><span id="text-count">0</span>/2000</p>
				</div>
			</div>
	    </div>
	</div>
	<div class="row">
		<span class="m-2"><i class="bi bi-check-lg" style="color: #ff792a;"></i><a>  최대 6개까지 선택 가능합니다.</a></span>
		<div class="btn-group m-2">
			<span>
				<button type="button" class="btn btn-taste border-secondary rounded-pill text-secondary" data-keyword-type="1">#음식이 맛있어요</button>
				<button type="button" class="btn btn-clean border-secondary rounded-pill text-secondary" data-keyword-type="2">#매장이 청결해요</button>
				<button type="button" class="btn btn-menu border-secondary rounded-pill text-secondary" data-keyword-type="3">#메뉴가 다양해요</button>
				<button type="button" class="btn btn-price border-secondary rounded-pill text-secondary" data-keyword-type="4">#가격이 적당해요</button>
				<button type="button" class="btn btn-seat border-secondary rounded-pill text-secondary" data-keyword-type="5">#좌석이 편안해요</button>
				<button type="button" class="btn btn-takeout border-secondary rounded-pill text-secondary" data-keyword-type="6">#포장이 깔끔해요</button>
				<button type="button" class="btn btn-mood border-secondary rounded-pill text-secondary" data-keyword-type="7">#분위기가 좋아요</button>
				<button type="button" class="btn btn-solo border-secondary rounded-pill text-secondary" data-keyword-type="8">#혼밥하기 좋아요</button>
				<button type="button" class="btn btn-parking border-secondary rounded-pill text-secondary mt-2" data-keyword-type="9">#주차가 편해요</button>
				<button type="button" class="btn btn-wide border-secondary rounded-pill text-secondary mt-2" data-keyword-type="10">#매장이 넓어요</button>
				<button type="button" class="btn btn-view border-secondary rounded-pill text-secondary mt-2" data-keyword-type="11">#뷰가 예뻐요</button>
				<button type="button" class="btn btn-kind border-secondary rounded-pill text-secondary mt-2" data-keyword-type="12">#친절해요</button>
			</span>
	        <input type="hidden" name="reviewKeyword" value="#음식이 맛있어요" disabled data-keyword-no="1"/>
	        <input type="hidden" name="reviewKeyword" value="#매장이 청결해요" disabled data-keyword-no="2"/>
	        <input type="hidden" name="reviewKeyword" value="#메뉴가 다양해요" disabled data-keyword-no="3"/>
	        <input type="hidden" name="reviewKeyword" value="#가격이 적당해요" disabled data-keyword-no="4"/>
	        <input type="hidden" name="reviewKeyword" value="#좌석이 편안해요" disabled data-keyword-no="5"/>
	        <input type="hidden" name="reviewKeyword" value="#포장이 깔끔해요" disabled data-keyword-no="6"/>
	        <input type="hidden" name="reviewKeyword" value="#분위기가 좋아요" disabled data-keyword-no="7"/>
	        <input type="hidden" name="reviewKeyword" value="#혼밥하기 좋아요" disabled data-keyword-no="8"/>
	        <input type="hidden" name="reviewKeyword" value="#주차가 편해요" disabled data-keyword-no="9"/>
	        <input type="hidden" name="reviewKeyword" value="#매장이 넓어요" disabled data-keyword-no="10"/>
	        <input type="hidden" name="reviewKeyword" value="#뷰가 예뻐요" disabled data-keyword-no="11"/>
	        <input type="hidden" name="reviewKeyword" value="#친절해요" disabled data-keyword-no="12"/>
		</div>
	</div>
	<div class="row mx-4 mt-3">
		<span><i class="bi bi-pin" style="font-size: 20px; color: #ff792a;"></i><a>  사진은 필수로 입력해 주세요 :)</a></span>
	</div>
	<div class="row">
	    <div class="photo-section">
			    <div id="form-image">
			        <label for="imageFile">
	       				<a class="btn
	       				" style="position: relative; display: inline-block;"><i class="bi bi-plus-square-dotted" style="font-size: 65px; color: #000;"></i></a> 
						<span></span>	
			        </label>
			    	<input style="visibility: hidden" type="file" id="imageFile" name="chooseFile" accept="image/*" >
			    </div>
			<div class="modal fade" id="previewModal" tabindex="-1" aria-labelledby="previewModalLabel" aria-hidden="true">
			    <div class="modal-dialog modal-dialog-centered modal-xl">
		            <div class="modal-body" style="background-color: transparent; display: flex; justify-content: center; align-items: center; height: 90vh;">
		                <img id="modal-img" class="custom-modal-img" style="max-width: 100%; max-height: 100%;" alt="...">
		            </div>  
			    </div> 
			</div>
		        <p style="position: relative; left: 30px;"><span id="image-count">0</span>/10</p>
		    <div class="buttons">
		        <button type="button" class="btn btn-light" style="border: 1px solid #7F7F7F; min-width: 140px; min-height: 50px; padding-left: 14px; padding-right: 14px; border-radius: 50px;" onclick="goBack()" >취소</button>
		        <button id="btn-review-submit" type="submit" class="btn btn-outline-success" disabled style="min-width: 140px; min-height: 50px; padding-left: 14px; padding-right: 14px; border-radius: 50px;" >리뷰 올리기</button>
		    </div>
		</div>
	</div>
	</form>
	</div>
<%@ include file="common/footer.jsp"%>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function() {
	
	let hasText = false;
	let hasImage = false;
	
	let previewModal = new bootstrap.Modal("#previewModal");
	
	// 페이지 로드 시 초기 선택값을 설정합니다.
	//$('.emoji-btn').first().addClass('active');
 
	
    $('.emoji-btn').click(function() {		
		 // 모든 버튼에 있는 'active' 클래스를 제거합니다.
		$('.emoji-btn').removeClass('active');
		// 클릭한 버튼에만 'active' 클래스를 추가합니다.
		$(this).addClass('active');
		$("input[name=rating]").val(parseInt($(this).attr("data-recommend-type")));
	});
	
	$("#form-image span").on('click', 'button', function(event) {
		// !$(event.target): 이벤트가 발생한 HTML 엘리먼트를 jQuery 객체로 감싼 것, .hasClass: text-danger를 갖고 있는지 물어보는코드
        if (!$(event.target).hasClass('text-danger')) {
            // 클릭한 버튼의 자손중에서 img 엘리먼트를 검색하고, src 속성값을 읽어온다.
            let imageSource = $(this).find("img").attr("src");
            // 조회된 이미지소스를 모달창의 img엘리먼트에 적용한다.
            $("#modal-img").attr("src", imageSource);
            previewModal.show(); // 이미지를 감싸는 버튼 클릭 시 모달 창을 보여줌
        }
    });
	
	// 이미지 필드의 이미지가 변경되면 
	$(".photo-section").on("change", "#imageFile", function(event) {
		
		// 버튼과  이미지태그르 생성한다.
		let content = `
			<button type="button" class="btn position-relative">
				<i class="bi bi-x position-absolute fw-bold text-danger bg-secondary" style="top: 8px; right:15px; padding-left:1px;"></i>
				<img style="width: 100px; height: 100px; object-fit: cover;">
			</button>
		`;
		// 생성된 태그를 span에 추가한다.	
		$("#form-image span").append(content);
		
		// 파일데이터를 읽어오는 FileReader객체를 생성한다.
	    var file = event.target.files[0];
	    var reader = new FileReader(); 
	    // FileReader가 전부 파일을 읽어오면 새로 추가한 이미지태그에 표시한다.
	    reader.onload = function(e) {
	    	$("#form-image button img:last").attr("src", e.target.result);
	    }

	    // FileReader객체로 파일을 읽어온다.
	    reader.readAsDataURL(file);
	    
	    $(".photo-section").prepend($("#imageFile").attr("id", "").attr("name", "chooseFile"));
	    $("label[for=imageFile]").after(`<input style="visibility: hidden" type="file" id="imageFile" accept="image/*" >`);
	    
		hasImage = true;
		toggleSubmitButton()	    
	});
	
	
	$("textarea[name=content]").keyup(function() {
		
	    let maxLength = 2000; 
	    let totalLength = $("textarea[name=content]").val().trim().length
	    
	    console.log("글자수", totalLength)
	    if (totalLength === 0) {
	        hasText = false;
	    } else {
	       hasText = true;
	    }
	    toggleSubmitButton()
	   
	    if (totalLength > maxLength) {
	        $(this).val("");
	        let sub = text.slice(0, maxLength);
	        $(this).val(sub);
	        totalLength = 2000;
	        text = '';
	    }
	    $("#text-count").text(totalLength)
	});
	
	// 초기값이 0인 이미지 수를 나타내는 변수
    let imageCount = 0;
    const maxImageCount = 10;

    $(".photo-section").on("change", function() {
	    
    	// imageCount가 maxImageCount보다 작다면 이미지 카운트를 증가
        if (imageCount < maxImageCount) {
            imageCount++;
            // imageCount가 증가할 때 마다 텍스트 내용을 변경
            $("#image-count").text(imageCount);
            // imageCount와 maxImageCount가 같다면 이미지 선택 버튼 비활성화
            if (imageCount === maxImageCount) {
                $("#imageFile").prop("disabled", true); 
            }
        } 
    });
    
    $("#form-image").on('click', 'i.text-danger', function(event) {
    	event.stopImmediatePropagation()
    	event.preventDefault()
    	
    	let $btn = $(this).parent();
    	let index = $btn.index();
    	$btn.remove();
    	
    	$(".photo-section input[type=file]").eq(index).remove();
    	
    	// imageCount가 감소할 때 마다 텍스트 내용을 변경
    	 imageCount--;
         $("#image-count").text(imageCount);
         
      // imageCount가 maxImageCount보다 작다면 이미지 선택 버튼 활성화
         if (imageCount > 0) { 
         	$("#imageFile").prop("disabled", false);
         }
      
         if (imageCount=== 0) {
 			hasImage = false
         } else {
 	        hasImage = true;
 	    }
         toggleSubmitButton()
     
    	return false;
    })
    
    
    function toggleSubmitButton() {
    //	console.log("글자", hasText, "이미지", hasImage);
    	if (hasText && hasImage) {
    		$("#btn-review-submit").prop("disabled", false);
    	} else {
    		$("#btn-review-submit").prop("disabled", true);
    	}
    }
	

    // 초기 상태에서 textarea의 내용 확인하여 버튼 상태 설정
    $("#textLength").trigger("input");
 
    /*let selectedButtonCount = 0;
    
    // 키워드 버튼 상태 설정 
	$(".btn-taste").click(function() {
		$(this).toggleClass("border-opacity-10 bage-rounded-pill text-bg-danger bg-opacity-75 fw-lighter fs-6 text-white");
		
	})
	
	$(".btn-parking").click(function() {
		$(this).toggleClass("bage-rounded-pill border-opacity-10 text-bg-secondary bg-opacity-75 fw-lighter fs-6 text-white" )
	})
	$(".btn-clean").click(function() {
		$(this).toggleClass("bage-rounded-pill border-opacity-10 text-bg-info bg-opacity-75 fw-lighter fs-6 text-white")
	})
	$(".btn-wide").click(function() {
		$(this).toggleClass("bage-rounded-pill border-opacity-10 text-bg-primary bg-opacity-75 text-white fw-lighter fs-6 ")
	})
	$(".btn-mood").click(function() {
		$(this).toggleClass("bage-rounded-pill border-opacity-10 text-bg-warning bg-opacity-75 text-white fw-lighter fs-6 ")
	})
	
	$(".btn-kind").click(function() {
		$(this).toggleClass("bage-rounded-pill border-opacity-10 text-bg-success bg-opacity-75 fw-lighter fs-6 text-white")
	})
	
	$(".btn-menu").click(function() {
		$(this).toggleClass("bage-rounded-pill border-opacity-10 text-bg-success bg-opacity-75 fw-lighter fs-6 text-white")
	})
	.
	
	$(".btn-price").click(function() {
		$(this).toggleClass("bage-rounded-pill border-opacity-10 text-bg-success bg-opacity-75 fw-lighter fs-6 text-white")
	})
	
	$(".btn-solo").click(function() {
		$(this).toggleClass("bage-rounded-pill border-opacity-10 text-bg-success bg-opacity-75 fw-lighter fs-6 text-white")
	})
	
	$(".btn-seat").click(function() {
		$(this).toggleClass("bage-rounded-pill border-opacity-10 text-bg-success bg-opacity-75 fw-lighter fs-6 text-white")
	})
	
	$(".btn-view").click(function() {
		$(this).toggleClass("bage-rounded-pill border-opacity-10 text-bg-success bg-opacity-75 fw-lighter fs-6 text-white")
	})
	
	$(".btn-takeout").click(function() {
		$(this).toggleClass("bage-rounded-pill border-opacity-10 text-bg-success bg-opacity-75 fw-lighter fs-6 text-white")
	})*/
	
	// 버튼 클릭 이벤트 핸들러
	const selectedButtons = []; // 선택된 버튼을 저장할 배열

	function updateButtonState(button) {
	    const index = selectedButtons.indexOf(button);

	    if (index === -1) {
	        if (selectedButtons.length >= 6) {
	            // 이미 6개 이상의 버튼이 선택된 경우, 새로운 버튼 선택을 막음
	            return;
	        }
	        // 새로운 버튼을 선택한 경우
	        selectedButtons.push(button);
	        $(button).toggleClass("bg-warning-subtle border border-warning-subtle text-warning-emphasis badge-rounded-pill fw-lighter fs-6 text-white");
	    } else {
	        // 이미 선택된 버튼을 다시 클릭한 경우
	        selectedButtons.splice(index, 1);
	        $(button).toggleClass("bg-warning-subtle border border-warning-subtle text-warning-emphasis badge-rounded-pill fw-lighter fs-6 text-white");
	    }

	    // 선택된 버튼이 6개 이상인 경우 나머지 버튼을 비활성화 처리
	    if (selectedButtons.length >= 6) {
	        $(".btn-group .btn").not(selectedButtons).prop("disabled", true);
	    } else {
	        $(".btn-group .btn").prop("disabled", false);
	    }
	}

	$(".btn-group .btn").click(function() {
	    updateButtonState(this);
	});
	

	const reviewForm = document.getElementById('reviewForm');
	const reviewKeywordInput = document.getElementById('reviewKeywordInput');

	// 클릭된 버튼들의 data-keyword-type 값을 수집하여 hidden input에 설정하는 함수
	function updateReviewKeywords() {
	    const selectedButtons = document.querySelectorAll('.btn-group .btn.active');
	    const selectedKeywordNos = Array.from(selectedButtons).map(button => button.getAttribute('data-keyword-type'));
	    
		    $("input[name=reviewKeyword]").prop("disabled", true);
		    
		    selectedKeywordNos.forEach(function(no) {
		    	$("input[data-keyword-no="+no+"]").prop("disabled", false)
		    })
	}

	// 버튼 클릭 이벤트 핸들러 추가
	const buttons = document.querySelectorAll('.btn-group .btn');
	buttons.forEach(button => {
	    button.addEventListener('click', () => {
	        button.classList.toggle('active');
	        updateReviewKeywords();
	    });
	});

	
/* 	$("#reviewForm").submit(function() {
		document.getElementById("imageFile").files = files;
		console.log("FFFFFFFFFFFF files -> ", document.getElementById("imageFile").files)
	}) */
	
	
});
	
	// 이전 화면으로 돌아가는 함수
	function goBack() {
	    window.history.back();
	}
	
	
</script>
</body>
</html>