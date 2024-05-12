<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!-------------------- 
 * 기능 번호  : #5
 * 상세 설명  : 비빌번호 수정 페이지(기존 비빌번호, 수정할 비밀번호 입력)
 * 시작 날짜 : 2024-05-12
 * 담당자 : 김인수
 -------------------->

<!-- Controller layer  -->
<%

	//로그인 상태 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp"); // 로그인하지 않은 사용자는 로그인 페이지로 이동
		return;
	}

	//비밀번호 변경 오류 시 표시될 메세지
	String nullErrorMessage = request.getParameter("errorMessage");
	String errorMessage = null;
	
	//비밀번호 변경 오류 시 반환할 에러 메세지 처리
	if(nullErrorMessage != null && !nullErrorMessage.equals("null")){
 		errorMessage = request.getParameter("errorMessage"); 		
	}
%>

<!-- view layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Update password page</title>
	
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
		<jsp:include page="/inc/subMenu.jsp"></jsp:include>
	</aside>
	
	<!-------------------- main -------------------->
	<main>
		<div class="userFormDiv">
				<h2>비빌번호 수정</h2>
				<form action="/atti/action/empPwUpdateAction.jsp" method="post">
					<div class="inputDiv">
						<label>기존 비빌번호</label>
						<input type="password" name="currentPw">
					</div>
					<div class="inputDiv">
						<label>변경 비밀번호</label>
						<input type="password" name="newPw">
					</div>
					<button type="submit">확인</button>
					<%
						//애러 메세지 출력
						if(errorMessage != null){
					%>
							<div id="errorMessageDiv">
								<%=errorMessage%>
							</div>
					<%	
						}
					%>
				</form>
			</div>
	</main>
</body>
</html>