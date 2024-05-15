<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="atti.*" %>

<!-------------------- 
 * 기능 번호  : #14
 * 상세 설명  : 직원 탈퇴 (사번, 전공)
 * 시작 날짜 : 2024-05-14
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
	
	//선택된 직원의 사번, 직급
	int empNo = Integer.parseInt(request.getParameter("empNo")); 
	String empGrade = request.getParameter("empGrade");

	
	//디버깅
	//System.out.println(empNo);
	//System.out.println(empGrade);
	
%>

<!-- Model layer -->
<%
	//선택된 직원의 사번괴 직급을 확인하고 퇴사자로 상태 변경
	int updateRow = EmpDao.empDelete(empNo, empGrade);
%>

<% if(updateRow > 0) { %>

	<!-- 상세보기 페이지 이동 -->
	<form action="/atti/view/empDetail.jsp" method="post" id="redirectForm">
	    <input type="hidden" name="empNo" value="<%=empNo%>">
	    <script>
	        document.getElementById("redirectForm").submit(); // 자동으로 폼 제출
	    </script>
	</form>
	
<% }else{%>

	<!-- 직원 정보 수정 페이지 이동 -->
	<form action="/atti/view/empUpdateForm.jsp" method="post" id="redirectForm">
	    <input type="hidden" name="empNo" value="<%=empNo%>">
	    <script>
	        document.getElementById("redirectForm").submit(); // 자동으로 폼 제출
	    </script>
	</form>
<% 
	}
%>

