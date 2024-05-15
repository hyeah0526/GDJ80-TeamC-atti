<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="atti.*" %>


<!-------------------- 
 * 기능 번호  : #13
 * 상세 설명  : 직원 정보 수정 (전화번호, 전공)
 * 시작 날짜 : 2024-05-14
 * 담당자 : 김인수
 -------------------->

<!-- Controller layer  -->
<%

	//세션을 변수로 변환
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	
	//로그인한 사용자가 관리자인지 확인
	if(loginEmp == null || (loginEmp != null && loginEmp.get("empNo").toString().charAt(0) != '1')){
		response.sendRedirect("/atti/view/main.jsp"); // 로그인하지 않은 사용자는 로그인 페이지로 이동
		return;
	}
	
	//디버깅
	//System.out.println(loginEmp);
	
	//선택된 직원의 사번, 전공, 전화번호
	int empNo = Integer.parseInt(request.getParameter("empNo")); 
	String empMajor = request.getParameter("empMajor");
	String empTel = request.getParameter("empTel");
	
	
	//디버깅
	//System.out.println(empNo);
	//System.out.println(empMajor);
	//System.out.println(empTel);
	
%>

<!-- Model layer -->
<% 
	int updateRow = 0;

	//직원의 변경할 전화번호 검증 (null, 빈값, 숫자가 아닌 경우, 010으로 시작하지 않는 경우, 길이가 11자리가 아닌 경우)
	if(empTel == null || empTel.trim().isEmpty() || !empTel.matches("^010\\d{8}$")){
		
%>
		<!-- 직원 정보 수정 페이지 이동 -->
		<form action="/atti/view/empUpdateForm.jsp" method="post" id="redirectForm">
		    <input type="hidden" name="empNo" value="<%=empNo%>">
		    <script>
		        document.getElementById("redirectForm").submit(); // 자동으로 폼 제출
		    </script>
		</form>
<%
	}else{
		
		//선택된 직원의 사번을 확인하고 직무 또는 전화번호 변경
		updateRow = EmpDao.empUpdate(empNo, empMajor, empTel);
	
		//디버깅
		//System.out.println(updateRow);		
	}
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

