<%@page import="com.foodary.foodary.FoodaryCalendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인화면 로그인</title>
<script type="text/javascript" src="./js/jquery-3.7.0.js"></script>
<style type="text/css">
	tr {
		height: 30px;
	}
	
	th {
		font-size: 10pt;
		width: 30px;
		text-align: center;
	}
	th#sunday {
		color: red;
	}
	th#saturday {
		color: blue;
	}
	td {
	    font-size: 10pt;
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
<%
Calendar calendar = Calendar.getInstance();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH) + 1;
	try {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		
		if (month >= 13) {
	year++;
	month = 1;
		} else if (month <= 0) {
	year--;
	month = 12;
		}
	} catch (NumberFormatException e) {
		
	}
%>
<form action="?" method="post">
   <table width="290" align="center" cellpadding="5" cellspacing="2">
	<tr>
		<th>
			<input 
				class="button button1" 
				type="button"
				value="◀" 
				onclick="location.href='?year=<%=year%>&month=<%=month - 1%>'"
			>
		</th>
		<th id="title" colspan="5" style="font-size: 15pt;">
			<%=year%>년 <%=month%>월
		</th>
		<th>
			<button type="button" 
				class="button button2"
				onclick="location.href='?year=<%=year%>&month=<%=month + 1%>'">
				▶
			</button>
		</th>
	</tr>
	<tr>
		<th id="sunday" style="font-size: 13pt;">일</th>
		<th style="font-size: 13pt;">월</th>
		<th style="font-size: 13pt;">화</th>
		<th style="font-size: 13pt;">수</th>
		<th style="font-size: 13pt;">목</th>
		<th style="font-size: 13pt;">금</th>
		<th id="saturday" style="font-size: 13pt;">토</th>
	</tr>
	<tr>
	
<%
	int week = FoodaryCalendar.weekDay(year, month, 1);
		int start = 0;
		if (month == 1) {
			start = 31 - week;
		} else {
			start = FoodaryCalendar.lastDay(year, month - 1) - week;
		}

		for (int i=0; i<week; i++) {
			if (i == 0) {
		out.println("<td><span id='beforesun' style='font-size: 11pt;'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</span></td>");
			} else {
		out.println("<td><span class='before'  style='font-size: 11pt;'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</span></td>");
			}
		}

		for(int i=1; i<=FoodaryCalendar.lastDay(year, month); i++) {
			switch (FoodaryCalendar.weekDay(year, month, i)) {
		case 0: 
			out.println("<td><span class='sun'  style='font-size: 13pt; font-weight: 800;'>" + i + "</span></td>");
			break;
		case 6: 
			out.println("<td><span class='sat'  style='font-size: 13pt; font-weight: 800;'>" + i + "</span></td>");
			break;
		default:
			out.println("<td><span style='font-size: 13pt; font-weight: 800;'>" + i + "</span></td>");
			break;
			}
			
			if (FoodaryCalendar.weekDay(year, month, i) == 6 && i != FoodaryCalendar.lastDay(year, month)) {
		out.println("</tr><tr>");
			}
		}

		if (month == 12) {
			week = FoodaryCalendar.weekDay(year + 1, 1, 1);
		} else {
			week = FoodaryCalendar.weekDay(year, month + 1, 1);
		}

		if (week != 0) {
			start = 1;
			for (int i=week; i<=6; i++) {
		if (i == 6) {
			out.println("<td><span id='aftersat'  style='font-size: 11pt;'>" + (month == 12 ? 1 : month + 1) + "/" + start++ + "</span></td>");
		} else {
			out.println("<td><span class='after'  style='font-size: 11pt;'>" + (month == 12 ? 1 : month + 1) + "/" + start++ + "</span></td>");
		}
			}
		}
	%>
	</tr>
</table>
 </form>
</body>
</html>