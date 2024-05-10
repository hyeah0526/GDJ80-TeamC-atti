<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="atti.*" %>

<!-- Controller layer  -->
<%
	//loginForm에서 보낸 id, pw 
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	String empPw = request.getParameter("empPw");
	
	//id, pw 디버깅
	//System.out.println("empNo = " + empNo);
	//System.out.println("empPw = " + empPw);
%>

<!-- Model layer -->
<%
	//직원 로그인
	HashMap<String, Object> loginEmp = EmpDao.login(empNo,empPw);
	
	//로그인 디버깅
	//System.out.println(resultMap);
	
	if(loginEmp != null){
		session.setAttribute("loginEmp", loginEmp);
		response.sendRedirect("/atti/view/main.jsp");
	}else{
		//로그인 실패시 
		response.sendRedirect("/atti/view/loginForm.jsp");
	}
%>