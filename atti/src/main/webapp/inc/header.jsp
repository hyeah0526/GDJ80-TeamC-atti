<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!-- Controller layer  -->
<%
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
%>

<!-- view layer -->
<header id="header">
	<%
		//session 유무에 따라 보여주는 보여주는 버튼을 다르게 보여주기 
		if(session.getAttribute("loginEmp")!= null){
	%>
			<!-- 로그인 정보 출력 -->
			<div id="headerTop">
				<div id="headerLogin">
					<%=loginEmp.get("empNo")%> <%=loginEmp.get("empGrade")%>  <%=loginEmp.get("empName")%>님 &nbsp;
					<button>
						<a href="/atti/action/logoutAction.jsp">로그아웃</a>
					</button>
					<button>
						<a href="/atti/view/empPwUpdateForm.jsp">
							비밀번호수정
						</a>
					</button>
				</div>
			</div>
	
	<%			
		}else{	
	%>
			<div id="headerTop">
				<div id="headerLogin">
					<button>
						<a href="/atti/view/loginForm.jsp">로그인</a>
					</button>
				</div>
			</div>
	<%
		}
	%>
	
	<!-- 메인 카테고리 -->
	<div id="mainCategory">
		<!-- 이미지로고 -->
		<div id="logoImg">
			<img id="logo" src="../inc/logo.png">
		</div>
	
		<!-- 카테고리출력 -->
		<div id="mainCategoryDiv">
			<button>고객</button>
			<button>접수/예약</button>
			<button>진료</button>
			<button>검사/수술</button>
			<button>처방</button>
			<button>입원</button>
			<button>결제</button>
			<%
				if(session.getAttribute("loginEmp") != null){
					
					//로그인한 사용자의 사번, 직무, 이름 디버깅 
					//System.out.println(loginEmp.get("empGrade"));
					//System.out.println(loginEmp.get("empName"));	
					//System.out.println(loginEmp.get("empNo"));
					//System.out.println(loginEmp.get("empNo").toString().charAt(0));
					
					if(loginEmp.get("empNo") != null && loginEmp.get("empNo").toString().charAt(0) == '1'){					
			%>		
						<button>매출관리</button>
						<button>직원관리</button>					
			<%
					}
				}
			%>
		</div>
	</div>
</header>