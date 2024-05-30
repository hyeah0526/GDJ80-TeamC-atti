<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="atti.*"%>
<%

	/*
	 * 기능 번호  : #36
	 * 상세 설명  : 접수 등록 
	 * 시작 날짜 : 2024-05-22
	 * 담당자 : 한은혜
	*/

	System.out.println("---------------- regiForm.jsp -----------------");
	//로그인 세션 
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp"); 
		return;
	}

%>
<%	
	// 고객 조회(searchList)에서 넘긴 값 받아오기
	String petNoParam = request.getParameter("petNo");
	String customerNoParam = request.getParameter("customerNo");
	
	int petNo = 0;
	int customerNo = 0;
	
	if (petNoParam != null && !petNoParam.isEmpty()) {
	    petNo = Integer.parseInt(petNoParam);
	}
	
	if (customerNoParam != null && !customerNoParam.isEmpty()) {
	    customerNo = Integer.parseInt(customerNoParam);
	}
	String petName = request.getParameter("petName");
	String customerName = request.getParameter("customerName");
	String customerTel = request.getParameter("customerTel");

	// 오늘 날짜 		
	LocalDate date = LocalDate.now();	
	System.out.println(date + " ====== regiForm.jsp date");
	
	String errMsg = request.getParameter("errMsg");
	
	// 펫 정보 메서드 호출 
	HashMap<String, Object> regiInfo = RegistrationDao.regiInfo(petNo);
	String petKind = (String) regiInfo.get("petKind");
	
	// 의사 정보 메서드 호출 
	ArrayList<HashMap<String, Object>> empinfo = (ArrayList<HashMap<String, Object>>) regiInfo.get("emplist");

	// 디버깅
	
	System.out.println(petNo + " ====== regiForm.jsp petNo");
	//System.out.println(customerNo + " ====== regiForm.jsp customerNo");
	//System.out.println(petName + " ====== regiForm.jsp petName");
	//System.out.println(customerName + " ====== regiForm.jsp customerName");
	//System.out.println(customerTel + " ====== regiForm.jsp customerTel");

	//System.out.println(regiInfo + " ====== regiForm regiInfo");
	//System.out.println(petKind + " ====== regiForm petKind");
	//System.out.println(empinfo + " ====== regiForm emplist");

	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>접수 등록</title>
	
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
				<button type="button" onclick="location.href='./searchList.jsp'">고객 / 펫 조회</button><br><br>
				<button type="button" onclick="location.href='./customerRegiForm.jsp'">고객 등록</button><br><br>
			
			</div>
		</div>
	</aside>
	
	<!-------------------- main -------------------->
	<main id="listMain">
		<div id="centerDiv">
			<h2>접수 등록</h2>
		</div>
		<!-- 접수 등록 폼 -->
		<div id="regiForm">
			<form method="post" action="/atti/action/regiAction.jsp">
				<div>
					<label>동물 번호</label>
					<input type="text" name="petNo" value="<%= petNo %>" readonly="readonly"><br>
				</div>
				<div>
					<label>동물 이름</label>
					<input type="text" name="petName" value="<%= petName %>" readonly="readonly"><br>
				</div>
				<div>	
					<label>동물 종류</label>
					<input type="text" name="petKind" value="<%= petKind %>" readonly="readonly"><br>
				</div>
				<div>
					<label>보호자 번호</label>
					<input type="text" name="customerNo" value="<%= customerNo %>" readonly="readonly"><br>
				</div>
				<div>	
					<label>보호자 이름</label>
					<input type="text" name="customerName" value="<%= customerName %>" readonly="readonly"><br>
				</div>
				<!-- 의사 선택 -->
				<div>
					<label>담당 의사</label>
					<select name="empNo">
							<option selected value="선택">===== 담당의사 선택 =====</option>
						<%
							for(HashMap<String, Object> e  : empinfo) { 
						%>
							<option value="<%= e.get("empNo") %>"><%= e.get("empName") %></option>
							
						<%
							 }
						%>
					</select>
				</div> 
			
				<div>
					<label>진료 날짜</label>
					<input type="date" name="regiDateSelect" value="<%= date %>">
				</div>
				<div>	
					<label>진료 시간</label>
					<!-- 진료 시간 선택 -->
					<select name="regiDateTime">
						<option value="선택">=== 시간 선택 ===</option>
						<option value="9:00">9:00 - 10:00</option>
						<option value="10:00">10:00 - 11:00</option>
						<option value="11:00">11:00 - 12:00</option>
						<option value="12:00">12:00 - 1:00</option>
						<option value="1:00">1:00 - 2:00</option>
						<option value="2:00">2:00 - 3:00</option>
						<option value="3:00">3:00 - 4:00</option>
						<option value="4:00">4:00 - 5:00</option>
						<option value="5:00">5:00 - 6:00</option>
					</select>
				</div>
				<div>	
					<!-- 진료 상태 선택 -->
					<label>유형</label>
					<select name="regiState">
						<option value="대기" selected>대기</option>
						<option value="예약">예약</option>
					</select>
				</div>
				<div>
					<label>접수 내용</label>
				</div>
				<div style="justify-content: center;">
					<textarea rows="8" style="width: 90%;" name="regiContent"></textarea>
				</div>
				<%
					// 에러메세지 
					if(errMsg != null) {
				%>
						<div class="errorMsg" style="justify-content: center; color: red;"><%=errMsg%></div>
				<%		
					}
				%>
				<div style="justify-content: center;">
					<button id="detailBtn" type="submit">등록</button>
				</div>
			</form>
		</div>
	</main>
</body>
</html>