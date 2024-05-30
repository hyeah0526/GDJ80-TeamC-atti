<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="atti.*"%>
<!-- 
	 * 기능 번호  	: #28, 31
	 * 상세 설명  	: 접수 상태 변경
	 * 시작 날짜 	: 2024-05-20
	 * 담당자 	: 한은혜
 -->
<%
	// input 값 가져오기 
	int regiNo = Integer.parseInt(request.getParameter("regiNo"));

	int petNo = Integer.parseInt(request.getParameter("petNo"));
	String regiState = request.getParameter("regiState");
	String clinicInsert = request.getParameter("clinicInsert");
	// 디버깅
	System.out.println(regiNo + " ====== regiStateAction regiNo");
	//System.out.println(petNo + " ====== regiStateAction petNo");
	System.out.println(regiState + " ====== regiStateAction regiState");
	System.out.println(clinicInsert + " ====== regiStateAction clinicInsert");
	
	// 상태 변경 메서드 호출 
	int updateRow = RegistrationDao.regiState(regiNo, regiState);
	int insertRow = 0;
	
	if (updateRow == 1) {
	    if (regiState.equals("접수취소")) {
	    	// 접수 취소 성공시
	        System.out.println(regiState + " ====== regiStateAction regiList regiState");
	        System.out.println("regiList 접수 취소 성공");
	        response.sendRedirect("/atti/view/regiList.jsp");
	        
	    } else if (regiState.equals("예약취소")) {
	    	// 예약 취소 성공시
	        System.out.println(regiState + " ====== regiStateAction reservationList regiState");
	        System.out.println("reservationList 예약 취소 성공");
	        response.sendRedirect("/atti/view/reservationList.jsp");
	   
	    } else if (regiState.equals("진행")){
	    	// 접수 진행 상태가 대기 -> 진행 으로 변경
	    	System.out.println(regiState + " ====== regiStateAction clinicList regiState");
	    	System.out.println("clinicList 진행으로 변경 성공");
	    	if(clinicInsert.equals("clinicInsert")) {
		    	String paymentCategory = "진료";
			 	insertRow = ClinicDao.clinicInsert(regiNo);
				 // 중복된 결제 정보 조회 
				HashMap<String, Object> paymentSelect = PaymentDao.paymentSelect(regiNo, paymentCategory);
			
				//디버깅
				//System.out.println(paymentSelect);
				//System.out.println(paymentSelect.size());
				
				//중복된 결제 정보가 없는 경우
				if(paymentSelect == null || paymentSelect.size() < 1){
					
					//결제 정보 저장
					PaymentDao.paymentInsert(regiNo, paymentCategory);
					
				} else {
					
					//결제 정보 수정
					PaymentDao.paymentUpdate(regiNo, paymentCategory);
				}
		    	
		        response.sendRedirect("/atti/view/clinicDetailForm.jsp?regiNo=" + regiNo + "&" + "petNo=" +petNo);
		    }
		}
   	}
	    	
	    	
	
%>
