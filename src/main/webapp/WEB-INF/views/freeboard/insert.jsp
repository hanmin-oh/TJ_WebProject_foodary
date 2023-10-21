<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 쓰기</title>
<link rel="stylesheet" href="../css/threeGrid.css"/>
<script type="text/javascript" src="../js/jquery-3.7.0.js"></script>
<script defer type="text/javascript" src="../js/FreeboardUpload.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
	<!-- 헤더 영역 -->
	<div class="header">
		<jsp:include page="./headerAfter.jsp"></jsp:include>
	</div>
	<!-- 중간영역 -->
	<div class="main">
		<form action="insertOK" method="post" enctype="multipart/form-data" onsubmit="return insertCheck()">
			<table class="table table-sm"
				style="width: 800px; margin-left: auto; margin-right: auto; vertical-align: middle; border: 1px solid #bfbfbf;">
				<!-- 이름입력 -->
				<tr>
					<th width="200" style="font-size: 20pt; text-align: center; background: lavender;">
						<label for="name">이름</label>
					</th>
					<td width="520" style="font-size: 20pt;">
						<input 
							id="name"
							type="text" 
							name="name"
							value="${rvo.username}"
							style="padding: 5px; border: 0px;" readonly="readonly"/>
					</td>
					<!-- 공지여부 -->
					<!-- 
					<th width="100" style="text-align: center; font-size: 20pt; background: #d9ffed;">
						공지글 : &nbsp;<input type="checkbox" name="notice" style="accent-color: #7a33ff;"/>
					</th>
					-->
				</tr>
				<!-- hidden으로 id넘기기 -->
				<input id="id" type="hidden" name="id" value="${rvo.id}"/>
				<input id="admin" type="hidden" name="admin" value="Y" />
				<tr>
					<th style="font-size: 20pt; text-align: center;  background: #d9ffed;">
						<label for="subject" style="font-size: 20pt;">제목</label>
					</th>
					<td colspan="2">
						<input id="subject" type="text" name="subject"
							style="font-size: 18pt; padding: 5px; width:650px; border: 2px solid #956fd6; border-radius: 10px;"/>
					</td>
				</tr>
				<tr>
					<th style="font-size: 20pt; text-align: center; background: lavender;">
						<label for="content" style="font-size: 18pt;">내용</label>
					</th>
					<td colspan="2">
						<textarea
							id="content" 
							rows="5"
							name="content"
							style="resize: none; font-size: 20pt; padding: 10px; width:650px; border: 2px solid #956fd6; border-radius: 10px;"
							></textarea>
					</td>
				</tr>
				<tr>
					<th style="font-size: 20pt; text-align: center; background: #d9ffed;">
						<label for="picture" style="font-size: 18pt;">사진 첨부</label>
					</th>
					<td colspan="2">
		        			<input id="picture" class="form-control form-control-sm" type="file" accept="image/*" name="fileName" onchange="photoView(event)" value="파일 선택"
		        				style="font-size: 15pt; color: #b49bde; width: 650px; height: 20px;"/>
					</td>
				</tr>
				<tr>
					<th style="font-size: 18pt; text-align: center; background: #ede8ff;">
						<span>미리보기</span>
					</th>
					<td colspan="2">
						<img id="output" style="max-width: 450px; max-height: 300px; margin: 20px;"/><br/>
					</td>
				</tr>
			</table>
					<div style="text-align: center;">
						<button 
							type="submit" 
							style="border: 0; background: none; cursor: pointer;">
							<span style="background: #fafcd9; font-size: 25pt;; font-weight: 800;">저장하기</span></button>&nbsp;&nbsp;&nbsp;
						<button
							type="reset" 
							style="border: 0; background: none; cursor: pointer;">
							<span style="background: #fafcd9; font-size: 25pt;; font-weight: 800;">다시쓰기</span>
						</button>&nbsp;&nbsp;&nbsp;
						<button 
							type="button" 
							style="border: 0; background: none; cursor: pointer;"
							onclick="history.back()">
							<span style="background: #fafcd9; font-size: 25pt;; font-weight: 800;">목록보기</span>
						</button>
					</div>
		</form>
	</div>
	<!-- Footer 영역 -->
	<div class="footer">
		<jsp:include page="./footerAfter.jsp"></jsp:include>
	</div>
</div>
</body>
</html>














