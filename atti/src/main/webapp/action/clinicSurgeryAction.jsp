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
	// 로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}

	
	
	
	// clinicDetailFrom -> clinicSurgeryAction
	String surgeryInsert = request.getParameter("surgeryInsert");
	String surgeryUpdate = request.getParameter("surgeryUpdate");
	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
	int petNo = Integer.parseInt(request.getParameter("petNo"));
	String surgeryKind = request.getParameter("surgeryKind");
	String surgeryContent = request.getParameter("surgeryContent");
	String surgeryDate = request.getParameter("surgeryDate");
	

	// 디버깅
	//System.out.println("surgeryInsert: " + surgeryInsert);
	//System.out.println("surgeryUpdate: " + surgeryUpdate);
	//System.out.println("regiNo: " + regiNo);
	//System.out.println("petNo: " + petNo);
	//System.out.println("surgeryKind: " + surgeryKind);
	//System.out.println("surgeryContent: " + surgeryContent);
	//System.out.println("surgeryDate: " + surgeryDate);
	
	String surgeryError = null;
	if(surgeryKind == null || surgeryKind.trim().isEmpty() || surgeryDate == null || 
		surgeryDate.trim().isEmpty() || surgeryContent == null || surgeryContent.trim().isEmpty()) { 
			surgeryError = URLEncoder.encode("내용이 입력되지 않았습니다.", "UTF-8");
	// surgery 입력값이 null이거나 공백일 때
	}

	// String surgeryNo가 null이 아니라면 형 변환 
	String surgeryNoStr = request.getParameter("surgeryNo");
	int surgeryNo = 0;
	if(surgeryNoStr != null){
		surgeryNo = Integer.parseInt(surgeryNoStr); 
	}
%>
<!-- model layer -->
<%
	// 수술 입력 시
	
	// 들어온 값에 따라 insertRow / updateRow를 분기
	
	if(surgeryError != null) {
		response.sendRedirect("/atti/view/clinicDetailForm.jsp?regiNo=" + regiNo + "&" + "surgeryError=" + surgeryError);
	} else {
		int resultRow = 0;
		if(surgeryInsert != null && "surgeryInsert".equals(surgeryInsert)) {
			int insertRow = SurgeryDao.surgeryInsert(regiNo, surgeryKind, surgeryContent, surgeryDate);
			System.out.println("SurgeryDao#surgeryInsert: " + insertRow);
			resultRow = insertRow;

			if(resultRow == 1){
				System.out.println("수술 등록 성공");
				String paymentCategory = "수술";
				
				HashMap<String, Object> paymentSelect = PaymentDao.paymentSelect(regiNo, paymentCategory);
				
				if(paymentSelect == null || paymentSelect.size() < 1){
					PaymentDao.paymentInsert(regiNo, paymentCategory);
				} else {
					PaymentDao.paymentUpdate(regiNo, paymentCategory);
				}
			}
		} else if(surgeryUpdate != null && "surgeryUpdate".equals(surgeryUpdate)) {
			int updateRow = SurgeryDao.surgeryUpdate(regiNo, surgeryNo, surgeryContent);
			System.out.println("SurgeryDao#surgeryUpdate: " + updateRow);
			resultRow = updateRow;

			if(resultRow == 1) {
				System.out.println("수술 정보 수정 완료");
			}
		}
		response.sendRedirect("/atti/view/clinicDetailForm.jsp?regiNo=" + regiNo + "&" + "petNo=" + petNo);
	}
%>
