<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 영양소 계산기</title>
<script type="text/javascript" src="js/jquery-3.7.0.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script defer type="text/javascript" src="./js/mainFunction.js"></script>
<script defer type="text/javascript" src="./js/mainCalculator.js"></script>
</head>
<body>
   <table width="300px" cellpadding="10px" cellspacing="5px;">
      <tr> 
         <th style="text-align: center;">
           <span style="background: #fafcd9; font-size: 25pt;">★ 영양소 계산기 ★</span>
         </th>   
      </tr>
      <tr>
         <th style="text-align: center; font-size: 22pt;">
            <span style="background: lavender; font-size: 22pt;">현재 체중:</span>
            <input type="text" id="currentWeight"
            	style="width: 70px; height: 25px; font-size: 25pt; border-left:0; border-right:0; border-top:0; border-bottom:5; text-align: center;"/> kg
         </th>
      </tr>
      <tr>
         <th style="text-align: center; font-size: 22pt;">
            <span style="background: lavender; font-size: 22pt;">목표 체중:</span>
            <input type="text" id="goalWeight"
            	style="width: 70px; height: 25px; font-size: 25pt; border-left:0; border-right:0; border-top:0; border-bottom:5; text-align: center;"/> kg
         </th>
      </tr>
      <tr>   
         <th style="text-align: center; font-size: 22pt;">
            <span style="background: lavender; font-size: 22pt;">키:</span> 
            <input type="text" id="height"
            	style="width: 70px; height: 25px; font-size: 25pt; border-left:0; border-right:0; border-top:0; border-bottom:5; text-align: center;"/> cm
         </th>      
     </tr>
      <tr>   
         <th style="text-align: center; font-size: 22pt;">
           <span style="background: lavender; font-size: 22pt;">만 나이:</span> 
            <input type="text" id="age"
            	style="width: 70px; height: 25px; border-left:0; border-right:0; border-top:0; border-bottom:5; text-align: center;"/> 세
         </th>      
     </tr>
      <tr>
         <th style="text-align: center; font-size: 22pt;">
            <span style="background: lavender; font-size: 22pt;">성별:</span>&nbsp;&nbsp;&nbsp;
         	<input id="gender" type="radio" name="gender" checked="checked" value="남성"/>&nbsp;남성 &nbsp;&nbsp;
            <input id="gender" type="radio" name="gender" value="여성"/>&nbsp;여성
         </th>
	<tr>
         <th style="text-align: center; font-size: 22pt;">
            <span style="background: lavender; font-size: 22pt;">활동량:</span> 
            <select style="width: 150px; height: 30px; font-size: 13pt;">
               <option value="다시" name="active" selected="selected">활동량 선택</option>
               <option value="1.2" name="active">많이 앉아있는 경우</option>
               <option value="1.375" name="active">앉아있는 일이 적은 경우</option>
               <option value="1.55" name="active">움직임이 많은 경우</option>
               <option value="1.725" name="active">운동 될 움직임을 할 경우</option>
               <option value="1.9" name="active">매우 많은 운동량</option>
            </select>
         </th> 
      </tr>
      <tr>
         <th style="text-align: center; font-size: 20pt;">
          	<span style="background: lavender; font-size: 20pt;">Mode:</span> &nbsp;
              <input id="mode" type="radio" checked="checked" name="mode" value="health"/> 건강한 삶
              <input id="mode" type="radio" name="mode" value="diet"/> 목표 달성!
        </th>
      </tr>
      <tr>
         <td colspan="2" align="center">
            <button type="button" onclick="mainCalculator();" style="background: none; border: 0; cursor: pointer; padding-top: 10px;">
            	<span style="background: #baffda; font-size: 25pt; font-weight: 800;">계산하기</span>
            </button>
         </td>
      </tr>
   </table>
<hr width="270px" style="margin: 10px; padding-left: 30px;">
<table width="300px">
	<tr>
		<th style="text-align: center; font-size: 22pt;"">
           	<span style="background: #fafcd9; font-size: 25pt;">★일일 권장 영양소★</span>
        	</th>
	</tr>
	<tr>
		<th style="text-align: center; font-size: 20pt;"">
		<span style="background: lavender; font-size: 22pt;">칼로리</span> &nbsp;
		<input type="text" id="kcal" disabled="disabled" style="width: 70px; height: 22px; border-left:0; border-right:0; border-top:0; border-bottom:5; text-align: center;"/> &nbsp;kcal
		</th>
	</tr>
	<tr> 
		<th style="text-align: center; font-size: 20pt;"">
		<span style="background: lavender; font-size: 22pt;">탄수화물</span> &nbsp;
		<input type="text" id="carbs" disabled="disabled" style="width: 70px; height: 22px; border-left:0; border-right:0; border-top:0; border-bottom:5; text-align: center;"/> &nbsp;g
		</th>
	</tr>
	<tr>
		<th style="text-align: center; font-size: 20pt;"">
		<span style="background: lavender; font-size: 22pt;">단백질</span> &nbsp;
		<input type="text" id="protein" disabled="disabled"  style="width: 70px; height: 22px; border-left:0; border-right:0; border-top:0; border-bottom:5; text-align: center;"/> &nbsp;g
		</th>
	</tr>
	<tr>
		<th style="text-align: center; font-size: 20pt;"">
		<span style="background: lavender; font-size: 22pt;">지방</span> &nbsp;
		<input type="text" id="fat" disabled="disabled" style="width: 70px; height: 25px; border-left:0; border-right:0; border-top:0; border-bottom:5; text-align: center;"/> &nbsp;g
		</th>
	</tr>
	  <tr>
         <td colspan="2" align="center">
            <button type="button" onclick="location.reload()" style="background: none; border: 0; cursor: pointer; padding-top: 10px;">
				<span style="background: #baffda; font-size: 25pt; font-weight: 800;">다시하기</span>
			</button>
         </td>
      </tr>
</table>
</body>
</html>