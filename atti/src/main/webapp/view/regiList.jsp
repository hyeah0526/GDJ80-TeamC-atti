<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="atti.*"%>
<%
	/*
	 * 기능 번호  : #29
	 * 상세 설명  : 접수 리스트  
	 * 시작 날짜 : 2024-05-20
	 * 담당자 : 한은혜
	*/
	
	System.out.println("---------------- regiList.jsp -----------------");
	// 로그인 세션 


%>
<%
	//오늘 날짜 값	가져오기
	LocalDate today = LocalDate.now();	
	String date = today.toString();
	
	// 에러메세지 가져오기
	String errMsg = request.getParameter("errMsg");
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
	
	// 처방 리스트 DAO 호출
	ArrayList<HashMap<String, Object>> regiList = RegistrationDao.regiList(date, startRow, rowPerPage);
	
	// 총 행 수 구하기 
	int totalRow = 0;
	// null인 경우 처리 (regiList가 비어있지 않은 경우에만 totalRow 호출)
	if(!regiList.isEmpty()){ 
		totalRow = (Integer)regiList.get(0).get("totalRow");
	}
	// 마지막 페이지 계산하기
	int lastPage = totalRow / rowPerPage;
	// 나머지가 있으면 마지막 페이지 +1 
	if (totalRow % rowPerPage != 0) {
		lastPage += 1; 
	} 
	
	// 디버깅
	//System.out.println(today + " ====== regiList.jsp today ");
	//System.out.println(date + " ====== regiList.jsp date ");
	//System.out.println(currentPage + " ====== regiList.jsp currentPage ");
	//System.out.println(rowPerPage + " ====== regiList.jsp rowPerPage ");
	//System.out.println(startRow + " ====== regiList.jsp startRow ");
	//System.out.println(totalRow + " ====== regiList.jsp totalRow ");
	//System.out.println(lastPage + " ====== regiList.jsp lastPage ");
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
	<main id="regiListMain">
		<div id="centerDiv">
			<h2>접수 리스트</h2>
		</div>
		<!-- 에러 메세지 -->
		<div>
			<% 
				if(errMsg != null){
			%>
				<h6><%=errMsg%></h6>R
			<%}%>
		</div>
		<!-- 점수 리스트 출력 -->
			<table id="regiListTable">
				<tr>
					<th>접수 번호</th>
					<th>반려동물</th>
					<th>담당의사</th>
					<th>접수 내용</th>
					<th>진료 시간</th>
					<th>접수 상태</th>
					<th></th>
					<th></th>
				</tr>
			<%
				for(HashMap<String, Object> r : regiList) { 
			%>
				<tr>
					<td><%= r.get("regiNo") %></td>				
					<td><%= r.get("petName") %> (<%= r.get("petKind")%>) </td>				
					<td><%= r.get("empName") %></td>				
					<td><%= r.get("regiContent") %></td>				
					<td><%= r.get("regiDate") %></td>				
					<td><%= r.get("regiState") %></td>				
					<td>
						<% if(r.get("regiState").equals("예약")) { %>
							<form action="/atti/action/regiStateAction.jsp" method="post">
								<input type="hidden" name="regiNo" value="<%= r.get("regiNo") %>">
								<input type="hidden" name="regiState" value="대기">
								<button type="submit" id="detailBtn">대기하기</button>
							</form>
						<% } else { %>	
							<form action="/atti/action/regiStateAction.jsp" method="post">
								<input type="hidden" name="regiNo" value="<%= r.get("regiNo") %>">
								<input type="hidden" name="regiState" value="대기">
								<button type="submit" id="detailBtn" style="background-color: #D5D5D5" disabled="disabled">대기하기</button>
							</form>
						<% } %>
					</td>
					<td>
						<form action="/atti/action/regiStateAction.jsp" method="post">
							<input type="hidden" name="regiNo" value="<%= r.get("regiNo") %>">
							<input type="hidden" name="regiState" value="접수취소">
							<button id="detailBtn" type="submit">취소하기</button>
						</form>					
					</td>
				</tr>
			<%
				}
			%>
			</table>
		
		<!-- 페이징 -->
		<div id="paginationDiv">
			<div>
			    <!-- 이전 페이지 링크 -->
			    <% if(currentPage > 1){ %>
			        <a href="/atti/view/regiList.jsp?currentPage=<%=currentPage-1%>" id="paginationBtn">이전</a>
			    <% } else { %>
			        <span id="paginationBtn disabled">이전</span>
			    <% } %>
	
			    <!-- 현재 페이지 표시 -->
			    <span id="currentPage"><%=currentPage%></span>
	
			    <!-- 다음 페이지 링크 -->
			    <% if(currentPage < lastPage) { %>
			        <a href="/atti/view/regiList.jsp?currentPage=<%=currentPage+1%>" id="paginationBtn">다음</a>
			    <% } else { %>
			        <span id="paginationBtn disabled">다음</span>
			    <% } %>
			</div>	
		</div>
	</main>
</body>
</html>