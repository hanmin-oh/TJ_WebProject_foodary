<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 후 메인페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="../css/threeGrid.css"/>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script type="text/javascript" src="../js/mainFunction.js"></script>
</head>
<body>
<!-- 곳곳에서 작업 후 넘어오는 얼럿창 (내용 없으면 아무것도 안 뜸) -->
<c:if test="${not empty msg}">
	<script type="text/javascript">
		alert('${msg}')
	</script>
</c:if>
<div class="container">
<!-- header -->
	<div class="header">
		<jsp:include page="./headerAfter.jsp"></jsp:include>
		<div style="text-align: center; padding-top: 60px; background-image:url('../images/note2.png');">
			<a href="foodaryMainPageAfter"
				style=" font-family: 'insungitCutelivelyjisu'; font-size: 80pt; font-weight: 900;
				color: black; cursor: pointer; text-decoration: none;">
				Foodary
			</a>
			<p class="text-center">
				<span style="background: #baffda; font-size: 30pt;">"내 몸을 위한 일기장"</span>
			</p>
			<br/>
		</div>
	</div>
	<!-- Foodary 쓰기, 보기 버튼 / 캘린더 -->
	<div class="main">
		<div style="display: flex;">
			<div style="padding-top: 20px;">
				<div style="margin-left: 100px;">
					<button  onclick="location.href='../diet/dietInsertView?id=${rvo.id}'" style="cursor: pointer; margin-left: 30px; background: none; border: 0;">
			          <span class="mb-0" style="font-size: 50pt; font-weight: 900; background: #FFF08F;">Foodary 쓰기</span>&nbsp;&nbsp;
			          <img src="../images/pencil.png" style="width: 60px; height: 60px;"/>&nbsp;&nbsp;
			        </button>
		        </div>
		        <br>
		        <!-- 식단 보기에 날짜를 넣어 주기 위한 date 클래스 객체 -->
		        <jsp:useBean id="date" class="java.util.Date"/>
				<fmt:formatDate  value="${date}" pattern="yyyy-MM-dd" var="dietWriteDate"/>
				<fmt:formatDate  value="${date}" pattern="HH:mm" var="dietWriteTime"/>
				<div style="margin-left: 100px;">
					<button  onclick="location.href='../diet/dietListView?id=${rvo.id}&dietWriteDate=${dietWriteDate}'" style="cursor: pointer; margin-left: 30px; background: none; border: 0;">
			          <span class="mb-0" style="font-size: 50pt; font-weight: 900; background: #FFF08F;">Foodary 보기</span>&nbsp;&nbsp;
			          <img src="../images/note3.png" style="width: 60px; height: 60px;"/>&nbsp;&nbsp;
			        </button>
		        </div>
			</div>
			<div style="margin-left: 200px;">
				<jsp:include page="./mainCalendarAfter.jsp"></jsp:include>
			</div>
		</div>
		<br/><br/>
		<!-- 자유게시판 -->
		<div style="width: 100%; height: auto;" align="center">
			<div align="center">
				<jsp:include page="./mainFreeboardListAfter.jsp"/>
			</div>
		</div>
		<!-- 영상, 오메추 -->
		<div id="slider-div">
			<div style="text-align: center; background-image:url('../images/monun2.jpg'); height: 400px; vertical-align: middle; display: flex;">
				<div style="height: 200px; padding-top: 30px; margin-left: 90px; display: inline-block;" id="showMenu" align="center">
					<button type="button" onclick="showMenu()" style="background: none;">
						<span style="background: #FFF08F; color:black; font-size: 30pt;"><오늘의 메뉴 추천></span>
					</button><br/>
					<img src="../images/polra.png" height="300px;">
				</div>
				<div style="margin-left: 160px; padding-top:20px;">
					<iframe src="https://www.youtube.com/embed/R5VM-yp-NwE" width="650" height="360"
					style="border: 4px solid black; display: inline-block;" allowfullscreen></iframe>
				</div>
			</div>
		</div>
	</div>
	<!-- footer 영역 -->
    <div class="footer">
    	<jsp:include page="./footerAfter.jsp"></jsp:include>
    </div>
</div>
</body>
</html>

