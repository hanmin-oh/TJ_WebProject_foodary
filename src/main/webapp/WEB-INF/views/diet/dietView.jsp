<%@page import="com.foodary.vo.DietList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>푸드어리 보기</title>
<script type="text/javascript" src="../js/dietView.js" defer="defer"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/threeGrid.css"/>
<script type="text/javascript" src="../js/jquery-3.7.0.js"></script>
</head>
<body onload = "showNutrient()">
<div class="container">
   <div class="header">
      <jsp:include page="./headerAfter.jsp"></jsp:include>
   </div>
	<div class="main" align="center" style="text-align: center;">
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
		<form action="dietUpdateView" method="post">
	   		<span style="background: #baffda; font-size: 35pt; font-weight: 900;">${dvo.dietWriteDate} &nbsp;${dvo.dietWriteTime} &nbsp;Foodary</span>
            <input type="hidden" id="dietWriteTime" name="dietWriteTime" value="${dvo.dietWriteTime}" />
           	<input	type="hidden" id="dietWriteDate" name="dietWriteDate" value="${dvo.dietWriteDate}"  />
            <input	type="hidden" id="id" name="id" value="${dvo.id}"  />
            <input	type="hidden" id="idx" name="idx" value="${dvo.idx}"  />
            <input	type="hidden" id="gup" name="gup" value="${dvo.gup}"  />
			<c:set var="list" value="${userFoodList.list}"/>
			
			 <table style="width: 1000px; margin-left: auto; margin-right: auto; margin-top: 10px; " class="table table-hover table-sm">
				   <tr style="background: #f7f2ff;">
			     		<th>음식 이름</th>
			     		<th>칼로리</th>
			     		<th>탄수화물</th>
			     		<th>단백질</th>
			     		<th>지방</th>
			     	</tr>
				   
				   <c:forEach var="uvo" items="${list}" varStatus="status">
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
				   </tr>
				   </c:forEach>
				  </table>

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
				   <!-- 3 -->
				     <!-- 내용 입력 부분 -->
				  <table style="width: 1000px; margin-left: auto; margin-right: auto;">
				  	<tr style="height: 50px;"></tr> <!-- 공백 -->
				     	<tr>
				        	<td class="text-center">
				            	<span style="background: lavender; font-size: 25pt;">메모</span>
				            </td>
				        </tr>
				      	<tr>
				        	<td >
				            	<textarea 
					               id="memo"
					               rows="5" 
					               name="dietMemo" 
					               style="resize: none; width: 70%; height: 75%; vertical-align: middle; padding: 10px;
					               			border: 2px solid #956fd6; border-radius: 30px;"
					               rows="10" 
					               name="dietMemo" 
					               readonly="readonly"
					               >${dvo.dietMemo}</textarea>
				         	</td>
				     	</tr>
				     	<tr style="height: 50px;"></tr> <!-- 공백 -->
				      	<!-- 사진 첨부 -->
					   	<tr class="text-center">
					   		<td>
								<c:if test="${dvo.dietPicture ne 'no picture'}">
									<img src="../upload/diet/${dvo.dietPicture}" style="max-width: 450px; max-height: 300px;">
								</c:if>
							</td>
						</tr>
				      <tr style="height: 20px;"></tr> <!-- 공백 -->
				     </table>
				     
				   <div>
				        <button
				            type="submit" 
				            style="background: none; border: 0; cursor: pointer;"
				         >
							<span style="background: #fafcd9; font-size: 25pt; font-weight: 900;">수정하기</span>
				         </button>&nbsp;&nbsp;
				         <button 
				            type="button"
				            style="background: none; border: 0; cursor: pointer;"
				            onclick="deleteOK()">
				            <span style="background: #fafcd9; font-size: 25pt; font-weight: 900;">삭제하기</span>
				            </button>&nbsp;&nbsp;
				         <button
				            type="button" 
				            onclick="location.href='dietListView?dietWriteDate=${dvo.dietWriteDate}&id=${rvo.id}'" 
				             style="background: none; border: 0; cursor: pointer;">
				            <span style="background: #fafcd9; font-size: 25pt; font-weight: 900;">목록보기</span>
				         </button>&nbsp;&nbsp;
				   </div>
			</form>
	</div>
   <div class="footer">
      <jsp:include page="./footerAfter.jsp"></jsp:include>
   </div>
  </div>
</body>
</html>