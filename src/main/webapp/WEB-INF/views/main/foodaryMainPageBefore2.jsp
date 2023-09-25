<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 전 메인페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="css/main.css" />
<script type="text/javascript" src="js/jquery-3.7.0.js"></script>
<script type="text/javascript" src="js/mainFunction.js"></script>
<script defer type="text/javascript" src="./js/mainCalculator.js"></script>
<!-- 화면 효과를 위한 js -->
<script src="js/jquery.min.js"></script>
<script src="js/skel.min.js"></script>
<script src="js/util.js"></script>
<script src="js/main.js"></script>

</head>
<body>
${message}
${msg}
	<!-- header -->
	<header id="header" class="alt">
		<div class="inner">
			<a href="?"
				style="
					font-family: 'insungitCutelivelyjisu';
					font-size: 100pt;
					font-weight: 900;
					color: black;
					cursor: pointer;
					text-decoration: none;">
				Foodary
			</a>
			<p class="text-center">
				<span
					style="background: #fafcd9;
						font-size: 26pt;
						color: black;
						font-weight: 900;">"내 몸을 위한 일기장"</span>
			</p>
			<button type="button" onclick="location.href='user/register'"
					style="background: none; border: 0; cursor: pointer;">
       	 		<span 
       	 			style="background: lavender; color:black; font-size: 28pt;">회원가입</span>
       	 	</button>
       	 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" onclick="location.href='user/loginForm'"
					style="background: none; border: 0; cursor: pointer;">
       	 		<span style="background: lavender; color:black; font-size: 28pt; border: 0;">로그인</span>
       	 	</button>
       	 	
       	 	<br><br><br>
       	 	
        	<a href="#calculator" style="text-decoration: none;">
        		<span style="background: #baffda; font-size: 25pt; color: black; text-decoration: none;"><식단계산기 바로가기></span>
        	</a>
		</div>
	</header>
<!-- 영양소 계산기 -->
	<div id="calculator" class="alt" align="center" style="display: flex; text-align: center;">
		<table width="600px" style="margin-left: 20%; margin-right: 20%;" cellspacing="0px" cellpadding="5">
		<tr height="50px;"></tr>
			<tr>
				<th style="text-align: center;">
					<span style="background: #fafcd9; font-size: 25pt;">
						< 영양소 계산기 >
					</span>
					<br>
					<span style="color: gray;">* 모든 정보를 빠짐 없이 입력해주세요</span>
				</th>
			</tr>
			<tr>
				<th style="text-align: center; font-size: 22pt; width: 220px;">
					<span
						style="background: lavender; font-size: 22pt;">현재 체중:</span>
					<input
						type="text" id="currentWeight"
						style="width: 70px; height: 25px;
						font-size: 25pt; border-left: 0;
						border-right: 0; border-top: 0;
						border-bottom: 5; text-align: center;"/>
						kg
				</th>
			</tr>
			<tr>
				<th style="text-align: center; font-size: 22pt;">
					<span style="background: lavender; font-size: 22pt;">목표 체중:</span>
					<input type="text" id="goalWeight"
						style="width: 70px; height: 25px;
						font-size: 25pt; border-left: 0;
						border-right: 0; border-top: 0;
						border-bottom: 5; text-align: center;"/>
						kg
				</th>
			</tr>
			<tr>
				<th style="text-align: center; font-size: 22pt;">
					<span style="background: lavender; font-size: 22pt;">키:</span>
					<input
						type="text" id="height"
						style="width: 70px; height: 25px;
						font-size: 25pt; border-left: 0;
						border-right: 0; border-top: 0;
						border-bottom: 5; text-align: center;"/>
						cm
				</th>
			</tr>
			<tr>
				<th style="text-align: center; font-size: 22pt;">
				<span style="background: lavender; font-size: 22pt;">만 나이:</span>
				<input
					type="text" id="age"
					style="width: 70px; height: 25px;
					font-size: 25pt; border-left: 0;
					border-right: 0; border-top: 0;
					border-bottom: 5; text-align: center;"/>
					세
				</th>
			</tr>
			<tr>
				<th style="text-align: center; font-size: 22pt;">
					<span style="background: lavender; font-size: 22pt;">성별:</span>
					&nbsp;
					<input id="gender" type="radio" name="gender" checked="checked"
					value="남성" />&nbsp;남성 &nbsp;
					<input id="gender" type="radio" name="gender"
					value="여성" />&nbsp;여성</th>
			</tr>
			<tr>
				<th style="text-align: center; font-size: 22pt;"><span
					style="background: lavender; font-size: 22pt;">활동량:</span>
					<select style="width: 120px; height: 30px; font-size: 13pt;">
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
				<th style="text-align: center; font-size: 20pt;" colspan="2">
					<span style="background: lavender; font-size: 20pt;">Mode:</span>
					&nbsp;
					<input id="mode" type="radio" checked="checked" name="mode" value="health" /> 건강한 삶 
					<input id="mode" type="radio" name="mode" value="diet" /> 목표 달성!</th>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="button" onclick="mainCalculator();"
						style="background: none; border: 0; cursor: pointer; padding-top: 10px;">
						<span
							style="background: #baffda; font-size: 25pt; font-weight: 800;">계산하기</span>
					</button>
				</td>
			</tr>
		</table>
		<!-- =============== 계산 결과 ================ -->
		<table width="400px" height="500px" style="margin-right: 20%; margin-top: 50px;"  border="0" cellpadding="1px" cellspacing="1px">
			<tr>
				<th style="text-align: center; font-size: 22pt;">
					<span style="background: #fafcd9; font-size: 25pt;">★하루 권장 영양소★</span>
				</th>
			</tr>
			<tr>
				<th style="text-align: center; font-size: 22pt;">
					<span style="background: lavender; font-size: 22pt;">칼로리:</span> &nbsp;
					<input type="text" id="kcal" disabled="disabled"
						style="width: 70px; height: 25px; border: 0; text-align: center; font-size: 22pt; color: black;"/>
					&nbsp;kcal
				</th>
			</tr>
			<tr>
				<th style="text-align: center; font-size: 22pt;">
					<span style="background: lavender; font-size: 22pt;">탄수화물:</span> &nbsp;
					<input type="text" id="carbs" disabled="disabled"
						style="width: 70px; height: 25px;  border: 0; text-align: center; font-size: 22pt; color: black;"/>
					&nbsp;g
				</th>
			</tr>
			<tr>
				<th style="text-align: center; font-size: 22pt;">
					<span style="background: lavender; font-size: 22pt;">단백질:</span> &nbsp;
					<input type="text" id="protein" disabled="disabled"
						style="width: 70px; height: 25px;  border: 0; text-align: center; font-size: 22pt; color: black;" />
					&nbsp;g
				</th>
			</tr>
			<tr>
				<th style="text-align: center; font-size: 22pt;">
					<span style="background: lavender; font-size: 22pt;">지방:</span> &nbsp;
					<input type="text" id="fat" disabled="disabled"
					style="width: 70px; height: 25px;  border: 0; text-align: center; font-size: 22pt; color: black;"/>
					&nbsp;g
				</th>
			</tr>
			<tr>
				<td align="center">
					<button type="button" onclick="location.reload()"
						style="background: none; border: 0; cursor: pointer; padding-top: 10px;">
						<span style="background: #baffda; font-size: 25pt; font-weight: 800;">다시하기</span>
					</button>
				</td>
			</tr>
		</table>
	</div>

	<div class="copyright" style="margin-top: 200px;" align="center">
		<hr style="border: 3; width: 165px;">
		<a href="?">
			Foodary
		</a>
		by 아무래도
		<hr style="border: 3; width: 165px;">
	</div>
</body>
</html>

