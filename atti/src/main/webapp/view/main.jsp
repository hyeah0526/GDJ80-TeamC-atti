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
	String regiDate = regiToday.toString();
	
	//디버깅
	//System.out.println(regiDate);
	
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
	//System.out.println(regiCurrentPage + " ====== regiList.jsp regiCurrentPage ");
	//System.out.println(regiRowPerPage + " ====== regiList.jsp regiRowPerPage ");
	//System.out.println(regiStartRow + " ====== regiList.jsp regiStartRow ");
	//System.out.println(regiTotalRow + " ====== regiList.jsp regiTotalRow ");
	//System.out.println(regiLastPage + " ====== regiList.jsp regiLastPage ");

	
	/*---- 오늘 수술 내역 가져오기 ----*/
	// 오늘 날짜 		
	LocalDate surgeryToday = LocalDate.now();
	String surgeryDate = surgeryToday.toString();
	
	// 페이징
	// 현재 페이지 기본값
	int surgeryCurrentPage = 1;
	// 페이지 설정값 가져오기
	if(request.getParameter("currentPage") != null){
		surgeryCurrentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 한 페이지에 나오는 개수
	int surgeryRowPerPage = 10;
	int surgeryStartRow = (surgeryCurrentPage-1) * surgeryRowPerPage;
	
	// 검사 리스트 DAO 호출
	ArrayList<HashMap<String, Object>> surgeryList = SurgeryDao.surgeryList(surgeryDate, surgeryStartRow, surgeryRowPerPage);
	
	// 총 행 수 구하기 
	int surgeryTotalRow = 0;
	// null인 경우 처리 (surgeryList가 비어있지 않은 경우에만 totalRow 호출)
	if(!surgeryList.isEmpty()){ 
		surgeryTotalRow = (Integer)surgeryList.get(0).get("totalRow");
	}
	// 마지막 페이지 계산하기
	int surgeryLastPage = surgeryTotalRow / surgeryRowPerPage;
	
	// 나머지가 있으면 마지막 페이지 +1 
	if (surgeryTotalRow % surgeryRowPerPage != 0) {
		surgeryLastPage += 1; 
	}
	
	
	// 디버깅
	//System.out.println(surgeryDate + " ====== surgeryList surgeryDate");
	//System.out.println(surgeryCurrentPage + " ====== surgeryList surgeryCurrentPage");
	//System.out.println(surgeryRowPerPage + " ====== surgeryList surgeryRowPerPage");
	//System.out.println(surgeryStartRow + " ====== surgeryList surgeryStartRow");
	//System.out.println(surgeryTotalRow + " ====== surgeryList surgeryTotalRow");
	//System.out.println(surgeryLastPage + " ====== surgeryList surgeryLastPage");

	
	/*---- 오늘 검사 내역 가져오기 ----*/
	
	// 오늘 날짜 		
	LocalDate examinationToday = LocalDate.now();	
	String examinationDate = examinationToday.toString();
	
	// 페이징 
	// 현재 페이지 기본값
 	int examinationCurrentPage = 1;
 	// 페이지 설정값 가져오기
	if(request.getParameter("currentPage") != null){
		examinationCurrentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
 	// 한 페이지에 나오는 개수
	int examinationRowPerPage = 10;
	int examinationStartRow = (examinationCurrentPage-1) * examinationRowPerPage;
	
	// 검사 리스트 DAO 호출
	ArrayList<HashMap<String, Object>> examinationList = ExaminationDao.examinationList(examinationDate, examinationStartRow, examinationRowPerPage);
	
	// 총 행 수 구하기 
	int examinationTotalRow = 0;
	// null인 경우 처리 (examinationList가 비어있지 않은 경우에만 totalRow 호출)
	if(!examinationList.isEmpty()){ 
		examinationTotalRow = (Integer)examinationList.get(0).get("totalRow");
	}
	// 마지막 페이지 계산하기
	int examinationLastPage = examinationTotalRow / examinationRowPerPage;
	
	// 나머지가 있으면 마지막 페이지 +1 
	if (examinationTotalRow % examinationRowPerPage != 0) {
		examinationLastPage += 1; 
	}
	
	// 디버깅
	//System.out.println(examinationDate + " ====== examinationList examinationDate");
	//System.out.println(examinationCurrentPage + " ====== examinationList examinationCurrentPage");
	//System.out.println(examinationRowPerPage + " ====== examinationList examinationRowPerPage");
	//System.out.println(examinationStartRow + " ====== examinationList examinationStartRow");
	//System.out.println(examinationTotalRow + " ====== examinationList examinationTotalRow");
	//System.out.println(examinationLastPage + " ====== examinationList examinationLastPage");
	
	// 접수 내용 출력 개수
	int regiCount = 0;

	// 진료 내용 출력 개수
	int clinicCount = 0;
	
	// 수술 내용 출력 개수
	int surgeryCount = 0;
	
	// 검사 내용 출력 개수
	int examinationCount = 0;
	
	//디버깅
	//System.out.println("regiCount = " + regiCount);
	//System.out.println("clinicCount = " + clinicCount);
	//System.out.println("surgeryCount = " + surgeryCount);
	//System.out.println("examinationCount = " + examinationCount);
	
%>

<!-- Model layer -->
<%
	//진료 리스트 DAO 호출
	ArrayList<HashMap<String, Object>> clinicList = ClinicDao.clinicList(empNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>메인 페이지</title>
	
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
			
			<!-- 접수와 진료 Div -->	
			<div class="mainPageListDiv">
			
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
						<table border="1" class="mainListTable">
							<tr>
								<th>반려동물</th>
								<th>접수 내용</th>
								<th>접수 상태</th>
								<th></th>
								<th></th>
							</tr>
						<%
							
							for(HashMap<String, Object> r : regiList) { 
								if (regiCount < 4) { 
						%>
							    	<tr>
							    		<td><%= r.get("petName") %> (<%= r.get("petKind")%>) </td>
							    		<td><%= r.get("regiContent") %></td>		                            
								        <td><%= r.get("regiState") %></td>                
								        <td>
								            <% if(r.get("regiState").equals("예약")) { %>
								                <form action="/atti/action/regiStateAction.jsp" method="post">
								                    <input type="hidden" name="regiNo" value="<%= r.get("regiNo") %>">
								                    <input type="hidden" name="regiState" value="대기">
								                </form>
								            <% } else { %>    
								                <form action="/atti/action/regiStateAction.jsp" method="post">
								                    <input type="hidden" name="regiNo" value="<%= r.get("regiNo") %>">
								                    <input type="hidden" name="regiState" value="대기">
								                </form>
								            <% } %>
								        </td>
								        <td>
								            <form action="/atti/action/regiStateAction.jsp" method="post">
								                <input type="hidden" name="regiNo" value="<%= r.get("regiNo") %>">
								                <input type="hidden" name="regiState" value="접수취소">
								            </form>                    
								        </td>
								    </tr>
							<% 
					        	} else { 
							%>
								    <tr style="display:none;">            
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
							        regiCount++;
							    }
							%>
							<% if (regiList.size() > 4) { %>
							    <tr>
							        <td colspan="5" style="text-align: center;">
							            <button onclick="location.href='/atti/view/regiList.jsp'">더 보기</button>
							        </td>
							    </tr>
							<% 
								} 
							%>
						</table>
					</div>
				</div>
				
				<!-- 진료 리스트 -->
				<div class="mainContentDiv">
					<div>
						<h2>오늘의 진료 리스트</h2>
					</div>
					<!-- 진료 리스트 출력 -->
					<table border="1" class="mainListTable">
						<tr>
							<th>동물이름(종류)</th>
							<th>접수내용</th>
							<th>접수날짜</th>
							<th>접수상태</th>
							<th></th>
						</tr>
						<!-- 진료 리스트에 보여줄 값 -->
						<%
							for(HashMap<String, Object> c : clinicList) {
								if (clinicCount < 4) { 
						%>
									<tr>
										<td><%= c.get("petName")%>(<%= c.get("petKind")%>)</td>
										<td><%= c.get("regiContent")%></td>
										<td><%= c.get("regiDate")%></td>
										<td><%= c.get("regiState")%></td>
										<td>
										<%
											if(c.get("petNo") == null){
										%>
												&nbsp;
										<%		
											} else {
										%>
											<!-- 진료 상태 변경을 위해 보내는 값 -->
											<form method="post" action="/atti/action/regiStateAction.jsp">
												<input type="hidden" name="regiNo" value="<%=c.get("regiNo")%>">
												<input type="hidden" name="petNo" value="<%=c.get("petNo")%>">
												<input type="hidden" name="clinicInsert" value="clinicInsert">
												<input type="hidden" name="regiState" value="진행">
											</form>
										<%		
											}
										%>
										</td>
									</tr>
						<%
								}else{		
						%>
									<tr style="display:none;">
										<td><%= c.get("petName")%>(<%= c.get("petKind")%>)</td>
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
								clinicCount++;
							}
						%>
						
						<% if (clinicList.size() > 4) { %>
						    <tr>
						        <td colspan="5" style="text-align: center;">
						            <button onclick="location.href='/atti/view/clinicList.jsp'">더 보기</button>
						        </td>
						    </tr>
						<% 
							} 
						%>
					</table>
				</div>
			</div>
			
			<!-- 수술과 검사 Div  -->
			<div class="mainPageListDiv">
				
				<!-- 수술 리스트 -->
				<div class="mainContentDiv">
					<div>
						<h2>수술 리스트</h2>
					</div>
				
					<!-- 수술 리스트 출력 -->
					<table border="1" class="mainListTable">
						<tr>
							<th>담당 의사(사번)</th>		
							<th>수술 종류</th>		
							<th>수술 날짜</th>		
							<th>반려동물 이름(종류)</th>
							<th>상세 보기</th>
							<th>상태</th>		
						</tr>
						<!-- 수술 리스트 값 호출 -->
						<%
							for(HashMap<String, Object> s : surgeryList) {
								if (surgeryCount < 4) { 
						%>	
									<tr>
										<td><%= s.get("empName") %>(<%= s.get("empNo") %>)</td>
										<td><%= s.get("surgeryKind") %></td>
										<td><%= s.get("surgeryDate") %></td>
										<td><%= s.get("petName") %>(<%= s.get("petKind") %>)</td>
										<td><a href="/atti/view/surgeryDetail.jsp?surgeryNo=<%=s.get("surgeryNo") %>">상세 보기</a></td>
										<td><%=s.get("surgeryState") %>
											<%
												if("대기".equals(s.get("surgeryState"))) {
											%>
													<button type="button" onclick="location.href='/atti/action/surgeryStateAction.jsp?surgeryNo=<%=s.get("surgeryNo")%>'">상태 변경</button>
											<%		
												}
											%>
										</td>
									</tr>
							<%		
								}else{		
							%>
									<tr style="display:none;">
										<td><%= s.get("empName") %>(<%= s.get("empNo") %>)</td>
										<td><%= s.get("surgeryKind") %></td>
										<td><%= s.get("surgeryDate") %></td>
										<td><%= s.get("petName") %>(<%= s.get("petKind") %>)</td>
										<td><a href="/atti/view/surgeryDetail.jsp?surgeryNo=<%=s.get("surgeryNo") %>">상세 보기</a></td>
										<td><%=s.get("surgeryState") %>
											<%
												if("대기".equals(s.get("surgeryState"))) {
											%>
													<button type="button" onclick="location.href='/atti/action/surgeryStateAction.jsp?surgeryNo=<%=s.get("surgeryNo")%>'">상태 변경</button>
											<%		
												}
											%>
										</td>
									</tr>
						<%
								}
								surgeryCount++;
							}
						%>
						<% if (surgeryList.size() > 4) { %>
						    <tr>
						        <td colspan="5" style="text-align: center;">
						            <button onclick="location.href='/atti/view/surgeryList.jsp'">더 보기</button>
						        </td>
						    </tr>
						<% 
							} 
						%>
					</table>
				</div>
				
				<!-- 검사 리스트 -->
				<div class="mainContentDiv">
					
					<div>
						<h2>검사 리스트</h2>
					</div>
				
					<!-- 검사 리스트 출력 -->
					<table border="1" class="mainListTable">
						<tr>
							<th>반려동물 이름</th>
							<th>검사 종류</th>
							<th>검사 날짜</th>
							<th> </th>
						</tr>
						<!-- 검사 리스트 값 -->
						<%
							for(HashMap<String, Object> e : examinationList) {
								if (examinationCount < 4) { 
						%>
									<tr>
										<td><%= e.get("petName")%></td>
										<td><%= e.get("examinationKind")%></td>
										<td><%= e.get("examinationDate")%></td>
										<td><a href="/atti/view/examinationDetail.jsp?examinationNo=<%=e.get("examinationNo") %>">상세보기</a></td>
									</tr>
						<%
								}else{
						%>
									<tr style="display:none;">
										<td><%= e.get("petName")%></td>
										<td><%= e.get("examinationKind")%></td>
										<td><%= e.get("examinationDate")%></td>
										<td><a href="/atti/view/examinationDetail.jsp?examinationNo=<%=e.get("examinationNo") %>">상세보기</a></td>
									</tr>
	
						<%		
								}
								examinationCount++;
							}
						%>
						<% if (examinationList.size() > 4) { %>
						    <tr>
						        <td colspan="5" style="text-align: center;">
						            <button onclick="location.href='/atti/view/examinationList.jsp'">더 보기</button>
						        </td>
						    </tr>
						<% 
							} 
						%>
					</table>
				</div>
			</div>
		</div>
	</main>
</body>
</html>