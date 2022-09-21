<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>트리플리,Tripply</title>
<!-- 화면 뼈대 설정용 css -->
<!-- <link rel="stylesheet" href="/WEB-INF/resources/css/common-style.css"> -->
</head>
<body>
<!-- 헤더-메뉴바 -->
	<div id="header">
		<jsp:include page="/WEB-INF/views/common/menuBar.jsp"></jsp:include>
	</div>
<!-- 컨텐츠 -->
	<div id="contents">
		<div id="sideBar"></div>
		<div id="contents-1"></div>
		<div id="contents-2"></div>
	</div>
<!-- 푸터 -->
	<div id="footer"></div>
</body>
</html>