<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>푸드어리 회원가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<link rel="stylesheet" href="../css/threeGrid.css"/>
<link rel="stylesheet" href="../css/bootstrap.css"/>
<script type="text/javascript" src="../js/jquery-3.7.0.js"></script>
<script type="text/javascript" src="../js/bootstrap.js"></script>
<script type="text/javascript" src="../js/userRegister.js"></script> 
</head>
<body>
<div class="container">
	<div class="header">
	   <jsp:include page="./header.jsp"></jsp:include>
	</div>
	<br>
	<div class="main">	
		<div>
			<form action="registerOK" method="post" name="registerform">
				<!-- 회원가입에 필요한 기본 정보 -->
				<table cellspacing="25" cellpadding="5" style="width: 1000px; margin-left: auto; margin-right: auto; margin-top: 0px;">
			      <thead>
			         <tr class="info">
			         	<th style="text-align: center;"><span style="background: #baffda; font-size: 40px;"><회원가입></span></th>
			         </tr>
			      </thead>
			       <tr>
			         <th style="text-align: center;">
			            <label for="username"><span style="background: lavender; font-size: 22pt;">이름</span> :</label>
			            <label><input id="username" type="text" name="username" autocomplete="off" style="padding-left: 10px;"/></label>
			         </th>   
			      </tr>
			      <tr>
			         <th style="text-align: center;">
			            <label for="id"><span style="background: lavender; font-size: 22pt;">아이디</span> :</label>
			            <label><input id="id" type="text" name="id" autocomplete="off" style="padding-left: 10px;"/></label>&nbsp;&nbsp;
			            <button type="button" onclick="idCheckFunction()" style="background: none; border: 0; cursor: pointer;">
			            	<span style="background: #fafcd9; font-size: 25pt; font-weight: 800;">중복검사</span>
			            </button> 
			         </th>
			      </tr>
			      <tr>
			         <td style="text-align: center;">
			            <!-- 아이디 중복 검사 결과 메시지를 출력하는 영역 -->
			            <h5 id="idCheckMessage" style="color: purple; font-weight: bold;  font-size: 22pt;"></h5>
			            <!-- 에러 메시지 결과를 출력하는 영역 -->
			            <h5 id="errorMessage" style="color: red; font-weight: bold;  font-size: 22pt;">
			            </h5>
			         </td>
			     </tr>
			      <tr>
			         <th style="text-align: center;">
			            <label for="password"><span style="background: lavender; font-size: 22pt;">비밀번호</span> :</label>
			            <label><input id="password" type="password" name="password" autocomplete="off"
			            	onkeyup="passwordCheckFunction()" style="font-family: D2Coding; padding-left: 10px;"/></label><br>
			            <span style="font-size:15pt; background: #fafcd9;">* 비밀번호는 8자 이상 / 영문자, 숫자 및 특수문자를 모두 1개 이상 포함해야 합니다</span>
			         </th>
			      </tr>
			      <tr>
			         <th style="width: 300px; text-align: center;">
			            <label for="passwordCheck"><span style="background: lavender; font-size: 22pt;">비밀번호 확인</span> :</label>
			            <label><input id="passwordCheck" type="password" name="passwordCheck" 
			               autocomplete="off" onkeyup="passwordCheckFunction()" style="font-family: D2Coding; padding-left: 10px;"/></label>
			         </th>
			      </tr>
			      <tr>
			      	<td style="text-align: center;">
			            <h5 id="passwordCheckMessage" style="color: red; font-weight: bold; font-size: 20pt;"></h5>
			      	</td>
			      </tr>
			      <tr>
			         <th style="text-align: center;">
			            <label for="email"><span style="background: lavender; font-size: 22pt;">이메일</span> :</label>
			            <label><input id="email" type="email" name="email" autocomplete="off" style="padding-left: 10px;"/></label>
			        </th>
			      </tr>
			      <tr>
			         <th style="text-align: center;">
			            <label for="gender"><span style="background: lavender; font-size: 22pt;">성별</span> :</label>&nbsp;&nbsp;
			            <label>
			               <input id="male" type="radio" name="gender" checked="checked" value="남성"/>&nbsp;남성&nbsp;&nbsp;
			               <input id="female" type="radio" name="gender" value="여성"/>&nbsp;여성&nbsp;&nbsp;
			            </label>
			         </th>
			      </tr>
			      </table>
			      <!-- 영양소 계산에 필요한 정보 -->
			      <table cellspacing="30" cellpadding="10" style="width: 1000px; margin-left: auto; margin-right: auto; margin-top: 0px;">
				      <tr>
				         <th style="text-align: center;">
				            <label for="height"><span style="background: lavender; font-size: 22pt;">키</span> :</label>
				            <label><input id="height" type="text" name="height" autocomplete="off" style="padding-left: 10px;"/></label> cm
				         </th>
				         <th style="text-align: center;">
				            <label for="age"><span style="background: lavender; font-size: 22pt;">만 나이</span> :</label>
				            <label><input id="age" type="text" name="age" autocomplete="off" style="padding-left: 10px;"/></label> 세
				         </th>
				      </tr>
				      <tr>
				         <th style="text-align: center;">
				            <label for="currentWeight"><span style="background: lavender; font-size: 22pt;">현재 체중</span> :</label>
				            <input id="currentWeight" type="text" name="currentWeight" autocomplete="off" style="padding-left: 10px;"/> kg
				         </th>
				         <th style="text-align: center;">
				            <label for="goalWeight"><span style="background: lavender; font-size: 22pt;">목표 체중</span> :</label>
				            <label><input id="goalWeight" type="text" name="goalWeight" autocomplete="off" style="padding-left: 10px;"/> kg</label>
				         </th>
				      </tr>
				      <tr>
				         <th colspan="2" align="center" style="text-align: center;">
				            <label for="active"><span style="background: lavender; font-size: 22pt;">활동량</span> : </label>
				            <select name="active" style="height: 40px;">
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
			        <th colspan="2" align="center" style="text-align: center;">
			            <label for="mode"><span style="background: lavender; font-size: 22pt;">Mode</span> :</label>&nbsp;&nbsp;
			            <label>
			               <input id="health" type="radio" name="state" checked="checked" value="health"/> 건강한 삶&nbsp;&nbsp;
			               <input id="diet" type="radio" name="state" value="diet"/> 목표 달성!&nbsp;&nbsp;
			            </label>
			         </th>
			      </tr>
			      <tr></tr>
			      <tr>
			         <td colspan="2" align="center">
			            <button id="register" type="button" onclick="Noregister()" disabled="disabled"
			            	style="background: none; border: 0; cursor: pointer; ">
			            	<span style="background: #fafcd9; font-size: 25pt; font-weight: 800;">회원가입</span>
			            </button>&nbsp;&nbsp;&nbsp;
			            <button type="reset" style="background: none; border: 0; cursor: pointer;">
							<span style="background: #fafcd9; font-size: 25pt; font-weight: 800;">다시쓰기</span>
						</button>
			         </td>
			      </tr>
			   </table>
			   
			   <input type="hidden" name="ip" onclick="userRegister()"/> 
			   <%-- <input type="hidden" name="currentPage" value="<%=currentPage%>"/> --%>
			</form>
		</div>
		<br><br><br>
	<div class="footer">
		<jsp:include page="./footer.jsp"></jsp:include>
	</div>
</div>
<div id="messageModal" class="modal fade" role="dialog" aria-hidden="true">
   <div class="vertical-alignment-helper">
      <div class="modal-dialog vertical-align-center">
         <!-- 모달 창의 종류(색상)를 설정한다. -->
         <!-- messageCheck라는 id를 추가하고 class를 제거한다. -->
         <div id="messageCheck">
            <!-- 헤더 -->
            <div class="modal-header panel-heading">
               <button class="close" type="button" data-dismiss="modal" style="background: none; border: 0; cursor: pointer;">
                  <span style="background: #fafcd9; font-size: 25pt;; font-weight: 800;">X</span>
               </button>
               <!-- messageType이라는 id를 추가한다. -->
               <h4 id="messageType" class="modal-title">
                  <%-- ${messageType} --%>
               </h4>
            </div>
            <!-- 바디 -->
            <!-- messageContent이라는 id를 추가한다. -->
            <div id="messageContent" class="modal-body">
               <%-- ${messageContent} --%>
            </div>
            <!-- 풋터 -->
            <div class="modal-footer" style="border: 0;">
               <button type="button" data-dismiss="modal" style="background: none; border: 0; cursor: pointer;">
               	<span style="background: #fafcd9; font-size: 25pt; font-weight: 800;">닫기</span>
	               </button>
	            </div>
	         </div>
	      </div>
	   </div>
	</div>
</div>
</body>
</html>