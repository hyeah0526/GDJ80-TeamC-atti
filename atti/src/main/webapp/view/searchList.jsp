<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*" %>
<%@ page import="java.util.*" %>
<%
	/*
	 * 기능 번호  : 
	 * 상세 설명  : 고객, 펫 조회 및 검색 기능
	 * 시작 날짜 : 2024-05-11
	 * 담당자 : 김지훈
	*/
	System.out.println("--------------------");
	System.out.println("serchList.jsp");
	
	String selectCategory = request.getParameter("selectCategory");
	System.out.println("selectCategory: " + selectCategory);
	
%>
<%
	// 출력 리스트 페이지네이션
	// 페이지 단위별 출력
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	int rowPerPage = 10;
	int startRow = (currentPage -1 ) * rowPerPage;

	String searchWord = null;
	if(request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}
	
	// 마지막 페이지
	int totalRow = 0;
	int lastPage = 0;
%>

<%
	ArrayList<HashMap<String, Object>> searchAll = CustomerDao.searchAll(searchWord, startRow, rowPerPage);
	ArrayList<HashMap<String, Object>> customerList = CustomerDao.customerSearch(searchWord, startRow, rowPerPage);
	ArrayList<HashMap<String, Object>> petList = PetDao.petSearch(searchWord, startRow, rowPerPage);
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
		<div>
			<h2>고객 및 펫 조회</h2>
		</div>
		<div>
		<form method="post" action="/atti/view/searchList.jsp">
			<%
				if(selectCategory == null || "all".equals(selectCategory)){
			%>
					<input type="radio" name="selectCategory" value="all" checked="checked"> 전체
					<input type="radio" name="selectCategory" value="customer"> 고객
					<input type="radio" name="selectCategory" value="pet"> 반려동물
					<input type="text" name="searchWord">
					<button type="submit">조회하기</button>
					<table border="1">
						<tr>
							<th>고객 번호</th>
							<th>펫 이름</th>
							<th>고객 전화번호</th>
							<th>고객 이름</th>
							<th>등록일</th>
						</tr>
						<%
							for(HashMap<String, Object> s : searchAll){
						%>		
								<tr>
									<td>
										<a href="/atti/view/customerDetail.jsp?customerNo=<%=s.get("customerNo")%>">
											<%=s.get("customerNo")%></a>
									</td>
									<td>
										<a href="/atti/view/petDetail.jsp?petNo=<%=s.get("petNo")%>">
											<%=s.get("petName")%>
										</a>
									</td>
									<td><%=s.get("customerTel")%></td>
									<td>
										<a href="/atti/view/customerDetail.jsp?customerNo=<%=s.get("customerNo")%>">
											<%=s.get("customerName")%>
										</a>
									</td>
									<td><%=s.get("createDate")%></td>
								</tr>
						<%
							}
						%>		
					</table>
			<%
				} else if(selectCategory != null && "customer".equals(selectCategory)){
			%>
					<input type="radio" name="selectCategory" value="all"> 전체
					<input type="radio" name="selectCategory" value="customer" checked="checked"> 고객
					<input type="radio" name="selectCategory" value="pet"> 반려동물
					<input type="text" name="searchWord">
					<button type="submit">조회하기</button>
					<table border="1">
						<tr>
							<th>고객 번호</th>
							<th>고객 이름</th>
							<th>고객 전화번호</th>
							<th>등록된 펫(수)</th>
							<th>등록일</th>
						</tr>
						<%
							for(HashMap<String, Object> c : customerList){
						%>		
								<tr>
									<td>
										<a href="/atti/view/customerDetail.jsp?customerNo=<%=c.get("customerNo")%>">
											<%=c.get("customerNo")%>
										</a>
									</td>
									<td>
										<a href="/atti/view/customerDetail.jsp?customerNo=<%=c.get("customerNo")%>">
											<%=c.get("customerName")%>
										</a>
									</td>
									<td><%=c.get("customerTel")%></td>
									<td><%=c.get("petCnt")%></td>
									<td><%=c.get("createDate")%></td>
								</tr>
						<%
							}
						%>		
					</table>
					
					
			<%
				} else if(selectCategory != null && "pet".equals(selectCategory)){
			%>
					<input type="radio" name="selectCategory" value="all"> 전체
					<input type="radio" name="selectCategory" value="customer"> 고객
					<input type="radio" name="selectCategory" value="pet" checked="checked"> 반려동물
					<input type="text" name="searchWord">
					<button type="submit">조회하기</button>
					<table border="1">
					c
						<%
							for(HashMap<String, Object> p : petList){
						%>		
								<tr>
									<td>
										<a href="/atti/view/petDetail.jsp?petNo=<%=p.get("petNo")%>">
											<%=p.get("petNo")%>
										</a>
									</td>
									<td>
										<a href="/atti/view/petDetail.jsp?petNo=<%=p.get("petNo")%>">
											<%=p.get("petName")%>
										</a>	
									</td>
									<td>
										<a href="/atti/view/customerDetail.jsp?customerNo=<%=p.get("customerNo")%>">
											<%=p.get("customerName")%>
										</a>
									</td>
									<td><%=p.get("createDate")%></td>
								</tr>
						<%
							}
						%>		
					</table>
			<%
				}
			%>		
		</form>	
		</div>

	</main>
</body>
</html>