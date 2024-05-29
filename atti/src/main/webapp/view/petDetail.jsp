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
	// 로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}
	
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
	<title>펫 상세 보기</title>
	
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
	<main class="petFormMain">
		<div >
			<h2>펫 상세 정보</h2>
			<div id="petDetailDiv">
				<%
					for(HashMap<String, Object> p : petDetail){
						String originalTel = (String)(p.get("customerTel")); 
						
				%>
					<!-- 선택된 직원 정보 보여주기 폼 -->
						<form action="" method="post" class="petForm">
							<div>
								<label>펫 번호</label>
								<input type="text" readonly="readonly" value=<%=(Integer)(p.get("petNo"))%>>
							</div>
							<div>
								<label>분류</label>
								<input type="text" readonly="readonly" value=<%=(String)(p.get("empMajor")) %>>
							</div>
							<div>
								<label>종류</label>
								<input type="text" readonly="readonly"  value=<%=(String)(p.get("petKind")) %>>
							</div>
							<div>
								<label>이름</label>
								<input type="text" readonly="readonly"  value=<%=(String)(p.get("petName")) %>>
							</div>
							<div>
								<label>생년월일</label>
								<input type="text" readonly="readonly"  value=<%=(String)(p.get("petBirth")) %>>
							</div>
							<div>
								<label>보호자</label>
								<input type="text" readonly="readonly"  value=<%=(String)(p.get("customerName")) %>>
							</div>
							<div>
								<label>보호자</label>
								<input type="text" readonly="readonly" value=<%=originalTel.replaceAll("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3")%>>
							</div>
						<div id="detailPetBtn">
							<button type="button" onclick="location.href='/atti/view/searchList.jsp'" class="detailPetBtn">목록으로</button>
							<button type="button" onclick="location.href='/atti/view/petUpdateForm.jsp?petNo=<%=petNo%>'" class="detailPetBtn">수정하기</button>
						</div>
						</form>
				<%
					}
				%>
			</div>
			
		</div>
	</main>
</body>
</html>