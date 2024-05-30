<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.HospitalRoomDao"%>
<%@ page import="java.util.*"%>
<!-- 
	 * 기능 번호  : #39
	 * 상세 설명  : 입원환자 전체 조회기능
	 * 시작 날짜 : 2024-05-14
	 * 담당자 : 박혜아
 -->
 <%
	//로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}
 %>
 <%
 	/* 페이징 및 검색  */
 	// 검색
 	String searchName = request.getParameter("searchName");
 	if(searchName == null){
 		searchName = ""; // null값일 경우 ""공백넣어주기
 	}
 	
 	// 현재 페이지 변수 기본값
 	int currentPage = 1;
 	
 	// 페이지 설정값 가져오기
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
 	//System.out.println("hospitalList.jsp currentPage --> "+currentPage);
	
	// 한페이지에 보여줄 개수
	int rowPerPage = 8;
	int startRow = (currentPage-1)*rowPerPage;
	
	// 전체목록 뿌려주기 DAO
	ArrayList<HashMap<String, Object>> hospitalList = HospitalRoomDao.hospitalizationList(searchName, startRow, rowPerPage);
	
	// 총갯수 구하기
	int totalRow = HospitalRoomDao.hospitalizationListCnt(searchName);
	//System.out.println("hospitalList.jsp totalRow --> "+totalRow);

	// 마지막 페이지 계산하기
	int lastPage = totalRow / rowPerPage;
	//System.out.println("hospitalList.jsp lastPage --> "+lastPage);
		
	// 나머지가 있을 경우 마지막 페이지 추가
	if (totalRow % rowPerPage != 0) {
		lastPage += 1; 
	}
 	
	System.out.println("====================================");
 %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>입원 환자관리</title>
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- CSS 공통적용CSS파일 -->
	<link rel="stylesheet" href="../css/css_all.css">
	<link rel="stylesheet" href="../css/css_hyeah.css">
	<link rel="stylesheet" href="../css/css_kiminsu.css">
</head>

<body id="fontSet">
	
	<!-------------------- header -------------------->
	<jsp:include page="../inc/header.jsp"></jsp:include>

	<!-------------------- aside-------------------->
	<aside>
		<!-- 서브메뉴나오는 부분 -->
		<div id="subMenu">
			<div id="subMenuBtnContainer">
				<button type="button" onclick="location.href='./hospitalRoomList.jsp'">입원실</button><br><br>
				<button type="button" onclick="location.href='./hospitalizationList.jsp'">입원 환자</button><br><br>
			</div>
		</div>
	</aside>
	
	<!-------------------- main -------------------->
	<main id="hospitalListMain">
		<h2>입원환자 목록</h2>
			
		<!-- 이름으로 환자 검색 -->
		<div id="hospitalSearchForm">
			<form action="/atti/view/hospitalizationList.jsp?currentPage=1&searchName=<%=searchName%>">
				<label>동물이름</label>
				<input type="text" name="searchName" value="<%=searchName%>">
				<button type="submit" id="paginationBtn">검색</button>
			</form>
		</div><br>
			
		<!-- 입원했던 환자 전체목록 출력  -->
		<div id="hospitalListTable">
			<table>
				<tr>
					<th>접수번호</th>
					<th>동물이름</th>
					<th>동물종류</th>
					<th>보호자이름</th>
					<th>입원날짜</th>
					<th>퇴원날짜</th>
					<th>상세보기</th>
				</tr>					
				<%
					for(HashMap<String, Object> h : hospitalList){
				%>
						<tr>
							<td><%=(Integer)h.get("regiNo")%></td>
							<td><%=(String)h.get("petName")%></td>
							<td><%=(String)h.get("petKind")%></td>
							<td><%=(String)h.get("customerName")%></td>
							<td><%=(String)h.get("createDate")%></td>
							<td><%=(String)h.get("dischargeDate")%></td>
							<td>
								<!-- 상세보기로이동 -->
								<a id="hospitalListDetail" class="btn" href="/atti/view/hospitalizationDetail.jsp?regiNo=<%=(Integer)h.get("regiNo")%>">
									상세보기
								</a>
							</td>
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
			        <a href="/atti/view/hospitalizationList.jsp?currentPage=<%=currentPage -1%>&searchName=<%=searchName%>" class="paginationBtn">이전</a>
			    <% } else { %>
			        <span class="paginationBtn disabled">이전</span>
			    <% } %>
			
			    <!-- 현재 페이지 표시 -->
			    <span class="currentPage"><%=currentPage%></span>
			
			    <!-- 다음 페이지 링크 -->
			    <% if(currentPage < lastPage) { %>
			        <a href="/atti/view/hospitalizationList.jsp?currentPage=<%=currentPage +1%>&searchName=<%=searchName%>" class="paginationBtn">다음</a>
			    <% } else { %>
			        <span class="paginationBtn disabled">다음</span>
			    <% } %>
			     
			</div>	
		</div>
	</main>
</body>
</html>