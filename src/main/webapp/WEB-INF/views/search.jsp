<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<link rel="shortcut icon" href="/images/logo/png/favicon.ico"image/x-icon">
	<link rel="icon" href="/images/logo/png/favicon.ico" type="image/x-icon">
	<title>Food Street</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<style type="text/css">
		   .card-zoom:hover {
            transform: scale(1.05); /* 마우스를 올렸을 때 이미지를 확대 */
            transition: transform 0.2s ease-in-out; /* 부드러운 확대 효과를 위한 트랜지션 */
        }
	</style>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8dc99e5108c8ac0f59f4315f77a45f84&libraries=services,clusterer,drawing"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8dc99e5108c8ac0f59f4315f77a45f84"></script>
</head>
<body>
<%@ include file="common/navbar.jsp"%>
<div class="wrap">
	<div class="container-fluid text-center" style = "padding-left:100px; padding-right:100px;" >
		<div class="row my-3 d-flex justify-content-between">
			<div class="col-8 ">
				<div class="d-flex justify-content-between my-3">
					<a class="title btn fs-4" href="/store/search" style="color:#ff792a;">맛집 검색결과</a>
					<select class="form-select me-3" style="width: 150px;" name="sort">
						<option value="rating">추천 순</option>
						<option value="bookmark">즐겨찾기 순</option>
						<option value="review">리뷰 많은 순</option>
					</select>
				</div>
				<div class="row mb-3">
					<div class="col-12 mb-2" style="text-align: left;">
						<a id="" class="category btn active" role="button" href="search">전체</a>
						<a id="한식" class="category btn" role="button" >한식</a>
						<a id="중식" class="category btn" role="button" >중식</a>
						<a id="일식" class="category btn" role="button" >일식</a>
						<a id="치킨" class="category btn" role="button" >치킨</a>
						<a id="피자" class="category btn" role="button" >피자</a> 
						<a id="버거" class="category btn" role="button" >버거</a>
						<a id="돈까스" class="category btn" role="button" >돈까스</a>
						<a id="구이" class="category btn" role="button" >구이</a>
						<a id="양식" class="category btn" role="button" >양식</a> 
						<a id="이탈리안" class="category btn" role="button" >이탈리안</a>
						<a id="아시안" class="category btn" role="button" >아시안</a> 
						<a id="분식" class="category btn" role="button" >분식</a>
						<a id="카페" class="category btn" role="button" >카페</a> 
						<a id="주점" class="category btn" role="button" >주점</a>
						
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-12 ">
						<div id="storeLoadingSpinner" class="spinner-border text-primary"
							role="status" style="margin: 0 auto; margin-top: 150px;">
							<span class="visually-hidden" style="display: none;">Loading...</span>
						</div>
						<div id="div-stores" class="row mb-3"></div>
					</div>
				</div>
				<div class="row mb-3">
					<div id = "div-pagination" class="col-12">
							<nav>
								<ul class="pagination justify-content-center">
									<li id = "prepage" class="page-item page-move">
										<a id = "prepage-link" href="" class="page-link" >이전</a>
									</li>
									<li id = "nextpage" class="page-item page-move">
										<a id = "nextpage-link" href="" class="page-link" >다음</a>
									</li>
								</ul>
							</nav>
					</div>
				</div>
			</div>
			<div class="col-3 right-sidebar bg-body-tertiary">
				<div class="my-3" style="position:sticky; top: 100px;">
					<!-- 지도 -->
					<div id="map" class="mb-4" style="width: 100%; height: 350px; "></div>
					<h4 class="mb-4 text-start" id="search-post-header" style="color:#ff792a;">관련 포스트</h4>
					<div id="postArea">
					</div>
				</div>
			</div>
		</div>
	</div>
<%@ include file="common/footer.jsp"%>
</div>
	<script type="text/javascript">
		let sortValue = "rating"; 
		let pageValue = 1; 
		let categoryValue;
		let keywordValue;
		if($("input[name=keyword]").val()!=null){
			keywordValue = $("input[name=keyword]").val();
		}
		let xStartValue;
		let xEndValue;
		let yStartValue;
		let yEndValue;
					
		getResult();
		getPost();
		
		function changePage(event,page){
			event.preventDefault();
			
			pageValue = page;
			console.log("pageValue : " + pageValue);
			
			getResult();
			
		}
		
		//	카테고리 변경 이벤트 등록
		$(".category").click(function(event){
			event.preventDefault();
			$(this).siblings().removeClass('active');
			$(this).addClass('active');
			
			categoryValue = $(this).attr("id");
			pageValue = 1;
		
			getResult();
			getPost();
		})
		
		// 이전/다음 페이지 버튼 눌렀을 때의 이벤트 등록
		$(".page-move").click(function(event) {
			console.log("page-move clicked");
			event.preventDefault();

			let id = $(this).attr("id");
			console.log("id : {} ", id);

			if(id ==='prepage'){
				pageValue--;
			}else{
				pageValue++;
			}
			console.log("pageValue : ", pageValue);

			getResult();
		})
		
		//정렬 방식 바꿨을 때 이벤트 등록
		$(".form-select").change(function(event){
			event.preventDefault();
		
			pageValue = 1; 
			sortValue = $(this).val();
			
			getResult();
		})
		
		//가게 카드에 mouseenter 이벤트 리스너 등록
		$("#div-stores").on('mouseenter', ".store", function(){
			let index = $(this).find(".card").attr("index-id");
			console.log("index-id : ",$(this).find(".card").attr("index-id"));
			
			infoOverlay[index].setMap(map);
		})
		
		//가게 카드에 mouseleave 이벤트 리스너 등록
		$("#div-stores").on('mouseleave', ".store", function(){
			let index = $(this).find(".card").attr("index-id");
			console.log("index-id : ",$(this).find(".card").attr("index-id"));
			
			infoOverlay[index].setMap(null);
		})

		function getResult() {
			$("#div-stores").find(".store").remove();
            $("#storeLoadingSpinner").css("display", "block");
            $("#div-pagination").css("display", "none");
            $("#div-stores").empty();
            $("html, body").scrollTop(0);
			$.getJSON('stores', {sort:sortValue, page:pageValue, category:categoryValue, keyword:keywordValue,
										 xStart:xStartValue, xEnd:xEndValue, yStart:yStartValue, yEnd:yEndValue }, function(result) {
				if(result.stores.length===0){
					$("#div-stores").append( `<h4>'\${keywordValue}' 에 대한 검색 결과가 없습니다.</h4>
					<br><br>
					<h5>단어의 철자가 정확한지 확인해 보세요.<br>
					또는 다른 검색어로 다시 검색해 보세요.</h5>
					`)
				}else{
				    let points = [];
					let storeNames = [];
					let i = 0;
					result.stores.forEach(function(store){ 
						points.push(new kakao.maps.LatLng(store.latitude, store.longitude));
						let content = `
							<div class="col-5 mb-3 me-3 store card-zoom">
								<div id="store-card-\${store.id}" index-id ="\${i}" class="card shadow" onclick="location.href='/store/detail?id=\${store.id}'" style="cursor: pointer;">
									<img src="/images/review/png/\${store.pictureName}" onerror="this.onerror=null; this.src='/images/review/jpeg/store-default.jpeg';" class="card-img-top rounded " alt="..." style="object-fit: cover; height: 250px;">
								</div>
								<div class="row">
									<div class="col text-start mt-1">							
										<div class="d-flex justify-content-between">
											<a id="store-name-\${store.id}" class="link-dark fs-4 " style="text-decoration: none;">\${store.name}</a>
											<a id="store-reviewAvg-\${store.id}" class="fs-4" style="color: #ff792a; text-decoration: none;">\${store.reviewAvg.toFixed(1)}</a>
										</div>
										<div class="d-flex justify-content-between">
											<p id="store-category-\${store.id}" class="fs-6 text-secondary">\${store.category} - \${store.address}</p>
											<div>
												<i id="store-reviewCnt-\${store.id}" class="bi bi-pencil-square text-secondary">\${store.reviewCnt}</i> 
												<i id="store-bookmarkCnt-\${store.id}" class="bi bi-star text-secondary">\${store.bookmarkCnt}</i>
											</div>
										</div>
									</div>
								</div>
							</div>
						`;
						// store 카드 추가 및 텍스트 내용 입력
						$("#div-stores").append(content);
						$("#store-name-store.id").text(store.name);
						$("#store-reviewAvg-store.id").text(store.reviewAvg);
						$("#store-category-store.id").text(store.category);
						$("#store-reviewCnt-store.id").text(store.reviewCnt);
						$("#store-bookmarkCnt-store.id").text(store.bookmarkCnt);
						
						storeNames.push(store.name);
	
						i = i+1;
					});
					//페이지네이션
					//페이지-이전/다음
					if(result.pagination.first){
						$("#prepage").addClass('disabled');
					}
					else{
						$("#prepage").removeClass('disabled');
					}
					
					if(result.pagination.last){
						console.log("result.pagination.last : ", result.pagination.last);
						$("#nextpage").addClass('disabled');
					}
					else{
						$("#nextpage").removeClass('disabled');
					}
		
					//페이지-숫자
					let beginPageNum = result.pagination.beginPage;
					let endPageNum = result.pagination.endPage;
				    let currentPage = result.pagination.page; 
	
					console.log("beginPageNum : "+beginPageNum);
					console.log("endPageNum : "+endPageNum);
					console.log("currentPage : "+currentPage);
				    
					$(".page-num").remove();
					for(let num = beginPageNum; num <= endPageNum; num++){
						
						let isActive;
						if(num==currentPage){
						
							isActive = 'active';
						}else{
							isActive = '';
						}
						
					    let content = `
					        <li class="page-item page-num ">
					            <a href="search?page=\${num}" 
					            		class="page-link num-link \${isActive}"
					            		onclick="changePage(event, \${num})">\${num}
					            </a>
					        </li>
					    `;
	
					    $("#nextpage").before(content);
							
					}
		            $("#div-pagination").css("display", "block");
	
					drawMarker(points);
					setInfoOverlay(storeNames,points);
				}
	            $("#storeLoadingSpinner").css("display", "none");
			})
		}
		
		function getPost(){
			$('#postArea').empty();
			$.getJSON('/store/posts',{category:categoryValue, keyword:keywordValue, xStart:xStartValue, xEnd:xEndValue, yStart:yStartValue, yEnd:yEndValue }, function(result,status){
				if(result.length===0){
					$('#search-post-header').text("");
				}else{
					$('#search-post-header').text("관련 포스트");
					result.forEach(function(post){
						let content = `
							<div class="card text-center text-light font-weight-bold shadow mt-3" onclick="location.href='/post/detail?id=\${post.id}'" style="cursor: pointer;">
								<img src="/images/post/jpeg/\${post.pictureFile }" class="card-img-top rounded" alt="..." 
									 style="width: 100%; height: 100px; object-fit:cover; filter: brightness(60%);">
								<div class="card-img-overlay d-flex justify-content-center align-items-center">
									<p class="fs-5 my-0">\${post.title }</p>
								</div>
							</div>
						`
						$("#postArea").append(content);
					})
				}
			})
		}
			
		var container = document.getElementById('map');
		var markers = [];
		// 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
		var infowindows = [];
		var options = {
			//latitude,longitude 순으로 입력
			center: new kakao.maps.LatLng(37.5729587735263, 126.992241734889),
			level: 3
		};
		// map 생성
		var map = new kakao.maps.Map(container, options);
		var buttonOverlay; 
		var infoOverlay = [];

		function drawMarker(points) {
			// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
			let bounds = new kakao.maps.LatLngBounds();    
			
			//마커 지우기 - 새 페이지를 위해 
			if(markers.length!=0){
				markers.forEach(function(marker) {
					marker.setMap(null);
				});
				markers.length = 0;
			}
			
			for (let i = 0; i < points.length; i++) {
			    // 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
			    markers.push (new kakao.maps.Marker({ position : points[i] }));
			    
			    // LatLngBounds 객체에 좌표를 추가합니다
			    bounds.extend(points[i]);
			    markers[i].setMap(map);
			    
				// 마커에 마우스오버 이벤트를 등록합니다
				kakao.maps.event.addListener(markers[i], 'mouseover', function() {
				  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
				  	infoOverlay[i].setMap(map);
				});
				// 마커에 마우스아웃 이벤트를 등록합니다
				kakao.maps.event.addListener(markers[i], 'mouseout', function() {
				    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
					infoOverlay[i].setMap(null);
				});	
			}
			console.log("points : ", points);
	    	
			// LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
	  	 	// 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
			map.setBounds(bounds);
			
	 		// 마우스 드래그로 지도 이동/ 지도 확대,축소가 완료되었을 때 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
			kakao.maps.event.addListener(map, 'bounds_changed', function() {      
				setButtonOverlay();
			});
		}

		let swLatLng; 
		let neLatLng;
		
		function setButtonOverlay(){
			  if (buttonOverlay) {
			        buttonOverlay.setMap(null);
			    }
		   		// 지도 중심좌표를 얻어옵니다 
		   		let center = map.getCenter();
		   		let mapBounds = map.getBounds();
			    // 영역의 남서쪽 좌표를 얻어옵니다 
			    swLatLng = mapBounds.getSouthWest(); 
			    // 영역의 북동쪽 좌표를 얻어옵니다 
			    neLatLng = mapBounds.getNorthEast(); 
			    let distance =  neLatLng.getLat() - swLatLng.getLat();
			    
				//오버레이가 표시될 위치입니다 
		   		var position = new kakao.maps.LatLng(swLatLng.getLat() + (0.05)*distance, center.getLng());  

				var content = '<button type="button" id="map-search-button" class="btn btn-primary">이 지역 검색</button>';
				
				buttonOverlay = new kakao.maps.CustomOverlay({
					   position: position,
					   content: content   
				});
				
				buttonOverlay.setMap(map);
				
		        // 오버레이의 버튼에 이벤트를 추가
		        let button = document.getElementById('map-search-button');
		        button.addEventListener('click', searchByPosition);
			
		}
		
		function setInfoOverlay(storeNames, points){
			  if (infoOverlay.length!=0) {
				  infoOverlay.forEach(function(overlay) {
					  overlay.setMap(null);
					});
				  infoOverlay.length = 0;
				}
			  
				// info 오버레이 생성
				for(let i=0; i<storeNames.length; i++){
					let storeName = storeNames[i];
					console.log("storeName : ", storeName);
					var content = `<button type="button" id="info-\${i}" class="btn btn-primary btn-sm">\${storeName}</button>`;
					console.log("content : ", content);

					infoOverlay.push(new kakao.maps.CustomOverlay({
						position: points[i],
						content: content   
					}));
				}
		}
		
        function searchByPosition() {  
	      buttonOverlay.setMap(null);
	      
		  xStartValue = swLatLng.getLng();
		  xEndValue = neLatLng.getLng();
		  yStartValue = swLatLng.getLat();
		  yEndValue = neLatLng.getLat();
		  
		  pageValue = 1; 

	      getResult();
	      getPost();
          
        }

	</script>
</body>
</html>