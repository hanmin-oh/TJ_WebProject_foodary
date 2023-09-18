<%@page import="com.foodary.vo.UserFoodList"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식단수정</title>
<!-- bootstrap -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="../js/dietUpdate.js" defer="defer"></script>
<link rel="stylesheet" href="../css/threeGrid.css"/>
<style type="text/css">
input[type='date']::before {content: attr(data-placeholder); width: 100%;}
	input[type='date']:active {content: attr(data-placeholder);}
	input[type='date'] {padding: 5px; width: 40%; width: 200px; border: 2px solid #956fd6; border-radius: 10px;}
	input[type='date']:focus::before, input[type='date']:valid::before {display: none;}
	input[type='time']::before {content: attr(data-placeholder);width: 100%;}
	input[type='time'] {padding: 5px; width: 40%; width: 200px; border: 2px solid #956fd6; border-radius: 10px;}
	input[type='time']:focus::before, input[type='time']:valid::before {display: none;}
</style>
</head>
<body onload = "showNutrient()">
	<div class="container">
		<div class="header">
		   <jsp:include page="./headerAfter.jsp"></jsp:include>
		</div>
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
			      <c:if test="${active == '다시'}">selected="selected"</c:if>>활동량 선택
			   </option>
			     <option value="1.2" name="active" 
			        <c:if test="${active == '1.2'}">selected="selected"</c:if>>많이 앉아있는 경우
			     </option>
			   <option value="1.375" name="active" 
			      <c:if test="${active == '1.375'}">selected="selected"</c:if>>앉아있는 일이 적은 경우
			   </option>
			   <option value="1.55" name="active" 
			      <c:if test="${active == '1.55'}">selected="selected"</c:if>>움직임이 많은 경우
			   </option>
			   <option value="1.725" name="active" 
			      <c:if test="${active == '1.725'}">selected="selected"</c:if>>운동 될 움직임을 할 경우
			   </option>
			   <option value="1.9" name="active" 
			      <c:if test="${active == '1.9'}">selected="selected"</c:if>>매우 많은 운동량
			   </option>
			</select>
	
			<span style="background: #fafcd9; font-size: 40pt; font-weight: 900;">Foodary 수정</span>
	      	<!-- form값으로 시간 데이터 보내기 위한 input,hidden태그 -->
			<form action="dietUpdateOK" method="post" enctype="multipart/form-data" onsubmit="return insertCheck()">
		      <div style="text-align: center;">
 				<button  type="button" onclick="openPopup()" style="background: none; border: 0; cursor: pointer;">
                   <span style="background: #baffda; font-size: 35px; font-weight: 900;">음식 검색하러 가기</span>
                </button>
		      </div>
		     <!-- 팝업창에서 추가된 음식 목록 -->
		     	<table style="width: 1000px; margin-left: auto; margin-right: auto; margin-top: 10px; " class="table table-hover table-sm">
			     <tbody id="tableBody">
			     	<tr style="background: #f7f2ff;">
			     		<th>음식 이름</th>
			     		<th>칼로리</th>
			     		<th>탄수화물</th>
			     		<th>단백질</th>
			     		<th>지방</th>
			     		<th>수정 / 삭제</th>
			     	</tr>
		       <c:set var="list" value="${userFoodList.list}"/>
		       <c:if test="${list.size() != 0}">
		       <c:forEach var="uvo" items="${list}" varStatus="status">
		       <!-- foodWriteInsert.jsp에서 request 영역에 저장한 foodList에서 1페이지 분량의 글을 꺼내온다. -->
		        <input type="hidden" id="gup" name="gup" value="${uvo.gup}"/>
			      <tr>
		           <td>
		             <input type="text" id="userFoodName_${status.index}" name="userFoodName_${status.index}" value="${uvo.foodName}"
		             	style="width:200px; border: 2px solid #956fd6; border-radius: 10px; text-align: center;"/>   
		           </td>
		           <td class="kcals" id="kcal">
		             <input type="text" id="userKcal_${status.index}" name="userKcal_${status.index}" value="${uvo.kcal}"
		             	style="width:85px; border: 2px solid #956fd6; border-radius: 10px; text-align: center;"/> kcal      
		           </td>
		           <td class="carbs">
		             <input type="text" id="userCarbs_${status.index}" name="userCarbs_${status.index}" value="${uvo.carbs}"
		             	style="width:85px; border: 2px solid #956fd6; border-radius: 10px; text-align: center;"/> g      
		           </td>
		           <td class="proteins">
		             <input type="text" id="userProtein_${status.index}" name="userProtein_${status.index}" value="${uvo.protein}"
		             	style="width:85px; border: 2px solid #956fd6; border-radius: 10px; text-align: center;"/> g      
		           </td>
		           <td class="fats">
		             <input type="text" id="userFat_${status.index}" name="userFat_${status.index}" value="${uvo.fat}"
		             	style="width:85px; border: 2px solid #956fd6; border-radius: 10px; text-align: center;"/> g    
		           </td>
		           <td align="center">
		             <button type="button" onclick="dietUpdateUserFood(${uvo.idx}, ${status.index})" style="border: 0; font-size: 25pt; background: 0;">
		                <span style="background: lavender; font-weight: 900;">수정</span>
		             </button>
		             &nbsp;
		             <button type="button" onclick="location.href='diteDeleteUserFood?idx=${uvo.idx}&gup=${uvo.gup}'"
		                style="border: 0; font-size: 25pt; background: 0;">
		               <span style="background: #fafcd9; font-weight: 900;">삭제</span>
		           </button>
		           </td>
		         </tr>
		       </c:forEach>
		       </c:if>
		     </tbody>
		   </table>
		   
		   <!-- 영양소 그래프 -->
			<table style="width: 1000px; margin-left: auto; margin-right: auto;">
			     <tr>
			     	<th style="width: 200px;">
			         <span style="background: lavender; font-size: 23pt;">칼로리</span>
			        </th>
			        <td style="height: 40px; text-align: left; width: 800px;">
			          <div class="progress" style="height: 30px; width: 700px; margin-left: auto; margin-right: auto;">
			            <div id="kcalGraph" class="progress-bar" role="progressbar" 
			            aria-valuemin="0" style="width:0%; height: 30px; font-size: 15pt; background: #8800ff;">
			            </div>
			          </div>
			        </td>   
			     </tr>
		          <tr>
			        <th style="width: 200px;">
			            <span style="background: lavender; font-size: 23pt;">탄수화물</span>
			        </th>
		          <td style="height: 40px; text-align: left; width: 800px;">
		              <div class="progress" style="height: 30px; width: 700px; margin-left: auto; margin-right: auto;">
		                <div id="carbsGraph" class="progress-bar progress-bar-info" role="progressbar" 
		                   aria-valuemin="0" style="width:0%; height: 30px; font-size: 15pt; background: #8800ff;">
		                   
		                </div>
		              </div>
		           </td>
		          </tr>
		          <tr>
		          	<th style="width: 200px;">
		                <span style="background: lavender; font-size: 23pt;">단백질</span>
		          	</th>
		           <td style="height: 40px; text-align: left; width: 800px;">
		              <div class="progress" style="height: 30px; width: 700px; margin-left: auto; margin-right: auto;">   
		                   <div id="proteinGraph" class="progress-bar progress-bar-info" role="progressbar"
		                      aria-valuemin="0" style="width:0%; height: 30px; font-size: 15pt; background: #8800ff;">
		                      
		                   </div>
		              </div>
		           </td>
		          </tr>
		        <tr>
		          <th style="width: 200px;">
		              <span style="background: lavender; font-size: 23pt;">지방</span>
		          </th>
		          <td style="height: 40px; text-align: left; width: 800px;">
		            <div class="progress" style="height: 30px; width: 700px; margin-left: auto; margin-right: auto;">
		               <div id="fatGraph" class="progress-bar progress-bar-info" role="progressbar"
		                     aria-valuemin="0" style="width:0%; height: 30px; font-size: 15pt; background: #8800ff;">
		               </div>
		            </div>
		          </td>
		    	</tr>
			  </table>
	     <table style="width: 1000px; margin-left: auto; margin-right: auto;">
	     <tr style="height: 50px;"></tr> <!-- 공백 -->
	     <!-- 시간 입력 -->
	      <tr >
        	 <td align="center" colspan="2" class="text-center">
				<span style="background: lavender; font-size: 25pt;" >날짜:</span> &nbsp;&nbsp;&nbsp;
	            <input
	             	type="date" 
	             	id="dietWriteDate"
	             	name="dietWriteDate"
	             	data-placeholder="날짜 선택"
	             	required
	  				aria-required="true"
  					value="${dvo.dietWriteDate}"
	             />
	             &nbsp;&nbsp;&nbsp;
	            <span style="background: lavender; font-size: 25pt;">시간:</span> &nbsp;&nbsp;&nbsp;
	            <input
	             	type="time"
	             	id="dietWriteDate"
	             	name="dietWriteTime"
	             	data-placeholder="시간 선택"
	             	required
	  				aria-required="true"
	  				value="${dvo.dietWriteTime}"
	            />
        	</td>
	      </tr>
	      <tr style="height: 50px;"></tr> <!-- 공백 -->
	     	<tr>
	        	<td colspan="2" class="text-center">
	            	<span style="background: lavender; font-size: 25pt; font-weight: 900;">메모</span>
	            </td>
	        </tr>
	        <tr>
	         <td colspan="2">
            	<textarea 
	               id="memo"
	               rows="5" 
	               name="dietMemo" 
	               style="resize: none; width: 70%; height: 75%; vertical-align: middle; padding: 10px;
	               			border: 2px solid #956fd6; border-radius: 30px;"
	               rows="10" 
	               name="dietMemo" 
	               	>${dvo.dietMemo}</textarea><br/><br/>
	               <input type="hidden" id="idx" name="idx" value="${dvo.idx}"/>
	         	</td>
	      </tr>
	      <tr style="height: 50px;"></tr> <!-- 공백 -->
	      <!-- 사진 첨부 -->
	     	<tr class="text-center">
				<td style="font-size: 20pt; text-align: center; width: 200px;">
					<label for="picture"><span style="background: lavender; font-size: 25pt; font-weight: 900;">사진 수정</span></label>
				</td>
				<td>
		    		<input id="picture" class="form-control form-control-sm" type="file" accept="image/*" name="fileName" onchange="photoView(event)" value="파일 선택"
		    				style="font-size: 15pt; color: #b49bde; width: 650px; height: 20px;"/>
				</td>
			</tr>
			<tr>
				<td style="font-size: 18pt; text-align: center;">
					<span style="background: lavender; font-size: 25pt; font-weight: 900;">미리보기</span>
				</td>
				<td align="left" style="padding-left: 50px;" id="photo">
					<br>
					<c:if test="${dvo.dietPicture ne 'no picture'}">
						<img id="output" src="/upload/diet/${dvo.dietPicture}" style="max-width: 450px; max-height: 300px;">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button id="deleteBtn" type="button" onclick="photoDelete()" style="background: none; border: 0; cursor: pointer;">
							<span style="background: #baffda; font-size: 30px; font-weight: 900;">사진 삭제</span>
						</button>
					</c:if>
					<img id="output" style="max-width: 450px; max-height: 300px; margin: 20px;"/><br/>
				</td>
			</tr>
	     </table>
	   </div>
	   <br>
	   <!-- 식단 최종 저장버튼 -->
       <div class="text-center">
		<button type="submit" style="background: none; border: 0; cursor: pointer;">
         	<span style="background: #fafcd9; font-size: 30pt; font-weight: 900;">수정하기</span>
        </button>
         &nbsp;&nbsp;&nbsp;&nbsp;
        <button type="button" style="background: none; border: 0; cursor: pointer;" onclick="history.back()">
        	<span style="background: #fafcd9; font-size: 30pt; font-weight: 900;">돌아가기</span>
        </button>
       </div>
	     	<input type="hidden" value="${rvo.id}" id="id" name="id"/>
	     	<input id="dietPictuer" type="hidden" name="dietPicture" value="${dvo.dietPicture}"/>
	      </form>
	</div>
   <div class="footer">
      <jsp:include page="./footerAfter.jsp"></jsp:include>
   </div>
</body>
</html>