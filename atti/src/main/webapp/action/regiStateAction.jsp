<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="atti.*"%>
<!-- 
	 * 기능 번호  	: #28
	 * 상세 설명  	: 접수 상태 변경
	 * 시작 날짜 	: 2024-05-20
	 * 담당자 	: 한은혜
 -->
<%
	// input 값 가져오기 
	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
	String regiState = request.getParameter("regiState");
	// 디버깅
	System.out.println(regiNo + " ====== regiStateAction regiNo");
	System.out.println(regiState + " ====== regiStateAction regiState");
	
	String errMsg = "";
	// 상태 변경 메서드 호출 
	int updateRow = RegistrationDao.regiCancel(regiNo, regiState);
	
	// 업데이트 실패 시 
	if(updateRow == 0){
		
		errMsg = URLEncoder.encode("상태 변경에 실패했습니다. 다시 시도해주세요.", "UTF-8");
		System.out.println("resiStateAction 상태 변경 실패");
		
	} else {
		// 업데이트 성공 시
		System.out.println("resiStateAction 상태 변경 성공");
		response.sendRedirect("/atti/view/regiList.jsp");
	}
	
%>
