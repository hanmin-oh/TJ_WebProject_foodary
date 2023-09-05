<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정할 글 보기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/threeGrid.css"/>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script defer type="text/javascript" src="../js/FreeboardUpload.js"></script>
</head>
<body>
<div class="container">
		<!-- 헤더 영역 -->
	<div class="header">
		<jsp:include page="./headerAfter.jsp"></jsp:include>
	</div>
	<!-- 중간영역 -->
	<div class="main">	
		<form action="updateOK" method="post" enctype="multipart/form-data" onsubmit="return insertCheck()">
			<table cellpadding="4" cellspacing="20" style="width: 700px; margin-left: auto; margin-right: auto; vertical-align: middle;">
				<tr>
					<th colspan="4" style="text-align: center;"><span style="background: #baffda; font-size: 45px;"><수정할 내용을 입력하세요></span></th>
				</tr>
				<tr style="font-weight: 800;">
					<td style="width: 300px; text-align: center;">
						<span style="background: lavender; font-size: 22pt;">No.</span>
					</td>
					<td style="width: 250px; text-align: center;">
						<span style="background: lavender; font-size: 22pt;">이름</span>
					</td>
					<td style="width: 150px; text-align: center;">
						<span style="background: lavender; font-size: 22pt;">작성일</span>
					</td>
					<td style="width: 100px; text-align: center;">
						<span style="background: lavender; font-size: 22pt;">조회수</span>
					</td>
				</tr>
				<tr>
					<td align="center" style="font-size: 22pt;">${vo.idx}</td>
					<td align="center" style="font-size: 22pt;">
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
					<th>
						<span style="background: lavender; font-size: 22pt;">제목</span> :
					</th>
					<td colspan="2">
						<input 
							id="subject" 
							type="text" 
							name="subject"
							style="width: 430px; padding: 5px;"
							value="${vo.subject}"/>
					</td>
					<th width="100" style="text-align: center;">
						공지글 : 
						<c:if test="${fn:trim(vo.notice) == 'on'}">
							<input class="form-check-input" type="checkbox" name="notice" checked="checked"/>
						</c:if>
						<c:if test="${fn:trim(vo.notice) != 'on'}">
							<input class="form-check-input" type="checkbox" name="notice"/>
						</c:if>
					</th>
				</tr>
				<tr>
					<th class="align-middle">
						<span style="background: lavender; font-size: 22pt;">내용</span>
					</th>
					<td colspan="3">
						<textarea 
							id="content" 
							rows="6" 
							name="content"
							style="width: 550px; padding: 5px; resize: none;"
							>${vo.content}</textarea>
						<c:if test="${not empty vo.picture}">
							<img id="output" src="./upload/${vo.picture}" style="max-width: 450px; max-height: 300px;">
						</c:if>
					</td>
				</tr>
				<tr>
					<th>
						<span style="background: lavender; font-size: 18pt;">사진 첨부</span> :
					</th>
					<td colspan="3">
		        		<input type="file" accept="image/*" name="fileName" onchange="photoView(event)" value="파일 선택"
		        			style="font-size: 10pt;"/>
						<img id="output" style="max-width: 450px; max-height: 300px;"/><br/>
					</td>
				</tr>
				<input type="hidden" name="idx" value="${vo.idx}"/>
				<input type="hidden" name="currentPage" value="${currentPage}"/>
				<tr class="table-secondary">
					<td></td>
					<td colspan="3" align="center">
						<div style="width: 90%; margin-left: auto; margin-right: auto;">
							<button 
								type="submit" 
								style="border: 0; background: none; cursor: pointer;">
								<span style="background: #fafcd9; font-size: 25pt;; font-weight: 800;">수정하기</span>&nbsp;&nbsp;&nbsp;
							</button>
							<button
								type="reset" 
								style="border: 0; background: none; cursor: pointer;">
								<span style="background: #fafcd9; font-size: 25pt; font-weight: 800;">다시쓰기</span>&nbsp;&nbsp;&nbsp;
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
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="footer">
		<jsp:include page="./footerAfter.jsp"></jsp:include>
	</div>
</div>
</body>
</html>











