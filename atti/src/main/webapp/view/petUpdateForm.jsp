<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="atti.*" %>
<!-------------------- 
 * 기능 번호  : #23
 * 상세 설명  : 펫 정보 수정 페이지(폼)
 * 시작 날짜 : 2024-05-13
 * 담당자 : 김지훈
 -------------------->
 <%
	System.out.println("--------------------");
	System.out.println("petUpdateForm.jsp");
 
 	int petNo = Integer.parseInt(request.getParameter("petNo"));

 	System.out.println("petNo: " + petNo);
%>
 
 <%
	ArrayList<HashMap<String, Object>> petDetail = PetDao.petDetail(petNo);
 %>
<!-- view layer -->
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
	<div class="regiCustomerInput">
			<h2>펫 정보 수정</h2>
			<form action="/atti/action/petUpdateAction.jsp">
			<input type="hidden" name="petNo" value="<%=petNo%>">
			<table border="1">
				
				<%
					for(HashMap<String, Object> p : petDetail){
				%>
				
						<tr>
							<th><label for="major">분류</label></th> <!-- select로 수정 예정 -->
							<td><input type="text" name="major" id="major" value="<%=p.get("major")%>" readonly="readonly"></td>
						</tr>
						<tr>
							<th><label for="petKind">종류</label></th> <!-- select로 수정 예정 -->
							<td><input type="text" name="petKind" id="petKind" value="<%=p.get("petKind")%>" readonly="readonly"><td>
						</tr>
						<tr>
							<th><label for="petName">펫 이름</label></th>
							<td><input type="text" name="petName" id="petName" value="<%=p.get("petName")%>"></td>
						</tr>
						<tr>
							<th><label for="petBirth">펫 생일</label></th>
							<td><input type="date" name="petBirth" id="petBirth" value="<%=p.get("petBirth")%>" readonly="readonly"></td>
						</tr>
				<%		
					}
				%>
			</table>
			<button type="submit">등록하기</button>
			</form>
		</div>
	</main>
</body>
</html>