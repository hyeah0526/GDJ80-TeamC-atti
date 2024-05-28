<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*" %>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*" %>
<!-------------------- 
 * 기능 번호  : #33
 * 상세 설명  : 진료 등록(액션)
 * 시작 날짜 : 2024-05-26
 * 담당자 : 김지훈
 -------------------->    
<%
	System.out.println("--------------------");
	System.out.println("clinicAction.jsp");
%>

<!-- Controller layer  -->
<%
	// 로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}
	
	
	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
	String clinicContent = request.getParameter("clinicContent");
	
	// 디버깅
	//System.out.println("regiNo: " + regiNo);
	//System.out.println("clinicContent: " + clinicContent);
%>	
<!-- model layer -->
<%
	// 진료 입력 시
	//System.out.println("SurgeryDao#clinicInsert: " + insertRow);
	
	// 수술 정보 수정 시
	int updateRow = ClinicDao.clinicUpdate(regiNo, clinicContent, clinicContent);
		System.out.println("ClinicDao#clinicUpdate: " + updateRow);
	//System.out.println("SurgeryDao#surgerUpdate: " + updateRow);
	
	if(updateRow == 1){
		System.out.println("진료 내용 등록 or 수정 성공");
		// 진료 등록 성공시 -> payment 테이블에 추가 후 다시 진료 상세 페이지로 이동
		String paymentCategory = "진료";
		
		// 중복된 결제 정보 조회 
		HashMap<String, Object> paymentSelect = PaymentDao.paymentSelect(regiNo, paymentCategory);
	
		//디버깅
		//System.out.println(paymentSelect);
		//System.out.println(paymentSelect.size());
	
		//중복된 결제 정보가 없는 경우
		if(paymentSelect.size() < 1){
			//결제 정보 저장
			PaymentDao.paymentInsert(regiNo, paymentCategory);
		} else {
			//결제 정보 수정
			PaymentDao.paymentUpdate(regiNo, paymentCategory);
		}
	}
	response.sendRedirect("/atti/view/clinicDetailForm.jsp?regiNo=" + regiNo); // 진료 페이지로 이동
%>
