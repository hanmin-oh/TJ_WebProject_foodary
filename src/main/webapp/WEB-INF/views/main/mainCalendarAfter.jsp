<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.foodary.foodary.FoodaryCalendar"%>
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
		font-size: 15pt;
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
<%
Calendar calendar = Calendar.getInstance();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH) + 1;
	int hour = calendar.get(Calendar.HOUR);
	int minute = calendar.get(Calendar.MINUTE);
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
  <table width="450" height="300" align="center" cellpadding="5" cellspacing="5">
	<tr style="text-align: center;">
		<th>
			<button type="button" 
				onclick="location.href='foodaryMainPageAfter?year=<%=year%>&month=<%=month - 1%>'"
			>◀</button>
		</th>
		<th id="title" colspan="5">
			<span style="font-size: 25pt; background: #d2c2ff;"><%=year%>년 <%=month%>월</span>
		</th>
		<th>
			<button type="button" 
				onclick="location.href='foodaryMainPageAfter?year=<%=year%>&month=<%=month + 1%>'">
				▶
			</button>
		</th>
	</tr>
	<tr style="text-align: center;">
		<th id="sunday" style="font-size: 20pt;">일</th>
		<th style="font-size: 20pt;">월</th>
		<th style="font-size: 20pt;">화</th>
		<th style="font-size: 20pt;">수</th>
		<th style="font-size: 20pt;">목</th>
		<th style="font-size: 20pt;">금</th>
		<th id="saturday" style="font-size: 20pt;">토</th>
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
		String id = (String) session.getAttribute("id");
		String dietWriteDate = year + "-" + String.format("%02d", month) + "-";
		
		/* 이전 달 */
		for (int i=0; i<week; i++) {
			if (i == 0) {
				out.println("<td><a id='beforesun'" + 
				"style='font-size: 15pt; text-decoration: none; cursor: pointer; color: black;'" +
				"href='../diet/dietListView?dietWriteDate=" + year + "-" + String.format("%02d", (month == 1 ? 12 : month - 1)) + "-" +
				String.format("%02d", ++start) + "&id=" + id + "'>"
				+ (month == 1 ? 12 : month - 1) + "/" + start + "</a></td>");
			} else {
				out.println("<td><a class='before'" +
				"style='font-size: 15pt; text-decoration: none; cursor: pointer; color: black;'" +
				"href='../diet/dietListView?dietWriteDate="+ year + "-"  + String.format("%02d", (month == 1 ? 12 : month - 1)) + "-" + 
				String.format("%02d", ++start) + "&id=" + id + "'>"
				+ (month == 1 ? 12 : month - 1) + "/" + start + "</a></td>");
			}
		}
		/* 이번 달 */
		for(int i=1; i<=FoodaryCalendar.lastDay(year, month); i++) {
			switch (FoodaryCalendar.weekDay(year, month, i)) {
			
			case 0: 
				out.println("<td><a class='sun' style='font-size: 15pt; font-weight: 800; text-decoration: none; cursor: pointer; color: black;'" +
						"href='../diet/dietListView?dietWriteDate=" + dietWriteDate + String.format("%02d", i) + "&id=" + id +"'>"
					+ i + "</a></td>");
				break;
			case 6: 
				out.println("<td><a class='sat' style='font-size: 15pt; font-weight: 800; text-decoration: none; cursor: pointer; color: black;'" +
						"href='../diet/dietListView?dietWriteDate=" + dietWriteDate + String.format("%02d", i) + "&id=" + id +"'>"
					+ i + "</a></td>");
				break;
			default:
				out.println("<td><a id='day' style='font-size: 15pt; font-weight: 800; text-decoration: none; cursor: pointer; color: black;'" +
						"href='../diet/dietListView?dietWriteDate=" + dietWriteDate + String.format("%02d", i) + "&id=" + id +"'>"
					+ i + "</a></td>");
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

		/* 다음달 */
		if (week != 0) {
			start = 1;
			for (int i = week; i <= 6; i++) {
				if (i==6) {
					out.println("<td><a id='aftersat' style='font-size: 15pt; text-decoration: none; cursor: pointer; color: black;'"
						+ "href='../diet/dietListView?dietWriteDate=" + year + "-" + String.format("%02d", (month == 12 ? 1 : month + 1)) +
						"-" + String.format("%02d", start) + "&id=" + id +"'>"
						+ (month == 12 ? 1 : month + 1) + "/" + start++ + "</a></td>");
				} else {
					out.println("<td><a class='after' style='font-size: 15pt; text-decoration: none; cursor: pointer; color: black;'"
						+ "href='../diet/dietListView?dietWriteDate=" + year + "-" + String.format("%02d", (month == 12 ? 1 : month + 1)) + 
						"-" + String.format("%02d", start) + "&id=" + id +"'>"
						+ (month == 12 ? 1 : month + 1) + "/" + start++ + "</a></td>");
				}
			}
		}
	%>
	</tr>
</table>
</body>
</html>