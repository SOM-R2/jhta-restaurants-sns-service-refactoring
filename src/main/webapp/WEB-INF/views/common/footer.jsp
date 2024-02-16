<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
    .footer {
        /*position: absolute;*/
        bottom: 0;
        width: 100%;
    }
</style>
<footer class="footer navbar-fixed-bottom border-top">
    <div class="container-fluid bg-light">
        <!-- <div class="row">
            Navigation links
            <div class="col">
                <ul class="nav justify-content-center" >
                    <li class="nav-item">
                        <a class="nav-link" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/inquiry/list">문의하기</a>
                    </li>
                    Add more navigation links here
                </ul>
            </div>
        </div> -->
        
        <div class="row pt-4 mb-2">
       		<div class="col-2"></div>
        	<div class="col">
				<img src="/images/logo/png/FOOD-STREET-footer.png">  <!-- 홈 이미지 -->       		
        	</div>
        	<div class="col-2"></div>
        </div>
        <div class="row mb-2">
       		<div class="col-2"></div>
        	<div class="col-5"><hr></div>
        	<div class="col-3 "><hr></div>
        	<div class="col-2"></div>
        </div>
        <div class="row  border-text text-muted">
        	<div class="col-2"></div>
        	<div class="col-8">
        		팀구성 : 
        		<a>이은상</a>
        		<a>고태화</a>
        		<a>김성배</a>
        		<a>송지성</a>
        		<a>이소정</a><br>
        		<p>
        			개발환경<br>
        			운영체제 : Windows, iOS<br>
        			사용기술 : MySQL, Java, Spring Boot, HTML, JSP, JavaScript, jQuery<br>
        			개발도구 : Eclipse, IntelliJ, DBeaver<br>
        		</p>
        	</div>
        	<div class="col-2"></div>
        </div>
    </div>
    <script>
    </script>

</footer>