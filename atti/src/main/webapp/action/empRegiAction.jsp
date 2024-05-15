<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="atti.*" %>

<!-------------------- 
 * 기능 번호  : #9
 * 상세 설명  : 직원 등록 (사번, 전공, 직책, 이름, 생일, 성별, 전화번호, 입사일)
 * 시작 날짜 : 2024-05-15
 * 담당자 : 김인수
 -------------------->
 
 <!-- Controller layer  -->
<%
	//세션에서 로그인한 사용자 정보를 가져와 변수에 저장
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	
	// 로그인한 사용자가 관리자인지 확인
	if(loginEmp == null || (loginEmp != null && loginEmp.get("empNo").toString().charAt(0) != '1')){
		response.sendRedirect("/atti/view/main.jsp"); // 메인 페이지로 이동
		return;
	}
	
	// 디버깅
	//System.out.println(loginEmp);
	
	
	// 직원 등록 정보(전공, 직책, 이름, 생일, 성별, 전화번호, 입사일)
	String empMajor = request.getParameter("empMajor");
	String empGrade = request.getParameter("empGrade");
	String empName = request.getParameter("empName");
	String empBirth = request.getParameter("empBirth"); 
	String empGender = request.getParameter("empGender"); 
	String empTel = request.getParameter("empTel");  
	String empHireDate = request.getParameter("empHireDate"); 
	
	// 디버깅
	//System.out.println("empMajor = " + empMajor);
	//System.out.println("empGrade = " + empGrade);
	//System.out.println("empName = " + empName);
	//System.out.println("empBirth = " + empBirth);
	//System.out.println("empGender = " + empGender);
	//System.out.println("empTel = " + empTel);
	//System.out.println("empHireDate = " + empHireDate);
	
	// 입력 요류 시 표시될 메세지	
	String errorMessage = null;
	
	// 신규 직원 개인정보 입력 값 유효성 검증(이름, 생일, 전화번호, 입사일)
	if (empBirth == null || empBirth.trim().isEmpty() ||           
		empName == null || empName.trim().isEmpty() || !empName.matches("^[ㄱ-ㅎ가-힣a-zA-Z\\s]+$") ||
		empTel == null || empTel.trim().isEmpty() || !empTel.matches("^010\\d{8}$") ||
   		empHireDate == null || empHireDate.trim().isEmpty() || empHireDate.length() != 10) {
   		
		errorMessage =  URLEncoder.encode("데이터를 입력해 주세요.", "UTF-8"); // 오류 메세지 인코딩
		response.sendRedirect("/atti/view/empRegiForm.jsp?errorMessage="+errorMessage); // 오류 발생 시 직원 등록 페이지로 이동
		return;
	}
	
%>

<!-- Model layer -->
<%
	// 신규 직원 사원번호
	int empNo = 0;

	// 사원번호 생성 변수(입사일에서 연도(앞 두자리)를 제외한 숫자)
	String empHireDateFormat  =  empHireDate.replace("-", "");

	// 디버깅
	//System.out.println("empHireDateFormat = " + empHireDateFormat);
	
	// 의사일 경우 사원 번호 설정
	if(empGrade.equals("의사")){
		empNo = Integer.parseInt("2" + empHireDateFormat.substring(2)); // 여기서 '2'는 의사를 의미하는 고유 번호
	}
	
	// 간호사일 경우 사원 번호 설정
	if(empGrade.equals("간호사") ){
		empNo = Integer.parseInt("3" + empHireDateFormat.substring(2)); // 여기서 '3'는 간호사를 의미하는 고유 번호
	}

	// 디버깅
	//System.out.println("empNo = " + empNo);
	
	// 신규 직원의 정보를 저장
	int insertRow = EmpDao.empRegistration(empNo, empMajor, empGrade, empName, empBirth, empGender, empTel, empHireDate);
	
	if(insertRow > 0){
		response.sendRedirect("/atti/view/empList.jsp"); // 직원 등록 성공 시 직원 조회 페이지로 이동
	}else{
		response.sendRedirect("/atti/view/empRegiForm.jsp"); // 직원 등록 실패 시 직원 등록 페이지로 이동
	}
%>
