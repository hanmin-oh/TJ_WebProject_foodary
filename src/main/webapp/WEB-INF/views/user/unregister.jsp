<%@page import="com.foodary.vo.UserRegisterVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 신청</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script type="text/javascript" src="../js/dropInfo.js" defer="defer"></script>
<link rel="stylesheet" href="../css/threeGrid.css"/>
</head>
<body>
<div class="container">
   	<div class="header">
	   <jsp:include page="./headerAfter.jsp"></jsp:include>
	</div>
	<div align="center">
		<div style="text-align: center;" align="center">
			<span style="background: #fafcd9; font-size: 30pt; font-weight: 900;">비밀번호 재확인</span><br>
			<span style="background: lavender; font-size: 25pt; font-weight: 800;">회원탈퇴를 위해 비밀번호를 다시 한 번 입력해 주세요.</span>
		</div>
		<form>
			<table border="0" cellpadding="5" cellspacing="20">
				<tr>
					<th style="vertical-align: middle;">비밀번호</th>
					<td colspan="2">
						<input 
							id="password" 
							value="${rvo.password}"
							name="password" 
							type="password"
							readonly="readonly"
							style="font-family: D2coding;"
							/>
					</td>
				</tr>
				<tr>
					<th style="vertical-align: middle;">비밀번호 확인</th>
					<td colspan="2">
						<input 
							id="passwordChk" 
							type="password" 
							name="passwordChk" 
							autocomplete="off" 
							style="font-family: D2coding;"
							/>
							
						<h5 id="passwordCheckMessage" style="color: red; font-weight: bold;"></h5>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<button id="dropInfo" type="button" name="dropInfo" onclick="dropInfo1()" style="background: none; border: 0; cursor: pointer;">
							<span style="background: #baffda; font-size: 35px;">탈퇴하기</span>
						</button>
					</th>
				</tr>
			</table>
			<input id="id" type="hidden" value="${rvo.id}">
		</form>
	</div>
	<br><br>
	<div class="footer">
		<jsp:include page="./footerAfter.jsp"></jsp:include>
	</div>
</div>
</body>
</html>