<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 전 메인페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/fiveGrid.css"/>
<script type="text/javascript" src="js/jquery-3.7.0.js"></script>
<script type="text/javascript" src="js/mainFunction.js"></script>
</head>
<body>
<div class="container">
${message}
${msg}
<!-- header -->
	<div class="header">
		<jsp:include page="./header.jsp"></jsp:include>
		<div style="text-align: center; padding-top: 20px;">
			<a href="?" style="
				font-family: 'insungitCutelivelyjisu'; font-size: 70pt; font-weight: 900;
				color: black; cursor: pointer; text-decoration: none;">
				Foodary
			</a>
			<p class="text-center">
				<span style="background: #fafcd9; font-size: 26pt;">"내 몸을 위한 일기장"</span>
			</p>
		</div>
	</div>
<!-- 메인 콘텐츠 -->
    <div class="mainLeft">
    	<div style="">
			<jsp:include page="./mainCalculator.jsp"/>
		</div>
    </div>
    <div class="mainCenter">
		<div style="width: 100%; height: auto; margin-top: 20px;" align="center">
			<div style="height: 180px;">
				<div style="display: inline-block; background-image:url('./images/clipMemo.png'); background-repeat:no-repeat; width: 200px; padding-top: 30px;">
					<a href="#" style=" color: black; font-size: 40pt; cursor: pointer; text-decoration: none;" onclick="alert('로그인 후 이용 가능한 메뉴입니다.')">
						식단 쓰기
					</a>
				</div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<div style="display: inline-block; background-image:url('./images/clipMemo.png'); background-repeat:no-repeat; width: 200px; padding-top: 30px;">
					<a href="#" style=" color: black; font-size: 40pt; cursor: pointer; text-decoration: none;" onclick="alert('로그인 후 이용 가능한 메뉴입니다.')">
						식단 보기
					</a>
				</div>
			</div>
		</div>
		<div style="width: 100%; height: auto;" align="center">
			<div align="center" style="display: inline-block;
			background-image:url('./images/spring.png'); background-repeat:no-repeat; width: 700px; height: 600px; padding-top: 65px;">
				<jsp:include page="./mainFreeboardList.jsp"/>
			</div>
		</div>
	</div>
    <div class="mainRight">
		<div style="background-image:url('./images/memo.png'); margin-left: 30px;
				background-size:260px; background-repeat:no-repeat; width: 270px; height: 270px; padding-top: 70px;">
			<div>
				<jsp:include page="./mainLoginForm.jsp"/><br/><br/>
			</div>
		</div>
			<br/><br/>
			<div style="text-align: center; margin-left: 15px;">
				<jsp:include page="./mainCalendar.jsp"/>
			</div>
	</div>
<!-- footer 영역 -->
    <div class="footer">
    	<jsp:include page="./footer.jsp"></jsp:include>
    </div>
</div>
</body>
</html>

