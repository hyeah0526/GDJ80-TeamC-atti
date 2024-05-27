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
	// 로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}

	// petUpdateForm -> petUpdateAction
	int petNo = Integer.parseInt(request.getParameter("petNo"));
	String petName = request.getParameter("petName");
	
	// 디버깅
	//System.out.println("petNo: " + petNo);
	//System.out.println("petName: " + petName);
	
	// 펫 정보 수정 실패 시 보여질 에러 메시지
	String errorMsg = null;
	if(petName == null || petName.trim().isEmpty()) { // 펫의 이름이 null이거나 공백일 시
		errorMsg = URLEncoder.encode("이름이 입력되지 않았으니 확인해 주세요", "UTF-8");
	}	
	System.out.println("errorMsg: " + errorMsg);
%>
<!-- model layer -->
<%	
	// errorMsg가 null일 경우 메소드 실행
	if(errorMsg == null) {

		int updateRow = PetDao.petUpdate(petNo, petName);
		
		if(updateRow > 0) { // updateRow가 1 이상일 경우 펫 정보 수정 완료
			System.out.println("펫 정보 수정이 완료되었습니다.");
			response.sendRedirect("/atti/view/petDetail.jsp?petNo=" + petNo);
			// 펫 정보 수정 완료 시 petDetail로 redirect
		} else { // updateRow가 1 미만일 경우 펫 정보 수정 실패
			System.out.println("펫 정보 수정에 실패하였습니다.");
			response.sendRedirect("/atti/view/petUpdateForm.jsp?petNo=" + petNo + "&" + "errorMsg=" + errorMsg);
			// 펫 정보 수정 실패 시 에러 메시지와 함께 petUpdateForm으로 redirect
		}
	} else {
		System.out.println("펫 정보 수정이 실패하였습니다.");
		response.sendRedirect("/atti/view/petUpdateForm.jsp?petNo=" + petNo + "&" + "errorMsg=" + errorMsg);
		// 펫 정보 수정 실패 시 에러 메시지와 함께 petUpdateForm으로 redirect
	}
%>