<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="atti.*"%>
<%

	/*
	 * 기능 번호  : #35
	 * 상세 설명  : 검사 조회 기능
	 * 시작 날짜 : 2024-05-10
	 * 담당자 : 한은혜
	*/

	System.out.println("---------------- examinationList.jsp -----------------");
	// 로그인 세션 

%>
<%
	// 검색 날짜 값 가져오기 
	String searchDate = request.getParameter("searchDate");
	//System.out.println(searchDate + " ====== searchDate");
	
	// searchDate가 null일 경우(날짜를 선택하지 않은 경우) -> searchDate = 현재 날짜 입력
	LocalDate date = LocalDate.now();	// 오늘 날짜 
	//System.out.println(date);
	if(searchDate == null) {
		searchDate = date.toString();
		//System.out.println(searchDate);
	}
	
	// 검사 리스트 
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
	<link rel="stylesheet" href="../css/css_eunhye.css">
</head>
<body id="fontSet">
	
	<!-------------------- header -------------------->
	<jsp:include page="/inc/header.jsp"></jsp:include>

	<!-------------------- aside -------------------->
	<aside>
		<!-- 서브메뉴나오는 부분 -->
		<div id="subMenu">
			<div id="subMenuBtnContainer">
				<button type="button" onclick="location.href='./examinationList.jsp'">검사 조회</button><br><br>
			</div>
		</div>
	</aside>
	
	<!-------------------- main -------------------->
	<main>
	<div class="row">
	<div>
		<h2>검사 리스트</h2>
	</div>
	<div class="col container mb-2">
		<!-- 날짜 선택해서 검색 -->
		<form method="post" action="examinationList.jsp" class="inline">
			<input type="date" name="searchDate" value="<%= searchDate %>">
			<button type="submit">검색</button>
		</form>
		<!-- 오늘 날짜 바로 검색 -->
		<form method="post" action="examinationList.jsp" class="inline">
			<button type="submit" name="searchDate" value="<%= date %>">오늘</button>
		</form>
	</div>
	
	<!-- 검사 리스트 출력 -->
	<table border="1" class="a">
		<tr>
			<th>검사 번호</th>
			<th>동물 종류</th>
			<th>반려동물 이름</th>
			<th>검사 종류</th>
			<th>검사 내용</th>
			<th>검사 날짜</th>
			<th> </th>
		</tr>
		<!-- 검사 리스트 값 -->
		<%
			for(HashMap<String, Object> e : examinationList) {
		%>
		<tr>
			<td><%= e.get("examinationNo")%></td>
			<td><%= e.get("petKind")%></td>
			<td><%= e.get("petName")%></td>
			<td><%= e.get("examinationKind")%></td>
			<td><%= e.get("examinationContent")%></td>
			<td><%= e.get("examinationDate")%></td>
			<td><a href="/atti/view/examinationDetail.jsp?examinationNo=<%=e.get("examinationNo") %>">상세보기</a></td>
		</tr>
		<%
			}
		%>
	</table>
	</div>
	</main>
</body>
</html>