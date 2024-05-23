<%@ page import="java.util.*"%>
<%@ page import="atti.HospitalRoomDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	 * 기능 번호  : #38
	 * 상세 설명  : 입원실 조회기능
	 * 시작 날짜 : 2024-05-10
	 * 담당자 : 박혜아
 -->
 <%
	//로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}
 %>
 <%
 	// 입원실 리스트 전체 출력
 	ArrayList<HashMap<String, Object>> hospitalRmsList = HospitalRoomDao.hospitalRoomList();
 	//System.out.println("입원실리스트 출력hospitalRoomList.jsp --> "+hospitalRmsList);
 %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>입원실 조회</title>
	
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- CSS 공통적용CSS파일 -->
	<link type="text/css" rel="stylesheet" href="../css/css_all.css">
	<link type="text/css" rel="stylesheet" href="../css/css_hyeah.css">
</head>
<body id="fontSet">
	
	<!-------------------- header -------------------->
	<jsp:include page="../inc/header.jsp"></jsp:include>

	<!-------------------- aside-------------------->
	<aside>
		<!-- 서브메뉴나오는 부분 -->
		<div id="subMenu">
			<div id="subMenuBtnContainer">
				<button type="button" onclick="location.href='./hospitalRoomList.jsp'">입원실</button><br><br>
				<button type="button" onclick="location.href='./hospitalizationList.jsp'">입원 환자</button><br><br>
			</div>
		</div>
	</aside>
	
	<!-------------------- main -------------------->
	<main>
		<!-- 내용출력되는 부분 -->
		<div id="hospitalRoomList">
			<h2>입원실 현황</h2>
			<h5>포유류</h5>
			<%
				for(HashMap<String, Object> rms : hospitalRmsList){
					String state = (String)rms.get("state");
					String roomName = (String)rms.get("roomName");
					//System.out.println("입원실 뒷자리 가져오기 hospitalRoomList.jsp --> " + roomName.substring(1,3));
					
					// 입원실이 10으로 끝남 (float속성을 clear)
					if(roomName.substring(1,3).equals("10")){
						// 입원실의 입원 환자 ON / OFF 구분
						if(state.equals("ON")){
			%>
							<div id="hospitalRmON">
								<span id="hospitalRmName">[ <%=roomName%> ] </span>
								<span id="onRmLight">&#9679;</span><br>
								<!-- 접수번호로 상세보기이동 -->
								<%=(String)rms.get("petName")%> (<%=(Integer)rms.get("petAge")%>살)<br>
								<%=(String)rms.get("petKind")%><br>
								<%=(String)rms.get("createDate")%> ~
								<br><%=(String)rms.get("dischargeDate")%>
								<button>
									<a href="/atti/view/hospitalizationDetail.jsp?regiNo=<%=(Integer)rms.get("regiNo")%>">상세보기</a>
								</button>
							</div>
			<%
						}else if(state.equals("OFF")){
			%>
							<div id="hospitalRmOFF">
								<span id="hospitalRmName">[ <%=roomName%> ] </span>
								<span id="offRmLight">&#9679;</span>
								<br>비어있음
							</div>
			<%
						}
			%>
						<div style="clear: both;"></div><br>
						<!-- 호실에 따른 동물 종류 -->
						<%
							if(roomName.equals("A10")){
						%>
								<div><h5>파충류</h5></div>
						<%
							}else if(roomName.equals("B10")){
						%>
								<div><h5>조류</h5></div>
						<%		
							}
						%>
			<%
					}else{
					// 입원실이 1~09으로 끝남
						// 입원실의 입원 환자 ON / OFF 구분					
						if(state.equals("ON")){
			%>
							<div id="hospitalRmON">
								<span id="hospitalRmName">[ <%=roomName%> ] </span>
								<span id="onRmLight">&#9679;</span><br>
								<!-- 접수번호로 상세보기이동 -->
								<%=(String)rms.get("petName")%> (<%=(Integer)rms.get("petAge")%>살)<br>
								<%=(String)rms.get("petKind")%><br>
								<%=(String)rms.get("createDate")%> ~
								<br><%=(String)rms.get("dischargeDate")%><br>
								<button>
									<a href="/atti/view/hospitalizationDetail.jsp?regiNo=<%=(Integer)rms.get("regiNo")%>">상세보기</a>
								</button>
							</div>
			<%
						}else if(state.equals("OFF")){
			%>
							<div id="hospitalRmOFF">
								<span id="hospitalRmName">[ <%=roomName%> ] </span>
								<span id="offRmLight">&#9679;</span>
								<br>비어있음
							</div>
			<%
						}
					}
				}
			%>
		</div>
	</main>
</body>
</html>