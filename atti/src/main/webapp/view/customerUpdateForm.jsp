<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<!-------------------- 
 * 기능 번호  : #18
 * 상세 설명  : 보호자 정보 수정 페이지
 * 시작 날짜 : 2024-05-13
 * 담당자 : 김지훈
 -------------------->
<%
	// 현재 페이지
	System.out.println("--------------------");
	System.out.println("customerUpdateForm.jsp");
%>
<!-- Controller layer  -->
<%
	// 로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}
	
	// customerDetail -> customerUpdateForm
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	// 디버깅
	//System.out.println("customerNo: " + customerNo);
	
	// customerUpdateAction -> customerUpdateForm
	String errorMsg = request.getParameter("errorMsg");
	
	//System.out.println("errorMsg: " + errorMsg);
	

%>
<!-- model layer -->
<%
	ArrayList<HashMap<String, Object>> customerDetail = CustomerDao.customerDetail(customerNo);
	
	// 메소드 디버깅
	//System.out.println("customerDetail: " + customerDetail);
%> 
<!-- view layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>customerUpdateForm page</title>
	
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- CSS 공통적용CSS파일 -->
	<link rel="stylesheet" href="../css/css_all.css">
	<!-- CSS 개인 파일 -->
	<link rel="stylesheet" href="../css/css_jihoon.css">
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
	<main class="customerFormMain">
		<div class="regiCustomerInput">
			<h2>보호자 정보 수정</h2>
			
			<form action="/atti/action/customerUpdateAction.jsp" method="post" class="customerForm">
				<!-- form으로 customerNo를 같이 전달  -->
				<input type="hidden" name="customerNo" value="<%=customerNo%>"> 
				<%
					for(HashMap<String, Object> c: customerDetail){
				%>
						<div>
							<label for="customerName">이름</label>
							<input type="text" name="customerName" id="customerName" value="<%=(String)(c.get("customerName"))%>" readonly="readonly">
						</div>
						<div>
							<label for="customerTel">연락처</label>
							<input type="text" name="customerTel" id="customerTel" value="<%=(String)(c.get("customerTel"))%>" placeholder="-를 제외하고 입력해 주세요">
						</div>
						<div>
							<label for="customerAddress">주소</label>
							<input type="text" name="customerAddress" id="customerAddress" value="<%=(String)(c.get("customerAddress"))%>">
						</div>
						<div id="customerRegiBtn">
							<button class="customerRegiBtn" type="reset">초기화</button>
							<button class="customerRegiBtn" type="button" onclick="location.href='/atti/view/searchList.jsp'">목록으로</button>
							<button class="customerRegiBtn" type="submit">수정하기</button>
						</div>
				<%
					}
				%>
			</form>
			<%
				if(errorMsg != null) {
			%>
					<div class="errorMsg"><%=errorMsg%></div>
			<%		
				}
			%>
		</div>
	</main>
</body>
</html>