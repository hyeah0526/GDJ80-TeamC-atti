<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*"%>
<%@ page import="java.util.*"%>

<%
	System.out.println("--------------------");
	System.out.println("surgeryStateAction.jsp");
%>
<!-- Controller layer  -->
<%
	// 로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}
	
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