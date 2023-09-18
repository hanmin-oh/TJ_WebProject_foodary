<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>푸터 로그인 후</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
    <p class="col-md-4 mb-0 text-body-secondary">ⓒ 2023 아무래도</p>

		<a href="../main/foodaryMainPageAfter"
			style="font-family: 'insungitCutelivelyjisu';
			margin:10px; font-size: 25pt; font-weight:900; color: black; text-decoration: none;">Foodary</a>

    <ul class="nav col-md-4 justify-content-end">
      
      	<jsp:useBean id="date" class="java.util.Date"/>
		<jsp:useBean id="time" class="java.util.Date"/>
		<fmt:formatDate  value="${date}" pattern="yyyy-MM-dd" var="dietWriteDate"/>
		<fmt:formatDate  value="${time}" pattern="HH:mm" var="dietWriteTime"/>
      <li class="nav-item">
      	<a href="dietInsertView?id=${rvo.id}" class="nav-link px-2 text-body-secondary" style="color: black;">
      		Foodary 쓰기
      	</a>
      </li>
      <li class="nav-item">
      	<a href="dietListView?id=${rvo.id}&dietWriteDate=${dietWriteDate}" class="nav-link px-2 text-body-secondary" style="color: black;">
      		Foodary 보기
      	</a>
      </li>
      <li class="nav-item">
      	<a href="../freeboard/listView" class="nav-link px-2 text-body-secondary" style="color: black;">
      		자유게시판
      	</a>
      </li>
    </ul>
  </footer>

</body>
</html>