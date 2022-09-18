<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>트리플리,Tripply</title>
<!-- 화면 뼈대 설정용 css -->
<link rel="stylesheet" href="/WEB-INF/resources/css/common-style.css">
</head>
<body>
<!-- 헤더-메뉴바 -->
	<div id="header">
		<jsp:include page="/WEB-INF/views/common/menuBar.jsp"></jsp:include>
	</div>
<!-- 컨텐츠	 -->
	<div id="contents" width="90%">
		<div id="sideBar"></div>
<!-- 검색		 -->
		<div id="search-area">
			<form action="/review/search.kh" method="get">
				<jsp:include page="/WEB-INF/views/common/search.jsp"></jsp:include>
			</form>
		</div>
<!-- 게시물목록출력 -->
		<div id="list-area">
			<table align="center" width="100%">
				<tr id="detail-raw-wrap">
					<c:forEach items="${rList }" var="review" varStatus="N">
						<td id="detail-one-wrap" aligh="center" width="30%">
							<div class="detail title thumnale-wrap align="center">
								<img onclick="location.href='/review/detailView.kh?boardNo=${review.boardNo }';" onerror="this.src='/resources/image/flower1.png';" src="${review.thumbnailPath }" height="90%" width="90%">
							</div>
							<div align="center">
								<a href="/review/detailView.kh?boardNo=${review.boardNo }"><div class="detail title"><b>${review.reviewTitle }</b></div></a>
								<div class="detail writer">${review.reviewWriter }</div>
								<div class="detail info-wrap">
									<div class="detail viewcount-wrap">
										<img alt="눈모양 아이콘" src="/resources/image/viewcount.jpg" width="25px" height="25px">
											${review.reviewCount }
									</div>
									<span  class="detail date">${review.rCreateDate }</span>
								</div>
							</div>
						</td>
						<c:if test="${N.count % 3 == 0 }">
							</tr><tr>
						</c:if>			
					</c:forEach>
				</tr>
			</table>
<!-- 페이징처리 -->
			<div id="pageNavi">
				<c:if test="${paging.startNavi > 1 }">
					<a href="/review/list.kh?currentPage=${paging.startNavi-1 }">[이전]</a>
				</c:if>
				<c:forEach begin="${paging.startNavi }" end="${paging.endNavi }" var="p" >
					<a href="/review/list.kh?currentPage=${p }">${p }</a>
				</c:forEach>
				<c:if test="${paging.endNavi < paging.endPage }">
					<a href="/review/list.kh?currentPage=${paging.endNavi+1 }">[다음]</a>
				</c:if>
			</div>
<!-- 컨텐츠 하단 버튼	 -->
			<div id="button">
				<button onclick="location.href='/review/writeView.kh';">글 작성</button>
			</div>
			
		</div>
	</div>
<!-- 푸터 -->
	<div id="footer"></div>
</body>
</html>