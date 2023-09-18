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
<script type="text/javascript" src="../js/dietViewAll.js" defer="defer"></script>
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

         <span style="background: #fafcd9; font-size: 35pt; font-weight: 900;">${dietWriteDate} Foodary</span>
         <br>
         <span style="background: #baffda; font-size: 25pt; font-weight: 900;">전체 영양소 섭취량</span>
      <div class="diet">
         <form action="dietUpdate" method="post">
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
              <br>
               <c:set var="list" value="${userFoodList.list}"/><!-- 해당 시간대만 -->
               <table style="width: 1000px; margin-left: auto; margin-right: auto; margin-top: 10px; " class="table table-sm">
          <c:forEach var="diet" items="${selectDietList}">
                  <tr>
                    <th colspan="5">
                       <button type="button" style="background: none; border: 0; cursor: pointer; font-weight: 900;"
                          onclick="location.href='dietView?dietWriteDate=${diet.dietWriteDate}&dietWriteTime=${diet.dietWriteTime}&id=${rvo.id}'">
                           <span style="background: lavender; font-size: 30pt;">${diet.dietWriteTime} Foodary</span>
                       </button>
                    </th>
                  </tr>
               <tr style="background: #ffffed;">
                    <th>음식 이름</th>
                    <th>칼로리</th>
                    <th>탄수화물</th>
                    <th>단백질</th>
                    <th>지방</th>
                </tr>
             <!-- UserFoodVO 그룹화 -->
             <c:forEach var="food" items="${userFoodList.list}" varStatus="status">
                 <c:if test="${food.gup eq diet.gup}">
                     <!-- UserFood 정보 출력 -->
                     <tr>
                         <th class="kcals" id="kcal">
                             <input type="text" id="userFoodName_${status.index}" name="userFoodName_${status.index}" value="${food.foodName}"
                             style="width:200px; border: 2px solid #956fd6; border-radius: 10px; text-align: center;" readonly="readonly"/>      
                         </th>
                         <th>
                             <input type="text" id="userKcal_${status.index}" name="userKcal_${status.index}" value="${food.kcal}"
                             style="width:85px; border: 2px solid #956fd6; border-radius: 10px; text-align: center;" readonly="readonly"/> &nbsp;kcal 
                         </th>
                         <th>
                             <input type="text" id="userCarbs_${status.index}" name="userCarbs_${status.index}" value="${food.carbs}"
                             style="width:85px; border: 2px solid #956fd6; border-radius: 10px; text-align: center;" readonly="readonly"/> &nbsp;g
                         </th>
                         <th>
                             <input type="text" id="userProtein_${status.index}" name="userProtein_${status.index}" value="${food.protein}"
                             style="width:85px; border: 2px solid #956fd6; border-radius: 10px; text-align: center;" readonly="readonly"/> &nbsp;g  
                         </th>
                         <th>
                             <input type="text" id="userFat_${status.index}" name="userFat_${status.index}" value="${food.fat}"
                             style="width:85px; border: 2px solid #956fd6; border-radius: 10px; text-align: center;" readonly="readonly"/> &nbsp;g
                         </th>
                     </tr>
                 </c:if>
             </c:forEach>
          <!-- Diet 정보 출력 -->
                   <tr style="background: #ffffed;">
                      <th class="text-center" colspan="2">
                          <span style="font-size: 22pt;">메모</span>
                   </th>
                      <th class="text-center" colspan="3">
                          <span style="font-size: 22pt;">사진</span>
                   </th>
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
                           readonly="readonly"
                           >${diet.dietMemo}</textarea>
                     </td>
                     <th colspan="3" style="text-align: center; vertical-align: middle;">
                            <c:if test="${diet.dietPicture ne 'no picture'}">
                           <img src="../upload/diet/${diet.dietPicture}" style="max-width: 450px; max-height: 220px;">
                        </c:if>
                            <c:if test="${diet.dietPicture eq 'no picture'}">
                           <span style="color: gray; font-size: 15pt;">등록된 사진이 없습니다</span>
                        </c:if>
                     </th>
                 </tr>
                 <tr style="height: 50px;"></tr>
         </c:forEach>
          </table>
      </form>
      </div>
       <button
    type="button" 
    onclick="location.href='dietListView?dietWriteDate=${dietWriteDate}&id=${rvo.id}'" 
     style="background: none; border: 0; cursor: pointer;">
    <span style="background: #baffda; font-size: 25pt; font-weight: 900;">목록보기</span>
    </button>&nbsp;&nbsp;
   </div>
   <div class="footer">
      <jsp:include page="./footerAfter.jsp"></jsp:include>
   </div>
  </div>
  </div>
</body>
</html>