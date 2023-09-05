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
<title>음식목록</title>
<!-- bootstrap -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="../js/foodWrite.js" defer="defer"></script>
<link rel="stylesheet" href="../css/threeGrid.css"/>
</head>
<!-- <body onload = "showNutrient()"> -->
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

	<span style="background: #fafcd9; font-size: 50pt; font-weight: 900;">푸드어리 쓰기</span>
      <form action="dietInsert" method="post">
      <!-- form값으로 시간 데이터 보내기 위한 input,hidden태그 -->
      <div class="diet">
      <table width="1400" align="center" border="0" cellpadding="10" cellspacing="10">
      	
         <!-- 1 -->
         <tr>
            <td align="center">
             <!-- <button  type="button" onclick="foodList()">검색</button>  -->
            <button  type="button" onclick="openPopup()" style="background: none; border: 0; cursor: pointer;">
                   <span style="background: #baffda; font-size: 35px; font-weight: 900;">음식 검색하러 가기</span>
                </button>
            </td>
         </tr>
       </table>
             <!-- 2 -->
        <table width="1400" align="center" border="0" cellpadding="0" cellspacing="10">
         <tbody id="tableBody">
         <c:if test="${not empty foodNames}">
         <c:forEach var="index" begin="0" end="${fn:length(foodNames) - 1}">
	        <input type="hidden" id="id" name="id" value="${rvo.id}"/>
           <tr>
            <td>
               <input type="text" id="dietFoodName" name="dietFoodName" value="${foodNames[index]}" style="border: 0; font-size: 25pt; width: 150px; font-weight: 900;"/>
            </td>
            <td>
              <span style="background: lavender; font-size: 25pt;">칼로리:</span>
            </td>
            <td>
               <input type="text" id="dietKcal" name="dietKcal" value="${kcals[index]}" style="border: 0; font-size: 25pt; width: 80px;"/> kcal  
            </td>
            <td>
                <span style="background: lavender; font-size: 25pt;">탄수화물:</span>
            </td>
            <td>
               <input type="text" id="dietCarbs" name="dietCarbs" value="${carbss[index]}" style="border: 0; font-size: 25pt; width: 80px;"/> g   
            </td>
            <td>
               <span style="background: lavender; font-size: 25pt;">단백질:</span>
            </td>
            <td>
              <input type="text" id="dietProtein" name="dietProtein" value="${proteins[index]}" style="border: 0; font-size: 25pt; width: 80px;"/> g     
            </td>
            <td>
                <span style="background: lavender; font-size: 25pt;">지방:</span>
            </td>
            <td>
               <input type="text" id="dietFat" name="dietFat" value="${fats[index]}" style="border: 0; font-size: 25pt; width: 80px;"/> g     
            </td>
           <td align="center">
         <button type="button" onclick="foodPlus(<c:out value='${index}'/>)" style="border: 0; font-size: 25pt; background: 0;">
             <span style="background: #fafcd9; font-size: 25pt; font-weight: 900;">추가</span>
         </button> 
         </td>
         </tr>
         </c:forEach>
       </c:if>
       <c:if test="${empty foodNames}">
        <tr>
        </tr>
      </c:if>
       </tbody>
       </table>
         <!-- 3 -->
     <table width="1400" align="center" border="0" cellpadding="10" cellspacing="10">
     <tbody id="tableBody">
       <fmt:requestEncoding value="UTF-8"/>
       <!-- foodWriteInsert.jsp에서 request 영역에 저장한 foodList에서 1페이지 분량의 글을 꺼내온다. -->
       <c:set var="list" value="${userFoodList.list}"/>
       <c:if test="${list.size() != 0}">
       <c:forEach var="uvo" items="${list}" varStatus="status">
         <tr>
           <td>
             <input type="text" id="userFoodName_${status.index}" name="userFoodName_${status.index}" value="${uvo.foodName}"
             	style="border: 1; font-size: 25pt; width: 200px; font-weight: 900; height: 45px;"/>   
           </td>
           <td>
               <span style="background: lavender; font-size: 25pt;">칼로리:</span>
           </td>
           <td class="kcals" id="kcal">
             <input type="text" id="userKcal_${status.index}" name="userKcal_${status.index}" value="${uvo.kcal}"
             	style="border: 1; font-size: 25pt; width: 80px; height: 45px;"/> kcal      
           </td>
           <td>
                <span style="background: lavender; font-size: 25pt;">탄수화물:</span>
           </td>
           <td class="carbs">
             <input type="text" id="userCarbs_${status.index}" name="userCarbs_${status.index}" value="${uvo.carbs}"
             	style="border: 1; font-size: 25pt; width: 80px; height: 45px;"/> g      
           </td>
           <td>
            <span style="background: lavender; font-size: 25pt;">단백질:</span>
           </td>
           <td class="proteins">
             <input type="text" id="userProtein_${status.index}" name="userProtein_${status.index}" value="${uvo.protein}"
             	style="border: 1; font-size: 25pt; width: 80px; height: 45px;"/> g      
           </td>
           <td>
              <span style="background: lavender; font-size: 25pt;">지방:</span>
           </td>
           <td class="fats">
             <input type="text" id="userFat_${status.index}" name="userFat_${status.index}" value="${uvo.fat}"
             	style="border: 1; font-size: 25pt; width: 80px; height: 45px;"/> g    
           </td>
           <td align="center">
             <button type="button" onclick="updateUserFood(${uvo.idx}, ${status.index})" style="border: 0; font-size: 25pt; background: 0;">
                <span style="background: lavender; font-size: 35px; font-weight: 900;">수정</span>
             </button>
             &nbsp;
             <button type="button" onclick="location.href='deleteFood?idx=${uvo.idx}'"
                style="border: 0; font-size: 25pt; background: 0;">
               <span style="background: #fafcd9; font-size: 25pt; font-weight: 900;">삭제</span>
           </button>
           </td>
         </tr>
       </c:forEach>
       </c:if>
     </tbody>
   </table>
       <table width="1400" align="center" border="0" cellpadding="10" cellspacing="10">
      <!-- 4 -->
     <tr style="height: 50px;"></tr>
           <!-- 시간 입력 -->
      <tr>
         <td align="center">
			<span style="background: lavender; font-size: 30pt;">날짜:</span> &nbsp;&nbsp;&nbsp;
             <input type="date" id="dietWriteDate" name="dietWriteDate" style="width: 43%; width: 400px;"/> &nbsp;&nbsp;&nbsp;
             <span style="background: lavender; font-size: 30pt;">시간:</span> &nbsp;&nbsp;&nbsp;
             <input type="time" id="dietWriteDate" name="dietWriteTime" style="width: 43%; width: 400px;"/> <br>
         </td>
      </tr>
      <tr>
         <td colspan="2" class="text-center">
            <span style="background: lavender; font-size: 30pt;">메모</span>
      <tr>
         <td colspan="12">
            <textarea 
               id="memo"
               rows="5" 
               name="dietMemo" 
               style="resize: none; width: 80%; height: 75%; vertical-align: middle; padding: 10px;"
               rows="10" 
               name="dietMemo" 
               style="resize: none; width: 97%; height: 75%; vertical-align: middle;"
               ></textarea>
         </td>
      </tr>
      <!-- 5 -->
      <tr style="display: none;">
         <td colspan="3" class="text-center">
            <label for="totalcalorie">사진첨부</label>
         </td>
         <td colspan="10" align="center">
            <input type="text" id="province" name="province" placeholder="사진파일명" style="width: 95%;"/>   
         </td>   
         <td align="center">
           <input type="button" value="파일선택" onclick="location.href='showDiet.jsp'"/>
         </td>
      </tr>
       </table>
   </div>
       <!-- 6 -->
        <!-- 6 -->
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
           <!-- 7 -->
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
          <!-- 8 -->
          <tr>
             <td class="text-center">
                <button type="submit" style="background: none; border: 0; cursor: pointer;">
                	 <span style="background: #fafcd9; font-size: 30pt; font-weight: 900;">저장하기</span>
                </button>
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