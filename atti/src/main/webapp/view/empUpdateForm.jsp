<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="atti.*" %>

<!-------------------- 
 * 기능 번호  : #12
 * 상세 설명  : 직원 정보 수정 페이지(전화번호, 전공)
 * 시작 날짜 : 2024-05-14
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
	
	//선택된 직원의 사번
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	
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
		<div id="subMenu">
			<button onclick="location.href='/atti/view/empList.jsp'">직원조회</button>
			<button onclick="location.href='/atti/view/empRegiForm.jsp'">직원등록</button>
		</div>
	</aside>
	
	<!-------------------- main -------------------->
	<main class="userFormMain">
	
		<h2>직원 정보 수정</h2>
		
		<!-- 선택된 직원 정보 수정 입력 폼 -->
		<form action="/atti/action/empUpdateAction.jsp" method="post" class="empForm">
			<%
				//선택된 직원정보 출력하기
				for(HashMap<String, Object> m : detailList){
					
			%>
				<div>
					<label>사번</label>
					<input type="text" name="empNo" readonly="readonly" value=<%=(String)(m.get("empNo"))%>>
				</div>
				<div>
					<label>전공</label>
					<select name="empMajor">
						<!-- 직원 전공 보여주기 -->
						<option value="포유류" <%if("포유류".equals(m.get("empMajor"))){%>selected<%}%>>포유류</option>
						<option value="파충류" <%if("파충류".equals(m.get("empMajor"))){%>selected<%}%>>파충류</option>
						<option value="조류"  <%if("조류".equals(m.get("empMajor"))){%>selected<%}%>>조류</option>
					</select>
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
					<input class="telInput" type="text" name="empTelFirst" maxlength='3' value=<%=(String)(m.get("empTel")).toString().substring(0,3) %>>-
					<input class="telInput" type="text" name="empTelSecond" maxlength='4' value=<%=(String)(m.get("empTel")).toString().substring(3,7) %>>-
					<input class="telInput" type="text" name="empTelThrid" maxlength='4' value=<%=(String)(m.get("empTel")).toString().substring(7,11) %>>
				</div>
			
				<div>							
					<button type="button" onclick="window.history.back();" class="detailEmpBtn">뒤로가기</button>
					<button type="submit" class="detailEmpBtn">확인</button>
		            <button class="detailEmpBtn">
		            	<a href="/atti/action/empDeleteAction.jsp?empNo=<%=(String)(m.get("empNo"))%>&empGrade=<%=(String)(m.get("empGrade"))%>">
			            	회원탈퇴
		            	</a>
	            	</button>
				</div>
			<%
				}
			%>	
		</form> 
		
	</main>
</body>
</html>