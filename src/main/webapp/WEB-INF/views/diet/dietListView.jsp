
<%@page import="com.foodary.foodary.FoodaryCalendar"%>
<%@page import="com.foodary.vo.UserFoodList"%>
<%@page import="com.foodary.vo.UserFoodVO"%>
<%@page import="com.foodary.vo.DietList"%>
<%@page import="java.sql.Time"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.foodary.vo.DietVO"%>
<%@page import="com.foodary.vo.UserRegisterVO"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<!-- 날짜 -->
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jstl -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식단 목록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/threeGrid.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">
	th {font-size: 20pt; text-align: center;}
	th#sunday {
		color: red;
	}
	th#saturday {
		color: blue;
	}
	td {
	    font-size: 15pt;
		text-align: center;
	}
	td.sun {
		color: red;
	}
	td.sat {
		color: blue;
	}
	.button {
		background: white;
		border: 0;
	}
	button {
		background: white;
		border: 0;
	}
</style>
</head>
<body>
<div class="container">
   <div class="header">
      <jsp:include page="./headerAfter.jsp"></jsp:include>
   </div>
   <div class="main" style="display: flex;">
<%
   request.setCharacterEncoding("UTF-8");
%>
		<!-- =========================================== 달 력 ==================================================== -->   
		   <%
		   request.setCharacterEncoding("UTF-8"); 
		   String dietWriteDate = request.getParameter("dietWriteDate");
		   String id = request.getParameter("id");
		   DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		   LocalDate date = LocalDate.parse(dietWriteDate, formatter);
		
		   Calendar calendar = Calendar.getInstance();
		   int year = calendar.get(Calendar.YEAR);
		   int month = calendar.get(Calendar.MONTH) + 1;
		   int day = calendar.get(Calendar.DATE); 
		   
		   year = date.getYear();
		   month = date.getMonthValue();
		   day = date.getDayOfMonth();
		
		   try {
		      year = Integer.parseInt(request.getParameter("year"));
		      month = Integer.parseInt(request.getParameter("month"));
		      day = 1;
		      
		      if(month >= 13) {
		         year++;
		         month = 1;
		      }else if(month <= 0) {
		         year--;
		         month = 12;
		      }
		   }catch(NumberFormatException e) { }
		 	%>
	<div>
		<table width="600" height="600" border="0" align="center" cellpadding="10" cellspacing="20" style="text-align: center;">
		   <tr>
			<th>
				<c:if test="<%=month == 1%>">
					<button type="button" 
						onclick="location.href='dietListView?dietWriteDate=<%=year-1%>-12-01&id=${rvo.id}'"
					>◀</button>
				</c:if>
				<c:if test="<%=month != 1%>">
					<c:if test="<%=month <= 10%>">
						<button type="button" 
							onclick="location.href='dietListView?dietWriteDate=<%=year%>-0<%=month-1%>-01&id=${rvo.id}'"
						>◀</button>
					</c:if>
				</c:if>				
				<c:if test="<%=month > 10%>">
					<button type="button" 
						onclick="location.href='dietListView?dietWriteDate=<%=year%>-<%=month-1%>-01&id=${rvo.id}'"
					>◀</button>
				</c:if>
			</th>					   
	     	<th id="title" colspan="5">
	        	<span style="background: #baffda; font-size: 35pt; font-weight: 900;"><%=year%>년 <%=month%>월</span>
	     	</th>
	     	<th>
		    	<c:if test="<%=month == 12%>">
					<button type="button" 
						onclick="location.href='dietListView?dietWriteDate=<%=year+1%>-01-01&id=${rvo.id}'"
					>▶</button>
				</c:if>
				<c:if test="<%=month != 12%>">
					<c:if test="<%=month < 9%>">
						<button type="button" 
							onclick="location.href='dietListView?dietWriteDate=<%=year%>-0<%=month+1%>-01&id=${rvo.id}'"
						>▶</button>
					</c:if>
					<c:if test="<%=month >= 9%>">
						<button type="button" 
							onclick="location.href='dietListView?dietWriteDate=<%=year%>-<%=month+1%>-01&id=${rvo.id}'"
						>▶</button>
					</c:if>
				</c:if>				
			</th>	  
		      
		   </tr>   
		   <tr>
		      <th id="sunday" style="color: red; font-size: 25pt;">일</th>
		      <th style="font-size: 25pt;">월</th>
		      <th style="font-size: 25pt;">화</th>
		      <th style="font-size: 25pt;">수</th>
		      <th style="font-size: 25pt;">목</th>
		      <th style="font-size: 25pt;">금</th>
		      <th id="saturday" style="color: blue; font-size: 25pt;">토</th>
		   </tr>   
		   <!-- 달력에 날짜를 출력한다. -->
		   <tr>
		<%
		   int week = FoodaryCalendar.weekDay(year, month, 1);
		//   빈 칸에 출력할 전달 날짜의 시작일
		   int start = 0;
		
		   if(month == 1) {
		      start = 31 - week;
		   }else {
		      start = FoodaryCalendar.lastDay(year, month - 1) - week; // 2 ~ 12월
		   }
		//   1일이 출력될 위치(요일)을 맞추기 위해 달력을 출력할 달 1일의 요일만큼 반복하며 전 달의 날짜를 출력한다.
		   for(int i=0; i<week; i++) { 
		      if(i == 0) {
		         out.println("<td></td>");         
		      }else {
		         out.println("<td></td>");                  
		      }
		   }
		//   1일부터 달력을 출력할 달의 마지막 날짜까지 반복하며 날짜를 출력한다.
		   for(int i=1; i<=FoodaryCalendar.lastDay(year, month); i++) {
		         switch(FoodaryCalendar.weekDay(year, month, i) % 7) {
		            case 0:  // 일요일
		               out.println("<td><a style='text-decoration: none; color: black; cursor: pointer;'" +
		            		"href='dietListView?dietWriteDate=" + year + "-" + 
		               		String.format("%02d", month) + "-" + String.format("%02d", i) + "&id=" + id +"'>" + i + "</a></td>");
		               break;
		            case 6:  // 토요일
		               out.println("<td><a style='text-decoration: none; color: black; cursor: pointer;'" +
		            	"href='dietListView?dietWriteDate=" + year + "-" +
		               	String.format("%02d", month) + "-" + String.format("%02d", i) + "&id=" + id + "'>" + i + "</a></td>");
		               break;
		            default:  // 평일
		               out.println("<td><a style='text-decoration: none; color: black; cursor: pointer;'" +
		            	"href='dietListView?dietWriteDate=" + year + "-" + 
		               	String.format("%02d", month) + "-" + String.format("%02d", i) + "&id=" + id + "'>" + i + "</a></td>");
		               break;
		         } 
		      //   출력한 날짜(i)가 토요일이고 그 달의 마지막 날짜가 아니면 줄을 바꾼다.
			      if(FoodaryCalendar.weekDay(year, month, i) == 6 && i != FoodaryCalendar.lastDay(year, month)) {
			         out.println("</tr><tr>");
			      }   
		      }
		//    다음달 1일의 요일을 계산한다.
		   if(month == 12) {
		      week = FoodaryCalendar.weekDay(year + 1, 1, 1); // 12월
		   }else {
		      week = FoodaryCalendar.weekDay(year, month + 1, 1); // 1 ~ 11월
		   }
		%>
		   
		   </tr>
		   <tr style="height: 50px;"></tr>
		   <!-- 년, 월을 선택된 년도와 달의 달력으로 한번에 넘어가게 한다. -->
		   <tr>
			<td id="choice" colspan="7" >
			   <form action="?dietWriteDate=<%=year%>-<%=String.format("%02d", month)%>-<%=String.format("%02d", day)%>&id=${rvo.id}" method="post" onsubmit="navigateToSelectedMonth(event)">
			         <select class="select" name="year" style="width:100px; height: 40px;">
			<%
			            for(int i=1900; i<=2100; i++) {
			               if(calendar.get(Calendar.YEAR) == i) {
			                  out.println("<option selected='selected'>" + i + "</option>");               
			               }else {
			                  out.println("<option>" + i + "</option>");                     
			               }
			            }
			%>                  
			         </select> 년&nbsp; &nbsp;
			         <select class="select" name="month" style="width:100px; height: 40px;">
			<%
			            for(int i=1; i<=12; i++) {
			               if(calendar.get(Calendar.MONTH) + 1 == i) {
			                  out.println("<option selected='selected'>" + i + "</option>");   
			               }else {
			                  out.println("<option>" + i + "</option>");               
			               }
			            }
			%>                     
			         </select> 월&nbsp; &nbsp;
			         <button class="select" type="submit" style="background: none; border: 0; cursor: pointer;">
			         	<span style="background: lavender; font-size: 27pt; font-weight: 900;">달력 보기</span>
			         </button>
			      </form> 
			     </td>
			   </tr>
			</table>
	</div>
	<div style="margin-left: 120px;">
		  <div class="diet-table">
		   <br>
		      <span style="background: #fafcd9; font-size: 27pt; font-weight: 900;">${dietWriteDate} 식단 목록</span><br/><br/>
		      
			    <table width="400" border="0" align="center">
			      <c:set var="list" value="${dietList.list}"/>
				       <c:forEach var="dvo" items="${list}">
				         <tr>
				            <th>
				            	<a href="dietView?dietWriteDate=${dvo.dietWriteDate}&dietWriteTime=${dvo.dietWriteTime}&id=${rvo.id}"
				            	style="text-decoration: none; color: black; cursor: pointer;">
				            	<span style="background: #baffda; font-size: 25pt; font-weight: 900;">${dvo.dietWriteTime}</span> &nbsp;&nbsp;
				            	</a>
				            </th>
				      	<c:set var="list" value="${userFoodList.list}"/>
					        <td>
	 					       <c:forEach var="uvo" items="${list}" varStatus="status">
	 					       <c:if test="${dvo.gup == uvo.gup}">
					                  <span style="font-size: 25pt;">${uvo.foodName}</span> &nbsp
					          </c:if>
						      </c:forEach>
				            </td>
				         </tr>
		               </c:forEach>
	      		</table><br/><br/>
	      			<div style="text-align: right;">
		               <c:if test="${list.size() != 0}">
			               	 	<button type="button" 
				                     style="background: none; border: 0; 
				                     cursor: pointer;"
				                     onclick="location.href='dietViewAll?dietWriteDate=${dietWriteDate}&id=${rvo.id}'">
				                     <span style="background: lavender; font-size: 27pt; font-weight: 900;">전체 보기</span>
				               </button>
			          	</c:if>
			       	</div>
	   		</div>
		</div>
	</div>
   <div class="footer">
      <jsp:include page="./footerAfter.jsp"></jsp:include>
   </div>
</div>
</body>
</html>