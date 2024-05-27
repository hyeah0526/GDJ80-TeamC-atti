<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="atti.*" %>

<!-------------------- 
 * 기능 번호  : #2
 * 상세 설명  : 사용자가 입력한 사번과 비밀번호를 확인
 * 시작 날짜 : 2024-05-10
 * 담당자 : 김인수
 -------------------->

<!-- Controller layer  -->
<%
	//loginForm에서 보낸 사번, 비밀번호 받기
	int empNo = 0;
	String empPw = request.getParameter("empPw");
	String empNoStr = request.getParameter("empNo");
	
	//사번 입력 요류 시 표시될 메세지	
	String errorMessage = null;
	
	//사번 입력 검증
	if(empNoStr != null){
		
		//사번 입력 필드가 7자리 숫자인지 확인(정규표현식 적용)
		if(empNoStr.matches("\\d{7}")){	
			empNo = Integer.parseInt(empNoStr);	// 정상적인 사번 입력 시 숫자로 변환
		}else{
			errorMessage =  URLEncoder.encode("사번을 확인 해 주세요.", "UTF-8"); //오류 메세지 인코딩
		}
	}
	
	//사번 입력 검증
	if(empNoStr.trim().isEmpty()){
		errorMessage = URLEncoder.encode("사번을 입력해 주세요.", "UTF-8"); // 입력 필드가 비어있는 경우 오류 메세지
	}
	
	
	//디버깅
	//System.out.println("empNoStr = " + empNoStr);
	//System.out.println("empNo = " + empNo);
	//System.out.println("empPw = " + empPw);
	// System.out.println("errorMessage = " + errorMessage);
%>

<!-- Model layer -->
<%
	//사용자의 사번과 비밀번호를 확인하여 로그인 검증
	HashMap<String, Object> loginEmp = EmpDao.login(empNo,empPw);
	
	//검증된 값 디버깅
	//System.out.println("loginEmp = "+loginEmp);
	
	//로그인 성공 시
	if(loginEmp != null){
		session.setAttribute("loginEmp", loginEmp);
		response.sendRedirect("/atti/view/main.jsp"); // 로그인 성공 시 메인 페이지로 이동
	}else{
		//로그인 실패 시 오류 메세지 전달
		response.sendRedirect("/atti/view/loginForm.jsp?errorMessage="+errorMessage); // 로그인 실패시 로그인 페이지로 이동
	}
	
%>