<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="atti.*" %>
<%@page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>

<!-------------------- 
 * 기능 번호  : #33
 * 상세 설명  : 진료 내용 등록(검사)
 * 시작 날짜 : 2024-05-27
 * 담당자 : 한은혜
 -------------------->
 <% 
 	// 검사 사진 파일 확장자 구분
 	Part part = request.getPart("fileName"); 
	String originalName = part.getSubmittedFileName(); 
	int dotIdx = originalName.lastIndexOf("."); 
	String ext = originalName.substring(dotIdx); 
	//System.out.println(ext + " ====== clinicExaminationAction ext "); 
	// 파일명을 UUID로 바꾸기
	UUID uuid = UUID.randomUUID();
	String fileName = uuid.toString().replace("-", ""); 
	fileName = fileName + ext;
	//System.out.println(fileName+" ====== clinicExaminationAction fileName "); 

 	// 진료 정보 받아오기
 	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
 	int petNo = Integer.parseInt(request.getParameter("petNo"));
 	String examinationKind = request.getParameter("examinationKind");
 	String examinationByClinic = request.getParameter("examinationByClinic");
 	//System.out.println(regiNo + " ====== clinicExaminationAction regiNo");
 	//System.out.println(petNo + " ====== clinicExaminationAction petNo");
 	//System.out.println(examinationByClinic + " ====== clinicExaminationAction examinationByClinic");
 	
 	 // 입력값 검증 : examinationKind가 null이거나 비어있는지 확인
    if (examinationKind == null || examinationKind.isEmpty()) {
        out.println("Invalid examination kind.");
        return;
    }
 	
 	
 	if(examinationByClinic.equals("examinationInsert")){
 		
 		//int examinationNo = Integer.parseInt(request.getParameter("examinationNo"));
 		examinationKind = request.getParameter("examinationKind");
 		String examinationContent = request.getParameter("examinationContent");
 		
 		//System.out.println(examinationKind + " ====== clinicExaminationAction examinationKind");
 		//System.out.println(examinationContent + " ====== clinicExaminationAction examinationContent");
 	
	 	// 검사 등록시
	 	int insertRow = ExaminationDao.examinationInsert(regiNo, examinationKind, examinationContent, fileName);
	 	
	 	if(insertRow == 1){ // 등록 성공
	 		
	 		// 새로운 파일 만들기 + 파일 경로 
	 		InputStream is = part.getInputStream();
			String filePath = request.getServletContext().getRealPath("upload");
			File f = new File(filePath, fileName); 
			OutputStream os = Files.newOutputStream(f.toPath()); 
			is.transferTo(os);
			 // 디버깅: filePath 확인
            System.out.println(filePath + "  ====== clinicExaminationAction filePath");
			
         	// 업로드 디렉토리가 없으면 새로 생성
            File uploadDir = new File(filePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); 
            }
            
			os.close();
			is.close();
	 		
	 		// 결제 카테고리 설정
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
	 	
 	} else if(examinationByClinic.equals("examinationUpdate")) {
	 	// 검사 수정시
 		int examinationNo = Integer.parseInt(request.getParameter("examinationNo"));
 		examinationKind = request.getParameter("examinationKind");
 		String examinationContent = request.getParameter("examinationContent");
 		// 새로운 파일 만들기 + 파일 경로 
 		InputStream is = part.getInputStream();
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath, fileName); 
		OutputStream os = Files.newOutputStream(f.toPath()); 
		is.transferTo(os);
		 // 디버깅: filePath 확인
        System.out.println(filePath + "  ====== clinicExaminationAction filePath");
		
     	// 업로드 디렉토리가 없으면 새로 생성
        File uploadDir = new File(filePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); 
        }
        
		os.close();
		is.close();
 		
 		//System.out.println(examinationNo + " ======  clinicExaminationAction examinationNo");
 		//System.out.println(examinationKind + " ====== clinicExaminationAction examinationKind");
 		//System.out.println(examinationContent + " ====== clinicExaminationAction examinationContent");
 		//System.out.println(fileName + " ====== clinicExaminationAction fileName");
 	
 		int updateRow = ExaminationDao.examinationUpdate(regiNo, examinationKind, examinationContent, fileName, examinationNo);
 		//System.out.println(updateRow + " ====== clinicExaminationAction ");
 		
 		if(updateRow == 1){ // 수정 성공
 			
 			response.sendRedirect("/atti/view/clinicDetailForm.jsp?regiNo="+regiNo+"&petNo="+petNo);
 			
 		}
 		
	 }
 %>
 
 
 