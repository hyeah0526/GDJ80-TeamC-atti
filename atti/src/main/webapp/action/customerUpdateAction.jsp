<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*"%>
<!-------------------- 
 * 기능 번호  : #19
 * 상세 설명  : 고객 정보 수정 기능
 * 시작 날짜 : 2024-05-13
 * 담당자 : 김지훈
 -------------------->
<%
	// 현재 페이지 확인
	System.out.println("--------------------");
	System.out.println("customerUpdateAction.jsp");
%>

<!-- Controller layer  -->
<%	
	// customerUpdateForm -> customerUpdateAction
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	String customerTel = request.getParameter("customerTel");
	String customerAddress = request.getParameter("customerAddress");
	
	// 디버깅
	//System.out.println("customerNo: " + customerNo);
	//System.out.println("customerTel" + customerTel);
	//System.out.println("customerAddress" + customerAddress);
%>

<!-- model layer -->
<%	
	int updateRow = CustomerDao.customerUpdate(customerNo, customerTel, customerAddress);
	
	if(updateRow > 0 ) {
		System.out.println("고객 정보 수정 완료");
		response.sendRedirect("/atti/view/customerDetail.jsp?customerNo=" + customerNo);
	} else {
		System.out.println("고객 정보 수정 실패");
		response.sendRedirect("/atti/view/customerUpdateForm.jsp?customerNo=" + customerNo);
	}
%>
