<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="atti.*" %>

<!-------------------- 
 * 기능 번호  : #12
 * 상세 설명  : 직원 정보 수정 페이지(전화번호, 전공)
 * 시작 날짜 : 2024-05-14
 * 담당자 : 김인수
 -------------------->

<!-- Controller layer  -->
<%
	//세션을 변수로 변환
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	
	//로그인한 사용자가 관리자인지 확인
	if(loginEmp == null || (loginEmp != null && loginEmp.get("empNo").toString().charAt(0) != '1')){
		response.sendRedirect("/atti/view/main.jsp"); // 로그인하지 않은 사용자는 로그인 페이지로 이동
		return;
	}
	
	//디버깅
	//System.out.println(loginEmp);
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>empUpdateForm page</title>
</head>
<body>
	
</body>
</html>