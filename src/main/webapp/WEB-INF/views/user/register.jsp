<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>푸드어리 회원가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<link rel="stylesheet" href="../css/threeGrid.css"/>
<script type="text/javascript" src="../js/jquery-3.7.0.js"></script>
<script type="text/javascript" src="../js/userRegister.js"></script> 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="main">	
		<div class="form-group">
			<form action="registerOK" method="post" name="registerform">
				<!-- 회원가입에 필요한 기본 정보 -->
				<table class="table table-sm"
					style="width: 800px; margin-left: auto; margin-right: auto; margin-top: 40px;">
			      <thead>
			         <tr class="info" style="height: 50px; background: lavender;">
			         	<th style="text-align: center;" colspan="2">
			         		<span style="font-size: 40px; background: #fcf9dc;">
			         			<회원가입>
			         		</span>
			         	</th>
			         </tr>
			      </thead>
			       <tr>
			         <th style="text-align: center; width: 350px; background: #f0fff6;">
			            <label for="username"><span style="background: lavender; font-size: 22pt;">이름</span> :</label>
			         </th>
			         <td style="padding-left: 30px;">
			            <label><input id="username" type="text" name="username" autocomplete="off"
			            		style="padding-left: 10px; width: 500px; border-radius: 10px; border: 3px solid #e1d1ff;"/></label>
			         </td>
			      </tr>
			      <tr>
			         <th style="text-align: center;  background: #f0fff6; vertical-align: middle;">
			            <label for="id"><span style="background: lavender; font-size: 22pt;">아이디</span> :</label>
			         </th>
			         <td style="padding-left: 30px;">
			            <label><input class="form-control1" id="id" type="text" name="id" autocomplete="off"
			            style="padding-left: 10px; width: 500px; border-radius: 10px; border: 3px solid #e1d1ff;"/></label>&nbsp;&nbsp;
			            <button type="button" onclick="idCheckFunction()"
			            	style="background: none; border: 0; cursor: pointer;">
			            	&nbsp;&nbsp;&nbsp;<span style="background: #fafcd9; font-size: 20pt; font-weight: 800;">중복검사</span>
			            </button>
			            <!-- 아이디 중복 검사 결과 메시지를 출력하는 영역 -->
			            <h5 id="idCheckMessage" style="color: purple; font-weight: bold;  font-size: 15pt;"></h5>
			            <!-- 에러 메시지 결과를 출력하는 영역 -->
			            <h5 id="errorMessage" style="color: red; font-weight: bold;  font-size: 15pt;"></h5>
			         </td>
			      </tr>
			      <tr>
			         <th style="text-align: center; background: #f0fff6; vertical-align: middle;">
			            <label for="password"><span style="background: lavender; font-size: 22pt;">비밀번호</span> :</label>
			         </th>
			         <td style="padding-left: 30px;">
			            <label><input class="form-control1" id="password" type="password" name="password" autocomplete="off"
			            	onkeyup="passwordCheckFunction()"
			            	style="font-family: D2Coding; padding-left: 10px; width: 500px; border-radius: 10px; border: 3px solid #e1d1ff;"/></label><br>
			            <span style="font-size:15pt; background: #fafcd9;">* 비밀번호는 8자 이상 / 영문자, 숫자 및 특수문자를 모두 1개 이상 포함해야 합니다</span>
			      	</td>
			      </tr>
			      <tr>
			         <th style="text-align: center; background: #f0fff6; vertical-align: middle;">
			            <label for="passwordCheck"><span style="background: lavender; font-size: 22pt;">비밀번호 확인</span> :</label>
			         </th>
			         <td style="padding-left: 30px;">
			            <label><input class="form-control1" id="passwordCheck" type="password" name="passwordCheck" 
			               autocomplete="off" onkeyup="passwordCheckFunction()"
			               style="font-family: D2Coding; padding-left: 10px; width: 500px; border-radius: 10px; border: 3px solid #e1d1ff;"/></label>
			            <h5 id="passwordCheckMessage" style="color: red; font-weight: bold; font-size: 20pt;"></h5>
			      	</td>
			      </tr>
			      <tr>
			         <th style="text-align: center; background: #f0fff6;">
			            <label for="email"><span style="background: lavender; font-size: 22pt;">이메일</span> :</label>
			        </th>
			        <td style="padding-left: 30px;">
			            <label><input id="email" type="email" name="email" autocomplete="off"
			            	style="padding-left: 10px; width: 500px; border-radius: 10px; border: 3px solid #e1d1ff;"/></label>
			      	</td>
			      </tr>
			      <tr>
			         <th style="text-align: center; background: #f0fff6;">
			            <label for="gender"><span style="background: lavender; font-size: 22pt;">성별</span> :</label>&nbsp;&nbsp;
			         </th>
			         <td style="width: 850px; padding-left: 30px;">
			            <label>
			               <input id="male" type="radio" name="gender" checked="checked" value="남성" style="accent-color: #7a33ff;"/>&nbsp;
			               <label for="male"><span>남성</span></label>&nbsp;&nbsp;
			               <input id="female" type="radio" name="gender" value="여성" style="accent-color: #7a33ff;"/>&nbsp;
			               <label for="female"><span>여성</span></label>&nbsp;&nbsp;
			            </label>
			      	</td>
			      </tr>
			      </table>
			      <!-- 영양소 계산에 필요한 정보 -->
			      <table class="table table-sm"
					style="width: 800px; margin-left: auto; margin-right: auto; margin-top: 40px;">
				      <tr>
				         <th style="text-align: center; background: #f0fff6;">
				            <label for="height"><span style="background: lavender; font-size: 22pt;">키</span></label>
				         </th>
				         <th style="text-align: center; background: #f0fff6;">
				            <label for="age"><span style="background: lavender; font-size: 22pt;">만 나이</span></label>
				         </th>
				      </tr>
				      <tr>
				      	<td style="text-align: center;">
				            <label><input id="height" type="text" name="height" autocomplete="off"
				            	style="padding-left: 10px; width: 100px; border-radius: 10px; border: 3px solid #e1d1ff;"/></label> cm
				        </td>
				        <td style="text-align: center;">
				            <label><input id="age" type="text" name="age" autocomplete="off"
				            	style="padding-left: 10px; width: 100px; border-radius: 10px; border: 3px solid #e1d1ff;"/></label> 세
				      	</td>
				      </tr>
				      <tr>
				         <th style="text-align: center; background: #f0fff6;">
				            <label for="currentWeight"><span style="background: lavender; font-size: 22pt;">현재 체중</span></label>
				         </th>
				         <th style="text-align: center; background: #f0fff6;">
				            <label for="goalWeight"><span style="background: lavender; font-size: 22pt;">목표 체중</span></label>
				         </th>
				      </tr>
				      <tr>
				      	<td style="text-align: center;">
				            <input id="currentWeight" type="text" name="currentWeight" autocomplete="off" 
				            style="padding-left: 10px; width: 100px; border-radius: 10px; border: 3px solid #e1d1ff;"/> kg
				        </td>
				        <td style="text-align: center;">
				            <label><input id="goalWeight" type="text" name="goalWeight" autocomplete="off"
				            style="padding-left: 10px; width: 100px; border-radius: 10px; border: 3px solid #e1d1ff;"/> kg</label>
				      	</td>
				      <tr>
				         <th style="text-align: center; background: #f0fff6;">
				            <label for="active"><span style="background: lavender; font-size: 22pt;">활동량</span></label>
				         </th>   
				        <th style="text-align: center; background: #f0fff6;">
			            	<label for="mode"><span style="background: lavender; font-size: 22pt;">Mode</span></label>&nbsp;&nbsp;
				         </th>
				      </tr>
				      <tr>
				      	<td style="text-align: center;" align="center">
				            <select name="active" style="width: 250px; height: 50px; padding-left: 10px; border-radius: 10px; border: 3px solid #e1d1ff;">
				               <option value="다시" name="active" selected="selected">활동량 선택</option>
				               <option value="1.2" name="active">많이 앉아있는 경우</option>
				               <option value="1.375" name="active">앉아있는 일이 적은 경우</option>
				               <option value="1.55" name="active">움직임이 많은 경우</option>
				               <option value="1.725" name="active">운동 될 움직임을 할 경우</option>
				               <option value="1.9" name="active">매우 많은 운동량</option>
				            </select>
				  		</td>
				  		<td style="text-align: center; vertical-align: middle;">
				            <label>
				               <input id="health" type="radio" name="state" checked="checked" value="health" style="accent-color: #7a33ff;"/> 
				               <label for="health"><span>건강한 삶</span></label>&nbsp;&nbsp;
				               <input id="diet" type="radio" name="state" value="diet" style="accent-color: #7a33ff;"/> 
				               <label for="diet"><span>목표 달성!</span></label>&nbsp;&nbsp;
				            </label>
			            </td>
				  	</tr>
			   </table>
			   	<div style="text-align: center;">
			            <button id="register" type="button" onclick="Noregister()"
			            	style="background: none; border: 0; cursor: pointer; ">
			            	<span style="background: #fafcd9; font-size: 25pt; font-weight: 800;">회원가입</span>
			            </button>&nbsp;&nbsp;&nbsp;
			            <button type="reset" style="background: none; border: 0; cursor: pointer;">
							<span style="background: #fafcd9; font-size: 25pt; font-weight: 800;">다시쓰기</span>
						</button>&nbsp;&nbsp;&nbsp;
			            <button type="button" style="background: none; border: 0; cursor: pointer;" onclick="history.back()">
							<span style="background: #fafcd9; font-size: 25pt; font-weight: 800;">돌아가기</span>
						</button>
			   </div>
			   <input type="hidden" name="ip" onclick="userRegister()"/> 
			   <%-- <input type="hidden" name="currentPage" value="<%=currentPage%>"/> --%>
			</form>
		</div>
</div>
<div id="messageModal" class="modal fade" role="dialog" aria-hidden="true">
   <div class="vertical-alignment-helper">
      <div class="modal-dialog">
         <div id="messageCheck">
            <!-- 헤더 -->
            <div class="modal-header" style="background: #ebe8ff; height: 50px;">
               <span id="messageType" class="modal-title">
               </span>
            </div>
            
            <div id="messageContent" class="modal-body" style="height: 100px;"></div>
            
            <!-- 풋터 -->
            <div class="modal-footer">
               <button type="button" data-dismiss="modal" style="background: none; border: 0; cursor: pointer;">
               	<span style="font-size: 30pt; font-weight: 800; background: lavender;" data-bs-dismiss="modal">닫기</span>
	           </button>
	        </div>
         </div>
      </div>
   </div>
</div>
</body>
</html>