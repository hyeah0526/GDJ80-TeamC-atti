<%@page import="atti.ExaminationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%
	System.out.println("---------------- examinationList.jsp -----------------");
	// 로그인 세션 


%>
<%
	String searchDate = request.getParameter("searchDate");
	System.out.println(searchDate + " ====== searchDate");
	
	// searchDate가 null일 경우(날짜를 선택하지 않은 경우) -> searchDate = 현재 날짜 입력
	LocalDate date = LocalDate.now();
	//System.out.println(date);
	if(searchDate == null) {
		searchDate = date.toString();
		System.out.println(searchDate);
	}
	
	ArrayList<HashMap<String, Object>> examinationList = ExaminationDao.examinationList(searchDate);

%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Main page</title>
	
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- CSS 공통적용CSS파일 -->
	<link rel="stylesheet" href="../css/css_all.css">
	
</head>
<body id="fontSet">
	
	<!-------------------- header -------------------->
	<jsp:include page="/inc/header.jsp"></jsp:include>

	<!-------------------- aside -------------------->
	<aside>
		<!-- 서브메뉴나오는 부분 -->
		<jsp:include page="/inc/subMenu.jsp"></jsp:include>
	</aside>
	
	<!-------------------- main -------------------->
	<main>
	
	<div>
		<form method="post" action="examinationList.jsp" >
			<input type="date" name="searchDate" value="<%= searchDate %>">
			<button type="submit">검색</button>
		</form>
		
		<form method="post" action="examinationList.jsp" >
			<button type="submit" name="searchDate" value="<%= date %>">오늘</button>
		</form>
	</div>
	
	<table border="1">
		<tr>
			<th>검사 번호</th>
			<th>검사 종류</th>
			<th>검사 내용</th>
			<th>검사 날짜</th>
		</tr>
		<%
			for(HashMap<String, Object> e : examinationList) {
		%>
		<tr>
			<td><%= e.get("examinationNo")%></td>
			<td><%= e.get("examinationKind")%></td>
			<td><%= e.get("examinationContent")%></td>
			<td><%= e.get("examinationDate")%></td>
		</tr>
		<%
			}
		%>
	
	</table>
	
	</main>
</body>
</html>