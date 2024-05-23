<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="atti.*" %>
<!-------------------- 
 * 기능 번호  : #27
 * 상세 설명  : 접수 등록
 * 시작 날짜 : 2024-05-22
 * 담당자 : 한은혜 
 -------------------->
<%
	// 접수 등록 페이지(regiForm.jsp)에서 받아온 정보 
	int petNo = Integer.parseInt(request.getParameter("petNo"));
	String petName = request.getParameter("petName");
	String petKind = request.getParameter("petKind");
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	String customerName = request.getParameter("customerName");
	String customerTel = request.getParameter("customerTel");
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	String regiDateSelect = request.getParameter("regiDateSelect");
	String regiDateTime = request.getParameter("regiDateTime");
	String regiState = request.getParameter("regiState");
	String regiContent = request.getParameter("regiContent");
	// 진료 날짜 = 진료 YYYY-MM-DD TT:MM 
	String regiDate = regiDateSelect + " " + regiDateTime;
	
	//에러메세지 
	String errMsg = "";
	if(regiDateSelect == null || regiDateTime == null || regiState == null){
		
		errMsg = URLEncoder.encode("데이터를 입력해주세요.", "UTF-8");
	}
	
	
	// 진료 등록 메서드 호출
	int insertRow = RegistrationDao.regiAccept(empNo, petNo, regiContent, regiDate, regiState);
	
	if(insertRow == 1 && regiState.equals("대기")) {
		// 대기 접수 등록 성공
		response.sendRedirect("/atti/view/regiList.jsp");
		
	} else if(insertRow == 1 && regiState.equals("예약")) {
		// 예약 접수 등록 성공
		response.sendRedirect("/atti/view/reservationList.jsp");
	} else {
		// 등록 실패
		response.sendRedirect("/atti/view/regiForm.jsp");
		errMsg = URLEncoder.encode("다시 등록해주세요.", "UTF-8");
	}
	
	// 디버깅 
	//System.out.println(petNo + " ====== regiAction petNo");
	//System.out.println(petName + " ====== regiAction petName");
	//System.out.println(petKind + " ====== regiAction petKind");
	//System.out.println(customerNo + " ====== regiAction customerNo");
	//System.out.println(customerName + " ====== regiAction customerName");
	//System.out.println(customerTel + " ====== regiAction customerTel");
	//System.out.println(empNo + " ====== regiAction empNo");
	//System.out.println(regiDateSelect + " ====== regiAction regiDateSelect");
	//System.out.println(regiDateTime + " ====== regiAction regiDateTime");
	//System.out.println(regiState + " ====== regiAction regiState");
	//System.out.println(regiContent + " ====== regiAction regiContent");
	//System.out.println(regiDate + " ====== regiAction regiDate");
	
%>