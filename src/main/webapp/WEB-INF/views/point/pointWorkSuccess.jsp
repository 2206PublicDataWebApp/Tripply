<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>트리플리,Tripply</title>
<!-- 화면 뼈대 설정용 css -->
<link rel="stylesheet" href="/resources/css/common-style.css">
</head>
<body>
<!-- 헤더-메뉴바 -->
	<div id="header">
		<jsp:include page="/WEB-INF/views/common/menuBar.jsp"></jsp:include>
	</div>
<!-- 컨텐츠 -->
	<div id="contents">
<!-- 사이드바	 -->
		<div id="sideBar" style="float:left">
			<div class="my-side">
				<div class="my-side-bar" onclick="location.href='#';">회원정보수정</div>
				<div class="my-side-bar" onclick="location.href='/free/list.kh';">작성글</div>
				<div class="my-side-bar">북마크</div>
				<div class="my-side-bar" onclick="pointNavi(this);">포인트관리</div>
<!-- 사이드바 아코디언			 -->
				<div id="point-navi" style="display:block;">
					<ul>
						<li onclick="location.href='/point/historyView.kh';">포인트 내역</li>
						<li onclick="location.href='/point/chargeView.kh';">포인트 충전</li>
						<li onclick="location.href='/point/sendView.kh';">채택된 상품 구매하기</li>
					</ul>
				</div>
			</div>
		</div>
<!-- 본 컨텐츠 -->
		<div id="contents-2" style="float:left">
			<h1>포인트 ${message }에 성공하였습니다.</h1><hr>
			
			
		
		</div>
	</div>
<!-- 푸터 -->
	<div id="footer"></div>
</body>
<script>

//사이드 바 포인트관리 아코디언
	function pointNavi(target){
		var pointNaviDiv = target.nextElementSibling;
		var display = pointNaviDiv.style.display;
		if(display == 'none'){
			pointNaviDiv.style.display="block";
		}else{
			pointNaviDiv.style.display="none";
		}
	}
	
	window.onload=function(){
		setTimeout("location.href='/point/historyView.kh'",1500);
	}
	
</script>
</html>