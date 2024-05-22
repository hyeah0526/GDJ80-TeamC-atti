<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="atti.*" %>

<!-------------------- 
 * 기능 번호  : #32, #47
 * 상세 설명  : 진료 내용 등록(처방,입원)
 * 시작 날짜 : 2024-05-16
 * 담당자 : 김인수, 김지훈, 박혜아, 한은혜
 -------------------->

<!-- Controller layer  -->
<%
/* 
	//로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}
*/
	
	//사용자의 진료 번호 
	//int regiNo = Integer.parseInt(request.getParameter("regiNo"));
	int regiNo = 15;
	
%>

<!-- Model layer -->

<% 
	//진료
%>


<% 
	//검사
%>


<% 
	//수술
%>


<% 
	//처방
	
	//약선택을 위해 전체 약 조회
	ArrayList<HashMap<String, Object>> medicineList = PrescriptionDao.medicineList();
	
	//처방 받은 약 정보 전체 조회
	ArrayList<HashMap<String, Object>> prescriptionDetail = PrescriptionDao.prescrptionDetail(regiNo); 
	
	//디버깅
	//System.out.println("clinicDetailForm.jsp medicineList--> "+medicineList);
	//System.out.println("clinicDetailForm.jsp prescriptionDetail--> "+prescriptionDetail);
%>


<%
	//입원
	//변수가져오기
	String prescriptionUpdate = request.getParameter("prescriptionUpdate");
	if(prescriptionUpdate == null){
		prescriptionUpdate = "";
	}
	
	//사용 가능한 입원실 정보 조회
	ArrayList<HashMap<String, Object>>  hospitalRoomList = HospitalizationDao.hospitalRoomList();

	//진료 번호를 통해 입원 환자 정보 조회 
	HashMap<String, Object> hospitalizationDetail = HospitalizationDao.hospitalizationDetail(regiNo);

	
	//디버깅
	//System.out.println(hospitalRoomList);
	//System.out.println(hospitalizationDetail);
	
	  // 입원 환자 정보가 없는 경우 초기화
	if( hospitalizationDetail == null){
		hospitalizationDetail = new HashMap<>();
	}
	
	//디버깅
	//System.out.println(hospitalizationDetail);
	
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
	<link rel="stylesheet" href="../css/css_hyeah.css">
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
		<!-- 상세정보 전체 출력 창(정보가 없을경우 공란표기) -->
		<h5>고객정보 상세보기창</h5>
		<div id="clinicDetailMainDiv">
			
			<!-- 동물/보호자 정보 -->
			<div>동물/보호자 정보</div>
			
			<!-- 접수/진료 정보 -->
			<div>접수/진료 정보</div>
			
		</div><br><br>
	
	
		<!-- 정보등록 및 상세보기 -->
		<h5>정보등록 및 상세보기</h5>
		
		<!-- 처방: 등록된 처방정보 출력 -->
		
		
		<!-- 처방: 약 코드 및 내용 입력 폼 -->
		<div id="" style="border: 1px solid #ced4da; border-radius: 10px; width: 100%;">
			<div style="border: 1px solid red;">
					처방하기		
			</div>
			<div style="border: 1px solid red;">
				<h6>처방받은 약</h6>
				<%
						// 등록된 처방을 전체보여주기
						for(HashMap pd2 : prescriptionDetail){
				%>
							<table>
								<tr>
									<th>약</th>
									<td><%=pd2.get("medicineName")%></td>
									<th rowspan="3"><button type="submit">삭제</button></th>
								</tr>
								<tr>
									<th>내용</th>
									<td><%=pd2.get("prescriptionContent")%></td>
								</tr>
								<tr>
									<th>처방날짜</th>
									<td><%=pd2.get("prescriptionDate")%></td>
								</tr>
							</table>
				<%
						}
				%>
			</div>
			
			<div style="border: 1px solid red;">
				<h6>약 신규 등록</h6>
				<form action="/atti/action/clinicAction.jsp" method="post" id="prescriptionForm">
					<input type="hidden" value="<%=regiNo%>" name="regiNo">
					<input type="hidden" value="prescription" name="selectBtn">
					<input type="hidden" value="prescriptionInsert" name="selectPrescription">
					<input type="hidden" value="prescriptionUpdate" name="selectPrescription">
					
					
					<div id="">
						<!-- 처방받을 약코드를 선택 -->
						<div>약 선택</div>
							<select name="medicineNo">
								<%
									for(HashMap mc : medicineList){
								%>
										<option value="<%=(Integer)mc.get("medicineNo")%>">
											<%=(String)mc.get("medicineName")%>
										</option>
								<%	
									}
								%>
							</select>
							
						<!-- 선택된 약코드에대한 처방내용 등록 -->
						<div>처방내용</div>
						<input name="prescriptionContent">
						
						<button type="submit">저장</button>
					</div>
				</form>
			</div>
		</div><br>
		
		
		
		<!-- 입원 환자 호실 선택 및 입원 내용 입력 폼 -->
		<form action="/atti/action/clinicAction.jsp" method="post" id="hospitalizationRegiForm">			
		
			<input type="hidden" value="<%=regiNo%>" name="regiNo">
			<input type="hidden" value="hospitalization" name="selectBtn">

			<div id="hospitalizationTitleDiv">
				입원			
			</div>
			
			<div id="animalSelectBoxDiv">
				
				<%
					//입원실 정보 유무에 따라 다른 처리
					if("퇴원".equals(hospitalizationDetail.get("state"))){
				  		String empMajor = (String) hospitalizationDetail.get("empMajor");
                        String roomName = (String) hospitalizationDetail.get("roomName");
				%>
					<div>호실 선택</div>
				
					<%
						if("포유류".equals(empMajor)){ 
					%>
						<!-- 포유류 입원실 침대 선택하기 -->
						<select name="mammalRoom">
							<%
								for(HashMap<String, Object> room : hospitalRoomList){
									String roomNames = (String) room.get("room_name");
                                    if(roomNames.startsWith("A")) {
							%>
										<option value="<%= roomNames %>"><%= roomNames %></option>
							<%
                                    }
								}
							%>
						</select>				
					<%
						}else if("파충류".equals(empMajor)){
					%>
						<!-- 파충류 입원실 침대 선택하기 -->
						<select name="reptilesRoom">
							<%
								for(HashMap<String, Object> room : hospitalRoomList){
									String roomNames = (String) room.get("room_name");
                                    if(roomNames.startsWith("B")) {
							%>
										<option value="<%= roomNames %>"><%= roomNames %></option>
							<%
                                    }
								}
							%>
						</select>
					<%	
						}else{
					%>
						<!-- 조류 입원실 침대 선택하기 -->
						<select name="birdRoom">
							<%
								for(HashMap<String, Object> room : hospitalRoomList){
									String roomNames = (String) room.get("room_name");
                                    if(roomNames.startsWith("C")) {
							%>
										<option value="<%= roomNames %>"><%= roomNames %></option>
							<%
                                    }
								}
							%>
						</select>					
					<%
						}
					%>
					<input type="hidden" name="state" value="<%=hospitalizationDetail.get("state")%>">
					<button type="submit">저장</button>
			
				<%		
					}else{
						
				%>
					<div>
						<div>
							<%=hospitalizationDetail.get("empMajor")%> / 
							<%=hospitalizationDetail.get("petName")%>
						</div>
						<div>
							"<%=hospitalizationDetail.get("roomName")%>" 입원중
						</div>
						<div>
							입원일: <%=hospitalizationDetail.get("createDate").toString().substring(0,10)%>
						</div>
						<div>
							퇴원일: <%=hospitalizationDetail.get("dischargeDate").toString().substring(0,10)%>	
						</div>
					</div>
				<%
					}
				%>
			</div>
		</form>
		
	</main>
</body>
</html>