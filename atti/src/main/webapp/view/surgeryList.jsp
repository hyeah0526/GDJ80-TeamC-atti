<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="atti.*"%>
<%

	/*
	 * 기능 번호  : #36
	 * 상세 설명  : 수술 리스트 
	 * 시작 날짜 : 2024-05-14
	 * 담당자 : 한은혜
	*/

	System.out.println("---------------- surgeryList.jsp -----------------");
	// 로그인 세션 

%>
<%
	//검색 날짜 값 가져오기 
	String searchDate = request.getParameter("searchDate");
	// searchDate가 null일 경우(날짜를 선택하지 않은 경우) -> 공백 처리 
	if(searchDate == null) {
		searchDate = "";
	}
	// 오늘 날짜 		
	LocalDate date = LocalDate.now();	
	
	// 페이징
	// 현재 페이지 기본값
	int currentPage = 1;
	// 페이지 설정값 가져오기
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 한 페이지에 나오는 개수
	int rowPerPage = 10;
	int startRow = (currentPage-1) * rowPerPage;
	
	// 검사 리스트 DAO 호출
	ArrayList<HashMap<String, Object>> surgeryList = SurgeryDao.surgeryList(searchDate, startRow, rowPerPage);
	
	// 총 행 수 구하기 
	int totalRow = 0;
	// null인 경우 처리 (surgeryList가 비어있지 않은 경우에만 totalRow 호출)
	if(!surgeryList.isEmpty()){ 
		totalRow = (Integer)surgeryList.get(0).get("totalRow");
	}
	// 마지막 페이지 계산하기
	int lastPage = totalRow / rowPerPage;
	
	// 나머지가 있으면 마지막 페이지 +1 
	if (totalRow % rowPerPage != 0) {
		lastPage += 1; 
	}
	
	// 디버깅
	//System.out.println(searchDate + " ====== surgeryList searchDate");
	//System.out.println(date);
	//System.out.println(currentPage + " ====== surgeryList currentPage");
	//System.out.println(rowPerPage + " ====== surgeryList rowPerPage");
	//System.out.println(startRow + " ====== surgeryList startRow");
	//System.out.println(startRow + " ====== surgeryList totalRow");
	//System.out.println(lastPage + " ====== surgeryList lastPage");

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>수술 리스트</title>
	
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

	<!-------------------- aside-------------------->
	<aside>
		<!-- 서브메뉴나오는 부분 -->
		<div id="subMenu">
			<div id="subMenuBtnContainer">
				<button type="button" onclick="location.href='./surgeryList.jsp'">수술 조회</button><br><br>
			</div>
		</div>
	</aside>
	
	<!-------------------- main -------------------->
	<main>
		<div>
			<h2>수술 리스트</h2>
		</div>
		<div class="col container mb-2">
			<!-- 날짜 선택해서 검색 -->
			<form method="post" action="surgeryList.jsp" class="inline">
				<input type="date" name="searchDate" value="<%= searchDate %>">
				<button type="submit">검색</button>
			</form>
			<!-- 오늘 날짜 바로 검색 -->
			<form method="post" action="surgeryList.jsp" class="inline">
				<button type="submit" name="searchDate" value="<%= date %>">오늘</button>
			</form>
			<!-- 전체 검색 -->
			<form method="post" action="surgeryList.jsp" class="inline">
				<button type="submit" name="searchDate" value="">전체</button>
			</form>
		</div>
	
		<!-- 수술 리스트 출력 -->
		<table border="1" class="a">
			<tr>
				<th>접수 번호</th>		
				<th>수술 번호</th>		
				<th>담당 의사(사번)</th>		
				<th>수술 종류</th>		
				<th>수술 날짜</th>		
				<th>반려동물 이름(종류)</th>		
			</tr>
			<!-- 수술 리스트 값 호출 -->
			<%
				for(HashMap<String, Object> s : surgeryList) {
			%>	
			<tr>
				<td><%= s.get("regiNo") %></td>
				<td><%= s.get("surgeryNo") %></td>
				<td><%= s.get("empName") %>(<%= s.get("empNo") %>)</td>
				<td><%= s.get("surgeryKind") %></td>
				<td><%= s.get("surgeryDate") %></td>
				<td><%= s.get("petName") %>(<%= s.get("petKind") %>)</td>
				<td><a href="/atti/view/surgeryDetail.jsp?surgeryNo=<%=s.get("surgeryNo") %>">상세보기</a></td>
			</tr>
			<%
				}
			%>
		</table>
		<!-- 페이징 -->
		<div>
			<div>
			    <!-- 이전 페이지 링크 -->
			    <% if(currentPage > 1){ %>
			        <a href="/atti/view/surgeryList.jsp?currentPage=<%=currentPage-1%>&searchDate=<%=searchDate%>">이전</a>
			    <% } else { %>
			        <span class="disabled">이전</span>
			    <% } %>
	
			    <!-- 현재 페이지 표시 -->
			    <span class="currentPage"><%=currentPage%></span>
	
			    <!-- 다음 페이지 링크 -->
			    <% if(currentPage < lastPage) { %>
			        <a href="/atti/view/surgeryList.jsp?currentPage=<%=currentPage+1%>&searchDate=<%=searchDate%>">다음</a>
			    <% } else { %>
			        <span class="disabled">다음</span>
			    <% } %>
			</div>	
		</div>
	</main>
</body>
</html>