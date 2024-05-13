<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*" %>
<%@ page import="java.util.*" %>
<%
	/*
	 * 기능 번호  : #17
	 * 상세 설명  : 고객 상세 보기
	 * 시작 날짜 : 2024-05-10
	 * 담당자 : 김지훈
	*/
	
	System.out.println("--------------------");
	System.out.println("customerDetail.jsp");
	
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
%>

<% 
	ArrayList<HashMap<String, Object>> customerDetail = CustomerDao.customerDetail(customerNo);
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
	
</head>
<body id="fontSet">
	
	<!-------------------- header -------------------->
	<jsp:include page="/inc/header.jsp"></jsp:include>

	<!-------------------- aside-------------------->
	<aside>
		<!-- 서브메뉴나오는 부분 -->
		<jsp:include page="/inc/subMenu.jsp"></jsp:include>
	</aside>
	
	<!-------------------- main -------------------->
	<main>
		<div >
			<h2>고객 상세 정보</h2>
			<table border="1">
				<%
					for(HashMap<String, Object> c : customerDetail){
						
				%>
						<tr>
							<th>고객 번호</th>
							<td><%=c.get("customerNo")%></td>
						</tr>
						<tr>
							<th>고객 이름</th>
							<td><%=c.get("customerName")%></td>
						</tr>
						<tr>
							<th>고객 전화번호</th>
							<td><%=c.get("customerTel")%></td>
						</tr>
						<tr>	
							<th>고객 주소</th>
							<td><%=c.get("customerAddress")%></td>
						</tr>	
				<% 
					}
				%>
			</table>
		</div>
	</main>
</body>
</html>