<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*" %>
<%@ page import="java.util.*" %>
<!-------------------- 
 * 기능 번호  : #25
 * 상세 설명  : 조회 및 검색 기능 // 고객, 펫
 * 시작 날짜 : 2024-05-13
 * 담당자 : 김지훈
 -------------------->

<%
	// 현재 페이지
	System.out.println("--------------------");
	System.out.println("serchList.jsp");
%>
<!-- Controller layer  -->
<%
	// 세션을 변수로 변환
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	
	/* // 로그인한 사용자가 관리자인지 확인
	// 관리자, 직원 여부에 따라 보여지는 뷰가 달라짐
	if(loginEmp == null || (loginEmp != null && loginEmp.get("empNo").toString().charAt(0) != '1')){
		response.sendRedirect("/atti/view/main.jsp"); // 로그인하지 않은 사용자는 로그인 페이지로 이동
		return;
	} */

	// 검색 시 선택한 값이 전체, 고객(보호자), 반려동물(펫)인지에 대한 값
	String selectCategory = request.getParameter("selectCategory");
	//System.out.println("selectCategory: " + selectCategory);
	
	// 검색 기능
	String searchWord = null;
	if(request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}
	
	
	// 출력 리스트 페이지네이션
	// 현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	// 페이지당 출력할 수
	int rowPerPage = 10;
	
	// 시작 페이지
	int startRow = (currentPage -1 ) * rowPerPage;

	// 전체 행의 수
	int totalRow = 0;
	
	// 마지막 페이지
	int lastPage = 0;
	
	// 전체 행 / 페이지당 출력할 row의 수가 0으로 나누어 떨어지지 않으면 +1
	if(totalRow % rowPerPage != 0) { // 0이 아닐 경우
		lastPage = lastPage +1; // lastPage에 1을 더한다.
	}
	
%>
<!-- model layer -->
<%
	ArrayList<HashMap<String, Object>> searchAll = CustomerDao.searchAll(searchWord, startRow, rowPerPage);
	ArrayList<HashMap<String, Object>> customerList = CustomerDao.customerSearch(searchWord, startRow, rowPerPage);
	ArrayList<HashMap<String, Object>> petList = PetDao.petSearch(searchWord, startRow, rowPerPage);
	
	// 메소드 디버깅
	//System.out.println("searchAll: " + searchAll);
	//System.out.println("customerList: " + customerList);
	//System.out.println("petList: " + petList);
%>
<!-- view layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>searchList page</title>
	
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
					<table>
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
					<table>
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
					<table>
						<tr>
							<th>펫 번호</th>
							<th>펫 이름</th>
							<th>고객 이름</th>
							<th>등록일</th>
						</tr>
					
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