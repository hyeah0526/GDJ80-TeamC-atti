<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*" %>
<!-------------------- 
 * 기능 번호  : #33
 * 상세 설명  : 수술 등록(액션)
 * 시작 날짜 : 2024-05-22
 * 담당자 : 김지훈
 -------------------->    
<%
	System.out.println("--------------------");
	System.out.println("clinicSurgeryAction.jsp");
%>

<!-- Controller layer  -->
<%
	/* // 로그인한 사용자가 관리자인지 확인
	// 세션을 변수로 변환
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	// 관리자, 직원 여부에 따라 보여지는 뷰가 달라짐
	if(loginEmp == null || (loginEmp != null && loginEmp.get("empNo").toString().charAt(0) != '1')){
		response.sendRedirect("/atti/view/main.jsp"); // 로그인하지 않은 사용자는 로그인 페이지로 이동
		return;
	} */

	// clinicDetailFrom -> clinicSurgeryAction
	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
	String surgeryKind = request.getParameter("surgeryKind");
	String surgeryContent = request.getParameter("surgeryContent");
	String surgeryDate = request.getParameter("surgeryDate");

	// 디버깅
	System.out.println("regiNo: " + regiNo);
	System.out.println("surgeryKind: " + surgeryKind);
	System.out.println("surgeryContent: " + surgeryContent);
	System.out.println("surgeryDate: " + surgeryDate);
%>
<!-- model layer -->
<%
	int insertRow = SurgeryDao.surgeryInsert(regiNo, surgeryKind, surgeryContent, surgeryDate);
	
	if(insertRow == 1) {
		System.out.println("수술 등록 성공");
		response.sendRedirect("/atti/view/clinicDetailTest.jsp?regiNo=" + regiNo);
	}
%>
