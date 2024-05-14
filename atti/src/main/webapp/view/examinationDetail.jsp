<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="atti.*"%>
<%

	/*
	 * 기능 번호  : #45
	 * 상세 설명  : 검사 상세 보기 
	 * 시작 날짜 : 2024-05-13
	 * 담당자 : 한은혜
	*/

	System.out.println("---------------- examinationDetail.jsp -----------------");
	// 로그인 세션 

%>
<%
	// 값 받아오기 -> 검사 번호
	int examinationNo = Integer.parseInt(request.getParameter("examinationNo"));
	//System.out.println(examinationDetail + " ====== examinationDetail");
	
	// 검사 번호에 대한 검사 상세 내용 
	ArrayList<HashMap<String, Object>> examinationDetail = ExaminationDao.examinationDetail(examinationNo);

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Main page</title>
	
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

	<!-------------------- aside -------------------->
	<aside>
		<!-- 서브메뉴나오는 부분 -->
		<div id="subMenu">
			<div id="subMenuBtnContainer">
				<button type="button" onclick="location.href='./examinationList.jsp'">검사 조회</button><br><br>
			</div>
		</div>
	</aside>
	
	<!-------------------- main -------------------->
	<main>
	<div>
		<h2>검사 상세 정보</h2>
	</div>
	
	<div>
		<table border="1">
		<!-- 검사 상세 정보 보여주기 -->
		<%
			for(HashMap<String, Object> d : examinationDetail) {
		%>
		
			<tr>
				<td><%= d.get("examinationNo")%></td>
				<td><%= d.get("petKind")%></td>
				<td><%= d.get("petName")%></td>
			</tr>
			<tr>
				<td><%= d.get("examinationKind")%></td>
				<td><%= d.get("examinationDate")%></td>
			</tr>
			<tr>
				<td><%= d.get("examinationContent")%></td>
			</tr>
			<tr>
				<td><%= d.get("photoName")%></td>
			</tr>
		
		<%
			}
		%>
		</table>
	</div>
	</main>
</body>
</html>