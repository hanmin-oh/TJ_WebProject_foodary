<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인후 헤더</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<header>
		<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<jsp:useBean id="date" class="java.util.Date"/>
		<jsp:useBean id="time" class="java.util.Date"/>
		<fmt:formatDate  value="${date}" pattern="yyyy-MM-dd" var="dietWriteDate"/>
		<fmt:formatDate  value="${time}" pattern="HH:mm" var="dietWriteTime"/>
		  <div class="container-fluid">
		    <a class="navbar-brand" href="../main/foodaryMainPageAfter"
		    	style="font-family: 'insungitCutelivelyjisu';
					position:relative;
					margin-top: 0;
					font-size: 20pt;
					font-weight:900;
					color: black;
					text-decoration: none;">Foodary</a>
					
		    <div class="collapse navbar-collapse" id="navbarColor06">
		      <ul class="navbar-nav me-auto">
		        <li class="nav-item">
		          <a class="nav-link" href="../diet/dietInsertView?id=${rvo.id}"
		         style="font-size: 18pt;
					color: black; 
					text-decoration: none;"><span style="background: #fafcd9">Foodary 쓰기</span></a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="../diet/dietListView?id=${rvo.id}&dietWriteDate=${dietWriteDate}"
		          style="font-size: 18pt;
					color: black; 
					text-decoration: none;"><span style="background: #fafcd9">Foodary 보기</span></a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="listView"
		          style="font-size: 18pt;
					color: black; 
					text-decoration: none;"><span style="background: #fafcd9">자유게시판</span></a>
		        </li>
		      </ul>
		      <ul>
				<li class="nav-item dropdown" style="list-style-type: none;">
		          <a class="nav-link dropdown-toggle" 
		          	data-bs-toggle="dropdown" href="#" role="button" 
		          	aria-haspopup="true" aria-expanded="false"
		          	 style="font-size: 18pt;
					color: black; 
					text-decoration: none;">
		          	<span style="background: lavender; font-size: 20pt;">${rvo.username}</span> 님
		          </a>
		          <div class="dropdown-menu align-center">
		            <a class="dropdown-item" href="../user/myPageOK"
		            style="font-size: 18pt;
					color: black; 
					text-decoration: none;">MY 페이지</a>
					
		            <a class="dropdown-item" href="../main/logoutOK?name=${rvo.username}"
		            style="font-size: 18pt;
					color: black; 
					text-decoration: none;">Logout</a>
		          </div>
		        </li>
		       </ul>
		    </div>
		  </div>
		</nav>
</header>
</body>
</html>