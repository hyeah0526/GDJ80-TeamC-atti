<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!-------------------- 
 * 기능 번호  : #20
 * 상세 설명  : 펫 정보 등록 페이지(폼)
 * 시작 날짜 : 2024-05-13
 * 담당자 : 김지훈
 -------------------->
<%
	System.out.println("--------------------");
	System.out.println("petRegiForm.jsp");
%>
<!-- Controller layer  -->
<%
	/* // 로그인한 사용자가 관리자인지 확인
	// 세션을 변수로 변환
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	// 관리자, 직원 여부에 따라 보여지는 뷰가 달라짐
	if(loginEmp == null || (loginEmp != null && loginEmp.get("empNo").toString().charAt(0) != '1')){
		response.sendRedirect("/atti/view/main.jsp"); // 로그인하지 않은 사용자는 로그인 페이지로 이동
		return;
	} */
	
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	//System.out.println("customerNo: " + customerNo);
	
	String errorMsg = request.getParameter("errorMsg");
	//System.out.println(errorMsg);
	
%>	
<!-- view layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>petRegiForm page</title>
	
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
		<div class="regiCustomerInput">
			<h2>펫 등록</h2>
			<form action="/atti/action/petRegiAction.jsp">
			<input type="hidden" name="customerNo" value="<%=customerNo %>">
			<table class="inputTable">
				<tr>
					<th><label for="major">분류</label></th> <!-- select로 수정 예정 -->
					<td>
						<select name="major" id="major">
							<option value="">=== 선택 ===</option>
							<option value="포유류">포유류</option>
							<option value="파충류">파충류</option>
							<option value="조류">조류</option>
						</select>
					
					</td>
				</tr>
				<tr>
					<th><label for="petKind">종류</label></th> 
					<td><input type="text" name="petKind" id="petKind"><td>
				</tr>
				<tr>
					<th><label for="petName">펫 이름</label></th>
					<td><input type="text" name="petName" id="petName"></td>
				</tr>
				<tr>
					<th><label for="petBirth">펫 생일</label></th>
					<td><input type="date" name="petBirth" id="petBirth"></td>
				</tr>
			</table>
			<%
				if(errorMsg != null) {
			%>
					<div class="errorMsg"><%=errorMsg%></div>
			<%					
				}
			%>	
			<div class="buttonContainer">
				<button class="inputButton" type="reset">초기화</button>
				<button class="inputButton" type="button" onclick="location.href='/atti/view/searchList.jsp'">목록으로</button>
				<button class="inputButton" type="submit">등록하기</button>
			</div>
			</form>
		</div>
	
	</main>
</body>
</html>