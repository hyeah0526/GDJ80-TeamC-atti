<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*" %>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*" %>
<!-------------------- 
 * 기능 번호  : #33
 * 상세 설명  : 수술 등록(액션)
 * 시작 날짜 : 2024-05-22
 * 담당자 : 김지훈
 -------------------->    
<%
	System.out.println("--------------------");
	System.out.println("clinicSurgeryAction.jsp");
%>

<!-- Controller layer  -->
<%
	/* // 로그인한 사용자가 관리자인지 확인
	// 세션을 변수로 변환
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	// 관리자, 직원 여부에 따라 보여지는 뷰가 달라짐
	if(loginEmp == null || (loginEmp != null && loginEmp.get("empNo").toString().charAt(0) != '1')){
		response.sendRedirect("/atti/view/main.jsp"); // 로그인하지 않은 사용자는 로그인 페이지로 이동
		return;
	} */

	// clinicDetailFrom -> clinicSurgeryAction
	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
	String surgeryKind = request.getParameter("surgeryKind");
	String surgeryContent = request.getParameter("surgeryContent");
	String surgeryDate = request.getParameter("surgeryDate");

	// 디버깅
	System.out.println("regiNo: " + regiNo);
	System.out.println("surgeryKind: " + surgeryKind);
	System.out.println("surgeryContent: " + surgeryContent);
	System.out.println("surgeryDate: " + surgeryDate);
%>
<!-- model layer -->
<%
	int insertRow = SurgeryDao.surgeryInsert(regiNo, surgeryKind, surgeryContent, surgeryDate);
	System.out.println("SurgeryDao#surgeryInsert: " + insertRow);
	
	if(insertRow == 1){
	// 수술 등록 성공시 -> payment 테이블에 추가 후 다시 진료 상세 페이지로 이동
	String paymentCategory = "수술";
	
	// 중복된 결제 정보 조회 
	HashMap<String, Object> paymentSelect = PaymentDao.paymentSelect(regiNo, paymentCategory);

	//디버깅
	//System.out.println(paymentSelect);
	//System.out.println(paymentSelect.size());
	
	//중복된 결제 정보가 없는 경우
	if(paymentSelect.size() < 1){
		
		//결제 정보 저장
		PaymentDao.paymentInsert(regiNo, paymentCategory);
		
	}else{
		
		//결제 정보 수정
		PaymentDao.paymentUpdate(regiNo, paymentCategory);
	}
	
	response.sendRedirect("/atti/view/clinicDetailTest.jsp?regiNo="+regiNo); // 진료 페이지로 이동
	} 
%>
