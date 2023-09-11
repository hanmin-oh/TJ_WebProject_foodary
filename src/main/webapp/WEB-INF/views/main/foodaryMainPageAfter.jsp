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
<link rel="stylesheet" href="../css/fiveGrid.css"/>
<script type="text/javascript" src="../js/jquery-3.7.0.js"></script>
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
		<div style="text-align: center; padding-top: 20px;">
			<a href="foodaryMainPageAfter"
				style=" font-family: 'insungitCutelivelyjisu'; font-size: 70pt; font-weight: 900;
				color: black; cursor: pointer; text-decoration: none;">
				Foodary
			</a>
			<p class="text-center">
				<span style="background: #fafcd9; font-size: 26pt;">"내 몸을 위한 일기장"</span>
			</p>
		</div>
	</div>
<!-- 중간 왼쪽(오메추, 영상광고) -->
	<div class="mainLeft">
		<div style="height: 200px;" id="showMenu" align="center">
				<button type="button" onclick="showMenu()"><span style="background: lavender; color:black; font-size: 30pt;"><오늘의 메뉴 추천></span></button>
				<img src="../images/polra.png" height="270px;">
		</div>
			<br><br><br><br><br><br><br><br><br>
			<!-- 영상 -->
		<div>
			<iframe src="https://www.youtube.com/embed/R5VM-yp-NwE" width="300" style="border: 4px solid black;" allowfullscreen></iframe>
		</div>
	</div>
<!-- 중간 가운데 (식단쓰기버튼, 식단 보기 버튼, 자유게시판 목록) -->
	<jsp:useBean id="date" class="java.util.Date"/>
	<fmt:formatDate  value="${date}" pattern="yyyy-MM-dd" var="dietWriteDate"/>
	<fmt:formatDate  value="${date}" pattern="HH:mm" var="dietWriteTime"/>
 	<div class="mainCenter">
		<!-- 식단 쓰러가기 버튼 -->
		<div style="width: 100%; height: auto; margin-top: 20px;" align="center">
			<div style="height: 180px;">
				<div style="display: inline-block; background-image:url('../images/clipMemo.png'); background-repeat:no-repeat; width: 200px; padding-top: 30px;">
					<a href="../diet/dietInsertView?id=${rvo.id}"
						style=" color: black; font-size: 40pt; cursor: pointer; text-decoration: none;">
						식단 쓰기
					</a>
				</div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<div style="display: inline-block; background-image:url('../images/clipMemo.png'); background-repeat:no-repeat; width: 200px; padding-top: 30px;">
					<a href="../diet/dietListView?id=${rvo.id}&dietWriteDate=${dietWriteDate}"
						style=" color: black; font-size: 40pt; cursor: pointer; text-decoration: none;">
						식단 보기
					</a>
				</div>
			</div>
		</div>
		<!-- 자유게시판 -->
		<div style="width: 100%; height: auto;" align="center">
			<div align="center" style="display: inline-block;
			background-image:url('../images/spring.png'); background-repeat:no-repeat; width: 700px; height: 600px; padding-top: 70px;">
				<jsp:include page="./mainFreeboardListAfter.jsp"/>
			</div>
		</div>
	</div>
<!-- 중간 오른쪽 (로그인, 달력) -->		
	<div class="mainRight">
		<div style="text-align: left; width: auto;">
			<form action="../user/myPageOK" method="post">
				<div style="display: inline-block; background-image:url('../images/memo.png'); margin-left: 30px;
				background-size:260px; background-repeat:no-repeat; width: 270px; height: 270px; padding-top: 70px;">
					<div>
						<table width="300px;" id="mainLoginForm"  cellpadding="5" cellspacing="5" align="center">
					       <tr>
					          <th style="text-align: center; font-size: 20pt; padding-right: 40px;">
					         	 <span style="background: #baffda; font-size: 30px;">${rvo.username}</span> 님<br/>
					         	 건강한 하루 되세요!
					          </th>
					       </tr>
					       <tr>
					          <td style="text-align: center; padding-right: 50px;">
								<input id="idx" type="hidden" name="idx" value="${rvo.idx}"/>
					            <button type="submit">
					            	<span style="background: lavender; color:black; font-size: 25pt;">MY페이지</span>
					            </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					            <button type="button" onclick="location.href='logoutOK?name=${rvo.username}'">
					            	<span style="background: lavender; color:black; font-size: 25pt;">로그아웃</span>
					            </button>
					          </td>
					       </tr>
					    </table>
					</div>
				</div>
			</form>
		</div>
		<br><br><br>
		<div style="text-align: center; width: auto; margin-left: 15px;">
			<jsp:include page="./mainCalendarAfter.jsp"/>
		</div>
	</div>
<!-- footer 영역 -->
    <div class="footer">
    	<jsp:include page="./footerAfter.jsp"></jsp:include>
    </div>
</div>
</body>
</html>

