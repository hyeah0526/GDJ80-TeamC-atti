<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="atti.*" %>

<!-------------------- 
 * 기능 번호  : #33
 * 상세 설명  : 진료 내용 수정(입원)
 * 시작 날짜 : 2024-05-16
 * 담당자 : 김인수, 김지훈, 박혜아, 한은혜
 -------------------->
 
<!-- Controller layer  -->
<% 
	
	//로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}
	
	//사용자의 진료 번호 
	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
	
	
	/*입원*/
	// 입원 환자의 입원 정보, 입원 내용 등록 정보 
	String mammalRoom = request.getParameter("mammalRoom");
	String reptilesRoom = request.getParameter("reptilesRoom");
	String birdRoom = request.getParameter("birdRoom");
	String hospitalizationContent = request.getParameter("hospitalizationContent");
	
	if (mammalRoom == null) {
	    mammalRoom = "";
	}

	if (reptilesRoom == null) {
	    reptilesRoom = "";
	}

	if (birdRoom == null) {
	    birdRoom = "";
	}

	if (hospitalizationContent == null) {
	    hospitalizationContent = "";
	}
	
%>


<!-- Model layer -->
<% 
	
%>
