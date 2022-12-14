<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>게시글 상세 정보</title>
<script src="/resources/js/jquery-3.6.1.min.js"></script>

</head>
<body>
	<div id="header">
		<jsp:include page="/WEB-INF/views/common/menuBar.jsp"></jsp:include>
		<jsp:include page="/WEB-INF/views/common/sideBar.jsp"></jsp:include>
	</div>
	
 <div class="right-side">

	<br><br>
<%-- 	<h4 align='center'> ${party.partyNo }번글 확인하기</h6> --%>
<!-- 	<br><br> -->
		<table align="center" class="table col-10">
			<tr>
			<td  class="col-2" align='center'><b>작성자</b></td>
			<td  class="col-2" align='center'>${party.partyWriter }</td>
			<td  class="col-2" align='center'><b>작성날짜</b></td>
			<td  class="col-2" align='center'>${party.pUpdateDate }</td>
			<td  class="col-2"  align='center'><b>조회수</b></td>
			<td>${party.partyCount }</td>
			</tr>
				<tr>
			<td  class="col-2" align='center'><b>일정 시작</b></td>
			<td  class="col-2" align='center'>${party.partyFirstDate }</td>
			<td  class="col-2" align='center'><b>일정 마지막</b></td>
			<td  class="col-2" align='center'>${party.partyLastDate }</td>
			<td  class="col-2"  align='center'><b></b></td>
			<td></td>
			</tr>
			<tr>
			<td class="col-2"   align='center'><b>제목</b></td>
			<td colspan='8' >${party.partyTitle }</td>
			</tr>
			
			<tr >
<!-- 			<td  class="col-2" align='center'><b>내용</b></td> -->
			<td colspan=10'>${party.partyContents }
			</tr>
			
			<tr>
				<td colspan='10' align='center'>
				<button type="button" class="btn btn-dark"  onclick="location.href='/party/list.kh?&page=${page }'">리스트로</button> 
				
					<c:if test="${party.partyWriter eq loginUser.memberNickname }">
						<button type="button" class="btn btn-warning" onclick="location.href='/party/modifyView.kh?partyNo=${party.partyNo }&page=${page }'">수정하기</button>
					</c:if> 	
					<c:if test="${party.partyWriter eq loginUser.memberNickname }">
						<button type="button" class="btn btn-danger" onclick="removeBoard(${party.partyNo}, ${page});">삭제하기</button> 
					</c:if> 	
				</td>
			</tr>
		</table>
		
<!-- 		댓글 등록 -->
<form action="/party/addReply.kh" method="post" name="replyForm">
	<input type="hidden" name="pReplyWriter" value = ${loginUser.memberNickname }>
	<input type="hidden" name="refBoardNo" value=${party.partyNo }>
	<input type="hidden" name="page" value=${page }>

		<table align="center" class="table col-10">
		<tr>
		</tr>
			<tr>
				<td  class="col-10" align='center' >
					<textarea  class="form-control" id="exampleFormControlTextarea1" rows="3" cols="70" name="pReplyContents"></textarea>
				</td>
				<td>
				<input type="button" value='댓글 달기' class="btn btn-primary" onclick='replyChk();'>
				</td>
			</tr>
		</table>
</form>

<!-- 		댓글 목록 -->
		<table align="center" class="table col-10">
			<c:forEach items="${prList }" var="pReply" varStatus="i">
			<tr>
				<td  class="col-2" align='center' > ${pReply.pReplyWriter }</td>
				<td  class="col-4" align='center' >${pReply.pReplyContents }</td>
				<td  class="col-4" align='center' >${pReply.prUpdateDate }</td>
				<td>
				<c:if test="${pReply.pReplyWriter eq loginUser.memberNickname }">
				<button type="button" onclick="modifyView(this, '${pReply.pReplyContents }', ${page} ,${pReply.pReplyNo } ,${pReply.refBoardNo });"  class="btn btn-warning"> 수정 </button></c:if>
				<c:if test="${pReply.pReplyWriter eq loginUser.memberNickname }">
				<button type="button" onclick="removeReply(${pReply.refBoardNo },${page},${pReply.pReplyNo });" class="btn btn-danger"> 삭제 </button></c:if>
				</td>
					
			</tr>
			</c:forEach>
			
		</table>
		
		</div>

<script type="text/javascript">
function removeBoard(partyNo,page) {
 	event.preventDefault();// 하이퍼링크 이동 방지
	if(confirm("삭제하시려면 '확인'을 클릭하세요")){
		location.href="/party/remove.kh?partyNo="+partyNo+"&page="+page;

	}
 	
};

 	function removeReply(partyNo, page, pReplyNo) {
 	 	event.preventDefault();// 하이퍼링크 이동 방지
 	 	if(confirm("삭제하시려면 '확인'을 클릭하세요")){
		location.href="/party/removeReply.kh?partyNo="+partyNo+"&page="+page+"&pReplyNo="+pReplyNo;
 	 	}
	};
	
	function modifyView(obj, pReplyContents, page, pReplyNo, refBoardNo) {
 	 	event.preventDefault();// 하이퍼링크 이동 방지
 	// alert("성공");
		var $tr = $("<tr>");
		$tr.append("<td colspan='3'><input type='text' size='50' value='"+pReplyContents+"' id='modifyInput'  class='form-control'></td>");
		$tr.append("<td colspan='3'><button type='button' class='btn btn-warning'  onclick='modifyReply(this, "+page+", "+pReplyNo+", "+refBoardNo+");'> 수정 </button></td>");
		console.log($tr[0]);
		console.log(obj); //obj는 this를 통해 이벤트가 발생한 태그
		$(obj).parent().parent().after($tr);
 	};
 	

 	function modifyReply(obj,page, pReplyNo, refBoardNo) {
		var inputTag = $(obj).parent().siblings().eq(0).children();
 		var pReplyContents = $("#modifyInput").val();
 		console.log(inputTag.val());
 		// console.log(replyContents);
 		// console.log(replyNo);
 		var $form = $("<form>"); // form태그
 		$form.attr("action", "/party/modifyReply.kh" );
		$form.attr("method", "post"); // form태그에 속성 추가
		$form.attr("name", "replyForm"); // form태그에 속성 추가
		$form.append("<input type='hidden' value='"+pReplyContents+"' name='pReplyContents'>");
		$form.append("<input type='hidden' value='"+pReplyNo+"' name='pReplyNo'>");
		$form.append("<input type='hidden' value='"+refBoardNo+"' name='refBoardNo'>");
		$form.append("<input type='hidden' value='"+page+"' name='page'>");

		$form.appendTo("body");
		$form.submit(); // 전송

		};
 	
	function replyChk() {
		if(replyForm.pReplyContents.value=="") { // document 를 생략해도 됨
	        alert("댓글을 입력하세요!");
	        replyForm.pReplyContents.focus();
	    	return false;
		}
		replyForm.submit();
	}
</script>
</body>
</html>