<%@page import="java.util.HashMap"%>
<%@page import="atti.PaymentDao"%>
<%@page import="atti.PrescriptionDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-------------------- 
 * 기능 번호  : #33
 * 상세 설명  : 진료 내용 등록(처방)
 * 시작 날짜 : 2024-05-22
 * 담당자 : 박혜아
 -------------------->
<%
/*
//로그인한 사용자인지 검증
if(session.getAttribute("loginEmp") == null){
	response.sendRedirect("/atti/view/loginForm.jsp");
	return;
}
*/ 
 %>
<%

//사용자의 진료 번호 
int regiNo = Integer.parseInt(request.getParameter("regiNo"));

//신규등록(prescriptionInsert) OR 수정(prescriptionUpdate)
String selectPrescription = request.getParameter("selectPrescription");	


//디버깅
//System.out.println("clinicExaminationAction.jsp regiNo --> "+regiNo);
//System.out.println("clinicExaminationAction.jsp selectPrescription --> "+selectPrescription);


// 처방등록
if(selectPrescription.equals("prescriptionInsert")){
	//값 받아오기
	int medicineNo = Integer.parseInt(request.getParameter("medicineNo"));			//약번호
	String prescriptionContent = request.getParameter("prescriptionContent");		//약내용
	
	//디버깅
	//System.out.println("clinicExaminationAction.jsp 처방medicineNo --> "+medicineNo);
	//System.out.println("clinicExaminationAction.jsp prescriptionContent --> "+prescriptionContent);
	
	//등록
	int insertRow = PrescriptionDao.prescrptionInsert(regiNo, medicineNo, prescriptionContent);
	
	if(insertRow == 1){
		//처방 등록 성공시 -> payment테이블에 추가 후 다시 진료상세 페이지로 이동
		String paymentCategory = "처방";
		
		// 중복된 결제 정보 조회 
		HashMap<String, Object> paymentSelect = PaymentDao.paymentSelect(regiNo, paymentCategory);

		//디버깅
		//System.out.println(paymentSelect);
		//System.out.println(paymentSelect.size());
		
		//중복된 결제 정보가 없는 경우
		if(paymentSelect == null || paymentSelect.size() < 1){
			
			//결제 정보 저장
			PaymentDao.paymentInsert(regiNo, paymentCategory);
			
		}else{
			
			//결제 정보 수정
			PaymentDao.paymentUpdate(regiNo, paymentCategory);
		}
		
		response.sendRedirect("/atti/view/clinicDetailForm.jsp?regiNo="+regiNo); // 진료 페이지로 이동
	}
		
			
// 처방수정
}else if(selectPrescription.equals("prescriptionUpdate")){
	//값받아오기
	int prescriptionNo = Integer.parseInt(request.getParameter("prescriptionNo"));	//처방 고유번호
	int oldMedicineNo = Integer.parseInt(request.getParameter("oldMedicineNo"));	//전에 선택된 약번호
	int newMedicineNo = Integer.parseInt(request.getParameter("newMedicineNo"));	//새로 선택된 약번호
	String prescriptionContent = request.getParameter("prescriptionContent");		//처방내용
	
	//디버깅
	//System.out.println("clinicExaminationAction.jsp prescriptionNo --> "+prescriptionNo);
	//System.out.println("clinicExaminationAction.jsp oldMedicineNo --> "+oldMedicineNo);
	//System.out.println("clinicExaminationAction.jsp newMedicineNo --> "+newMedicineNo);
	//System.out.println("clinicExaminationAction.jsp prescriptionContent --> "+prescriptionContent);
	//System.out.println("clinicExaminationAction.jsp prescriptionContent --> "+prescriptionContent);
	
	//수정
	int updateRow = PrescriptionDao.prescrptionUpdate(regiNo, prescriptionNo, oldMedicineNo, newMedicineNo, prescriptionContent);
	
	if(updateRow == 1){
		response.sendRedirect("/atti/view/clinicDetailForm.jsp?regiNo="+regiNo); //진료 페이지로 이동
	}
	
}


%>