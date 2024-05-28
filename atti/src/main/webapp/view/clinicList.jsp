<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="atti.*"%>
<%

	/*
	 * 기능 번호  : #31
	 * 상세 설명  : 진료 리스트
	 * 시작 날짜 : 2024-05-23
	 * 담당자 : 한은혜
	*/

	System.out.println("---------------- clinicList.jsp -----------------");
	// 로그인 세션 
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp"); // 로그인하지 않은 사용자는 로그인 페이지로 이동
		return;
	}

%>
<%
	// 로그인 사번을 empNo으로 가져오기
	HashMap<String, Object> loginEmp = (HashMap<String, Object>) session.getAttribute("loginEmp");
	int empNo = Integer.parseInt((String) loginEmp.get("empNo"));
	System.out.println(empNo + " === clinicList.jsp empNo");
	
	// 진료 리스트 DAO 호출
	ArrayList<HashMap<String, Object>> clinicList = ClinicDao.clinicList(empNo);
	
	if (!(String.valueOf(empNo).startsWith("1") || String.valueOf(empNo).startsWith("2"))) {
	       response.sendRedirect("/atti/view/regiList.jsp");
	       return;
	}
	
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
				<button type="button" onclick="location.href='./clinicList.jsp'">진료 조회</button><br><br>
			</div>
		</div>
	</aside>
	
	<!-------------------- main -------------------->
	<main>
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
							<input type="hidden" name="petNo" value="<%=c.get("petNo")%>">
							<input type="hidden" name="regiState" value="진행">
							<button class="btn" type="submit">진료시작</button>
						</form>
					</td>
				</tr>
				<%
					}
				%>
		
	</main>
</body>
</html>