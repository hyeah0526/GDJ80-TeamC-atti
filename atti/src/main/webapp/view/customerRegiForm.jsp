<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!-------------------- 
 * 기능 번호  : #15
 * 상세 설명  : 고객 등록 기능
 * 시작 날짜 : 2024-05-10
 * 담당자 : 김지훈
 -------------------->

<%
	// 현재 페이지
	System.out.println("--------------------");
	System.out.println("customerRegiForm.jsp");
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
%>
<!-- view layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>customerRegiForm page</title>
	
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- CSS 공통적용CSS파일 -->
	<link rel="stylesheet" href="../css/css_all.css">
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
		<div>
			<h2>고객 등록</h2>
			<form action="/atti/action/customerRegiAction.jsp">
			<table>
				<tr>
					<th><label for="customerName">고객 이름</label></th>
					<td><input type="text" name="customerName" id="customerName"></td>
				</tr>
				<tr>
					<th><label for="customerTel">전화번호</label></th>
					<td><input type="text" name="customerTel" id="customerTel" placeholder="-를 제외하고 입력해 주세요"><td>
				</tr>
				<tr>
					<th><label for="customerAddress">주소</label></th>
					<td><input type="text" name="customerAddress" id="customerAddress"></td>
				</tr>
			</table>
			<button type="submit">등록하기</button>
			</form>
		</div>
	</main>
</body>
</html>