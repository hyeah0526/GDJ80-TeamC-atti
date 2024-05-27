<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="atti.*" %>
<%@ page import="java.util.*" %>

<!-------------------- 
 * 기능 번호  : #17
 * 상세 설명  : 보호자 상세 보기
 * 시작 날짜 : 2024-05-10
 * 담당자 : 김지훈
 -------------------->
<%
	// 현재 페이지
	System.out.println("--------------------");
	System.out.println("customerDetail.jsp");
%>
<!-- Controller layer  -->
<%	
	// 로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}

	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	//System.out.println("customerNo: " + customerNo);
%>
<!-- model layer -->
<% 
	ArrayList<HashMap<String, Object>> customerDetail = CustomerDao.customerDetail(customerNo);
	ArrayList<HashMap<String, Object>> petList = PetDao.petByCustomer(customerNo);
	
	// 메소드 디버깅
	//System.out.println("customerDetail: " + customerDetail);
	//System.out.println("petList: " + petList);
%>
    
<!-- view layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>customerDetail page</title>
	
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
		<div >
			<h2>고객 상세 정보</h2>
			<div id="customerDetailDiv">
				<%
					for(HashMap<String, Object> c : customerDetail){
						String originalTel = (String)(c.get("customerTel")); 
						
				%>
					<!-- 선택된 직원 정보 보여주기 폼 -->
						<form action="" method="post" class="customerForm">
							<div>
								<label>고객 번호</label>
								<input type="text" readonly="readonly" value=<%=(Integer)(c.get("customerNo"))%>>
							</div>
							<div>
								<label>이름</label>
								<input type="text" readonly="readonly" value=<%=(String)(c.get("customerName"))%>>
							</div>
							<div>
								<label>연락처</label>
								<input type="text" readonly="readonly"  value=<%=originalTel.replaceAll("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3")%>>
							</div>
							<div>
								<label>주소</label>
								<input type="text" readonly="readonly"  value=<%=(String)(c.get("customerAddress"))%>>
							</div>
							<div id="detailCustomerBtn">
								<button class="detailCustomerBtn" type="button" onclick="location.href='/atti/view/searchList.jsp'">목록으로</button>
								<button class="detailCustomerBtn" type="button" onclick="location.href='/atti/view/customerUpdateForm.jsp?customerNo=<%=customerNo%>'">수정하기</button>
								<button class="detailCustomerBtn" type="button" onclick="location.href='/atti/view/petRegiForm.jsp?customerNo=<%=customerNo%>'">펫 등록</button>
							</div>
						</form>
				<%
					}
				%>
			</div><br>
			<h2>펫 리스트</h2>
			<table class="petListTable">
				<tr>
					<th>펫 번호</th>
					<th>펫 이름</th>
					<th>최근 진료일</th>
					<th>접수</th>
				</tr>
				<%
					for(HashMap<String, Object> p : petList){
				%>
						<tr>
							<td><%=p.get("petNo")%></td> 
							<td>
								<a href="/atti/view/petDetail.jsp?petNo=<%=p.get("petNo")%>"><%=p.get("petName") %></a>
							</td>
							<td><%=p.get("regiDate")%></td>
							<td>
								<button class="petListBtn" type="button" onclick="location.href='/atti/view/regiForm.jsp?petNo=<%=p.get("petNo")%>'">접수하기</button>
							</td>
						</tr>			
				<%		
					}
				%>
			</table>
		</div>
	</main>
</body>
</html>