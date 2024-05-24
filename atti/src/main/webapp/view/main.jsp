<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="atti.*"%>
<!-------------------- 
 * 기능 번호  : #4
 * 상세 설명  : 메인 페이지
 * 시작 날짜 : 2024-05-10
 * 담당자 : 김인수
 -------------------->
 
<!-- Controller layer -->
<%
	//로그인 세션 검증 
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp"); // 로그인하지 않은 사용자는 로그인 페이지로 이동
		return;
	}

	//로그인 사번을 empNo으로 가져오기
	HashMap<String, Object> loginEmp = (HashMap<String, Object>) session.getAttribute("loginEmp");
	int empNo = Integer.parseInt((String) loginEmp.get("empNo"));
		

	/*---- 오늘 접수 내역 가져오기 ----*/
	//오늘 날짜 값	가져오기
	LocalDate regiToday = LocalDate.now();	
	//String date = regiToday.toString();
	String regiDate = "2024-05-09";
	
	System.out.println(regiDate);
	
	// 에러메세지 가져오기
	String errMsg = request.getParameter("errMsg");
	// 페이징 
	// 현재 페이지 기본값
	int regiCurrentPage = 1;
	// 페이지 설정값 가져오기
	if(request.getParameter("regiCurrentPage") != null){
		regiCurrentPage = Integer.parseInt(request.getParameter("regiCurrentPage"));
	}
	// 한 페이지에 나오는 개수
	int regiRowPerPage = 10;
	int regiStartRow = (regiCurrentPage-1) * regiRowPerPage;
	
	// 처방 리스트 DAO 호출
	ArrayList<HashMap<String, Object>> regiList = RegistrationDao.regiList(regiDate, regiStartRow, regiRowPerPage);
	
	// 총 행 수 구하기 
	int regiTotalRow = 0;
	// null인 경우 처리 (regiList가 비어있지 않은 경우에만 regiTotalRow 호출)
	if(!regiList.isEmpty()){ 
		regiTotalRow = (Integer)regiList.get(0).get("totalRow");
	}
	// 마지막 페이지 계산하기
	int regiLastPage = regiTotalRow / regiRowPerPage;
	// 나머지가 있으면 마지막 페이지 +1 
	if (regiTotalRow % regiRowPerPage != 0) {
		regiLastPage += 1; 
	} 
	
	// 디버깅
	//System.out.println(regiToday + " ====== regiList.jsp regiToday ");
	//System.out.println(regiDate + " ====== regiList.jsp regiDate ");
	//System.out.println(currentPage + " ====== regiList.jsp currentPage ");
	//System.out.println(regiRowPerPage + " ====== regiList.jsp regiRowPerPage ");
	//System.out.println(regiStartRow + " ====== regiList.jsp regiStartRow ");
	//System.out.println(regiTotalRow + " ====== regiList.jsp regiTotalRow ");
	//System.out.println(regiLastPage + " ====== regiList.jsp regiLastPage ");

	
	/*---- 오늘 수술 내역 가져오기 ----*/
	
	
%>


<%
	//진료 리스트 DAO 호출
	ArrayList<HashMap<String, Object>> clinicList = ClinicDao.clinicList(empNo);
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
	<link rel="stylesheet" href="../css/css_kiminsu.css">
	<link rel="stylesheet" href="../css/css_eunhye.css">
</head>
<body id="fontSet">
	
	<!-------------------- header -------------------->
	<jsp:include page="/inc/header.jsp"></jsp:include>

	<!-------------------- aside-------------------->
	<aside>
		<!-- 서브메뉴나오는 부분 -->
		<jsp:include page="/inc/subMenu.jsp"></jsp:include>
	</aside>
	
	<!-------------------- main -------------------->
	<main class="mainPageDiv">
		<div>
		
			<!--접수 내역-->
			<div class="mainContentDiv">
				<div>
					<h2>접수 리스트</h2>
				</div>
				<!-- 에러 메세지 -->
				<div>
					<% 
						if(errMsg != null){
					%>
						<h6><%=errMsg%></h6>
					<%}%>
				</div>
				<!-- 점수 리스트 출력 -->
				<div>
					<table>
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
										<button type="submit" class="btn">대기하기</button>
									</form>
								<% } else { %>	
									<form action="/atti/action/regiStateAction.jsp" method="post">
										<input type="hidden" name="regiNo" value="<%= r.get("regiNo") %>">
										<input type="hidden" name="regiState" value="대기">
										<button type="submit" class="btn" disabled="disabled">대기하기</button>
									</form>
								<% } %>
							</td>
							<td>
								<form action="/atti/action/regiStateAction.jsp" method="post">
									<input type="hidden" name="regiNo" value="<%= r.get("regiNo") %>">
									<input type="hidden" name="regiState" value="접수취소">
									<button type="submit">취소하기</button>
								</form>					
							</td>
						</tr>
					<%
						}
					%>
					</table>
				</div>
			
				<!-- 페이징 -->
				<div>
				    <!-- 이전 페이지 링크 -->
				    <% if(regiCurrentPage > 1){ %>
				        <a href="/atti/view/regiList.jsp?currentPage=<%=regiCurrentPage-1%>">이전</a>
				    <% } else { %>
				        <span class="disabled">이전</span>
				    <% } %>
		
				    <!-- 현재 페이지 표시 -->
				    <span class="currentPage"><%=regiCurrentPage%></span>
		
				    <!-- 다음 페이지 링크 -->
				    <% if(regiCurrentPage < regiLastPage) { %>
				        <a href="/atti/view/regiList.jsp?currentPage=<%=regiCurrentPage+1%>">다음</a>
				    <% } else { %>
				        <span class="disabled">다음</span>
				    <% } %>
				</div>	
			
			</div>
			
			<!-- 진료 리스트 -->
			<div class="mainContentDiv">
				<div>
					<h2>진료 리스트</h2>
				</div>
				<!-- 진료 리스트 출력 -->
				<table border="1" class="a">
					<tr>
						<th>접수번호</th>
						<th>동물이름(종류)</th>
						<th>동물생일</th>
						<th>접수내용</th>
						<th>접수날짜</th>
						<th>접수상태</th>
						<th></th>
					</tr>
					<!-- 진료 리스트에 보여줄 값 -->
					<%
						for(HashMap<String, Object> c : clinicList) {
					%>
					<tr>
						<td><%= c.get("regiNo")%></td>
						<td><%= c.get("petName")%>(<%= c.get("petKind")%>)</td>
						<td><%= c.get("petBirth")%></td>
						<td><%= c.get("regiContent")%></td>
						<td><%= c.get("regiDate")%></td>
						<td><%= c.get("regiState")%></td>
						<td>
							<!-- 진료 상태 변경을 위해 보내는 값 -->
							<form method="post" action="/atti/action/regiStateAction.jsp">
								<input type="hidden" name="regiNo" value="<%=c.get("regiNo")%>">
								<input type="hidden" name="regiState" value="진행">
								<button class="btn" type="submit">진료시작</button>
							</form>
						</td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			
			<div class="mainContentDiv">수술</div>
			<div class="mainContentDiv">검사</div>
		</div>
	</main>
</body>
</html>