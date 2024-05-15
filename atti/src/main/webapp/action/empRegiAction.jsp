<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="atti.*" %>

<!-------------------- 
 * 기능 번호  : #9
 * 상세 설명  : 직원 등록 (사번, 전공, 직책, 이름, 생일, 성별, 전화번호, 입사일, 비밀번호)
 * 시작 날짜 : 2024-05-15
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
	
	//직원 등록 정보(전공, 직책, 이름, 생일, 성별, 전화번호, 입사일)
	String empMajor = request.getParameter("empMajor");
	String empGrade = request.getParameter("empGrade");
	String empName = request.getParameter("empName"); //빈값 체크, 숫자말고 문자만 입력받기
	String empBirth = request.getParameter("empBirth"); // 빈값 체크
	String empGender = request.getParameter("empGender"); // 빈값 체크
	String empTel = request.getParameter("empTel"); // 빈값 체크, 문자말고 숫자만 입력받기 (010-0000-0000) 총 11글자 (앞 010은 고정) 
	String empHireDate = request.getParameter("empHireDate");
	
	//디버깅
	System.out.println(empMajor);
	System.out.println(empGrade);
	System.out.println(empName);
	System.out.println(empBirth);
	System.out.println(empGender);
	System.out.println(empTel);
	System.out.println(empHireDate);
	

	
%>


<!-- Model layer -->
<%

%>
