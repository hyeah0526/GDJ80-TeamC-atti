<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*" %>
<!-------------------- 
 * 기능 번호  : #19
 * 상세 설명  : 보호자 정보 수정 기능
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
	// 로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}
		
	// customerUpdateForm -> customerUpdateAction
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	String customerTel = request.getParameter("customerTel");
	String customerAddress = request.getParameter("customerAddress");
	
	// 디버깅
	//System.out.println("customerNo: " + customerNo);
	//System.out.println("customerTel" + customerTel);
	//System.out.println("customerAddress" + customerAddress);

	// 보호자 정보 수정 실패 시 보여질 에러 메시지
	String errorMsg = null;
	
	if(customerTel == null || customerTel.trim().isEmpty() || !(customerTel.length() ==  11) || !customerTel.matches("\\d+")) { // customerName이 null일 시
		errorMsg = URLEncoder.encode("보호자 연락처가 입력되지 않았으니 확인해 주세요", "UTF-8");
	} else if(customerAddress == null || customerAddress.trim().isEmpty()) { // customerTel이 null일 시
		errorMsg = URLEncoder.encode("보호자 주소가 입력되지 않았으니 확인해 주세요", "UTF-8");
	} 
	
	System.out.println("errorMsg: " + errorMsg);
%>

<!-- model layer -->
<%	
	// errorMsg가 null일 경우 메소드 실행
	if(errorMsg == null){
		int updateRow = CustomerDao.customerUpdate(customerNo, customerTel, customerAddress);
		if(updateRow > 0 ) { // updateRow가 1 이상일 경우 수정 완료
			System.out.println("보호자 정보 수정 완료");
			response.sendRedirect("/atti/view/customerDetail.jsp?customerNo=" + customerNo);
			// 수정 성공 시 customerDetail로 redirect
		} else { // updateRow가 1 미만일 경우 수정 실패
			System.out.println("보호자 정보 수정 실패");
			response.sendRedirect("/atti/view/customerUpdateForm.jsp?customerNo=" + customerNo + "&" + "errorMsg=" + errorMsg);
			// 수정 실패 시 에러 메시지와 함께 customerUpdateForm으로 redirect
		}
	} else {
		response.sendRedirect("/atti/view/customerUpdateForm.jsp?customerNo=" + customerNo + "&" +"errorMsg=" + errorMsg);
		// 수정 실패 시 에러 메시지와 함께 customerUpdateForm으로 redirect
	}
	
%>
