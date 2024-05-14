<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="atti.*" %>   
<%@ page import="java.util.*" %>
<!-------------------- 
 * 기능 번호  : #22
 * 상세 설명  : 펫 상세 보기
 * 시작 날짜 : 2024-05-13
 * 담당자 : 김지훈
 -------------------->

<%
	System.out.println("--------------------");
	System.out.println("petDetail.jsp");
%> 
<!-- Controller layer  -->
<%
	/* // 세션을 변수로 변환
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	
	// 로그인한 사용자가 관리자인지 확인
	// 관리자, 직원 여부에 따라 보여지는 뷰가 달라짐
	if(loginEmp == null || (loginEmp != null && loginEmp.get("empNo").toString().charAt(0) != '1')){
		response.sendRedirect("/atti/view/main.jsp"); // 로그인하지 않은 사용자는 로그인 페이지로 이동
		return;
	} */
	
	// petNo 
	int petNo = Integer.parseInt(request.getParameter("petNo"));
	//System.out.println("petNo: " + petNo);
%>
<!-- model layer -->
<%
	ArrayList<HashMap<String, Object>> petDetail = PetDao.petDetail(petNo);
	//System.out.println("petDetail: " + petDetail);
%>
<!-- view layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>petDetail page</title>
	
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- CSS 공통적용CSS파일 -->
	<link rel="stylesheet" href="../css/css_all.css">
	<!-- CSS 개인 파일 -->
	<link rel="stylesheet" href="../css/css_jihoon.css">
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
	<main>
		<div >
			<h2>펫 상세 정보</h2>
			<table class="inputTable">
				<%
					for(HashMap<String, Object> p : petDetail){
						
				%>
						<tr>
							<th>펫 번호</th>
							<td><%=p.get("petNo")%></td>
						</tr>
						<tr>
							<th>종류</th>
							<td><%=p.get("major")%></td>
						</tr>
						<tr>
							<th>분류</th>
							<td><%=p.get("petKind")%></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><%=p.get("petName")%></td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td><%=p.get("petBirth")%></td>
						</tr>
						<tr>
							<th>보호자 이름</th>
							<td><%=p.get("customerName")%></td>
						</tr>
						<tr>
							<th>보호자 연락처</th>
							<td><%=p.get("customerTel")%></td>
						</tr>
				<% 
					}
				%>
			</table>
			<div class="buttonContainer">
				<button class="inputButton" type="button" onclick="location.href='/atti/view/petUpdateForm.jsp?petNo=<%=petNo%>'">정보 수정하기</button>
				<button class="inputButton" type="button" onclick="location.href='/atti/view/searchList.jsp'">목록으로</button>
			</div>
		</div>
	</main>
</body>
</html>