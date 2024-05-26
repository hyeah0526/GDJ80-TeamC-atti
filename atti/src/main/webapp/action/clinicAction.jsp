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
	/* // 로그인한 사용자가 관리자인지 확인
	// 세션을 변수로 변환
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	// 관리자, 직원 여부에 따라 보여지는 뷰가 달라짐
	if(loginEmp == null || (loginEmp != null && loginEmp.get("empNo").toString().charAt(0) != '1')){
		response.sendRedirect("/atti/view/main.jsp"); // 로그인하지 않은 사용자는 로그인 페이지로 이동
		return;
	} */
	
	String clinicInsert = request.getParameter("clinicInsert");
	String clinicUpdate = request.getParameter("clinicUpdate");
	
	// 디버깅
	//System.out.println("clinicInsert: " + clinicInsert);
	//System.out.println("clinicInsert: " + clinicUpdate);
	
	// 넘어온 파라미터값을 받기
	// String clinicNo가 null이 아니라면 int로 형 변환
	String clinicNoStr = request.getParameter("clinicNo");
	
	int clinicNo = 0;
	if(clinicNoStr != null) {
		clinicNo = Integer.parseInt(request.getParameter("clinicNo"));
	} 
	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
	String clinicContent = request.getParameter("clinicContent");
	
	// 디버깅
	//System.out.println("clinicNo: " + clinicNo);
	//System.out.println("regiNo: " + regiNo);
	//System.out.println("clinicContent: " + clinicContent);
%>	
<!-- model layer -->
<%
	// 진료 입력 시
	int insertRow = 0;
	if(clinicInsert != null && "clinicInsert".equals(clinicInsert)) {
		insertRow = ClinicDao.clinicInsert(regiNo, clinicContent);
		System.out.println("ClinicDao#clinicInsert: " + insertRow);
	}
	//System.out.println("SurgeryDao#clinicInsert: " + insertRow);
	
	// 수술 정보 수정 시
	int updateRow = 0;
	if (clinicUpdate != null && "clinicUpdate".equals(clinicUpdate)) {
		updateRow = ClinicDao.clinicUpdate(regiNo, clinicNo, clinicContent);
		System.out.println("ClinicDao#clinicUpdate: " + updateRow);
	}
	//System.out.println("SurgeryDao#surgerUpdate: " + updateRow);
	
	// 들어온 값에 따라 insertRow / updateRow를 분기
	int resultRow = 0;
	
	if(clinicInsert != null && "clinicInsert".equals(clinicInsert)) {
		resultRow = insertRow;
		System.out.println("ClinicDao#clinicInsert: " + resultRow);
		if(resultRow == 1){
			System.out.println("진료 등록 성공");
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
	} else if(clinicUpdate != null && "clinicUpdate".equals(clinicUpdate)) {
		resultRow = updateRow;
		System.out.println("ClinicDao#clinicUpdate: " + resultRow);
		//clinicUpdate값이 들어온다면 정보 수정
		if(resultRow == 1) {
			System.out.println("진료 정보 수정 완료");			
		}
	}
	response.sendRedirect("/atti/view/clinicDetailTest.jsp?regiNo=" + regiNo); // 진료 페이지로 이동
%>
