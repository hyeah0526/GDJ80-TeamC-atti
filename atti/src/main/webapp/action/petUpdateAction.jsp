<%@page import="atti.PetDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-------------------- 
 * 기능 번호  : #24
 * 상세 설명  : 펫 정보 수정 페이지(액션)
 * 시작 날짜 : 2024-05-13
 * 담당자 : 김지훈
 -------------------->

<%
	System.out.println("--------------------");
	System.out.println("petUpdateAction.jsp");
%>
<%	
	int petNo = Integer.parseInt(request.getParameter("petNo"));
	String petName = request.getParameter("petName");
	
	System.out.println("petNo: " + petNo);
	System.out.println("petName: " + petName);
	
	int updateRow = PetDao.petUpdate(petNo, petName);
	
	if(updateRow > 0) {
		System.out.println("펫 정보 수정이 완료되었습니다.");
		response.sendRedirect("/atti/view/petDetail.jsp?petNo=" + petNo);
	} else {
		System.out.println("펫 정보 수정이 실패하였습니다.");
		response.sendRedirect("/atti/view/petUpdateForm.jsp?petNo=" + petNo);
	}
%>

