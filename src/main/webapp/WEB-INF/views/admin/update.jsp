<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정할 공지글</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/threeGrid.css"/>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script defer type="text/javascript" src="../js/AdminNoticeUpload.js"></script>
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
			<table class="table table-sm"
				style="width: 800px; margin-left: auto; margin-right: auto; vertical-align: middle; border: 1px solid #bfbfbf;">
				<tr style="font-weight: 800;">
					<td style="width: 100px; text-align: center; background: lavender;">
						<span style="font-size: 22pt;">No.</span>
					</td>
					<td style="width: 250px; text-align: center; background: lavender;">
						<span style="font-size: 22pt;">이름</span>
					</td>
					<td style="width: 150px; text-align: center; background: lavender;">
						<span style="font-size: 22pt;">작성일</span>
					</td>
					<td style="width: 100px; text-align: center; background: lavender;">
						<span style="font-size: 22pt;">조회수</span>
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
					<th style="background: #e8ffed; text-align: center; vertical-align: middle;">
						<span style="font-size: 22pt;">제목</span> :
					</th>
					<td colspan="2">
						<input 
							id="subject" 
							type="text" 
							name="subject"
							style="font-size: 18pt; padding: 5px; width:500px; margin-left:20px;
								border: 2px solid #956fd6; border-radius: 10px;"
							value="${vo.subject}"/>
					</td>
					<th width="100" style="background: #e8ffed; text-align: center; vertical-align: middle;">
						공지글 : 
						<c:if test="${fn:trim(vo.notice) == 'on'}">
							<input type="checkbox" name="notice" checked="checked" style="accent-color: #7a33ff;"/>
						</c:if>
						<c:if test="${fn:trim(vo.notice) != 'on'}">
							<input type="checkbox" name="notice" style="accent-color: #7a33ff;"/>
						</c:if>
					</th>
				</tr>
				<tr>
					<th style="background: #e8ffed; text-align: center; vertical-align: middle;">
						<span style="font-size: 22pt;">내용</span>
					</th>
					<td colspan="3">
						<textarea 
							id="content" 
							rows="5"
							name="content"
							style="resize: none; font-size: 20pt; padding: 10px; width:620px; margin-left:20px;
							border: 2px solid #956fd6; border-radius: 10px;"
							>${vo.content}</textarea>
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="3" align="center">
						<c:if test="${not empty vo.picture}">
							<img id="output" src="/upload/freeboard/${vo.picture}" style="max-width: 450px; max-height: 300px;">
							&nbsp;&nbsp;
							<button id="deleteBtn" type="button" onclick="photoDelete()" style="background: none; border: 0; cursor: pointer;">
								<span style="background: #baffda; font-size: 30px; font-weight: 900;">사진 삭제</span>
							</button>
						</c:if>
					</td>
				</tr>
				<tr>
					<th style="font-size: 20pt; text-align: center; background: #d9ffed;">
						<label for="picture" style="font-size: 18pt;">사진 첨부</label>
					</th>
					<td colspan="3">
		        			<input id="picture" class="form-control form-control-sm" type="file" accept="image/*" name="fileName" onchange="photoView(event)" value="파일 선택"
		        				style="font-size: 15pt; color: #b49bde; width: 650px; height: 20px;"/>
					</td>
				</tr>
				<tr>
					<th style="font-size: 18pt; text-align: center; background: #ede8ff;">
						<span>미리보기</span>
					</th>
					<td colspan="3">
						<img id="output" style="max-width: 450px; max-height: 300px; margin: 20px;"/><br/>
					</td>
				</tr>
			</table>
				<input type="hidden" name="idx" value="${vo.idx}"/>
				<input type="hidden" name="currentPage" value="${currentPage}"/>
				<input type="hidden" name="name" value="${vo.name}"/>
				<input type="hidden" name="id" value="${vo.id}"/>
				<input id="picture" type="hidden" name="picture" value="${vo.picture}"/>
					<div style="text-align: center;">
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
		</form>
	</div>
	<div class="footer">
		<jsp:include page="./footerAfter.jsp"></jsp:include>
	</div>
</div>
</body>
</html>











