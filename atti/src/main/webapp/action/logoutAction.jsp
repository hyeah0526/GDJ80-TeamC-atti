<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-------------------- 
 * 기능 번호  : #3
 * 상세 설명  : 사용자의 세션을 초기화(로그아웃)
 * 시작 날짜 : 2024-05-11
 * 담당자 : 김인수
 -------------------->

<!-- Model layer -->
<%
	session.invalidate(); // 기존 세션공간을 초기화(포멧)
	//System.out.println(session.getId() + "<---- session.invalidate() 호출 후 확인하기 ");
	response.sendRedirect("/atti/view/loginForm.jsp");
%>