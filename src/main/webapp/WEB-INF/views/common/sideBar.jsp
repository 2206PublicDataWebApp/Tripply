<%-- <%@ page session="false" %> 이거 있으면 세션스코프 동작 안함--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title></title>
 <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"> -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<style type="text/css">

.login-area {
    list-style-type: none;
    padding-left: 10px;
    margin-top: 0px;
    width: 200px;
    background-color: rgba(0,0,0,0.9);
    height: 100%;
    overflow: auto;
    position: fixed;
    font-family: 'Jua', sans-serif;	
    color:white;
     cuusor: pointer;
    
  }
  
  ul.service-menu {
    list-style-type: none;
    padding: 0px;
    margin: 0px;
    width: 200px;
    background-color: rgba(0,0,0,0.0);
    height: 100%;
    overflow: auto;
    position: fixed;
     cuusor: pointer;
  }
  
  
  li.service-menu  {
    text-decoration: none;
    padding: 10px;
    display: block;
    color: #fff;
    font-weight: bold;
     cuusor: pointer;
  }
  
  li.service-menu:hover {
    background-color:coral;
    font-weight: bold;
    color: white;
    cuusor: pointer;
  }
  

  
  .right-side {
    margin-left: 200px;
  }

</style>
</head>

<body>
<div id="left-sidebar">
   <div class="login-area">
		<c:if test="${empty loginUser }">
			<form action="/member/login.kh" method="post">
						아이디:<br>
						<input type="text" name="memberId"><br>
						비밀번호:<br>
						<input type="password" name="memberPwd"><br>
						<input type="submit" value="로그인"><br>
						<a href="/member/findId.kh">ID찾기</a> <br>
						<a href="/member/joinView.kh">회원가입</a> <br>
			</form>
		</c:if>
		<c:if test="${not empty loginUser }">
			${sessionScope.loginUser.memberNickname }님 환영합니다.
			
			<ul class="service-menu">
                <li class="service-menu" onclick="messageView('${sessionScope.loginUser.memberNickname}');">마이 쪽지</li>
                <li class="service-menu" onclick="location.href='/member/myPage.kh';" class="btn btn-dark">마이 페이지</li>
                <li class="service-menu" onclick="location.href='/member/logout.kh';">로그아웃</li>
                <c:if test="${loginUser.memberId eq 'admin' }">
                <li class="service-menu" onclick="location.href='/admin/banner/list.kh'">관리자 페이지</li>
                
                </c:if>
                
            </ul>
	
			</c:if>
	</div>
	
    
    </div>
        
     <script type="text/javascript">
		function messageView(memberNickname) {
			window.open('/message/recvList.kh?msgReciever='+memberNickname+'', 'window', 'width=800, height=700, menubar=no, status=no, toolbar=no');
		}
     </script>
       
</body>
</html>