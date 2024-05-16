<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="atti.PaymentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	 * 기능 번호  : #41
	 * 상세 설명  : 결제 내역 전체 조회
	 * 시작 날짜 : 2024-05-15
	 * 담당자 : 박혜아
 -->
 <%
	/* 페이징 및 검색  */
	// 검색
	String selectState = request.getParameter("selectState");
	if(selectState == null){
		selectState = "전체";
	}
 	//System.out.println("paymentList.jsp selectState -->"+selectState);
	
	// 현재 페이지 변수 기본값
	int currentPage = 1;
	
	// 페이지 설정값 가져오기
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//System.out.println("hospitalList.jsp currentPage --> "+currentPage);
	
	// 한페이지에 보여줄 개수
	int rowPerPage = 10;
	int startRow = (currentPage-1)*rowPerPage;
	//System.out.println("paymentList.jsp startRow --> "+startRow);
	
	// 전체목록 뿌려주기 DAO
	ArrayList<HashMap<String, Object>> paymentList = PaymentDao.paymentList(selectState, startRow, rowPerPage);
	
	// 총갯수 구하기
	int totalRow = (Integer)paymentList.get(1).get("totalRow");
	//System.out.println("paymentList.jsp totalRow --> "+totalRow);
	
	// 마지막 페이지 계산하기
	int lastPage = totalRow / rowPerPage;
	
	// 나머지가 있을 경우 마지막 페이지 추가
	if (totalRow % rowPerPage != 0) {
		lastPage += 1; 
	}
	//System.out.println("paymentList.jsp lastPage --> "+lastPage);
	
	System.out.println("====================================");
 %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>결제 내역 전체 조회</title>
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- CSS 공통적용CSS파일 -->
	<link rel="stylesheet" href="../css/css_all.css">
</head>
<body id="fontSet">
	
	<!-------------------- header -------------------->
	<jsp:include page="../inc/header.jsp"></jsp:include>

	<!-------------------- aside-------------------->
	<aside>
		<!-- 서브메뉴나오는 부분 -->
		<div id="subMenu">
			<div id="subMenuBtnContainer">
				<button type="button" onclick="location.href='./paymentList.jsp'">결제내역</button><br><br>
				<button type="button" onclick="location.href='./income.jsp'">매출관리</button><br><br>
			</div>
		</div>
	</aside>
	
	<!-------------------- main -------------------->
	<main>
		<h2>결제내역</h2>
		<!-- 전체/미납/완납 선택 검색 -->
		<div>
			<form action="/atti/view/paymentList.jsp" method="get">
				<select name="selectState" onchange="this.form.submit()">
					<%
						if(selectState.equals("전체")){
					%>
							<option value="전체" selected>전체</option>
                			<option value="미납">미납</option>
                			<option value="완납">완납</option>
					<%
						}else if(selectState.equals("미납")){
					%>
							<option value="전체">전체</option>
							<option value="미납" selected>미납</option>
							<option value="완납">완납</option>
					<%		
						}else{
					%>
							<option value="전체">전체</option>
							<option value="미납">미납</option>
							<option value="완납" selected>완납</option>
					<%		
						}
					%>
				</select>
			</form>
		</div>
		
		<!-- 전체목록뿌려주기 -->
		<div>
			<table border="1">
				<tr>
					<th>접수번호</th>
					<th>동물이름</th>
					<th>결제상태</th>
					<th>날짜</th>
				</tr>
			<%
				for(HashMap<String, Object> h : paymentList){
			%>
					<tr>
						<td><%=(Integer)h.get("regiNo")%></td>
						<td><%=(String)h.get("petName")%></td>
						<td><%=(String)h.get("paymentState")%></td>
						<td><%=(String)h.get("createDate")%></td>
						<td><a href="/atti/view/paymentDetail.jsp?regiNo=<%=(Integer)h.get("regiNo")%>">상세보기</a></td>
					</tr>
			<%
				}
			%>
			</table>
		</div>
		
		<!-- 페이징  -->
		<div id="paginationDiv">
			<div>
			    <!-- 이전 페이지 링크 -->
			    <% if(currentPage > 1){ %>
			        <a href="/atti/view/paymentList.jsp?currentPage=<%=currentPage-1%>&selectState=<%=selectState%>" class="paginationBtn">이전</a>
			    <% } else { %>
			        <span class="paginationBtn disabled">이전</span>
			    <% } %>
			
			    <!-- 현재 페이지 표시 -->
			    <span class="currentPage"><%=currentPage%></span>
			
			    <!-- 다음 페이지 링크 -->
			    <% if(currentPage < lastPage) { %>
			        <a href="/atti/view/paymentList.jsp?currentPage=<%=currentPage+1%>&selectState=<%=selectState%>" class="paginationBtn">다음</a>
			    <% } else { %>
			        <span class="paginationBtn disabled">다음</span>
			    <% } %>
			    
			</div>	
		</div>
		
	</main>
</body>
</html>