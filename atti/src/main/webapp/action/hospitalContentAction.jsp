<%@page import="org.apache.catalina.ha.backend.Sender"%>
<%@page import="atti.HospitalRoomDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	 * 기능 번호  : #40
	 * 상세 설명  : 입원실 입원환자 내용 추가등록
	 * 시작 날짜 : 2024-05-13
	 * 담당자 : 박혜아
 -->
<%
	// 값 받아오기
	String hospiContentDate = request.getParameter("hospiContentDate");
	hospiContentDate = hospiContentDate.replace("T", " "); // T로 찍히는 값을 공백으로 치환
	String hospiContent = request.getParameter("hospiContent");
	String hospiEmpName = request.getParameter("hospiEmpName");
	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
	int hospitalNo = Integer.parseInt(request.getParameter("hospitalNo"));
	
	// 디버깅
	//System.out.println("hospitalContentAction.jsp hospiContentDate--> "+hospiContentDate);
	//System.out.println("hospitalContentAction.jsp hospiContent--> "+hospiContent);
	//System.out.println("hospitalContentAction.jsp hospiEmpName--> "+hospiEmpName);
	//System.out.println("hospitalContentAction.jsp regiNo--> "+regiNo);
	//System.out.println("hospitalContentAction.jsp hospitalNo--> "+hospitalNo);
	
	// 입원내용등록 하나로 묶어주기
	// ex) [2024-05-13 07:34 박임시] 수술환자 경과 좋음 퇴원예정 
	String hospitalizationContent = "\n ["+hospiContentDate+" "+hospiEmpName+"] "+hospiContent;
	System.out.println("hospitalContentAction.jsp hospitalizationContent--> "+hospitalizationContent);
	
	// 등록하기
	int result = HospitalRoomDao.hospitalizationContent(hospitalNo, hospitalizationContent);
	
	// 등록 수정, 실패하면 hospitalizationDetail로 다시 redirect됨
	if(result == 1){
		System.out.println("hospitalContentAction.jsp 입원환자 기록일지 내용등록 성공");
		response.sendRedirect("/atti/view/hospitalizationDetail.jsp?regiNo="+regiNo);
	}else{
		System.out.println("hospitalContentAction.jsp 입원환자 기록일지 내용등록 실패");
		response.sendRedirect("/atti/view/hospitalizationDetail.jsp?regiNo="+regiNo);
	}
%>
