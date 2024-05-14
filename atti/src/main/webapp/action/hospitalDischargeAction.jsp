<%@ page import="atti.HospitalRoomDao"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	 * 기능 번호  : #40
	 * 상세 설명  : 입원실 퇴원기능 (입원실 상태변경 'ON' -> 'OFF')
	 * 시작 날짜 : 2024-05-13
	 * 담당자 : 박혜아
 -->
<%
	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
	String roomName = request.getParameter("roomName");
	//System.out.println("hospitalContentAction.jsp 입원실번호--> "+roomName);
	//System.out.println("hospitalContentAction.jsp 접수번호--> "+regiNo);
	
	//
	int result = HospitalRoomDao.hospitalizationDischarge(roomName);
	
	// 상태변경 성공 - 입원실목록 / 실패 - 해당환자입원상베로 redirect
	if(result == 1){
		System.out.println("hospitalContentAction.jsp 퇴원 입원실 상태변경 완료");
		response.sendRedirect("/atti/view/hospitalRoomList.jsp");
	}else{
		System.out.println("hospitalContentAction.jsp 퇴원 입원실 상태변경 실패");
		String errMsg = URLEncoder.encode("입원실 퇴원처리 실패. 다시 시도해주세요.","UTF-8");
		response.sendRedirect("/atti/view/hospitalizationDetail.jsp?regiNo="+regiNo+errMsg);
	}
%>
