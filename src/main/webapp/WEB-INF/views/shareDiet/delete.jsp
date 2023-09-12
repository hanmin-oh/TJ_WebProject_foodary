<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제할 글 보기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/threeGrid.css"/>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<body>
<div class="container">
	<div class="header">
		<jsp:include page="./headerAfter.jsp"></jsp:include>
	</div>
	<div class="main">
		<form action="deleteOK" method="post">
			<table cellpadding="4" cellspacing="20" style="width: 700px; margin-left: auto; margin-right: auto; vertical-align: middle;">
				<tr>
					<th colspan="4" style="text-align: center;"><span style="background: #baffda; font-size: 45px;"><삭제할 내용을 확인하세요></span></th>
				</tr>
				<tr style="font-weight: 800;">
					<td style="width: 150px; text-align: center;">
						<span style="background: lavender; font-size: 22pt;">No.</span>
					</td>
					<td style="width: 350px; text-align: center;">
						<span style="background: lavender; font-size: 22pt;">이름</span> :
					</td>
					<td style="width: 200px; text-align: center;">
						<span style="background: lavender; font-size: 22pt;">작성일</span>
					</td>
					<td style="width: 100px; text-align: center;">
						<span style="background: lavender; font-size: 22pt;">조회수</span>
					</td>
				</tr>
				<tr>
					<td align="center">${vo.idx}</td>
					<td align="center">
						<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}"/>
						<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
						${name}
					</td>
					<td align="center">
						<jsp:useBean id="date" class="java.util.Date"/>
						<c:if test="${date.year == vo.writeDate.year && date.month == vo.writeDate.month &&
							date.date == vo.writeDate.date}">
							<fmt:formatDate value="${vo.writeDate}" pattern="a h:mm:ss"/>
						</c:if>
						<c:if test="${date.year != vo.writeDate.year || date.month != vo.writeDate.month ||
							date.date != vo.writeDate.date}">
							<fmt:formatDate value="${vo.writeDate}" pattern="yyyy.MM.dd(E)"/>
						</c:if>
					</td>
					<td align="center">${vo.hit}</td>
				</tr>
				<tr>
					<th><span style="background: lavender; font-size: 22pt;">제목</span> :</th>
					<td colspan="3">
						<c:set var="subject" value="${fn:replace(vo.subject, '<', '&lt;')}"/>
						<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
						${subject}
					</td>
				</tr>
				<tr>
					<th class="align-middle"><span style="background: lavender; font-size: 22pt;">내용</span></th>
					<td colspan="3">
						<c:set var="content" value="${fn:replace(vo.content, '<', '&lt;')}"/>
						<c:set var="content" value="${fn:replace(content, '>', '&gt;')}"/>
						<c:set var="content" value="${fn:replace(content, enter, '<br/>')}"/>
						${content}<br>
						<c:if test="${not empty vo.picture}">
							<img id="output" src="/upload/${vo.picture}" style="max-width: 450px; max-height: 300px;">
						</c:if>
					</td>
				</tr>
				<tr class="table-secondary">
					<td colspan="4" align="center">
						<div class="row g-3 align-items-center" style="width: 90%; margin-left: auto; margin-right: auto;">
							<div class="col-auto">
								<button 
								type="submit" 
								style="border: 0; background: none; cursor: pointer;">
								<span style="background: #fafcd9; font-size: 25pt;; font-weight: 800;">삭제하기</span>&nbsp;&nbsp;&nbsp;
								</button>
								<button
									type="button" 
									style="border: 0; background: none; cursor: pointer;"
									onclick="history.back()">
									<span style="background: #fafcd9; font-size: 25pt; font-weight: 800;">돌아가기</span>&nbsp;&nbsp;&nbsp;
								</button>
								<button
									type="button" 
									style="border: 0; background: none; cursor: pointer;"
									onclick="location.href='listView?currentPage=${currentPage}'">
									<span style="background: #fafcd9; font-size: 25pt; font-weight: 800;">목록보기</span>
								</button> 
							</div>
						</div>
					</td>
				</tr>
			</table>
			
			<input type="hidden" name="idx" value="${vo.idx}"/>
			<input type="hidden" name="currentPage" value="${currentPage}"/>
		</form>
	</div>
	<div class="footer">
		<jsp:include page="./footerAfter.jsp"></jsp:include>
	</div>
</div>
</body>
</html>











