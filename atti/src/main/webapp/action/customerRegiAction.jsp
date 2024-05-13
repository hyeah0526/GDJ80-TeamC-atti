<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="atti.*"%>    
<%
	/*
	 * 기능 번호  : #16
	 * 상세 설명  : 고객 등록 기능
	 * 시작 날짜 : 2024-05-10
	 * 담당자 : 김지훈
	*/
	
	System.out.println("--------------------");
	System.out.println("customerRegiAction.jsp");
	
	String customerName = request.getParameter("customerName");
	String customerTel = request.getParameter("customerTel");
	String customerAddress = request.getParameter("customerAddress");
	
	
	// form -> action 파라미터값 확인
	
	System.out.println("customerName: " + customerName);
	System.out.println("customerTel: " + customerTel);
	System.out.println("customerAddress: " + customerAddress);
	
	
	// 메서드의 반환값을 customerNo를 할당
	int customerNo = CustomerDao.customerRegistration(customerName, customerTel, customerAddress);
	
	if(customerNo > 0) {
		System.out.println("고객 등록 성공");
		response.sendRedirect("/atti/view/customerDetail.jsp?customerNo=" + customerNo);
	} else {
		System.out.println("고객 등록 실패");
		response.sendRedirect("/atti/view/customerRegiForm.jsp");
	}
%>    