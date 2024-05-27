<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="atti.*"%>    
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<!-------------------- 
 * 기능 번호  : #16
 * 상세 설명  : 보호자 등록 기능
 * 시작 날짜 : 2024-05-10
 * 담당자 : 김지훈
 -------------------->
<%
	// 현재 페이지 확인
	System.out.println("--------------------");
	System.out.println("customerRegiAction.jsp");
%>
<!-- Controller layer  -->
<%
	// 로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}

	// form에서 action으로 보낸 값
	String customerName = request.getParameter("customerName");
	String customerTel = request.getParameter("customerTel");
	String customerAddress = request.getParameter("customerAddress");
	
	// 디버깅
	//System.out.println("customerName: " + customerName);
	//System.out.println("customerTel: " + customerTel);
	//System.out.println("customerAddress: " + customerAddress);
	
	// 보호자 등록 실패 시 보여질 에러 메시지 
	String errorMsg = null;
	
	if(customerName == null || customerName.trim().isEmpty()) { // customerName이 null이거나 공백일 시
		errorMsg = URLEncoder.encode("보호자 이름이 입력되지 않았으니 확인해 주세요", "UTF-8");
	} else if(customerTel == null || customerTel.trim().isEmpty()) { // customerTel이 null이거나 공백일 시
		errorMsg = URLEncoder.encode("보호자 연락처가 입력되지 않았으니 확인해 주세요", "UTF-8");
	} else if(customerAddress == null || customerAddress.trim().isEmpty()) { // customerAddress가 null이거나 공백일 시
		errorMsg = URLEncoder.encode("보호자 주소가 입력되지 않았으니 확인해 주세요", "UTF-8");
	}
	
	System.out.println("errorMsg: " + errorMsg);
%>
<!-- model layer -->
<%	
	
	// errorMsg == null일 경우 메소드를 실행
	if(errorMsg == null) {
		// 메소드의 반환값에 customerNo를 할당함
		int customerNo = CustomerDao.customerRegistration(customerName, customerTel, customerAddress);
		// customerNo가 1 이상일 경우 등록 성공
		if(customerNo > 0) {
			System.out.println("보호자 등록 성공");
			response.sendRedirect("/atti/view/customerDetail.jsp?customerNo=" + customerNo);
			// 보호자 등록 성공 시 customerDetail로 redirect
		} else {
			System.out.println("보호자 등록 실패");
			response.sendRedirect("/atti/view/customerRegiForm.jsp?errorMsg=" + errorMsg);
			// 보호자 등록 실패 시 에러 메시지와 함께 customerRegiForm으로 redirect
		}
	} else { // errorMsg != null일 경우
		response.sendRedirect("/atti/view/customerRegiForm.jsp?errorMsg=" + errorMsg);
		// 보호자 등록 실패 시 에러 메시지와 함께 customerRegiForm으로 redirect
	}
%>    