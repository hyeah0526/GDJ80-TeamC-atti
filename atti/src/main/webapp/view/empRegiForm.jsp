<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="atti.*" %>

<!-------------------- 
 * 기능 번호  : #8
 * 상세 설명  : 직원 등록 페이지(전공, 직책, 이름, 생일, 성별, 전화번호, 입사일)
 * 시작 날짜 : 2024-05-15
 * 담당자 : 김인수
 -------------------->

<!-- Controller layer  -->
<%
	//세션에서 로그인한 사용자 정보를 가져와 변수에 저장
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	
	//로그인한 사용자가 관리자인지 확인
	if(loginEmp == null || (loginEmp != null && loginEmp.get("empNo").toString().charAt(0) != '1')){
		response.sendRedirect("/atti/view/main.jsp"); // 메인 페이지로 이동
		return;
	}
	
	//디버깅
	//System.out.println(loginEmp);
	
	//입력 오류 시 표시될 메세지
	String errorMessage = request.getParameter("errorMessage");
	
%>

<!-- view layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>empRegiForm page</title>
	
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- CSS 공통적용CSS파일 -->
	<link rel="stylesheet" href="../css/css_all.css">
	<link rel="stylesheet" href="../css/css_kiminsu.css">
</head>
<body id="fontSet">
	
	<!-------------------- header -------------------->
	<jsp:include page="/inc/header.jsp"></jsp:include>

	<!-------------------- aside-------------------->
	<aside>
		<!-- 서브메뉴나오는 부분 -->
		<jsp:include page="/inc/empSubMenu.jsp"></jsp:include>
	</aside>
	
	<!-------------------- main -------------------->
	<main class="userFormMain"> 
		<h2>신규 직원 등록</h2>
		
		<!-- 신규 직원의 정보 입력 폼 -->
		<form action="/atti/action/empRegiAction.jsp" method="post" class="empForm">
				<div>
					<label>전공</label>
					<select name="empMajor">
						<!-- 직원 전공 선택하기 -->
						<option value="포유류">포유류</option>
						<option value="파충류">파충류</option>
						<option value="조류">조류</option>
					</select>
				</div>
				<div>
					<label>직책</label>
					<select name="empGrade">
						<!-- 직원 성별 선택하기 -->
						<option value="의사">의사</option>
						<option value="간호사">간호사</option>
					</select>
				</div>
				<div>
					<label>이름</label>
					<input type="text" name="empName">
				</div>
				<div>
					<label>생일</label>
					<input type="date" name="empBirth">
				</div>
				<div>
					<label>성별</label>
					<select name="empGender">
						<!-- 직원 성별 선택하기 -->
						<option value="M">남자</option>
						<option value="F">여자</option>
					</select>
				</div>
				<div>
					<label>전화번호</label>
					<input class="telInput" type="text" name="empTelFirst">-
					<input class="telInput" type="text" name="empTelSecond">-
					<input class="telInput" type="text" name="empTelThrid">
				</div>
				<div>
					<label>입사일</label>
					<input type="date" name="empHireDate">
				</div>
					<%
						//애러 메세지 출력
						if(errorMessage != null){
					%>
						<div id="errorMessageRegiDiv">
							<%=errorMessage%>
						</div>
					<%	
						}
					%>
				<div>
					<div></div>						
					<button type="submit" class="detailEmpBtn">확인</button>
					<div></div>
				</div>
		</form> 
	</main>
</body>
</html>
