<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="atti.*" %>

<!-- Controller layer  -->
<%
	//로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}
	
	//int regiNo = Integer.parseInt(request.getParameter("regiNo"));

%>

<!-- Model layer -->
<%
	HashMap<String, Object> hospitalizationDetail = HospitalizationDao.hospitalizationDetail(11);
	
	//디버깅
	//System.out.println(hospitalizationDetail);
	
	if( hospitalizationDetail == null){
		hospitalizationDetail = new HashMap<>();
	}
		System.out.println(hospitalizationDetail);
	
%>

<!-- view layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>clinicDetailForm page</title>
	
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
		<!-- 입원 환자 호실 선택 및 입원 내용 입력 폼 -->
		<form action="/atti/action/clinicAction.jsp" method="post" id="HospitalizationRegiForm">
			
			<div id="animalSelectBoxDiv">
				
				<%
					if(hospitalizationDetail.isEmpty()){
				  		String empMajor = (String) hospitalizationDetail.get("empMajor");
                        String roomName = (String) hospitalizationDetail.get("roomName");
				%>
					<span>호실 선택</span>
				
					<%
						if("포유류".equals(empMajor)){ 
					%>
						<!-- 포유류 입원 호실 선택하기 -->
						<select name="mammalRoom">
							<option value="A01">A01</option>
							<option value="A02">A02</option>
							<option value="A03">A03</option>
							<option value="A04">A04</option>
							<option value="A05">A05</option>
							<option value="A06">A06</option>
							<option value="A07">A07</option>
							<option value="A08">A08</option>
							<option value="A09">A09</option>
							<option value="A10">A10</option>
						</select>				
					<%
						}else if("파충류".equals(empMajor)){
					%>
						<!-- 파충류 입원 호실 선택하기 -->
						<select name="reptilesRoom">
							<option value="B01">B01</option>
							<option value="B02">B02</option>
							<option value="B03">B03</option>
							<option value="B04">B04</option>
							<option value="B05">B05</option>
							<option value="B06">B06</option>
							<option value="B07">B07</option>
							<option value="B08">B08</option>
							<option value="B09">B09</option>
							<option value="B10">B10</option>
						</select>
					<%	
						}else{
					%>
						<!-- 조류 입원 호실 선택하기 -->
						<select name="birdRoom">
							<option value="C01">C01</option>
							<option value="C02">C02</option>
							<option value="C03">C03</option>
							<option value="C04">C04</option>
							<option value="C05">C05</option>
							<option value="C06">C06</option>
							<option value="C07">C07</option>
							<option value="C08">C08</option>
							<option value="C09">C09</option>
							<option value="C10">C10</option>
						</select>					
					<%
						}
					%>
				
				<%		
					}else{
						
				%>
					
				<%
					}
				%>
				
			</div>
			
			<div id="HospitalizationRegiFormDetails">
				<textarea name="hospitalizationContent" rows="4" ></textarea>		
				<button type="submit">저장</button>
			</div>
			
		</form>
	</main>
</body>
</html>