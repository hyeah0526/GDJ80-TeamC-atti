<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="atti.*"%>
<%
	/*
	 * 기능 번호  : #30
	 * 상세 설명  : 예약 리스트  
	 * 시작 날짜 : 2024-05-20
	 * 담당자 : 한은혜
	*/
	
	System.out.println("---------------- regiList.jsp -----------------");
	// 로그인 세션 


%>
<%
	
	// 값 가져오기 
	String searchDate = request.getParameter("searchDate");
	String searchWord = request.getParameter("searchWord");
	String customerTel = "";
	// searchDate가 null일 경우(날짜를 선택하지 않은 경우) -> 공백 처리 
	if(searchDate == null) {
		searchDate = "";
	}
	// searchWord가 null일 경우(검색하지 않은 경우) -> 공백 처리 
	if(searchWord == null){
		
		searchWord = "";
	}
	
	// 오늘 날짜 		
	LocalDate date = LocalDate.now();	
	
	// 처방 리스트 DAO 호출
	ArrayList<HashMap<String, Object>> rsvnList = RegistrationDao.rsvnList(searchDate, searchWord);
	
	// 디버깅
	//System.out.println(searchDate + " ====== reservationList.jsp searchDate");
	//System.out.println(searchWord + " ====== reservationList.jsp searchWord");
	//System.out.println(date + " ====== reservationList.jsp date");

%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>접수 리스트</title>
	
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
				<button type="button" onclick="location.href='./regiList.jsp'">접수 조회</button><br><br>
				<button type="button" onclick="location.href='./reservationList.jsp'">예약 조회</button><br><br>
			
			</div>
		</div>
	</aside>
	
	<!-------------------- main -------------------->
	<main>
		<div>
			<h2>예약 리스트</h2>
		</div>
		<!-- 날짜 검색 부분 -->
		<div class="col container mb-2">
			<!-- 날짜 선택해서 검색 -->
			<form method="post" action="reservationList.jsp" class="inline">
				<input type="date" name="searchDate" value="<%= searchDate %>">
				<button type="submit">검색</button>
			</form>
			<!-- 오늘 날짜 바로 검색 -->
			<form method="post" action="reservationList.jsp" class="inline">
				<button type="submit" name="searchDate" value="<%= date %>">오늘</button>
			</form>
			<!-- 전체 검색 -->
			<form method="post" action="reservationList.jsp" class="inline">
				<button type="submit" name="searchDate" value="">전체</button>
			</form>
			<!-- 단어 검색 -->
			<form method="post" action="reservationList.jsp" class="inline">
				<input type="text" name="searchWord" value="<%= searchWord%>">
				<button type="submit">검색</button>
			</form>
		</div>
		<!-- 예약 리스트 출력 -->
		<div>
			<table>
				<tr>
					<th>접수 번호</th>
					<th>반려동물</th>
					<th>보호자</th>
					<th>담당의사</th>
					<th>접수 내용</th>
					<th>예약 시간</th>
					<th>접수 상태</th>
					<th></th>
				</tr>
			<%
				for(HashMap<String, Object> r : rsvnList) { 
					// 고객 전화번호 뒤에서 4자리 따오기
					if(!rsvnList.isEmpty()){
						customerTel = (String)r.get("customerTel");
					}
					
					String customerTelLastFour = customerTel.substring(customerTel.length() - 4);
					//System.out.println(customerTel + " ====== reservationList.jsp customerTel");
					//System.out.println(customerTelLastFour + " ====== reservationList.jsp customerTelLastFour");

			%>
				<tr>
					<td><%=r.get("regiNo") %></td>
					<td><%=r.get("petName") %>(<%=r.get("petKind") %>)</td>
					<td><%=r.get("customerName") %>(<%= customerTelLastFour %>)</td>
					<td><%=r.get("empName") %></td>
					<td><%=r.get("regiContent") %></td>
					<td><%=r.get("regiDate") %></td>
					<td><%=r.get("regiState") %></td>
					<td>
						<form action="/atti/action/regiStateAction.jsp" method="post">
							<input type="hidden" name="regiNo" value="<%= r.get("regiNo") %>">
							<input type="hidden" name="regiState" value="예약취소">
							<button type="submit">취소하기</button>
						</form>		
					</td>
				</tr>
			<%
				}
			%>
			</table>
		</div>
	
	</main>
</body>
</html>