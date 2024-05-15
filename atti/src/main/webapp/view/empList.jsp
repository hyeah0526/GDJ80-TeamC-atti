<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="atti.*" %>

<!-------------------- 
 * 기능 번호  : #10
 * 상세 설명  : 모든 직원 조회 페이지
 * 시작 날짜 : 2024-05-13
 * 담당자 : 김인수
 -------------------->

<!-- Controller layer  -->
<%
	//세션에서 로그인한 사용자 정보를 가져와 변수에 저장
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	
	//로그인한 사용자가 관리자인지 확인
	if(loginEmp == null || (loginEmp != null && loginEmp.get("empNo").toString().charAt(0) != '1')){
		response.sendRedirect("/atti/view/main.jsp"); // 메인 페이지로 이동
		return;
	}
	
	//디버깅
	//System.out.println(loginEmp);
%>

<!-- Model layer -->
<%
	//검색어
	String searchWord = "";

	//검색어 null 값 체크 
	if(request.getParameter("searchWord") != null ){
		searchWord = request.getParameter("searchWord");
	} 
	
	//사용자가 선택한 직책  
  	String empGrade = request.getParameter("empGrade");
	
	// 직책 null 값 체크
    if (empGrade == null || empGrade.isEmpty()) {
        empGrade = "%";
    }

	//현재 페이지 
	int currentPage = 1;
	
	//현재 페이지 값 형변환
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 페이지당 표시할 인원 수
	int rowPerPage = 10;

	// DB에서 시작 페이지 값 계산
	int startRow = (currentPage-1) * rowPerPage;

	// 전체 회원수 가져오기
	ArrayList<HashMap<String, Object>> list = EmpDao.empAll(searchWord, empGrade, startRow, rowPerPage);
	
	// 전체 인원 수 
	int totalRow = 0;
	
	if (!list.isEmpty() && list.get(0).containsKey("cnt")) {
        totalRow = Integer.parseInt((String) list.get(0).get("cnt"));
    }
	
	// 마지막 페이지 계산하기
	int lastPage = totalRow / rowPerPage;
	
	// 나머지가 있을 경우 마지막 페이지 추가
	if (totalRow % rowPerPage != 0) {
        lastPage += 1; 
    }
	
	//디버깅
	//System.out.println("list = " + list);
	//System.out.println("totalRow = " + totalRow);
		
%>

 
<!-- view layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>empList page</title>
	
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- CSS 공통적용CSS파일 -->
	<link rel="stylesheet" href="../css/css_all.css">
	<link rel="stylesheet" href="../css/css_kiminsu.css">
</head>
<body id="fontSet">
	
	<!-------------------- header -------------------->
	<jsp:include page="/inc/header.jsp"></jsp:include>

	<!-------------------- aside-------------------->
	<aside>
		<!-- 서브메뉴나오는 부분 -->
		<jsp:include page="/inc/empSubMenu.jsp"></jsp:include>
	</aside>
	
	<!-------------------- main -------------------->
	<main>
	
		<div id="searchDiv">
			
			<div id="searchForm">
			    <!-- 검색 폼 -->
			    <form action="/atti/view/empList.jsp" id="paginationForm" method="post">
			        <label id="paginationLabel">이름</label>
			        <input type="text" name="searchWord" id="paginationInput">
			        <button type="submit" id="paginationBtn">확인</button>
			    </form>
			</div>
		    
		    <div id="selectFromDiv">
		    	<!-- 직책 선택 폼 -->
		    	<form action="/atti/view/empList.jsp" id="paginationGradeForm" method="post">
		    		<select name="empGrade" onchange="this.form.submit()">
			    		<option value="">직책선택</option>
			    		<option value="의사">의사</option>
			    		<option value="간호사">간호사</option>
			    		<option value="퇴사자">퇴사자</option>
			    	</select>
		    	</form>
		    </div>
		
		</div>	
		<table>
			<tr>
				<th>사번</th>
				<th>직책</th>
				<th>이름</th>
				<th>상세보기</th>
			</tr>
			<% 
				//직원 정보 출력하기
				for(HashMap<String, Object> m : list){
			%>
				<tr>
					<td><%=(String)(m.get("empNo"))%></td>
					<td><%=(String)(m.get("empGrade"))%></td>
					<td><%=(String)(m.get("empName"))%></td>
					<td>
						<!-- 상세보기 페이지 이동-->
						<form action="/atti/view/empDetail.jsp" class="detailEmpForm" method="post">
							<input type="hidden" name="empNo" value="<%=(String)(m.get("empNo"))%>">
    						<button type="submit" class="detailEmpBtn">상세보기</button>
						</form>
					</td>
				</tr>
			<% 
				}
			%>
		</table>
		
		<div id="paginationDiv">
			<div>
			    <!-- 이전 페이지 링크 -->
			    <% if(currentPage > 1){ %>
			        <a href="/atti/view/empList.jsp?currentPage=<%=currentPage -1%>" class="paginationBtn">이전</a>
			    <% } else { %>
			        <span class="paginationBtn disabled">이전</span>
			    <% } %>
			
			    <!-- 현재 페이지 표시 -->
			    <span class="currentPage"><%=currentPage%></span>
			
			    <!-- 다음 페이지 링크 -->
			    <% if(currentPage < lastPage) { %>
			        <a href="/atti/view/empList.jsp?currentPage=<%=currentPage +1%>" class="paginationBtn">다음</a>
			    <% } else { %>
			        <span class="paginationBtn disabled">다음</span>
			    <% } %>
			</div>	
		</div>
		
	</main>
</body>
</html>