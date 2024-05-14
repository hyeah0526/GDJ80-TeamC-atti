<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="atti.*" %>

<!-------------------- 
 * 기능 번호  : #11
 * 상세 설명  : 직원 상세보기 페이지(사번, 이름, 생년월일, 성별, 전화번호, 입사일, 전공, 직책)
 * 시작 날짜 : 2024-05-13
 * 담당자 : 김인수
 -------------------->

<!-- Controller layer  -->
<%
	//세션을 변수로 변환
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	
	//로그인한 사용자가 관리자인지 확인
	if(loginEmp == null || (loginEmp != null && loginEmp.get("empNo").toString().charAt(0) != '1')){
		response.sendRedirect("/atti/view/main.jsp"); // 로그인하지 않은 사용자는 로그인 페이지로 이동
		return;
	}
	
	//디버깅
	//System.out.println(loginEmp);
	
	//직원의 사번
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	
	//디버깅
	//System.out.println(empNo);
	
%>

<!-- Model layer -->
<%
	//선택된 회원의 정보 가져오기(사번, 이름, 생년월일, 성별, 전화번호, 입사일, 전공, 직책)
	ArrayList<HashMap<String, Object>> detailList = EmpDao.empDetail(empNo);
	
	//디버깅
	//System.out.println("detailList = " + detailList);
%>

 
<!-- view layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>empDetail page</title>
	
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
	<main>
		<h2>직원 개인 정보 </h2>
		<div id="detailDiv">
		
			<%
				//선택된 직원정보 출력하기
				for(HashMap<String, Object> m : detailList){
					 String originalTel = (String)(m.get("empTel"));
			%>
				
				<form action="/atti/action/empUpdateAction.jsp" method="post" id="empUpdateForm">
						<div>
							<label>사번</label>
							<input type="text" readonly="readonly" value=<%=(String)(m.get("empNo"))%>>
						</div>
						<div>
							<label>전공</label>
							<input type="text" readonly="readonly" value=<%=(String)(m.get("empMajor")) %>>
						</div>
						<div>
							<label>직책</label>
							<input type="text" readonly="readonly"  value=<%=(String)(m.get("empGrade")) %>>
						</div>
						<div>
							<label>이름</label>
							<input type="text" readonly="readonly"  value=<%=(String)(m.get("empName")) %>>
						</div>
						<div>
							<label>생일</label>
							<input type="text" readonly="readonly"  value=<%=(String)(m.get("empBirth")) %>>
						</div>
						<div>
							<label>성별</label>
							<input type="text" readonly="readonly"  value=<%=(String)(m.get("empGender")) %>>
						</div>
						<div>
							<label>전화번호</label>
							<input type="text" readonly="readonly" value=<%=originalTel.replaceAll("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3")%>>
						</div>
				</form>
			
				<div id="detailBtn">
				
					<button type="button" onclick="window.history.back();" class="detailEmpBtn">뒤로가기</button>
					
					<!--개인 정보 수정 페이지 이동-->
					<form action="/atti/view/empUpdateForm.jsp" class="detailEmpForm" method="post">
						<input type="hidden" name="empNo" value="<%=(String)(m.get("empNo"))%>">
   						<button type="submit" class="detailEmpBtn">수정하기</button>
					</form>
				</div>
			<%
				}
			%>
		</div>
	</main>
</body>
</html>