<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인후 헤더</title>
</head>
<body>
<header>
	<!-- 네비게이션 바 -->
		<jsp:useBean id="date" class="java.util.Date"/>
		<jsp:useBean id="time" class="java.util.Date"/>
		<fmt:formatDate  value="${date}" pattern="yyyy-MM-dd" var="dietWriteDate"/>
		<fmt:formatDate  value="${time}" pattern="HH:mm" var="dietWriteTime"/>
		<div style="height: 70px; line-height: 70px; display: flex; justify-content: space-between; background: #f0f0f0">
			<div style="padding-left : 20px;">
				<a href="../diet/dietInsertView?id=${rvo.id}" style="font-size: 27pt; color: black; text-decoration: none;">식단 쓰기</a>&nbsp;&nbsp;&nbsp;
				<a href="../diet/dietListView?id=${rvo.id}&dietWriteDate=${dietWriteDate}&dietWriteTime=${dietWriteTime}"
					style="font-size: 27pt; color: black; text-decoration: none;">식단 보기</a>&nbsp;&nbsp;
				<a href="../freeboard/listView" style="font-size: 27pt; color: black; text-decoration: none;">자유게시판</a>
			</div>
			<div style="padding-right : 20px;">
				<a class="navbar-form navbar-right" href="foodaryMainPageAfter"
				style="font-family: 'insungitCutelivelyjisu'; position:relative;  margin-top: 0; font-size: 30pt; font-weight:900; color: black; text-decoration: none;">Foodary</a>
			</div>
		</div>
</header>
</body>
</html>