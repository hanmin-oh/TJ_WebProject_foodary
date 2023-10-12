<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 보기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="../css/threeGrid.css"/>
<script type="text/javascript" src="../js/setting.js" defer="defer"></script>
<script defer type="text/javascript" src="../js/FreeboardComment.js"></script>
<script defer type="text/javascript" src="../js/contentview.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body onload = "showNutrient()">
<body>
<div class="container">
	<div class="header">
	   <jsp:include page="./headerAfter.jsp"></jsp:include>
	</div>
	<div class="main" style="text-align: center;" align="center">
<input id="id" type="hidden" name="id" value="${rvo.id}"/>
<input id="height" type="hidden" name="height" value="${rvo.height}">
<input id="currentWeight" type="hidden" name="currentWeight" value="${rvo.currentWeight}">
<input id="goalWeight" type="hidden" name="goalWeight" value="${rvo.goalWeight}">
<input id="age" type="hidden" name="age" value="${rvo.age}">
<input id="gender" type="hidden" name="gender" value="${rvo.gender}"/>
<c:if test="${rvo.state eq 'health'}">
    <input id="health" type="radio" name="mode" value="health" checked="checked" style="display: none;"/>
    <input id="diet" type="radio" name="mode" value="diet" style="display: none;"/>
</c:if>
<c:if test="${rvo.state eq 'diet'}">
    <input id="health" type="radio" name="mode" value="health" style="display: none;"/>
    <input id="diet" type="radio" name="mode" value="diet" checked="checked" style="display: none;"/>
</c:if>
<c:set var="active" value="${rvo.active}"/>
<select name="active" style="height: 40px; display: none;">
   <option value="다시" name="active" 
      <c:if test="${active == '다시'}">selected="selected"
      </c:if>>활동량 선택
   </option>
     <option value="1.2" name="active" 
        <c:if test="${active == '1.2'}">selected="selected"
        </c:if>>많이 앉아있는 경우
     </option>
   <option value="1.375" name="active" 
      <c:if test="${active == '1.375'}">selected="selected"
      </c:if>>앉아있는 일이 적은 경우
   </option>
   <option value="1.55" name="active" 
      <c:if test="${active == '1.55'}">selected="selected"
      </c:if>>움직임이 많은 경우
   </option>
   <option value="1.725" name="active" 
      <c:if test="${active == '1.725'}">selected="selected"
      </c:if>>운동 될 움직임을 할 경우
   </option>
   <option value="1.9" name="active" 
      <c:if test="${active == '1.9'}">selected="selected"
      </c:if>>매우 많은 운동량
   </option>
</select>
	<div class="main">
		<table style="width: 1000px; margin-left: auto; margin-right: auto; margin-top: 10px; " class="table table-sm">
			<%-- <c:if test="${rvo.admin eq 'Y'}">
				<tr>
					<th colspan="4" style="text-align: center; background: #e0ffe9;">공지글</th>
				</tr>
			</c:if> --%>
			<tr style="font-weight: 800;">
				<td style="width: 100px; text-align: center; background: #e0ffe9;">
					<span style="font-size: 22pt;">No.</span>
				</td>
				<td style="width: 350px; text-align: center; background: #e0ffe9;">
					<span style="font-size: 22pt;">이름</span>
				</td>
				<td style="width: 150px; text-align: center; background: #e0ffe9;">
					<span style="font-size: 22pt;">작성일</span>
				</td>
				<td style="width: 100px; text-align: center; background: #e0ffe9;">
					<span style="font-size: 22pt;">조회수</span>
				</td>
			</tr>
			<tr>
				<td align="center" style="font-size: 22pt;">${vo.idx}</td>
				<td align="center" style="font-size: 22pt;">
					<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}"/>
					<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
					${name}
				</td>
				<td align="center" style="font-size: 22pt;">
					<jsp:useBean id="date" class="java.util.Date"/>
					<c:if test="${date.year == vo.writeDate.year && date.month == vo.writeDate.month &&
						date.date == vo.writeDate.date}">
						<fmt:formatDate value="${vo.writeDate}" pattern="a h:mm:ss"/>
					</c:if>
					<c:if test="${date.year != vo.writeDate.year || date.month != vo.writeDate.month ||
						date.date != vo.writeDate.date}">
						<fmt:formatDate value="${vo.writeDate}" pattern="yyyy.MM.dd(E)"/>
					</c:if>
				</td>
				<td align="center" style="font-size: 22pt;">${vo.hit}</td>
			</tr>
			<tr>
				<th style="text-align: center; vertical-align: middle; background: #fffdf5;">
					<span style="font-size: 22pt;">제목</span>
				</th>
			 	<td colspan="3" style="font-size: 22pt;  margin-bottom: 20px;" align="center">
					<c:set var="subject" value="${fn:replace(vo.subject, '<', '&lt;')}"/>
					<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
					${subject}
				</td>
			</tr>
			<tr style="padding: 30px;"
			></tr>
			<tr>
				<th style="text-align: center; vertical-align: middle; background: #fffdf5;">
					<span style="font-size: 22pt;">내용</span>
				</th>
				<td colspan="3" style="font-size: 22pt; padding: 10px;">
					<c:set var="content" value="${fn:replace(vo.content, '<', '&lt;')}"/>
					<c:set var="content" value="${fn:replace(content, '>', '&gt;')}"/>
					<c:set var="content" value="${fn:replace(content, enter, '<br/>')}"/>
					${content}<br/>
				</td>
			</tr>
			<c:if test="${not empty vo.picture}">
				<tr>
					<td align="center" colspan="4" style="text-align: center;">
						<img src="../upload/freeboard/${vo.picture}" style="max-width: 450px; max-height: 300px;" />
					</td>
				</tr>
			</c:if>
			<!-- 식단 내용과 그래프를 넣는 공간 -->
			<tr class="table-secondary">
			<c:if test="${!shareDietList.isEmpty()}">
			<table style="width: 1000px; margin-left: auto; margin-right: auto; margin-top: 10px;" class="table table-hover table-sm">
			    <c:set var="previousDate" value="" />
			    <c:set var="previousTime" value="" />
			    <c:forEach items="${shareDietList}" var="svo" varStatus="status">
			    <!-- 식단 날짜 행 -->
			    <tr>
			    	   <c:if test="${!svo.dietDate.equals(previousDate)}">
			                <td colspan="7" style="background: #f7f2ff;">
			                    ${svo.dietDate}
			                </td>
			        </c:if>
			    </tr>
			     <!-- 목차 행 -->
			     <tr>
			        	<c:if test="${!svo.dietTime.equals(previousTime)}">
			        <th style="text-align: center; vertical-align: middle; background: #888dff;">시간</th>
			                <th>
			                    ${svo.dietTime}
			                </th>
		                  <tr>
					        <th>음식 이름</th>
					        <th>칼로리</th>
					        <th>탄수화물</th>
					        <th>단백질</th>
					        <th>지방</th>
					    </tr>
			            </c:if>
			       </tr>
			 
			       <c:if test="${!svo.dietTime.equals(previousTime)}">
			    </c:if>
			      <!-- 식단 데이터 반복 행 -->
			        <tr>
			            <th style="text-align: center; vertical-align: middle;">
			                <input type="text" id="foodName_${status.index}" name="foodName_${status.index}" value="${svo.foodName}" 
			                	style="border: none; width: 100%; text-align: center;" readonly="readonly"/>
			            </th>
			            <th class="kcals" id="kcal">
			                <input type="text" id="kcal_${status.index}" name="kcal_${status.index}" value="${svo.kcal}" 
			                	style="border: none; width: 30%; height: 10%; text-align: center;" readonly="readonly"/>kcal
			            </th>
			            <th>
			                <input type="text" id="carbs_${status.index}" name="carbs_${status.index}" value="${svo.carbs}" 
			                	style="border: none; width: 30%; height: 10%; text-align: center;" readonly="readonly"/>g
			            </th>
			            <th>
			                <input type="text" id="protein_${status.index}" name="protein_${status.index}" value="${svo.protein}" 
			                	style="border: none; width: 30%; height: 10%; text-align: center;" readonly="readonly"/>g
			            </th>
			            <th>
			                <input type="text" id="fat_${status.index}" name="fat_${status.index}" value="${svo.fat}" 
			                	style="border: none; width: 30%; height: 10%; text-align: center;" readonly="readonly"/>g
			            </th>
			        </tr>
			        <c:set var="previousDate" value="${svo.dietDate}" />
			        <c:set var="previousTime" value="${svo.dietTime}" />
			    </c:forEach>
			</table>
			
				  <table style="width: 1000px; margin-left: auto; margin-right: auto;">
				     <tr>
				     	<th style="width: 200px;">
				         <span style="background: lavender; font-size: 23pt;">칼로리</span>
				        </th>
				        <td style="height: 40px; text-align: left; width: 800px;">
				          <div class="progress" style="height: 30px; width: 700px; margin-left: auto; margin-right: auto;">
				            <div id="kcalGraph" class="progress-bar" role="progressbar" 
				            aria-valuemin="0" style="width:0%; height: 30px; font-size: 15pt; background: #8800ff;">
				            </div>
				          </div>
				        </td>   
				     </tr>
				          <tr>
					        <th style="width: 200px;">
					            <span style="background: lavender; font-size: 23pt;">탄수화물</span>
					        </th>
				          <td style="height: 40px; text-align: left; width: 800px;">
				              <div class="progress" style="height: 30px; width: 700px; margin-left: auto; margin-right: auto;">
				                <div id="carbsGraph" class="progress-bar progress-bar-info" role="progressbar" 
				                   aria-valuemin="0" style="width:0%; height: 30px; font-size: 15pt; background: #8800ff;">
				                   
				                </div>
				              </div>
				           </td>
				          </tr>
				          <tr>
				          	<th style="width: 200px;">
				                <span style="background: lavender; font-size: 23pt;">단백질</span>
				          	</th>
				           <td style="height: 40px; text-align: left; width: 800px;">
				              <div class="progress" style="height: 30px; width: 700px; margin-left: auto; margin-right: auto;">   
				                   <div id="proteinGraph" class="progress-bar progress-bar-info" role="progressbar"
				                      aria-valuemin="0" style="width:0%; height: 30px; font-size: 15pt; background: #8800ff;">
				                      
				                   </div>
				              </div>
				           </td>
				          </tr>
				        <tr>
				          <th style="width: 200px;">
				              <span style="background: lavender; font-size: 23pt;">지방</span>
				          </th>
				          <td style="height: 40px; text-align: left; width: 800px;">
				            <div class="progress" style="height: 30px; width: 700px; margin-left: auto; margin-right: auto;">
				               <div id="fatGraph" class="progress-bar progress-bar-info" role="progressbar"
				                     aria-valuemin="0" style="width:0%; height: 30px; font-size: 15pt; background: #8800ff;">
				               </div>
				            </div>
				          </td>
				    	</tr>
				  </table>
		   </c:if>
			</tr>
			<tr class="table-secondary">
				<td colspan="4" align="center">
					<c:if test="${rvo.id eq vo.id}">
					<button 
						type="button" 
						style="background: none; border: 0; cursor: pointer;"
						onclick="location.href='selectByIdx?idx=${vo.idx}&currentPage=${currentPage}&job=update'">
						<span style="background: #fafcd9; font-size: 25pt;; font-weight: 800;">수정하기</span></button>&nbsp;&nbsp;&nbsp;
					<button
						type="button" 
						style="background: none; border: 0; cursor: pointer;"
						onclick="location.href='selectByIdx?idx=${vo.idx}&currentPage=${currentPage}&job=delete'">
						<span style="background: #fafcd9; font-size: 25pt;; font-weight: 800;">삭제하기</span></button>&nbsp;&nbsp;&nbsp;
					</c:if>
					<button
						type="button" 
						style="background: none; border: 0; cursor: pointer;"
						onclick="location.href='listView?currentPage=${currentPage}'">
						<span style="background: #fafcd9; font-size: 25pt;; font-weight: 800;">목록보기</span></button>
				</td>
				</td>
			</tr>
		</table>
	<br/>
	<hr style="color: gray; width: 1000px; margin-left: auto; margin-right: auto;"/>
	<br/>
	<!-- 댓글 폼 -->
		<form action="commentOK" method="post" name="commentForm" onsubmit="return insertCheck()">
			<table style="width: 700px; margin-left: auto; margin-right: auto; margin-top: 10px; " class="table table-sm">
				<tr>
					<th colspan="4" style="text-align: center;"><span style="background: #baffda; font-size: 40px;">댓글</span></th>
				</tr>
			
				<!-- 이 줄은 원래 보이면 안되는 줄로 작업이 완료되면 화면에 표시되지 않게 한다. -->
				<!-- <tr> -->
				<tr style="display: none;">
					<td colspan="4">
						idx: <input id="idx" type="text" name="idx" value="${vo.idx}" size="1"/>
						gup: <input type="text" name="gup" value="${vo.idx}" size="1"/>
						mode: <input type="text" name="mode" value="1" size="1"/>
						currentPage: <input id="currentPage" type="text" name="currentPage" value="${currentPage}" size="1"/>
						ip: <input type="text" name="ip" value="${pageContext.request.remoteAddr}"/>
					</td>
				</tr>
				<tr style="padding: 20px;"></tr>
				<tr style="margin-bottom: 20px; padding: 10px;">
					<th style="background: #fffdf5; text-align: center; vertical-align: middle;">
						<span style="font-size: 22pt;">이름: </span>
					</th>
					<td style="width: 250px;">
						<input id="name" type="text" name="name" value="${rvo.username}" readonly="readonly"
							style="text-align: center; border: 0px; font-size: 22pt; "/>
					</td>
				</tr>
				<tr></tr>
				<input id="id" type="hidden" name="id" value="${rvo.id}"/>
				<tr>
					<th style="background: #fffdf5; text-align: center; vertical-align: middle;">
						<span style="font-size: 22pt;">내용: </span>
					</th>
					<td colspan="3" style="width: 600px;">
						<textarea 
							id="ccontent"
							rows="3"
							name="content"
							style="resize: none; width: 95%; height: 70%; vertical-align: middle; padding: 10px; margin-left: 10px;
					               border: 2px solid #956fd6; border-radius: 30px;"></textarea>
					</td>
				</tr>
				<tr style="margin-bottom: 20px;">
					<td colspan="4" align="center">
						<button 
							type="submit" 
							style="background: none; border: 0; cursor: pointer;"
							name="commentBtn"
							>
							<span id="commentBtnText" style="background: lavender; font-size: 25pt; font-weight: 800;">댓글저장</span>
						</button>&nbsp;&nbsp;&nbsp;
						<button 
							type="reset" 
							style="background: none; border: 0; cursor: pointer;"
							onclick="setting(0, 1, '댓글저장', '', '')">
							<span style="background: lavender; font-size: 25pt; font-weight: 800;">다시쓰기</span>
						</button>
					</td>
				</tr>
				<!-- 댓글을 출력한다. -->
				<c:set var="comment" value="${freeboardCommentList.list}"></c:set>
				
				<!-- 댓글이 없는 경우 -->
				<c:if test="${comment.size() == 0}">
				<tr>
					<td colspan="4" style="text-align: center; vertical-align: middle;">
						<marquee>아직 작성된 댓글이 없습니다ㅠㅡㅜ</marquee>
					</td>
				</tr>
				</c:if>
				<!-- 댓글이 있는 경우 -->
				<c:if test="${comment.size() != 0}">
				<c:forEach var="co" items="${comment}">
				<tr>
					<td colspan="4">
						<span style="background: lavender; font-weight: 600;">
						<c:set var="name" value="${fn:replace(co.name, '<', '&lt;')}"/>
						<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
						${name}&nbsp;
						<fmt:formatDate value="${co.writeDate}" pattern="yyyy.MM.dd(E) HH:mm:ss"/></span>
						<div align="right">
							<!-- 글에 저장되어있는 정보와 현재 로그인중인 회원 정보가 일치하면 아래 버튼 다 나오고 다르면  -->
							<c:if test="${rvo.id eq co.id}">
								<button
									type="button" 
									style="background: none; border: 0; cursor: pointer;"
									onclick="setting(${co.idx}, 2, '댓글수정', '${name}', '${co.content}')">
									<span style="background: #fafcd9; font-size: 20pt;; font-weight: 800;">수정하기</span>
								</button>&nbsp;&nbsp;&nbsp;
								<button
									type="button" 
									style="background: none; border: 0; cursor: pointer;"
									onclick="setting(${co.idx}, 3, '댓글삭제', '${name}', '${co.content}')">
									<span style="background: #fafcd9; font-size: 20pt;; font-weight: 800;">삭제하기</span>
								</button>
							</c:if>
						</div>
						<c:set var="content" value="${fn:replace(co.content, '<', '&lt;')}"/>
						<c:set var="content" value="${fn:replace(content, '>', '&gt;')}"/>
						<c:set var="content" value="${fn:replace(content, enter, '<br/>')}"/>
						${content}<br><br>
					</td>
				</tr>
				<tr></tr><tr></tr><tr></tr><tr></tr>
				</c:forEach>
				</c:if>
			</table>
		</form>
		<br/>
	</div>
	<div class="footer">
		<jsp:include page="./footerAfter.jsp"></jsp:include>
	</div>
</div>
</body>
</html>











