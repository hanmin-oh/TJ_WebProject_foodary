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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
   	<div class="header">
	   <jsp:include page="./headerAfter.jsp"></jsp:include>
	</div>
	<div align="center">
		<div style="text-align: center;" align="center">
			<span style="background: #fafcd9; font-size: 25pt; font-weight: 900;">비밀번호 재확인</span><br>
			<span style="background: lavender; font-size: 18pt; font-weight: 800;">회원탈퇴를 위해 비밀번호를 입력해 주세요.</span>
		</div>
		<br/>
		<form>
			<table border="0" cellpadding="5" cellspacing="20" width="600px;" align="center">
				<tr style="text-align: center;">
					<th style="vertical-align: middle;">비밀번호</th>
					<td>
						<input 
							id="password" 
							name="password" 
							type="password"
							style="font-family: D2coding;"
							/>
					</td>
				</tr>
				<tr style="height: 20px;"></tr>
				<tr style="text-align: center;">
					<th style="vertical-align: middle;">비밀번호 확인 </th>
					<td>
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
					<th colspan="2" style="text-align: center;">
						<button id="dropInfo" type="button" name="dropInfo" style="background: none; border: 0; cursor: pointer;">
							<span style="background: #baffda; font-size: 30px;">탈퇴하기</span>
						</button> &nbsp;&nbsp;&nbsp;&nbsp;
						<button id="dropInfo" type="button" name="dropInfo" onclick="history.back()"
							style="background: none; border: 0; cursor: pointer;">
							<span style="background: #baffda; font-size: 30px;">돌아가기</span>
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
<script type="text/javascript">
$(document).ready(function(e){
    $('#dropInfo').click(function(e) {
        e.preventDefault();
        if ($('#password').val() == '' || $('#passwordChk').val() == '') {
            alert("비밀번호를 입력하세요.");
            return;
        } else if ($('#passwordChk').val() != $('#password').val()){
            alert("비밀번호가 일치하지 않습니다.");
            $('#password').val('');
            $('#passwordChk').val('');
            $('#password').focus();
            return;
        } else if ($('#passwordChk').val() != '${rvo.password}' && $('#password').val() != '${rvo.password}') {
            alert("비밀번호가 일치하지 않습니다.");
            $('#password').val('');
            $('#passwordChk').val('');
            $('#password').focus();
            return;
        } else {
            var confirmation = confirm("Foodary에서 탈퇴하시겠습니까?");
            if (confirmation) {
                $('form').submit();
            }
        }
    });
});
</script>

</html>