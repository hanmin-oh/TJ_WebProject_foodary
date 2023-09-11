<%@page import="com.foodary.vo.FreeboardList"%>
<%@page import="com.foodary.vo.FreeboardVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 게시판 미리보기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- bootstrap icon -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<!-- custom style -->
<link rel="stylesheet" href="./css/style.css"/>
</head>
<body>
	   <table>
	      <tr>
	         <th colspan="2" style="text-align: left;">
	           	&nbsp; <span style="background: #baffda; font-size: 30pt;">★ 자유게시판 ★</span>
	         </th>
	         <td>
	       		<button type="button" onclick="location.href='/foodary_final/JSP_freeboard/list.jsp'">
	       			<span style="text-align: right; font-size: 22pt; background: #d4ffe8; font-weight: 800;">보러가기</span>
	       		</button>
	       	</td>
	      </tr>
	      <tr style="background: lavender;">
			 <td style="width: 100px; text-align: center; font-size: 18pt; font-weight: 800;">No</td>
	         <td style="width: 520px; font-size: 18pt; font-weight: 800; padding-left: 20px;">제목</td>
	         <td style="width: 70px; text-align: center; font-size: 18pt; font-weight: 800;" colspan="2">조회수</td>
	      </tr>
		<jsp:useBean id="date" class="java.util.Date"/>
		
		<!-- 공지글을 출력한다. -->
		<c:forEach var="vo" items="${notice}" begin="0" end="1">
		<tr class="table-warning">
			<td align="center" style="font-size: 18pt;">
				[공지]
			</td>
			<td>
				<c:set var="subject" value="${fn:replace(vo.subject, '<', '&lt;')}"/>
				<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
				<button onclick="../increment?idx=${vo.idx}&currentPage=1'"
					style="font-size: 18pt; color: black; text-decoration: none;">
					${subject}(${vo.commentCount})
				</button>>
			</td>
			<td align="center" style="font-size: 18pt;">${vo.hit}</td>
		</tr>
		</c:forEach>
		
		<!-- 메인글을 출력한다. -->
		<!-- list.jsp에서 request 영역에 저장한 freeboardList에서 1페이지 분량의 글을 꺼내온다. -->
		<c:set var="list" value="${freeboardList.list}"/>
	
		<!-- 메인글이 1건도 없으면 글이 없다고 출력한다. -->
		<c:if test="${list.size() == 0}">
		<tr>
			<td colspan="3">
				<marquee>테이블에 저장된 글이 없습니다.</marquee>
			</td>
		</tr>
		</c:if>
		
		<!-- 메인글이 있으면 메인글의 개수만큼 반복하며 글 제목을 출력한다. -->
		<c:if test="${list.size() != 0}">
		<c:forEach var="vo" items="${list}" begin="0" end="6">
		<tr>
			<td align="center" style="font-size: 18pt;">${vo.idx}</td>
			<td style="font-size: 18pt; color: black; text-decoration: none;">
				<!-- 제목에 태그를 적용할 수 없게 한다. -->
				<c:set var="subject" value="${fn:replace(vo.subject, '<', '&lt;')}"/>
				<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
				
				<button onclick="location.href='freeboard/increment?idx=${vo.idx}&currentPage=1'"
					style="font-size: 18pt; color: black; background: none; border: 0;">
					${subject}(${vo.commentCount})
				</button>
				<!-- 오늘 입력된 글에 new 아이콘 이미지를 표시한다. -->
				<c:if test="${date.year == vo.writeDate.year && date.month == vo.writeDate.month &&
					date.date == vo.writeDate.date}">
					<span style="background: navy; border: 0; border-radius: 5px; color: white; padding: 1px;">new</span>
				</c:if>
				
				<!-- 조회수가 일정 횟수를 넘어가면 hot 아이콘을 표시한다. -->
				<c:if test="${vo.hit > 10}">
					<span style="background: red; border: 0; border-radius: 5px; color: white; padding: 1px;">hot</span>
				</c:if>
			</td>
			<td align="center" style="font-size: 14pt; color: black; text-decoration: none;">${vo.hit}</td>
		</tr>
		</c:forEach>
		</c:if>
	</table>
</body>
</html>