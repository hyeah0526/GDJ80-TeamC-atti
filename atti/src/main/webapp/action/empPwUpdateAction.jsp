<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="atti.*" %>

<!-------------------- 
 * 기능 번호  : #6, #7
 * 상세 설명  : 사용자의 비빌번호 수정 (기존 비빌번호 저장 및 기존 비밀번호 수정)
 * 시작 날짜 : 2024-05-12
 * 담당자 : 김인수
 -------------------->

<!-- Controller layer  -->
<%

	//로그인 상태 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp"); // 로그인하지 않은 사용자는 로그인 페이지로 이동
		return;
	}

	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	
	// 사용자의 사번
	int empNo =  Integer.parseInt((String)loginEmp.get("empNo"));

	//비밀번호 변경 요류 시 표시될 메세지	
	String errorMessage = null;
	
	//empPwUpdateForm에서 보낸 기존 비밀번호, 새로운 비밀번호 받기
	String currentPw = request.getParameter("currentPw");
	String newPw = request.getParameter("newPw");
	
	//디버깅
	//System.out.println("currentPw = " + currentPw);
	//System.out.println("newPw = " + newPw);
%>

<!-- Model layer -->
<%
	// 기존 비밀번호 검사 기능 추가 
	
	//사용자의 사원번호와 기존 비밀번호를 확인하고 새로운 비밀변호로 변경 
	int updateRow = EmpDao.empPwUpdate(currentPw, newPw, empNo);

	//디버깅
	//System.out.println(updateRow);
	
	if(updateRow > 0){
		
		//사용자의 비밀번호 변경 후 기존 비밀번호 저장
		int insertRow = EmpDao.empPwHistory(empNo, currentPw);
		response.sendRedirect("/atti/action/logoutAction.jsp"); // 비밀번호 성공 시 로그아웃 action으로 이동			

	}else{
		
		errorMessage = URLEncoder.encode("이전에 사용했던 비밀번호 입니다.", "UTF-8");
		
		//새로운 비밀번호가 이전에 사용했던 비밀번호일 경우 페이지 이동 후 오류 메시지 입력
		response.sendRedirect("/atti/view/empPwUpdateForm.jsp?errorMessage="+errorMessage); 
	}

%>