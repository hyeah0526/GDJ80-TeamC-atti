<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/*
	 * 기능 번호  : #15
	 * 상세 설명  : 고객 등록 기능
	 * 시작 날짜 : 2024-05-10
	 * 담당자 : 김지훈
	*/
	System.out.println("--------------------");
	System.out.println("customerRegiForm.jsp");


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
	<link rel="stylesheet" href="../css/css_jihoson.css">
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
		<div class="regiCustomerInput">
			<h2>고객 등록</h2>
			<form action="/atti/action/customerRegiAction.jsp">
			<table border="1">
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