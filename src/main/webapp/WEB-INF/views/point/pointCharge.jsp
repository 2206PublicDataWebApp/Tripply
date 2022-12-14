<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>트리플리,Tripply</title>
<!-- 화면 뼈대 설정용 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/point/pointCharge.css">
</head>
<body>
<!-- 헤더-메뉴바 -->
	<div id="header">
		<jsp:include page="/WEB-INF/views/common/menuBar.jsp"></jsp:include>
		<jsp:include page="/WEB-INF/views/common/sideBar.jsp"></jsp:include>
	</div>
<!-- 컨텐츠 -->
	<div id="contents">
<!-- 사이드바	 -->
		<div id="sideBar">
				<div class="side-bar" onclick="location.href='/member/myPage.kh';"><p class="li-text">회원정보수정</p></div>
				<div class="side-bar" onclick="location.href='/free/myList.kh';"><p class="li-text">작성글</p></div>
				<div class="side-bar" onclick="seeyoulater()"><p class="li-text">북마크</p></div>
				<div class="side-bar" onclick="pointNavi(this);"><p class="li-text">포인트관리</p></div>
<!-- 사이드바 아코디언			 -->
				<div id="point-navi">
						<div id="side-history" onclick="location.href='/point/historyView.kh';" class="point-li">포인트 내역</div>
						<div id="side-charge" onclick="location.href='/point/chargeView.kh';" class="point-li">포인트 충전</div>
						<div id="side-send" onclick="location.href='/point/sendView.kh';" class="point-li">채택 상품 구매</div>
				</div>
		</div>
<!-- 본 컨텐츠 -->
		<div id="charge-area">
			<div id="charge-title">
				<div id="title"><h1>포인트 충전</h1></div>
				<span id="balance">현재 포인트 잔액 : ${loginUser.pointBalance }원</span>
			</div><br><br>
			<form id="pointCharge-form" action="/point/charge.kh" method="post">
				<input type="hidden" name="pointWorkType" value="C">
				<input type="hidden" name="pointToUser" value="${loginUser.memberId }">
				<div class="pointCharge method ">
					<br>
					현재 포인트 잔액 : ${loginUser.pointBalance }원
					<br>
					<h2>충전 수단 선택</h2><br>
					
					<label>
						  <div >
							  은행 <input type="radio" name="chargeMethod" value="bank" onchange="choiceBank(this);">
						  </div> 
					</label>
					
					<label>
						  <div >
							  카드 <input type="radio" name="chargeMethod" value="card" onchange="choiceCard(this);">
						  </div> 
					</label>
					<label>
						  <div >
							  계좌 입금 <input type="radio" name="chargeMethod" value="deposit" onchange="choiceDeposit(this);">
						  </div>
					</label>
					
					<div id="bank-info" style="display:none">
						은행 선택:
						<select id="bank-choice" name="bankChoice">
							<option value="kb" >국민</option>
							<option value="nh" >농협</option>
							<option value="sh" >신한</option>
							<option value="kaka" >카카오</option>
						</select><br>
						<input onkeyup="inputNumberCheck(this);" id="bank-accountNo" name="bankAccNo" type="text" placeholder=" '-'없이 계좌번호를 입력해주세요."  style="width:300px">
					</div>
				
					<div id="card-info" style="display:none">
						카드사 선택:
						<select id="card-choice" name="cardChoice">
							<option value="kb">KB</option>
							<option value="ss">삼성</option>
							<option value="hd">현대</option>
							<option value="kaka">카카오</option>
						</select><br>
						<input onkeyup="inputNumberCheck(this)" id="card-no" name="cardNo" type="text" placeholder=" '-'없이 카드번호를 입력해주세요."  style="width:300px">
					</div>
					
					<hr><br>
				</div>
				<div class="pointCharge amount">
					<h2>충전 금액 입력</h2>
					<select name="pointAmount">
						<option value="1000">1,000원</option>
						<option value="5000">5,000원</option>
						<option value="10000">10,000원</option>
						<option value="20000">20,000원</option>
						<option value="30000">30,000원</option>
						<option value="40000">40,000원</option>
						<option value="50000">50,000원</option>
					</select>
					<hr><br>
				</div>
				<div class="pointCharge btn">
					<button>충전하기</button>
				</div>
			</form>
			
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
	
//충전수단 선택 관련 함수

	function choiceBank(thisCheck){
	bankChecked = thisCheck.checked;
	if(bankChecked){
		document.querySelector("#bank-info").style.display = "block";
		document.querySelector("#card-info").style.display = "none";
	}
}
	function choiceCard(thisCheck){
		cardChecked = thisCheck.checked;
		if(cardChecked){
			document.querySelector("#bank-info").style.display = "none";
			document.querySelector("#card-info").style.display = "block";
		}
	}
	function choiceDeposit(thisCheck){
		depositChecked = thisCheck.checked;
		if(depositChecked){
			document.querySelector("#bank-info").style.display = "none";
			document.querySelector("#card-info").style.display = "none";
		}
	}
	
/////숫자입력 유효성검사

	function inputNumberCheck(thisInput){
		regExNumber = /^\d+$/;
		if(!regExNumber.test(thisInput.value)){
			thisInput.value = "";
		}
}

	function seeyoulater() {
		alert("추후 업데이트 예정입니다.");
	}
</script>
</html>