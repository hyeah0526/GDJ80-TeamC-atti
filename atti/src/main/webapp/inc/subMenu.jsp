<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="subMenu">
	<%
		//session 유무에 따라 보여주는 보여주는 버튼을 다르게 보여주기 
		if(session.getAttribute("loginEmp")!= null){
	%>
		<div id="subMenuBtnContainer">
			<button>버튼1</button><br><br>
			<button>버튼2</button><br><br>
			<button>버튼3</button><br><br>
			<button>버튼4</button><br><br>
		</div>
	<%			
		}	
	%>
</div>