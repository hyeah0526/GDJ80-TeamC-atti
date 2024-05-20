<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="atti.*" %>

<!-------------------- 
 * 기능 번호  : #33
 * 상세 설명  : 진료 내용 등록(수술,입원)
 * 시작 날짜 : 2024-05-16
 * 담당자 : 김인수, 김지훈, 박혜아, 한은혜
 -------------------->
 
<!-- Controller layer  -->
<% 
	
	//로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}
	
	//사용자의 진료 번호 
	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
	
	//디버깅
	//System.out.println(regiNo);
	
	
	
	
	
	
	
	
	/*--------------------------------------------------------------------------------------------*/
	
	/*입원*/
	// 입원 환자의 입원 정보, 입원 내용 등록 
	String mammalRoom = request.getParameter("mammalRoom"); // 포유류 입원실 침대
	String reptilesRoom = request.getParameter("reptilesRoom"); // 파충류 입원실 침대
	String birdRoom = request.getParameter("birdRoom"); // 조류 입원실 침대
	String roomName = request.getParameter("roomName"); // 이미 선택된 입원실 침대
	String state = request.getParameter("state"); // 입원 정보

	//디버깅
	//System.out.println("mammalRoom = " + mammalRoom);
	//System.out.println("reptilesRoom = " + reptilesRoom);
	//System.out.println("birdRoom = " + birdRoom);
	//System.out.println("roomName = " + roomName);
	//System.out.println("hospitalizationContent = " + hospitalizationContent);
	
	//null 체크 
	if (mammalRoom == null) mammalRoom = "";
	if (reptilesRoom == null) reptilesRoom = "";
	if (birdRoom == null) birdRoom = "";
	if (roomName == null) roomName = "";

	//빈값 체크
	if (!mammalRoom.isEmpty()) {
	    roomName = mammalRoom;
	} else if (!reptilesRoom.isEmpty()) {
	    roomName = reptilesRoom;
	} else if (!birdRoom.isEmpty()) {
	    roomName = birdRoom;
	}
	
%>


<!-- Model layer -->
<% 

	// 입원 정보 등록과 수정 
	int updateRow = HospitalizationDao.hospitalizationUpdate(roomName, regiNo);
	
	if(updateRow > 0){
		HospitalizationDao.hospitalRoomUpdate(roomName);
	}

	//디버깅
	//System.out.println("updateRow = " + updateRow);
	
	response.sendRedirect("/atti/view/clinicDetailForm.jsp"); // 진료 페이지로 이동
	
	
%>
