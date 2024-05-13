<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*"%>   
<!-------------------- 
 * 기능 번호  : #21
 * 상세 설명  : 펫 정보 등록 페이지(액션)
 * 시작 날짜 : 2024-05-13
 * 담당자 : 김지훈
 -------------------->
 
 <%
	System.out.println("--------------------");
	System.out.println("petRegiAction.jsp");
	
	
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	String major = request.getParameter("major");
	String petKind = request.getParameter("petKind");
	String petName = request.getParameter("petName");
	String petBirth = request.getParameter("petBirth");
	
	// form -> action 파라미터값 확인
	System.out.println("customerNo: " + customerNo);
	System.out.println("major: " + major);
	System.out.println("petKind: " + petKind);
	System.out.println("petName: " + petName);
	System.out.println("petBirth: " + petBirth);
	
	int insertRow = PetDao.petRegistration(customerNo, major, petKind, petName, petBirth);
	
	if(insertRow > 0) {
		System.out.println("고객 등록 성공");
		response.sendRedirect("/atti/view/customerDetail.jsp?customerNo=" + customerNo);
	} else {
		System.out.println("고객 등록 실패");
		response.sendRedirect("/atti/view/customerRegiForm.jsp");
	} 
 %>
