<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="../css/threeGrid.css"/>
</head>
<body>
${result}
<div class="container">
	<div class="header">
	   <jsp:include page="./headerAfter.jsp"></jsp:include>
	</div>
	<div class="main">
		<table style="width: 1000px; margin-left: auto; margin-right: auto;" cellpadding="5" cellspacing="8">
			<tr>
				<th colspan="5" style="text-align: center;">
					<span style="background: #baffda; font-size: 40px;">< 자유게시판 ></span>
				</th>
			</tr>
			<tr>
				<td colspan="5" align="right">
					<span style="background: #fafcd9;">${freeboardList.totalCount}(${freeboardList.currentPage} / ${freeboardList.totalPage})</span> 
				</td>
			</tr>
			<tr style="font-weight: 800;">
				<td style="width: 70px; text-align: center;"><span style="background: lavender;">No.</span></td>
				<td style="width: 610px; text-align: center;"><span style="background: lavender;">제목</span></td>
				<td style="width: 100px; text-align: center;"><span style="background: lavender;">이름</span></td>
				<td style="width: 150px; text-align: center;"><span style="background: lavender;">작성일</span></td>
				<td style="width: 70px; text-align: center;"><span style="background: lavender;">조회수</span></td>
			</tr>
			<tr></tr>
		</table>
		<hr style="width: 1000px; margin-left: 200px; margin-bottom: 5px;">
		<table style="width: 1000px; margin-left: auto; margin-right: auto;" cellpadding="5" cellspacing="8">
		<tr></tr>
			<!-- 오늘 날짜를 기억하는 Date 클래스 객체를 useBean으로 만든다. -->
			<jsp:useBean id="date" class="java.util.Date"/>
			
			<!-- 공지글을 출력한다. -->
			<c:if test="${currentPage == 1}">
			<c:forEach var="vo" items="${notice}">
			<tr>
				<td align="center" style="width: 70px;">
					[공지]
				</td>
				<td align="center" style="width: 610px;">
					<c:set var="subject" value="${fn:replace(vo.subject, '<', '&lt;')}"/>
					<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
					<a href="increment?idx=${vo.idx}&currentPage=${currentPage}" style="color: black; text-decoration: none;">
						${subject}(${vo.commentCount})
					</a>
				</td>
				<td align="center" style="width: 100px;">
					<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}"/>
					<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
					${name}
				</td>
				<td align="center" style="width: 150px;">
					<c:if test="${date.year == vo.writeDate.year && date.month == vo.writeDate.month &&
						date.date == vo.writeDate.date}">
						<fmt:formatDate value="${vo.writeDate}" pattern="a h:mm:ss"/>
					</c:if>
					<c:if test="${date.year != vo.writeDate.year || date.month != vo.writeDate.month ||
						date.date != vo.writeDate.date}">
						<fmt:formatDate value="${vo.writeDate}" pattern="yyyy.MM.dd(E)"/>
					</c:if>
				</td>
				<td align="center" style="width: 70px;">${vo.hit}</td>
			</tr>
			</c:forEach>
			</c:if>
			
			<!-- 메인글을 출력한다. -->
			<!-- list.jsp에서 request 영역에 저장한 freeboardList에서 1페이지 분량의 글을 꺼내온다. -->
			<c:set var="list" value="${freeboardList.list}"/>
		
			<!-- 메인글이 1건도 없으면 글이 없다고 출력한다. -->
			<c:if test="${list.size() == 0}">
			<tr>
				<td colspan="5">
					<marquee>저장된 글이 없습니다 1등으로 글을 남겨보세용가리</marquee>
				</td>
			</tr>
			</c:if>
			
			<!-- 메인글이 있으면 메인글의 개수만큼 반복하며 글 제목을 출력한다. -->
			<c:if test="${list.size() != 0}">
			<c:forEach var="vo" items="${list}">
			<tr>
				<c:if test="${vo.gup != 0}">
					<td align="center" style="width: 70px;">[식단공유]${vo.idx}</td>
				</c:if>
				<td align="center" style="width: 70px;">${vo.idx}</td>
				<td style="width: 610px; text-align: center;">
					<!-- 제목에 태그를 적용할 수 없게 한다. -->
					<c:set var="subject" value="${fn:replace(vo.subject, '<', '&lt;')}"/>
					<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
					
					<!-- 제목에 하이퍼링크를 걸어준다. -->
					<!-- 하이퍼링크를 클릭하면 조회수를 증가시키고 클릭한 메인글의 내용을 표시한다. -->
					<a href="increment?idx=${vo.idx}&currentPage=${currentPage}" style="color: black; text-decoration: none;">
						${subject}(${vo.commentCount})
					</a>
					<c:if test="${vo.gup != 0}">
					<!-- 하이퍼링크를 클릭하면 조회수를 증가시키고 클릭한 메인글의 내용을 표시한다. -->
					<a href="shareIncrement?idx=${vo.idx}&currentPage=${currentPage}&gup=${gup} style="color: black; text-decoration: none;">
						${subject}(${vo.commentCount})
					</a>
					</c:if>
					
					<!-- 오늘 입력된 글에 new 아이콘 이미지를 표시한다. -->
					<c:if test="${date.year == vo.writeDate.year && date.month == vo.writeDate.month &&
						date.date == vo.writeDate.date}">
						<span style="background: navy; border: 0; border-radius: 5px; color: white; padding: 1px;">new</span>
					</c:if>
					
					<!-- 조회수가 일정 횟수를 넘어가면 hot 아이콘을 표시한다. -->
					<c:if test="${vo.hit > 10}">
						<span style="background: red; border: 0; border-radius: 5px; color: white; padding: 1px;">hot</span>
					</c:if>
				</td>
				<td align="center" style="width: 100px;">
					<!-- 이름에 태그를 적용할 수 없게 한다. -->
					<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}"/>
					<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
					${name}
				</td>
				<td align="center" style="width: 150px;">
					<!-- 오늘 입력된 글은 시간만 어제 이전에 입력된 글은 날짜만 출력한다. -->
					<c:if test="${date.year == vo.writeDate.year && date.month == vo.writeDate.month &&
						date.date == vo.writeDate.date}">
						<fmt:formatDate value="${vo.writeDate}" pattern="a h:mm:ss"/>
					</c:if>
					<c:if test="${date.year != vo.writeDate.year || date.month != vo.writeDate.month ||
						date.date != vo.writeDate.date}">
						<fmt:formatDate value="${vo.writeDate}" pattern="yyyy.MM.dd(E)"/>
					</c:if>
				</td>
				<td align="center" style="width: 70px;">${vo.hit}</td>
			</tr>
			</c:forEach>
			</c:if>
			<tr></tr><tr></tr><tr></tr>
			<!-- 페이지 이동 버튼 -->
			<tr>
				<td colspan="4" align="center">
					<!-- 처음으로 -->
					<c:if test="${freeboardList.currentPage > 1}">
						<button 
							type="button" 
							title="첫 페이지로 이동합니다." 
							onclick="location.href='?currentPage=1'" style="background: none; border: 0; font-size: 15pt; color: gray; cursor: pointer;"
						>◀◀</button>
					</c:if>
					<c:if test="${freeboardList.currentPage <= 1}">
						<button 
							type="button" 
							disabled="disabled" 
							title="이미 첫 페이지 입니다." style="background: none; border: 0; font-size: 15pt; color: gray;"
						>◀◀</button>
					</c:if>
					
					<!-- 10페이지 앞으로 -->
					<c:if test="${freeboardList.startPage > 1}">
						<button 
							type="button" 
							title="이전 10페이지로 이동합니다." 
							onclick="location.href='?currentPage=${freeboardList.startPage - 1}'" style="background: none; border: 0; font-size: 15pt; color: gray; cursor: pointer;"
						>◀</button>
					</c:if>
					<c:if test="${freeboardList.startPage <= 1}">
						<button 
							type="button" 
							disabled="disabled" 
							title="이미 첫 10페이지 입니다." style="background: none; border: 0; font-size: 15pt; color: gray;"
						>◀</button>
					</c:if>
					
					<!-- 페이지 이동 버튼 -->
					<c:forEach var="i" begin="${freeboardList.startPage}" end="${freeboardList.endPage}" step="1">
						<c:if test="${freeboardList.currentPage == i}">
							<button type='button' style="background: none; border: 0;"><span style="background: lavender; font-size: 25pt;">${i}</span></button>
						</c:if>
						<c:if test="${freeboardList.currentPage != i}">
							<button 
								type='button' 
								title="${i}페이지로 이동합니다." style="background: none; border: 0; font-size: 25pt; cursor: pointer;"
								onclick="location.href='?currentPage=${i}'"
							>${i}</button>
						</c:if>
					</c:forEach>
					
					<!-- 10페이지 뒤로 -->
					<c:if test="${freeboardList.endPage < freeboardList.totalPage}">
						<button 
							type="button" 
							title="다음 10페이지로 이동합니다." style="background: none; border: 0; font-size: 15pt; color: gray; cursor: pointer;"
							onclick="location.href='?currentPage=${freeboardList.endPage + 1}'"
						>▶</button>
					</c:if>
					<c:if test="${freeboardList.endPage >= freeboardList.totalPage}">
						<button 
							type="button"
							disabled="disabled" 
							title="이미 마지막 10페이지 입니다." style="background: none; border: 0;font-size: 15pt; color: gray;"
						>▶</button>
					</c:if>
					
					<!-- 마지막으로 -->
					<c:if test="${freeboardList.currentPage < freeboardList.totalPage}">
					<button
						type="button" 
						title="마지막 페이지로 이동합니다." style="background: none; border: 0;font-size: 15pt; color: gray; cursor: pointer;"
						onclick="location.href='?currentPage=${freeboardList.totalPage}'"
					>▶▶</button>
					</c:if>
					<c:if test="${freeboardList.currentPage >= freeboardList.totalPage}">
						<button 
							type="button" 
							disabled="disabled" style="background: none; border: 0; font-size: 15pt; color: gray;"
							title="이미 마지막 페이지 입니다."
						>▶▶</button>
					</c:if>
					
				</td>
				<td align="right">
					<button type="button" onclick="location.href='insert'" style="background: none; border:0;">
						<span style="background:#baffda; font-size: 30px; font-weight: 800; cursor: pointer;">글쓰기</span>
					</button>
				</td>
				<td align="right">
					<button type="button" onclick="location.href='shareInsert'" style="background: none; border:0;">
						<span style="background:#baffda; font-size: 30px; font-weight: 800; cursor: pointer;">식단공유</span>
					</button>
				</td>
			</tr>
		</table>
	</div>
	<div class="footer">
		<jsp:include page="./footerAfter.jsp"></jsp:include>
	</div>
</div>
</body>
</html>









