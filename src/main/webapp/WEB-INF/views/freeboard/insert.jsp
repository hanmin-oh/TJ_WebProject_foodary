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
<<<<<<< HEAD
	<br/><br/>
		<form action="insertOK" method="post" enctype="multipart/form-data" onsubmit="return insertCheck()">
			<table cellpadding="5" cellspacing="20" style="width: 700px; margin-left: auto; margin-right: auto; vertical-align: middle;">
				<tr>
					<th colspan="4" style="text-align: center;"><span style="background: #baffda; font-size: 45px;"><아무 말이나 끄적여 보세요></span></th>
				</tr>
=======
		<form action="insertOK" method="post" enctype="multipart/form-data" onsubmit="return insertCheck()">
			<table class="table table-sm"
				style="width: 800px; margin-left: auto; margin-right: auto; vertical-align: middle; border: 1px solid #bfbfbf;">
>>>>>>> 370244fb95e8ea81ec8105779759cadf1c02ca29
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
					<th width="100" style="text-align: center; font-size: 20pt; background: #d9ffed;">
						공지글 : &nbsp;<input type="checkbox" name="notice" style="accent-color: #7a33ff;"/>
					</th>
				</tr>
				<!-- hidden으로 id넘기기 -->
				<input id="id" type="hidden" name="id" value="${rvo.id}"/>
				<tr>
					<th style="font-size: 20pt; text-align: center;  background: #d9ffed;">
						<label for="subject" style="font-size: 20pt;">제목</label>
					</th>
					<td colspan="2">
						<input id="subject" type="text" name="subject"
							style="font-size: 18pt; padding: 5px; width:650px; border: 2px solid #956fd6; border-radius: 10px;"/>
					</td>
				</tr>
<<<<<<< HEAD
			   <tr>
		            <td align="center">
		 				<button  type="button" onclick="openPopup()" style="background: none; border: 0; cursor: pointer;">
		                   <span style="background: #baffda; font-size: 35px; font-weight: 900;">음식 불러오기</span>
		                </button>
		            </td>
         		</tr>
         		<tr> 
			<tr>
			${shareDietList}
         		<c:if test="${vo.gup != null}">
 				<c:forEach items="${shareDietList}" var="svo" varStatus="status">
			   <tr>
			      <th class="kcals" id="kcal"><span style="background: lavender; font-size: 25pt;">음식 이름</span> :&nbsp; 
			         <input type="text" id="userFoodName_${status.index}" name="userFoodName_${status.index}" value="${svo.foodName}" style="width: 50%; height: 50%; text-align: center;" readonly="readonly"/>      
			      </th>
			      <th><span style="background: lavender; font-size: 25pt;">칼로리</span> :&nbsp; 
			         <input type="text" id="userKcal_${status.index}" name="userKcal_${status.index}" value="${svo.kcal}" style="width: 30%; height: 50%; text-align: center;" readonly="readonly"/> &nbsp;kcal 
			      </th>
			      <th><span style="background: lavender; font-size: 25pt;">탄수화물</span> :&nbsp; 
			         <input type="text" id="userCarbs_${status.index}" name="userCarbs_${status.index}" value="${svo.carbs}" style="width: 30%; height: 50%; text-align: center;" readonly="readonly"/> &nbsp;g
			      </th>
			      <th><span style="background: lavender; font-size: 25pt;">단백질</span> :&nbsp; 
			         <input type="text" id="userProtein_${status.index}" name="userProtein_${status.index}" value="${svo.protein}" style="width: 30%; height: 50%; text-align: center;" readonly="readonly"/> &nbsp;g  
			      </th>
			      <th><span style="background: lavender; font-size: 25pt;">지방</span> :&nbsp; 
			         <input type="text" id="userFat_${status.index}" name="userFat_${status.index}" value="${svo.fat}" style="width: 30%; height: 50%; text-align: center;" readonly="readonly"/> &nbsp;g
			      </th>
			   </tr>
			   </c:forEach>
		   <!-- 영양소 그래프 -->
		    <table width="1400" align="center" border="0" cellpadding="10" cellspacing="10">
		    <tr style="height: 30px;"></tr>
		     <tr>
		        <td style="height: 40px; text-align: left;">
                 <span style="background: lavender; font-size: 25pt; margin-left: 300px;"><칼로리></span>
                 <div class="progress" style="height: 40px; width: 800px; margin-left: auto; margin-right: auto;">
                   <div id="kcalGraph" class="progress-bar" role="progressbar" 
                   aria-valuemin="0" style="width:0%; height: 40px; font-size: 18pt; background: #8800ff;">
                   </div>
                 </div>
               </td>   
            </tr>
           <!-- 5 -->
           <tr style="height: 30px;"></tr>
            <tr>
             <td style="height: 40px; text-align: left;">
                <span style="background: lavender; font-size: 25pt; margin-left: 300px;"><탄수화물></span>
                <div class="progress" style="height: 40px; width: 800px; margin-left: auto; margin-right: auto;">
                  <div id="carbsGraph" class="progress-bar progress-bar-info" role="progressbar" 
                     aria-valuemin="0" style="width:0%; height: 40px; font-size: 18pt; background: #8800ff;">
                     
                  </div>
                </div>
             </td>
            </tr>
            <tr style="height: 30px;"></tr>
            <tr>
             <td style="height: 40px; text-align: left;">
                  <span style="background: lavender; font-size: 25pt; margin-left: 300px;"><단백질></span>
                <div class="progress" style="height: 40px; width: 800px; margin-left: auto; margin-right: auto;">   
                     <div id="proteinGraph" class="progress-bar progress-bar-info" role="progressbar"
                        aria-valuemin="0" style="width:0%; height: 40px; font-size: 18pt; background: #8800ff;">
                        
                     </div>
                </div>
             </td>
            </tr>
            <tr style="height: 30px;"></tr>
            <tr>
             <td style="height: 40px; text-align: left;">
                   <span style="background: lavender; font-size: 25pt; margin-left: 300px;"><지방></span>
                <div class="progress" style="height: 40px; width: 800px; margin-left: auto; margin-right: auto;">
                     <div id="fatGraph" class="progress-bar progress-bar-info" role="progressbar"
                        aria-valuemin="0" style="width:0%; height: 40px; background: #8800ff;">
                     </div>
                </div>
             </td>
		    </tr>
		    </table>
			</tr>
			</c:if>
                </tr> 
=======
>>>>>>> 370244fb95e8ea81ec8105779759cadf1c02ca29
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














