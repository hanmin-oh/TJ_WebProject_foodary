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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body onload = "showNutrient()">
<div class="main" style="text-align: center;" align="center">
<input id="id" type="hidden" name="id" value="${rvo.id}"/>
<input id="height" type="hidden" name="height" value="${rvo.height}">
<input id="currentWeight" type="hidden" name="currentWeight" value="${rvo.currentWeight}">
<input id="goalWeight" type="hidden" name="goalWeight" value="${rvo.goalWeight}">
<input id="age" type="hidden" name="age" value="${rvo.age}">
<input id="gender" type="hidden" name="gender" value="${rvo.gender}"/>
<c:if test="${rvo.state eq 'health'}">
    <input id="health" type="radio" name="mode" value="health" checked="checked" style="display: none;"/>
    <input id="diet" type="radio" name="mode" value="diet" style="display: none;"/>
</c:if>
<c:if test="${rvo.state eq 'diet'}">
    <input id="health" type="radio" name="mode" value="health" style="display: none;"/>
    <input id="diet" type="radio" name="mode" value="diet" checked="checked" style="display: none;"/>
</c:if>
<c:set var="active" value="${rvo.active}"/>
<select name="active" style="height: 40px; display: none;">
   <option value="다시" name="active" 
      <c:if test="${active == '다시'}">selected="selected"
      </c:if>>활동량 선택
   </option>
     <option value="1.2" name="active" 
        <c:if test="${active == '1.2'}">selected="selected"
        </c:if>>많이 앉아있는 경우
     </option>
   <option value="1.375" name="active" 
      <c:if test="${active == '1.375'}">selected="selected"
      </c:if>>앉아있는 일이 적은 경우
   </option>
   <option value="1.55" name="active" 
      <c:if test="${active == '1.55'}">selected="selected"
      </c:if>>움직임이 많은 경우
   </option>
   <option value="1.725" name="active" 
      <c:if test="${active == '1.725'}">selected="selected"
      </c:if>>운동 될 움직임을 할 경우
   </option>
   <option value="1.9" name="active" 
      <c:if test="${active == '1.9'}">selected="selected"
      </c:if>>매우 많은 운동량
   </option>
</select>
   ${javascriptCode}
</div>
<div class="container">
	<!-- 헤더 영역 -->
	<div class="header">
		<jsp:include page="./headerAfter.jsp"></jsp:include>
	</div>
	<!-- 중간영역 -->
	<div class="main">
		<form action="insertOK" method="post" enctype="multipart/form-data" onsubmit="return insertCheck()">
			<table class="table table-sm"
				style="width: 1000px; margin-left: auto; margin-right: auto; vertical-align: middle; border: 1px solid #bfbfbf;">
				<!-- 이름입력 -->
				<tr>
					<th width="200" style="font-size: 20pt; text-align: center; background: lavender;">
						<label for="name">이름</label>
					</th>
					<td style="font-size: 20pt;">
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
		            <td align="center" colspan="3">
		 				<button  type="button" onclick="openPopup()" style="background: none; border: 0; cursor: pointer;">
		                   <span style="background: #baffda; font-size: 35px; font-weight: 900;">음식 불러오기</span>
		                </button>
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
         		<tr>
         		<c:if test="${!shareDietList.isEmpty()}">
 				<table style="width: 1000px; margin-left: auto; margin-right: auto; margin-top: 10px;" class="table table-hover table-sm">
			    <c:set var="previousDate" value="" />
			    <c:set var="previousTime" value="" />
			    <c:forEach items="${shareDietList}" var="svo" varStatus="status">
			    <tr>
			    	   <c:if test="${!svo.dietDate.equals(previousDate)}">
			            <tr>
			                <td colspan="7" style="background: #f7f2ff;">
			                    ${svo.dietDate}
			                </td>
			            </tr>
			        </c:if>
			    </tr>
			     <tr>
			        	<c:if test="${!svo.dietTime.equals(previousTime)}">
			        <th style="text-align: center; vertical-align: middle; background: #888dff;">시간</th>
			                <th>
			                    ${svo.dietTime}
			                </th>
		                  <tr>
					        <th>음식 이름</th>
					        <th>칼로리</th>
					        <th>탄수화물</th>
					        <th>단백질</th>
					        <th>지방</th>
					    </tr>
			            </c:if>
			       </tr>
			 
			       <c:if test="${!svo.dietTime.equals(previousTime)}">
			    </c:if>
			        <tr>
			            <th>
			                <input type="text" id="foodName_${status.index}" name="foodName_${status.index}" value="${svo.foodName}" 
			                	style="border: none; width: 100%; height: 50%; text-align: center;" readonly="readonly"/>
			            </th>
			            <th class="kcals" id="kcal">
			                <input type="text" id="kcal_${status.index}" name="kcal_${status.index}" value="${svo.kcal}" 
			                	style="border: none; width: 30%; height: 50%; text-align: center;" readonly="readonly"/> kcal
			            </th>
			            <th>
			                <input type="text" id="carbs_${status.index}" name="carbs_${status.index}" value="${svo.carbs}" 
			                	style="border: none; width: 30%; height: 50%; text-align: center;" readonly="readonly"/> g
			            </th>
			            <th>
			                <input type="text" id="protein_${status.index}" name="protein_${status.index}" value="${svo.protein}" 
			                	style="border: none; width: 30%; height: 50%; text-align: center;" readonly="readonly"/> g
			            </th>
			            <th>
			                <input type="text" id="fat_${status.index}" name="fat_${status.index}" value="${svo.fat}" 
			                	style="border: none; width: 30%; height: 50%; text-align: center;" readonly="readonly"/> g
			            </th>
			        <c:set var="previousDate" value="${svo.dietDate}" />
			        <c:set var="previousTime" value="${svo.dietTime}" />
			    </c:forEach>
			</table>
			        </tr>
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














