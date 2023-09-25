<%@page import="com.foodary.vo.UserRegisterVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 회원정보</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="../css/fourGrid.css"/>
<script type="text/javascript" src="../js/jquery-3.7.0.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script type="text/javascript" src="../js/updateMypage.js"></script>
<script type="text/javascript" src="../js/updateMyCal.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload = "showNutrient()">
<c:if test="${not empty msg}">
	<script type="text/javascript">
		alert('${msg}')
	</script>
</c:if>
<div class="container">
	<div class="header">
	   <jsp:include page="./headerAfter.jsp"></jsp:include>
	</div>
	<div class="mainLeft" style="padding-left: 40px;">
	   <form action="userInfoUpdate" method="post">
	   <input type="hidden" name="idx" value="${rvo.idx}">
	     <div align="center" style="display: inline;">
	         <table width="600" height="450" cellpadding="20" cellspacing="20" style="margin-top: 30px;">
	            <tr>
	               <th style="text-align: right; font-size: 20pt;">이름 : &nbsp;</th>
	               <td>
	               		<input id="name" type="text" name="username" autocomplete="off" value="${rvo.username}"
	               			style="font-size: 20pt; width: 200px; padding-left:10px; border-radius: 10px; border: 3px solid #e1d1ff;"/>
	               </td>
	            </tr>
	            <tr>
	               <th style="text-align: right; font-size: 20pt;">성별 : &nbsp;</th>
	               <td>
	                  <input id="gender" type="text" name="gender" value="${rvo.gender}" readonly="readonly"
	                 	 style="font-size: 20pt; width: 100px; border: 0;"/>
	               </td>
	            </tr>
	            <tr>
	               <th style="text-align: right; font-size: 20pt;">아이디 : &nbsp;</th>
	               <td>
	                  <input id="id" type="text" name="id" autocomplete="off" value="${rvo.id}"
	                  	style="font-size: 20pt; border: 0;" readonly="readonly"/>
	               </td>
	            </tr>
	            <tr>
	               <th style="text-align: right; font-size: 20pt;">비밀번호 : &nbsp;</th>
	               <td>	
	                  <button id="passwordUpdate" type="button"
	                  	onclick="location.href='passwordUpdate?id=${rvo.id}&username=${rvo.username}&password=${rvo.password}&idx=${rvo.idx}'" style="width: 100px; border: 0; background: none; cursor: pointer;">
	                  	<span style="font-size: 20pt; background: #baffda; font-weight: 800;">비밀번호 수정</span>
	                  </button>
	               </td>
	            </tr>
	            <tr>
	               <th style="text-align: right; font-size: 20pt;">이메일 : &nbsp;</th>
	               <td>
	                  <input id="email" type="email" name="email" autocomplete="off" value="${rvo.email}"
	                  	style="font-size: 20pt; width: 350px; padding-left:10px; border-radius: 10px; border: 3px solid #e1d1ff;"/>
	               </td>
	            </tr>
	            <tr style="height: 60px;"></tr>
	           <tr>
	                <td colspan="2" style="text-align: center; padding-right: 70px;">
	                  <button id="updateBtn" type="submit" style="border: 0; background: none; cursor: pointer;">
	                  		<span style="font-size: 25pt; background: #fafcd9; font-weight: 800;">정보 수정</span>
	                  	</button>&nbsp;&nbsp;&nbsp;&nbsp;
	                  <button type="button" onclick="location.href='unregister?id=${rvo.id}&username=${rvo.username}&password=${rvo.password}&idx=${rvo.idx}'" style="border: 0; background: none; cursor: pointer;">
	                  	<span style="font-size: 25pt; background: #fafcd9; font-weight: 800;">회원 탈퇴</span>
	                  </button>
	                </td>
	           </tr>
	      </table>
	   </div>
	  </form>
	</div>
	
	  <div class="mainRight" style="padding-top: 50px; padding-left: 30px;">
		<div style="display: inline;">
			<form action="userKcalUpdate" method="post">
			   <div style="text-align: center; display: inline-block; font-size: 20pt;" align="center">
			      키 : <input id="height" type="text" name="height" value="${rvo.height}"
			      style="width: 50px; text-align: center; border-radius: 10px; border: 3px solid #e1d1ff; font-size: 20pt;"> cm&nbsp;&nbsp;
			      현재 체중 : <input id="currentWeight" type="text" name="currentWeight" value="${rvo.currentWeight}"
			      style="width: 50px; text-align: center; border-radius: 10px; border: 3px solid #e1d1ff; font-size: 20pt;"> kg&nbsp;&nbsp;
			      목표 체중 : <input id="goalWeight" type="text" name="goalWeight" value="${rvo.goalWeight}"
			      style="width: 50px; text-align: center; border-radius: 10px; border: 3px solid #e1d1ff; font-size: 20pt;"> kg&nbsp;&nbsp;
			      만 나이: <input id="age" type="text" name="age" value="${rvo.age}"
			      style="width: 50px; text-align: center; border-radius: 10px; border: 3px solid #e1d1ff; font-size: 20pt;"/> 세
			   <br/><br/>
		         Mode : 
		         <c:if test="${rvo.state eq 'health'}">
		             <input id="health" type="radio" name="mode" value="health" checked="checked"/> 건강한 삶&nbsp; &nbsp;
		             <input id="diet" type="radio" name="mode" value="diet"/> 목표달성!
		         </c:if>
		         <c:if test="${rvo.state eq 'diet'}">
		             <input id="health" type="radio" name="mode" value="health" style="accent-color: #7a33ff;"/> 건강한 삶&nbsp; &nbsp;
		             <input id="diet" type="radio" name="mode" value="diet" checked="checked" style="accent-color: #7a33ff;"/> 목표달성!
		         </c:if>
		        &nbsp;&nbsp;/&nbsp;&nbsp;
		 
			      활동량 :
			      <c:set var="active" value="${rvo.active}"/>
			      <select name="active" style="height: 40px; border-radius: 10px; border: 3px solid #e1d1ff;">
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
		  		</div>
		  		<br/>
				<br/>
			   <div align="left">
			   <table width="300" cellpadding="20" cellspacing="20" align="center" style="margin-left: 150px;">
			      <tr style="text-align: center;">
			         <th>칼로리</th>
			         <td>
			            <input id="kcal" type="text" name="kcal" autocomplete="off" style="width: 50px; text-align: center;  border: 0"/> kcal
			         </td>
			      </tr>
			      <tr style="text-align: center;">
			         <th>탄수화물</th>
			         <td>
			            <input id="carbs" type="text" name="carbs" autocomplete="off" style="width: 50px; text-align: center;  border: 0"/> g
			         </td>
			      </tr>
			      <tr style="text-align: center;">
			         <th>단백질</th>
			         <td>
			            <input id="protein" type="text" name="protein" autocomplete="off" style="width: 50px; text-align: center;  border: 0"/> g
			         </td>
			      </tr>
			      <tr style="text-align: center;">
			         <th>지방</th>
			         <td>
			            <input id="fat" type="text" name="fat" autocomplete="off" style="width: 50px; text-align: center;  border: 0"/> g
			         </td>
			      </tr>
			   </table>
			   <br/>
			      <button style="align-content: center; border: 0; background: none; cursor: pointer; margin-left: 250px;" type="submit">
			      	<span style="font-size: 25pt; background: #fafcd9; font-weight: 800;">정보 수정</span>
			      </button>
			   </div>
		   		<input type="hidden" name="id" value="${rvo.id}"/>
		   		<input type="hidden" name="idx" value="${rvo.idx}">
			</form>
		</div>
	</div>
	<div class="footer">
	   <jsp:include page="./footerAfter.jsp"></jsp:include>
	</div>
</div>
</body>
</html>