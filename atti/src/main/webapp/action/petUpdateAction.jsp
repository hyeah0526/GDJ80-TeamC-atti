<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<!-------------------- 
 * 기능 번호  : #24
 * 상세 설명  : 펫 정보 수정 페이지(액션)
 * 시작 날짜 : 2024-05-13
 * 담당자 : 김지훈
 -------------------->

<%
	System.out.println("--------------------");
	System.out.println("petUpdateAction.jsp");
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

	// petUpdateForm -> petUpdateAction
	int petNo = Integer.parseInt(request.getParameter("petNo"));
	String petName = request.getParameter("petName");
	
	// 디버깅
	//System.out.println("petNo: " + petNo);
	//System.out.println("petName: " + petName);
	String errorMsg = null;
	if(petName == null || petName.trim().isEmpty()) {
		errorMsg = URLEncoder.encode("이름이 입력되지 않았으니 확인해 주세요", "UTF-8");
	}	
%>
<!-- model layer -->
<%	
	if(errorMsg == null) {

		int updateRow = PetDao.petUpdate(petNo, petName);
		
		if(updateRow > 0) {
			System.out.println("펫 정보 수정이 완료되었습니다.");
			response.sendRedirect("/atti/view/petDetail.jsp?petNo=" + petNo);
		} else {
			System.out.println("펫 정보 수정이 실패하였습니다.");
			response.sendRedirect("/atti/view/petUpdateForm.jsp?petNo=" + petNo + "&" + "errorMsg=" + errorMsg);
		}
	} else {
		System.out.println("펫 정보 수정이 실패하였습니다.");
		response.sendRedirect("/atti/view/petUpdateForm.jsp?petNo=" + petNo + "&" + "errorMsg=" + errorMsg);
	}
%>