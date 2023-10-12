<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음식 목록</title>
<script type="text/javascript" src="../js/foodViewUpdate.js"></script> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="../css/threeGrid.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
  	<div class="main" align="center">
  	<br>
		<div class="dietContent_title">
			<span style="background: #fafcd9; font-size: 30pt; font-weight: 900;">음식 검색</span>
		</div>
		<form id="myForm" action="updateFoodList" method="POST">
		   <table  width="1000" align="center" class="table table-hover table-sm" style="text-align: center;">
				<thead>
				   <tr style="height: 60px;">
			   		<th colspan="7" class="text-center"">
				         <span style="background: #baffda; font-size: 35px; font-weight: 900;">음식 이름</span> : 
				         <input type="text" id="foodName" name="foodName" style="width:50%;" /> 
				          <button class='button button1' type="submit" style="width: 100px; height: 30px;
				          	background: none; border: 0; cursor: pointer;">
				          	<span style="background: lavender; font-size: 30px; font-weight: 900;">검색</span>
				          </button>     
			      	</th>
				   </tr>
					<tr class="info" style="background: lavender;">
						<th style="text-align: center; width: 100px;">
							<span style="font-size: 25px; font-weight: 900;">번호</span>
						</th>
						<th style="text-align: center; width: 250px;">
							<span style="font-size: 25px; font-weight: 900;">음식 이름</span>
						</th>
						<th style="text-align: center; width: 150px;">
							<span style="font-size: 25px; font-weight: 900;">칼로리</span>
						</th>
						<th style="text-align: center;">
							<span style="font-size: 25px; font-weight: 900;">탄수화물</span>
						</th>
						<th style="text-align: center;">
							<span style="font-size: 25px; font-weight: 900;">단백질</span>
						</th>
						<th style="text-align: center;">
							<span style="font-size: 25px; font-weight: 900;">지방</span>
						</th>
						<th style="text-align: center; width: 100px;">
							<span style="font-size: 25px; font-weight: 900;">선택</span>
						</th>
					</tr>
				</thead>
			   <!-- foodList.jsp에서 request 영역에 저장한 foodList에서 1페이지 분량의 글을 꺼내온다. -->
			   <tbody id="ajaxTable">
		       	<c:set var="list" value="${foodList.list}"/>
			   <c:forEach var="vo" items="${list}">
				<tr>
			      <td class="text-center" style="background: #f0fff6;">
			         ${vo.idx}
			      </td>
			      <td class="text-center">
			         ${vo.foodName}
			      </td>
			      <td class="text-center">
			        ${vo.kcal}
			      </td>
			      <td class="text-center">
			          ${vo.carbs}
			      </td>
			      <td class="text-center">
			          ${vo.protein}
			      </td>
			      <td class="text-center">
			           ${vo.fat}
			      </td>
			      <input type="hidden" id="gup" name="gup" value="${gup}"/>
			      <td class="text-center" style="background: #f0fff6;">
			         <input type="checkbox" value="선택" name="foodName" style="accent-color: #7a33ff;"/>      
			      </td>
			   </tr>
			   </c:forEach>
			   </tbody>
			<!-- 페이지 이동 버튼 --> 
				<c:set var="list" value="${foodList.list}"/>
				<tr style="height: 60px;">
					<td colspan="7" align="center">
						<!-- 처음으로 -->
						<c:if test="${foodList.currentPage > 1}">
							<button 
								class='button button1' 
								type="button" 
								title="첫 페이지로 이동합니다." 
								onclick="location.href='?currentPage=1&gup=${gup}'"
								style="background: none; border: 0; cursor: pointer;"
							>◀◀</button>
						</c:if>
						<c:if test="${foodList.currentPage <= 1}">
							<button 
								class='button button2' 
								type="button" 
								disabled="disabled" 
								title="이미 첫 페이지 입니다."
								style="background: none; border: 0; cursor: pointer;"
							>◀◀</button>
						</c:if>
						
						<!-- 10페이지 앞으로 -->
						<c:if test="${foodList.startPage > 1}">
							<button 
								type="button" 
								title="이전 10페이지로 이동합니다." 
								onclick="location.href='?currentPage=${foodList.startPage - 1}&gup=${gup}'"
								style="background: none; border: 0; cursor: pointer;"
							>◀</button>
						</c:if>
						<c:if test="${foodList.startPage <= 1}">
							<button 
								type="button" 
								disabled="disabled" 
								title="이미 첫 10페이지 입니다."
								style="background: none; border: 0; cursor: pointer;" 
							>◀</button>
						</c:if>
						
						<!-- 페이지 이동 버튼 -->
						<c:forEach var="i" begin="${foodList.startPage}" end="${foodList.endPage}" step="1">
							<c:if test="${foodList.currentPage == i}">
								<button type='button' disabled='disabled' style="background: none; border: 0; cursor: pointer; font-size: 25pt;">
									${i}
								</button>
							</c:if>
							<c:if test="${foodList.currentPage != i}">
								<button 
									type='button' 
									title="${i}페이지로 이동합니다."
									onclick="location.href='?currentPage=${i}&gup=${gup}'"
									style="background: none; border: 0; cursor: pointer;"
								>
									<span style="background: lavender; font-size: 25pt;">${i}</span>
								</button>
							</c:if>
						</c:forEach>
						
						<!-- 10페이지 뒤로 -->
						<c:if test="${foodList.endPage < foodList.totalPage}">
							<button 
								class='button button1' 
								type="button" 
								title="다음 10페이지로 이동합니다." 
								onclick="location.href='?currentPage=${foodList.endPage + 1}&gup=${gup}'"
								style="background: none; border: 0; cursor: pointer;"
							>▶</button>
						</c:if>
						<c:if test="${foodList.endPage >= foodList.totalPage}">
							<button 
								class='button button2' 
								type="button" 
								disabled="disabled" 
								title="이미 마지막 10페이지 입니다."
								style="background: none; border: 0; cursor: pointer;"
							>▶</button>
						</c:if>
						
						<!-- 마지막으로 -->
						<c:if test="${foodList.currentPage < foodList.totalPage}">
						<button
							type="button" 
							title="마지막 페이지로 이동합니다." 
							onclick="location.href='?currentPage=${foodList.totalPage}&gup=${gup}'"
							style="background: none; border: 0; cursor: pointer;"
						>▶▶</button>
						</c:if>
						<c:if test="${foodList.currentPage >= foodList.totalPage}">
							<button 
								type="button" 
								disabled="disabled" 
								title="이미 마지막 페이지 입니다."
								style="background: none; border: 0; cursor: pointer;"
							>▶▶</button>
						</c:if>
					</td>
				</tr> 
		        <tr style="height: 60px;">
		        <input type="hidden" value="${rvo.id}" id="id" name="id"/>
				   	<td colspan="8" align="center">
						<button type="button" onclick="addData()" style="background: none; border: 0; cursor: pointer;">
							<span style="background: lavender; font-size: 30px; font-weight: 900;">가져오기</span>
						</button>&nbsp;&nbsp;&nbsp;
						<button type="button" onclick="history.back()" style="background: none; border: 0; cursor: pointer;">
							<span style="background: lavender; font-size: 30px; font-weight: 900;">돌아가기</span>
						</button>
				   	</td>
			   	</tr>
		    	</table>
		   </form>
   </div>
</div>
</body>
</html>