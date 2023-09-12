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
<script type="text/javascript" src="../js/freeInsert.js"></script>
<script defer type="text/javascript" src="../js/FreeboardUpload.js"></script>
</head>
<body>
   ${javascriptCode}
<div class="container">
	<!-- 헤더 영역 -->
	<div class="header">
		<jsp:include page="./headerAfter.jsp"></jsp:include>
	</div>
	<!-- 중간영역 -->
	<div class="main">
	<br/><br/>
		<form action="insertOK" method="post" enctype="multipart/form-data" onsubmit="return insertCheck()">
			<table cellpadding="5" cellspacing="20" style="width: 700px; margin-left: auto; margin-right: auto; vertical-align: middle;">
				<tr>
					<th colspan="4" style="text-align: center;"><span style="background: #baffda; font-size: 45px;"><아무 말이나 끄적여 보세요></span></th>
				</tr>
				<!-- 이름입력 -->
				<tr>
					<th width="250" style="font-size: 20pt;">
						<label for="name">이름 :</label>
					</th>
					<td width="450" style="font-size: 20pt;">
						<input 
							id="name"
							type="text" 
							name="name"
							value="${rvo.username}"
							style="width: 200px; padding: 5px;" readonly="readonly"/>
					</td>
					<!-- 공지여부 -->
					<th width="100" style="text-align: center; font-size: 20pt;">
						공지글 : &nbsp; <input type="checkbox" name="notice"/>
					</th>
				</tr>
				<!-- hidden으로 id넘기기 -->
					<input id="id" type="hidden" name="id" value="${rvo.id}" style="width: 200px;"/>
					<tr>
					<th>
						<label for="subject" style="font-size: 20pt;">제목 :</label>
					</th>
					<td colspan="2">
						<input id="subject" type="text" name="subject" style="font-size: 20pt; padding: 5px; width:450px;"/>
					</td>
				</tr>
			   <tr>
		            <td align="center">
		 				<button  type="button" onclick="openPopup()" style="background: none; border: 0; cursor: pointer;">
		                   <span style="background: #baffda; font-size: 35px; font-weight: 900;">음식 불러오기</span>
		                </button>
		            </td>
         		</tr>
         		<tr>
         			<td><span style="background: lavender; font-size: 25pt;">음식 이름</span> :&nbsp; </td>
         		     <c:forEach var="UserFood" items="${userFoodList}">
                	<td>
		                    <input type="text" id="userFoodName_${status.index}" name="userFoodName_${status.index}" value="${UserFood.foodName}" 
		                    style="width: 20%; height: 50%; text-align: center;" readonly="readonly"/>      
		                    <input type="text" id="userFoodName_${status.index}" name="userFoodName_${status.index}" value="${UserFood.foodName}" 
		                   readonly="readonly"/>      
		            <input type="text" id="gup" name="gup" value="${UserFood.gup}"/>
		            </td>
	                </c:forEach>
                </tr> 
				<tr>
					<th>
						<label for="content" style="font-size: 20pt;">내용</label>
					</th>
					<td colspan="2">
						<textarea
							id="content" 
							rows="10"
							name="content"
							style="resize: none; font-size: 20pt; padding: 10px; width:450px;"></textarea>
					</td>
					  <!-- 음식검색 팝업창 띄우는 버튼 -->
				</tr>
				<tr>
					<th>
						<label for="subject" style="font-size: 20pt;">사진 첨부 :</label>
					</th>
					<td colspan="2">
		        		<input type="file" accept="image/*" name="fileName" onchange="photoView(event)" value="파일 선택"
		        			style="font-size: 20pt;"/>
						<img id="output" style="max-width: 450px; max-height: 300px;"/><br/>
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center">
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
					</td>
				</tr>
			</table>
		</form>
		<br/><br/>
	</div>
	<!-- Footer 영역 -->
	<div class="footer">
		<jsp:include page="./footerAfter.jsp"></jsp:include>
	</div>
</div>
</body>
</html>














