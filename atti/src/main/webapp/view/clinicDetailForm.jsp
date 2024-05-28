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
	
	//디버깅
	//System.out.println(regiNo);
	
%>

<!-- Model layer -->

<% 
	//진료
	ArrayList<HashMap<String, Object>> clinicInfo = ClinicDao.clinicInfo(regiNo);
	ArrayList<HashMap<String, Object>> clinicList = ClinicDao.clinicDetail(regiNo);
%>


<% 
	//검사
%>


<% 
	//수술
		//수술
	String surgeryUpdate = request.getParameter("surgeryUpdate");
	
	// 수술 수정을 위해 받는 파라미터값
	int surgeryNo = 0;
	if (request.getParameter("surgeryNo") != null) {
		surgeryNo = Integer.parseInt(request.getParameter("surgeryNo"));
		System.out.println("surgeryNo: " + surgeryNo);
	}
	String surgeryContent = request.getParameter("surgeryContent");
	String surgeryKind = request.getParameter("surgeryKind");
	String surgeryState = request.getParameter("surgeryState");
	String surgeryDate = request.getParameter("surgeryDate");
	
	//System.out.println("surgeryContent: " + surgeryContent);
	//System.out.println("surgeryKind: " + surgeryKind);
	//System.out.println("surgeryState: " + surgeryState);
	//System.out.println("surgeryDate: " + surgeryDate);
	
	ArrayList<HashMap<String, String>> surgeryCategory = SurgeryDao.surgeryKind();
	ArrayList<HashMap<String, Object>> surgeryList = SurgeryDao.surgeryDetailByClinic(regiNo);
	
	ArrayList<HashMap<String, Object>> surgeryDetail = null;
	if (surgeryNo != 0) {
		surgeryDetail = SurgeryDao.surgeryDetail(surgeryNo);
	}
%>


<% 
	//처방
	String selectPrescription = request.getParameter("selectPrescription");
	
	//처방 수정버튼을 누를경우 상세 정보를 가져오기
	HashMap<String, Object> prescriptionOne = new HashMap<String, Object>();
	
	if(selectPrescription == null){
		selectPrescription = "";
	}else if(selectPrescription.equals("prescriptionUpdate")){
		
		//수정원하는 처방고유번호에 대한 상세보기 조회
		int prescriptionNo = Integer.parseInt(request.getParameter("prescriptionNo"));
		prescriptionOne = PrescriptionDao.prescrptionOne(regiNo, prescriptionNo);
	}
	
	//약선택을 위해 전체 약 조회
	ArrayList<HashMap<String, Object>> medicineList = PrescriptionDao.medicineList();
	
	//처방 받은 약 정보 전체 조회
	ArrayList<HashMap<String, Object>> prescriptionDetail = PrescriptionDao.prescrptionDetail(regiNo); 
	
	//디버깅
	//System.out.println("clinicDetailForm.jsp medicineList--> "+medicineList);
	//System.out.println("clinicDetailForm.jsp prescriptionDetail--> "+prescriptionDetail);
	//System.out.println("clinicDetailForm.jsp selectPrescription--> "+selectPrescription);
	//System.out.println("clinicDetailForm.jsp prescriptionOne--> "+prescriptionOne);
%>


<%
	//입원
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
		<!-- 상세정보 전체 출력 창(정보가 없을경우 공란표기) -->
		<h5>고객정보 상세보기창</h5>
		<div id="clinicDetailMainDiv">
			
			<div>동물/보호자 정보</div>
			<!-- 접수/진료 정보 -->
			<div>접수/진료 정보</div>
			<%
				for(HashMap<String, Object> ci : clinicInfo) {
			%>
					<div>보호자: <%=(String)(ci.get("customerName"))%></div>
					<div>분류: <%=(String)(ci.get("empMajor"))%></div>
					<div>종류: <%=(String)(ci.get("petKind"))%></div>
					<div>이름: <%=(String)(ci.get("petName"))%></div>
					<div>접수 내용: <%=(String)(ci.get("regiContent"))%></div>
					<div>접수 시간: <%=(String)(ci.get("regiDate"))%></div>
					<div>진료 시간: <%=(String)(ci.get("createDate"))%></div>
			<%		
				}
			%>
			
		</div><br><br>
	
		<!-- 정보등록 및 상세보기 -->
		<h5>정보등록 및 상세보기</h5>
		<form action="/atti/action/clinicAction.jsp" method="post" id="hospitalizationRegiForm">
			<input type="hidden" value="<%=regiNo%>" name="regiNo"> 

			<div id="clinicTitleDiv">
				진료
			</div>

			<div id="clinicContentBoxDiv">
				<div>&nbsp;</div>
					<%
						if (clinicList == null) {
					%>
							<div>진료 이력이 없습니다.</div>
					<%
						} else {
							for (HashMap<String, Object> cl : clinicList) {
					%>
								[<%=cl.get("updateDate")%>]&nbsp;<%=cl.get("clinicContent")%><br>
					<%
							}
						}
					%>
				<textarea rows="3" cols="80" name="clinicContent" style="justify-content: left"></textarea><br>
				<button type="submit" style="width: 250px;">저장</button>
			</div>
		</form>
				<!-- 수술: 등록된 수술 정보 출력 -->
		<%
			if (surgeryUpdate == null) { 
	   	%>
	
			<div id="" style="border: 1px solid #ced4da; border-radius: 10px; width: 100%;">
				<div style="border: 1px solid red;">
					
				<div>과거 수술 이력</div>
				<%
					if(surgeryList == null){
				%>
						<div>수술 이력이 없습니다.</div>
				<%	  
					} else {
						for(HashMap<String, Object> sl : surgeryList) {
				%>		   
							
							<table>
								<tr>
									<th>
										수술 종류
									</th>
									<td>
										<%=sl.get("surgeryKind")%>
									</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<th>
										<label for="surgeryContent">수술 내용</label>
									</th>
									<td>
										<%=sl.get("surgeryContent")%>
									</td>
									<td>
										<form method="post" action="/atti/view/clinicDetailTest.jsp">
											<input type="hidden" name="surgeryUpdate" value="surgeryUpdate"> 
											<input type="hidden" name="surgeryNo" value="<%=sl.get("surgeryNo")%>">
											<button type="submit">수정</button><br>
										 </form>
									</td>
								</tr>
								<tr>
									<th>
										진행 상황
									</th>
									<td>
										<%=sl.get("surgeryState")%>
									</td>
									<td rowspan="2">&nbsp;</td>
								</tr>
								<tr>
									<th>
										수술 일자
									</th>
									<td>
										<%=sl.get("surgeryDate")%>
									</td>
								</tr>
							</table>
					<%	
						}
					%>
				<%						  
					}
				%>						
				</div>
				<!-- 수술: 새로운 수술 등록 -->
				<div style="border: 1px solid red;">
					<h6>수술</h6>
					<form method="post" action="/atti/action/clinicSurgeryAction.jsp">
					<input type="hidden" name="surgeryInsert" value="surgeryInsert">
					<input type="hidden" value="<%=regiNo%>" name="regiNo">
					<table>
						<tr>
							<th>수술 종류</th>
							<td>
								<select name="surgeryKind">
									<option value="">===수술===</option>
									<%
										for(HashMap<String, String> sc : surgeryCategory) {
									%>
											<option value="<%=sc.get("surgeryKind")%>"><%=sc.get("surgeryKind")%></option>
									<%	  
										}
									%>
								</select>
							</td>			
						</tr>
						<tr>			
							<th>수술 일자</th>		
							<td><input type="datetime-local" name="surgeryDate"></td>
						</tr>
						<tr>
							<th>수술 내용</th>
							<td>
								<textarea placeholder="수술 내용 등록" name="surgeryContent"></textarea>
							</td>
						</tr>
					</table>
					<button type="submit">저장</button>	
					</form>
				</div>
			</div>  
			<% 
				} else if (surgeryUpdate != null && surgeryDetail != null && !surgeryDetail.isEmpty()) {
					HashMap<String, Object> sd = surgeryDetail.get(0); 
					surgeryKind = (String) sd.get("surgeryKind");
					surgeryContent = (String) sd.get("surgeryContent");
					surgeryState = (String) sd.get("surgeryState");
					surgeryDate = (String) sd.get("surgeryDate");
	   		%>
					<div id="" style="border: 1px solid #ced4da; border-radius: 10px; width: 100%;">
						<div style="border: 1px solid red;">
							<form method="post" action="/atti/action/clinicSurgeryAction.jsp">
							<input type="hidden" name="surgeryUpdate" value="surgeryUpdate">
							<input type="hidden" name="surgeryNo" value="<%=surgeryNo%>">
							<input type="hidden" name="regiNo" value="<%=regiNo%>">
								<div>수술 정보 수정</div>
								<table>
									<tr>
										<th>
											<label for="surgeryKind">수술 종류</label>
										</th>
										<td>
											<input type="text" name="surgeryKind" value="<%=surgeryKind%>" readonly="readonly">
										</td>									
									</tr>
		 							<tr>
										<th>
											<label for="surgeryContent">수술 내용</label>
										</th>
										<td>
											<input type="text" name="surgeryContent" value="<%=surgeryContent%>">
										</td>									
									</tr>
								 	<tr>
										<th>
											<label for="surgeryState">진행 상황</label>
										</th>
										<td>
											<input type="text" name="surgeryState" value="<%=surgeryState%>" readonly="readonly">
										</td>									
									</tr>
									<tr>
										<th>
											<label for="surgeryDate">수술 일자</label>
										</th>
										<td>
											<input type="text" name="surgeryDate" value="<%=surgeryDate%>" readonly="readonly">
										</td>									
									</tr>
								</table>
								<button type="submit">수정 완료</button>
							</form>
						</div>
					</div>
			<%
				} 
	   		%>			
		
		<!-- 처방 조회/신규등록/수정 -->
		<div id="prescrptionMainDiv">
			<div id="prescrptionTitleDiv">
				처방	
			</div>
			
			<!-- 처방방: 약 신규등록 -->
			<div id="prescrptionContentLeftDiv">
				<span>약 신규 등록</span><br><br>
				<form action="/atti/action/clinicPrescrptionAction.jsp" method="post" id="prescriptionForm">
					<input type="hidden" value="<%=regiNo%>" name="regiNo">
					<input type="hidden" value="prescriptionInsert" name="selectPrescription">
					
					<div id="">
						<!-- 처방받을 약코드를 선택 -->
						<div><h6>약 선택</h6></div>
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
							</select><br><br>
							
						<!-- 선택된 약코드에대한 처방내용 등록 -->
						<div><h6>처방내용</h6></div>
						<input name="prescriptionContent"><br><br>
						
						<button type="submit">저장</button>
					</div>
				</form>
			</div>
			
			<div id="prescrptionContentRightDiv">
				<%
					/* 처방: 처방받은 약 전체 조회 */
					if(!selectPrescription.equals("prescriptionUpdate")){
				%>
						<span>처방받은 약</span><br><br>
				<%
						for(HashMap pd2 : prescriptionDetail){
				%>
							<table>
								<tr>
									<th>약</th>
									<td><%=pd2.get("medicineName")%></td>
									<td rowspan="3">
										<button type="submit" 
											onclick="location.href='/atti/view/clinicDetailForm.jsp?regiNo=<%=regiNo%>&prescriptionNo=<%=pd2.get("prescriptionNo")%>&selectPrescription=prescriptionUpdate'">
											수정
										</button>
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
										<%=pd2.get("prescriptionContent")%>
									</td>
								</tr>
								<tr>
									<th>처방날짜</th>
									<td><%=pd2.get("prescriptionDate")%></td>
								</tr>
							</table>
				<%
						}
						
					/* 처방: 수정원하는 약 1개 선택 후 수정 */
					}else if(selectPrescription.equals("prescriptionUpdate")){
				%>
						<form action="/atti/action/clinicPrescrptionAction.jsp" method="post">
							<span>처방 수정</span>
							
							<input type="hidden" value="prescriptionUpdate" name="selectPrescription">
							<input type="hidden" value="<%=prescriptionOne.get("prescriptionNo")%>" name="prescriptionNo">
							<input type="hidden" value="<%=prescriptionOne.get("medicineNo")%>" name="oldMedicineNo">
							<input type="hidden" value="<%=regiNo%>" name="regiNo">
							
							<table>
								<tr>
									<th>약</th>
									<td>
										<select name="newMedicineNo">
									<%
											for(HashMap mc : medicineList){
												int medicineNo1 = (Integer)mc.get("medicineNo");
												int medicineNo2 = (Integer)prescriptionOne.get("medicineNo");
									%>
												<option value="<%=medicineNo1%>" <%= medicineNo1==medicineNo2 ? "selected" : ""%>>
													<%=(String)mc.get("medicineName")%>
												</option>
									<%	
											}
									%>
										</select>
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
										<input type="text" value="<%=prescriptionOne.get("prescriptionContent")%>" name="prescriptionContent">
									</td>
								</tr>
								<tr>
									<th>처방날짜</th>
									<td><%=prescriptionOne.get("prescriptionDate")%></td>
								</tr>
								<tr>
									<td colspan="4"><button type="submit">수정완료</button></td>
								</tr>
							</table>
						</form>
				<%
					}
				%>
			</div>
		</div><br>
		</div>
		
		<!-- 입원 환자 호실 선택 및 입원 내용 입력 폼 -->
		<form action="/atti/action/clinicHospitalAction.jsp" method="post" id="hospitalizationRegiForm">			
			<input type="hidden" value="<%=regiNo%>" name="regiNo">
			<input type="hidden" value="입원" name="paymentCategory">

			<div id="hospitalizationTitleDiv">
				입원			
			</div>
			
			<div id="animalSelectBoxDiv">
				
				<%
					//입원실 정보 유무에 따라 다른 처리
					if(("퇴원".equals(hospitalizationDetail.get("state")) || (hospitalizationDetail.get("state") == null))){
				  		String empMajor = (String) hospitalizationDetail.get("empMajor");
                        String roomName = (String) hospitalizationDetail.get("roomName");
                        
                        //디버깅
                        //System.out.println("roomName = " + roomName);
                        //System.out.println("empMajor = " + empMajor);
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
							입원일: 
							<%
								if(hospitalizationDetail.get("createDate") != null){
							%>							
								<%=hospitalizationDetail.get("createDate").toString().substring(0,10)%>
							<%
								}
							%>
						</div>
						<div>
							퇴원일: 
							<%
								if(hospitalizationDetail.get("dischargeDate") != null){
							%>
								<%=hospitalizationDetail.get("dischargeDate").toString().substring(0,10)%>								
							<%
								}
							%>
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