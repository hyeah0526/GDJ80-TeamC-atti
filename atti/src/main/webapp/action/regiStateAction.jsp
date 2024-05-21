<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="atti.*"%>
<!-- 
	 * 기능 번호  	: #28
	 * 상세 설명  	: 접수 상태 변경
	 * 시작 날짜 	: 2024-05-20
	 * 담당자 	: 한은혜
 -->
<%
	// input 값 가져오기 
	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
	String regiState = request.getParameter("regiState");
	String buttonRegiState = regiState;
	// 디버깅
	//System.out.println(regiNo + " ====== regiStateAction regiNo");
	//System.out.println(regiState + " ====== regiStateAction regiState");
	System.out.println(buttonRegiState + " ====== regiStateAction buttonRegiState");
	
	// 상태 변경 메서드 호출 
	int updateRow = RegistrationDao.regiCancel(regiNo, regiState);
	
	if (updateRow == 1) {
	    if (buttonRegiState.equals("접수취소")) {
	    	// 접수 취소 성공시
	        //System.out.println(regiState + " ====== regiStateAction regiList regiState");
	        System.out.println("regiList 접수 취소 성공");
	        response.sendRedirect("/atti/view/regiList.jsp");
	        
	    } else if (buttonRegiState.equals("예약취소")) {
	    	// 예약 취소 성공시
	        //System.out.println(regiState + " ====== regiStateAction reservationList regiState");
	        System.out.println("reservationList 예약 취소 성공");
	        response.sendRedirect("/atti/view/reservationList.jsp");
	    }
	}
	
%>
