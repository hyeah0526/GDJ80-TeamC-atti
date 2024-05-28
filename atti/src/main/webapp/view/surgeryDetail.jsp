<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="atti.*"%>
<%

	/*
	 * 기능 번호  : #46
	 * 상세 설명  : 수술 상세 보기 
	 * 시작 날짜 : 2024-05-14
	 * 담당자 : 한은혜
	*/

	System.out.println("---------------- surgeryDetail.jsp -----------------");
	// 로그인 세션 

%>
<%
	// 값 받아오기 -> 수술 번호 
	int surgeryNo = Integer.parseInt(request.getParameter("surgeryNo"));
	//System.out.println(surgeryNo + " ====== surgeryDetail surgeryNo");
	
	// 수술 상세보기 DAO 호출
	ArrayList<HashMap<String, Object>> surgeryDetail = SurgeryDao.surgeryDetail(surgeryNo);

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>수술 상세</title>
	
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- CSS 공통적용CSS파일 -->
	<link rel="stylesheet" href="../css/css_all.css">
	<link rel="stylesheet" href="../css/css_eunhye.css">
</head>
<body id="fontSet">
	
	<!-------------------- header -------------------->
	<jsp:include page="/inc/header.jsp"></jsp:include>

	<!-------------------- aside-------------------->
	<aside>
		<!-- 서브메뉴나오는 부분 -->
		<div id="subMenu">
			<div id="subMenuBtnContainer">
				<button type="button" onclick="location.href='./surgeryList.jsp'">수술 조회</button><br><br>
			</div>
		</div>
	</aside>
	
	<!-------------------- main -------------------->
	<main id="surgeryListMain">
		<div id="centerDiv">
			<h2>수술 상세 정보</h2>
		</div>
		<!-- 수술 상세보기 보여주기 -->
		<table id="surgeryDetailTable">
			<%
				for(HashMap<String, Object> sd : surgeryDetail) {
			%>
			<tr>
				<th>수술번호</th>
				<td><%=(Integer)(sd.get("surgeryNo"))%></td>
				<th>수술종류</th>
				<td><%=(String)(sd.get("surgeryKind"))%></td>
			</tr>
			<tr>
				<th>접수번호</th>
				<td><%=(Integer)(sd.get("regiNo"))%> </td>
				<th>담당의사</th>
				<td><%=(String)(sd.get("empName"))%> (<%=(Integer)(sd.get("empNo"))%>)</td>
			</tr>
			<tr>
				<th>동물정보</th>
				<td>NO.<%=(Integer)(sd.get("petNo"))%> <%=(String)(sd.get("petName"))%> (<%=(String)(sd.get("petKind"))%>)</td>
				<th>수술날짜</th>
				<td><%=(String)(sd.get("surgeryDate"))%></td>
			</tr>
			<tr>
				<th>수술내용</th>
				<td><%=(String)(sd.get("surgeryContent"))%></td>
			</tr>
			<%
				}
			%>
		</table>
	</main>
</body>
</html>