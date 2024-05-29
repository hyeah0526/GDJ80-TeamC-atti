<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="atti.*" %>
<%@page import="java.util.*" %>
<!-------------------- 
 * 기능 번호  : #33
 * 상세 설명  : 진료 내용 등록(검사)
 * 시작 날짜 : 2024-05-27
 * 담당자 : 한은혜
 -------------------->
 <% 
 	// 진료 번호
 	
 	
 	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
 	int petNo = Integer.parseInt(request.getParameter("petNo"));
 	String examinationByClinic = request.getParameter("examinationByClinic");
 
 	System.out.println(regiNo + " ====== clinicExaminationAction regiNo");
 	System.out.println(petNo + " ====== clinicExaminationAction petNo");
 	System.out.println(examinationByClinic + " ====== clinicExaminationAction examinationByClinic");
 	
 	if(examinationByClinic != null && examinationByClinic.equals("examinationInsert")){
 		
 		int examinationNo = Integer.parseInt(request.getParameter("examinationNo"));
 		String examinationKind = request.getParameter("examinationKind");
 		String examinationContent = request.getParameter("examinationContent");
 		String fileName = request.getParameter("fileName");
 		
 		System.out.println(examinationKind + " ====== clinicExaminationAction examinationKind");
 		System.out.println(examinationContent + " ====== clinicExaminationAction examinationContent");
 		System.out.println(fileName + " ====== clinicExaminationAction fileName");
 	
	 	// 검사 등록
	 	int insertRow = ExaminationDao.examinationInsert(regiNo, examinationKind, examinationContent, fileName);
	 	
	 	if(insertRow == 1){
	 		
	 		String paymentCategory = "검사";
	 	
			 // 중복된 결제 정보 조회 
			HashMap<String, Object> paymentSelect = PaymentDao.paymentSelect(regiNo, paymentCategory);
		
			//디버깅
			//System.out.println(paymentSelect);
			//System.out.println(paymentSelect.size());
			
			//중복된 결제 정보가 없는 경우
			if(paymentSelect == null || paymentSelect.size() < 1){
				
				//결제 정보 저장
				PaymentDao.paymentInsert(regiNo, paymentCategory);
				
			} else {
				
				//결제 정보 수정
				PaymentDao.paymentUpdate(regiNo, paymentCategory);
			}
			
			response.sendRedirect("/atti/view/clinicDetailForm.jsp?regiNo="+regiNo+"&petNo="+petNo); // 진료 페이지로 이동
	 	
	 	} 
	 	
 	} else if(examinationByClinic != null && examinationByClinic.equals("examinationUpdate")) {
	 		
 		int examinationNo = Integer.parseInt(request.getParameter("examinationNo"));
 		String examinationKind = request.getParameter("examinationKind");
 		String examinationContent = request.getParameter("examinationContent");
 		String fileName = request.getParameter("fileName");
 		
 		System.out.println(examinationNo + " ====== 이거왜안받아와 clinicExaminationAction examinationNo");
 		System.out.println(examinationKind + " ====== clinicExaminationAction examinationKind");
 		System.out.println(examinationContent + " ====== clinicExaminationAction examinationContent");
 		System.out.println(fileName + " ====== clinicExaminationAction fileName");
 	
 		int updateRow = ExaminationDao.examinationUpdate(regiNo, examinationKind, examinationContent, fileName, examinationNo);
 		System.out.println(updateRow + "  이거확인2222333");
 		if(updateRow != 0){
 			
 			response.sendRedirect("/atti/view/clinicDetailForm.jsp?regiNo="+regiNo);
 			
 		}
 		
	 }
	 	
 %>
 
 
 