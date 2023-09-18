<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script type="text/javascript" src="../js/jquery-3.7.0.js"></script>
<script defer type="text/javascript" src="../js/changeIdBefore.js"></script>
<link rel="stylesheet" href="../css/threeGrid.css"/>
</head>
<body>
<div class="container" style="margin-top: 13%;">
   <div style="text-align: center;" align="center">
      <form action="findIdOK" method="post" enctype="multipart/form-data" onsubmit="return changeIdBefore()">
         <div>
            <span style="background: #fafcd9; font-size: 30pt; font-weight: 900;">아이디 찾기</span><br/>
            <span style="text-decoration: underline; background: lavender; font-size: 25pt; font-weight: 800;">본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 아이디를 찾을 수 있습니다.</span><br/><br/>
            이름: <input id="username" name="username" type="text"/><br/><br/>
            이메일: <input id="email" name="email" type="email" style="width: 300px;"/><br/><br/>
         </div>
         <br/><br/>
         <div>
            <button type="submit" style="background: none; border: 0; cursor: pointer;">
               <span style="background: #baffda; font-size: 35px;">확인</span>
            </button>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="button" onclick="location.href='${pageContext.request.contextPath}'" style="background: none; border: 0; cursor: pointer;">
               <span style="background: #baffda; font-size: 35px;">돌아가기</span>
            </button>
         </div>
      </form>
   </div>
</div>
</body>
</html>