<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="atti.*" %>
<!-------------------- 
 * 기능 번호  : #23
 * 상세 설명  : 펫 정보 수정 페이지(폼)
 * 시작 날짜 : 2024-05-13
 * 담당자 : 김지훈
 -------------------->
<%
	System.out.println("--------------------");
	System.out.println("petUpdateForm.jsp");
%>
<!-- Controller layer  -->
<%
	// 로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}
	
	int petNo = Integer.parseInt(request.getParameter("petNo"));
 	//System.out.println("petNo: " + petNo);
 	
 	// petUpdateAction -> petUpdateForm
 	String errorMsg = request.getParameter("errorMsg");
 	//System.out.println(errorMsg);
 	
 	
%>
<!-- model layer -->
<%
	ArrayList<HashMap<String, Object>> petDetail = PetDao.petDetail(petNo);
 	// 메소드 디버깅
 	//System.out.println("petDetail: " + petDetail);
%>
<!-- view layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>petUpdateForm page</title>
	
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
	<main class="customerFormMain">
		<div class="">
			<h2>펫 정보 수정</h2>
			<div id="">
				<form action="/atti/action/petUpdateAction.jsp" method="post" class="customerForm">
					<input type="hidden" name="petNo" value="<%=petNo%>">
					<%
						for(HashMap<String, Object> p : petDetail){
					%>
							<div>
								<label for="empMajor">분류</label>
								<input type="text" name="empMajor" id="empMajor" value="<%=(String)(p.get("empMajor"))%>" readonly="readonly">
							</div>
							<div>
								<label for="petKind">종류</label>
								<input type="text" name="petKind" id="petKind" value="<%=(String)(p.get("petKind"))%>" readonly="readonly">
							</div>
							<div>
								<label for="petName">펫 이름</label>
								<input type="text" name="petName" id="petName" value="<%=(String)(p.get("petName"))%>">
							</div>
							<div>
								<label for="petBirth">펫 생일</label>
								<input type="date" name="petBirth" id="petBirth" value="<%=(String)(p.get("petBirth"))%>" readonly="readonly">
							</div>
							<div id="petRegiBtn">
								<button class="petRegiBtn" type="reset">초기화</button>
								<button class="petRegiBtn" type="button" onclick="location.href='/atti/view/searchList.jsp'">목록으로</button>
								<button class="petRegiBtn" type="submit">수정하기</button>
							</div>
					<%
						}
					%>	
				</form>
					<!-- errorMsg 출력 -->
				<%
					if(errorMsg != null) {
				%>
						<div class="errorMsg"><%=errorMsg%></div>
				<%					
					}
				%>	
			</div>			
		</div>
	</main>
</body>
</html>