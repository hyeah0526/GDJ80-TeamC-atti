<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="atti.*"%>    
<%@ page import="java.util.*" %>
<!-------------------- 
 * 기능 번호  : #16
 * 상세 설명  : 고객 등록 기능
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
	// 세션을 변수로 변환
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	
	// 로그인한 사용자가 관리자인지 확인
	// 관리자, 직원 여부에 따라 보여지는 뷰가 달라짐
	if(loginEmp == null || (loginEmp != null && loginEmp.get("empNo").toString().charAt(0) != '1')){
		response.sendRedirect("/atti/view/main.jsp"); // 로그인하지 않은 사용자는 로그인 페이지로 이동
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
%>
<!-- model layer -->
<%	
	// 메소드의 반환값에 customerNo를 할당함
	// 
	int customerNo = CustomerDao.customerRegistration(customerName, customerTel, customerAddress);
	
	// customerNo가 1 이상일 경우 등록 성공
	if(customerNo > 0) {
		System.out.println("고객 등록 성공");
		response.sendRedirect("/atti/view/customerDetail.jsp?customerNo=" + customerNo);
		// 고객 등록 성공 시 customerDetail로 redirect
	} else {
		System.out.println("고객 등록 실패");
		response.sendRedirect("/atti/view/customerRegiForm.jsp");
		// 고객 등록 실패 시 customerRegiForm으로 redirect
	}
%>    