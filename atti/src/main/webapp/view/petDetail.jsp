<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="atti.*" %>   
<%@ page import="java.util.*" %>
<%
	System.out.println("--------------------");
	System.out.println("petDetail.jsp");
	
	// petNo 
	int petNo = Integer.parseInt(request.getParameter("petNo"));
	System.out.println("petNo: " + petNo);
%> 

<%
	ArrayList<HashMap<String, Object>> petDetail = PetDao.petDetail(petNo);

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
	<link rel="stylesheet" href="../css/css_kiminsu.css">
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
			<h2>펫 상세 정보</h2>
			<table border="1">
				<%
					for(HashMap<String, Object> p : petDetail){
						
				%>
						<tr>
							<th>펫 번호</th>
							<td><%=p.get("petNo")%></td>
						</tr>
						<tr>
							<th>종류</th>
							<td><%=p.get("major")%></td>
						</tr>
						<tr>
							<th>분류</th>
							<td><%=p.get("petKind")%></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><%=p.get("petName")%></td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td><%=p.get("petBirth")%></td>
						</tr>
						<tr>
							<th>보호자 이름</th>
							<td><%=p.get("customerName")%></td>
						</tr>
						<tr>
							<th>보호자 연락처</th>
							<td><%=p.get("customerTel")%></td>
						</tr>
				<% 
					}
				%>
			</table>
			<button type="button" onclick="location.href='/atti/view/petUpdateForm.jsp?petNo=<%=petNo%>'">정보 수정하기</button>
			<button type="button" onclick="location.href='/atti/view/searchList.jsp'">목록으로</button>
		</div>
	</main>
</body>
</html>