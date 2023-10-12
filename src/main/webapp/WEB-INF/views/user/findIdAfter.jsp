<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script type="text/javascript" src="../js/jquery-3.7.0.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script defer type="text/javascript" src="../js/changeIdBefore.js"></script>
<script type="text/javascript">
	var message = "${msg}";
	if (message) {
		alert(message);
	}
</script>
<link rel="stylesheet" href="../css/threeGrid.css"/>
</head>
<body>
<body>
<div class="container" style="margin-top: 13%;">
   <div style="text-align: center;" align="center">
      <form>
      <c:choose>
      <c:when test="${empty idList}">
         <script type="text/javascript">
            alert("일치하는 아이디가 없습니다.");
            location.href = "findId";
         </script>
      </c:when>
      <c:otherwise>
         <div>
            <span style="background: #fafcd9; font-size: 30pt; font-weight: 900;">아이디 찾기</span><br/>
            <span style="text-decoration: underline; background: lavender; font-size: 25pt; font-weight: 800;">고객님의 정보와 일치하는 아이디 목록입니다.</span><br/><br/>
            <c:forEach items="${idList}" var="id">
               <span style="font-size: 30pt;">아이디: ${id}</span><br/>
            </c:forEach>
         </div>
      </c:otherwise>
      </c:choose>
         <br/><br/>
         <div>
            <button type="button" onclick="location.href='${pageContext.request.contextPath}'" style="background: none; border: 0; cursor: pointer;">
               <span style="background: #baffda; font-size: 35px;">로그인하기</span>
            </button>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="button" onclick="location.href='findPassword'" style="background: none; border: 0; cursor: pointer;">
               <span style="background: #baffda; font-size: 35px;">비밀번호 찾기</span>
            </button>
         </div>
      </form>
   </div>
</div>
</body>
</body>
</html>