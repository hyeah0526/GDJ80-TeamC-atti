<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!-- Controller layer  -->
<%
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
%>

<!-- view layer -->
<header id="header">
	<%
		//session 유무에 따라 버튼을 다르게 보여주기 
		if(session.getAttribute("loginEmp")!= null){
	%>
			<!-- 로그인 정보 출력 -->
			<div id="headerTop">
				<div id="headerLogin">
					<%=loginEmp.get("empNo")%> <%=loginEmp.get("empGrade")%>  <%=loginEmp.get("empName")%>님 &nbsp;
					<button onclick="location.href='/atti/action/logoutAction.jsp'">
						로그아웃
					</button>
					<button onclick="location.href='/atti/view/empPwUpdateForm.jsp'">
						비밀번호수정
					</button>
				</div>
			</div>
	
	<%			
		}else{	
	%>
			<div id="headerTop">
				<div id="headerLogin">
					<button onclick="location.href='/atti/view/loginForm.jsp'" >
						로그인
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
			<button onclick="location.href='/atti/view/main.jsp'">
				<img id="logo" src="../inc/logo.png">
			</button>
		</div>
	
		<!-- 카테고리출력 -->
		<div id="mainCategoryDiv">
			<button onclick="location.href='/atti/view/searchList.jsp'">
				고객
			</button>
			
			<button onclick="location.href='/atti/view/regiList.jsp'">
				접수/예약
			</button>
			<%
				if(session.getAttribute("loginEmp") != null){
					if(loginEmp.get("empNo") != null && !(loginEmp.get("empNo").toString().charAt(0) == '3')){
			%>
				<button onclick="location.href='/atti/view/clinicList.jsp'">
					진료
				</button>
			
			<%
					}
				}			
			%>
			
			<button onclick="location.href='/atti/view/examinationList.jsp'">
				검사
			</button>
			
			<button onclick="location.href='/atti/view/surgeryList.jsp'">
				수술
			</button>
			
			<button onclick="location.href='/atti/view/prescriptionList.jsp'">
				처방
			</button>
			
			<button onclick="location.href='/atti/view/hospitalRoomList.jsp'">
				입원
			</button>
			
			<button onclick="location.href='/atti/view/paymentList.jsp'">
				결제
			</button>
			<%
				if(session.getAttribute("loginEmp") != null){
					
					//로그인한 사용자의 사번, 직무, 이름 디버깅 
					//System.out.println(loginEmp.get("empGrade"));
					//System.out.println(loginEmp.get("empName"));	
					//System.out.println(loginEmp.get("empNo"));
					//System.out.println(loginEmp.get("empNo").toString().charAt(0));
					
					//로그인한 사용자의 권한에 따라 버튼 다르게 보여주기(관리자만)
					if(loginEmp.get("empNo") != null && loginEmp.get("empNo").toString().charAt(0) == '1'){					
			%>		
						<button onclick="location.href='/atti/view/income.jsp'">
							매출관리
						</button>
						<button onclick="location.href='/atti/view/empList.jsp'">
							직원관리
						</button>					
			<%
					}
				}
			%>
		</div>
	</div>
</header>