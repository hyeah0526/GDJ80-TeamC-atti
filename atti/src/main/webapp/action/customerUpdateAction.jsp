<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*"%>
<%
	System.out.println("--------------------");
	System.out.println("customerUpdateAction.jsp");
	
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	String customerTel = request.getParameter("customerTel");
	String customerAddress = request.getParameter("customerAddress");
	
	System.out.println("customerNo: " + customerNo);
	System.out.println("customerTel" + customerTel);
	System.out.println("customerAddress" + customerAddress);
	
	int updateRow = CustomerDao.customerUpdate(customerNo, customerTel, customerAddress);
	
	if(updateRow > 0 ) {
		System.out.println("고객 정보 수정 완료");
		response.sendRedirect("/atti/view/customerDetail.jsp?customerNo=" + customerNo);
	} else {
		System.out.println("고객 정보 수정 실패");
		response.sendRedirect("/atti/view/customerUpdateForm.jsp?customerNo=" + customerNo);
	}
	
%>
