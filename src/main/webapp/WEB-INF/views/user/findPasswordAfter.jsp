<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script type="text/javascript" src="../js/jquery-3.7.0.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script defer type="text/javascript" src="../js/changeIdBefore.js"></script>
<link rel="stylesheet" href="../css/threeGrid.css"/>
</head>
<body>
<body>
<div class="container" style="margin-top: 13%;">
   <div style="text-align: center;" align="center">
      <form>
      <c:choose>
      <c:when test="${empty password}">
         <script type="text/javascript">
            alert("아이디 또는 이름을 확인해주세요.");
            location.href = "findPassword";
         </script>
      </c:when>
      <c:otherwise>
         <div>
            <span style="background: #fafcd9; font-size: 30pt; font-weight: 900;">비밀번호 찾기</span><br/>
            <span style="text-decoration: underline; background: lavender; font-size: 25pt; font-weight: 800;">입력하신 정보와 일치하는 비밀번호 입니다.</span><br/><br/>
               <span style="font-size: 30pt;">${password}</span><br/>
         </div>
      </c:otherwise>
      </c:choose>
         <br/><br/>
         <div>
            <button type="button" onclick="location.href='${pageContext.request.contextPath}'" style="background: none; border: 0; cursor: pointer;">
               <span style="background: #baffda; font-size: 35px;">로그인하기</span>
            </button>
         </div>
      </form>
   </div>
   <div class="footer">
      <jsp:include page="./footerAfter.jsp"></jsp:include>
   </div>
</div>
</body>
</body>
</html>