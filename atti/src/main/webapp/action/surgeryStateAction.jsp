<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*"%>


<%
	System.out.println("--------------------");
	System.out.println("surgeryStateAction.jsp");
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
	
	// surgeryList -> surgeryStateAction
	// 수술 대기 -> 수술 완료 상태로 변경을 위한 파라미터
	int surgeryNo = Integer.parseInt(request.getParameter("surgeryNo"));
	
	// 디버깅
	System.out.println(surgeryNo);
%>
<!-- model layer -->
<%
	int updateRow = SurgeryDao.surgeryStateUpdate(surgeryNo);
	
	// updateRow가 1 이상일 시 메소드 실행 
	if(updateRow == 1) {
		System.out.println("수술 상태 변경 완료");
		response.sendRedirect("/atti/view/surgeryList.jsp");
	}
%>