<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Main Content</title>
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- CSS 공통적용CSS파일 -->
	<link rel="stylesheet" href="./css/css_all.css">
</head>

<body id="fontSet">
	<div id="bodyDiv">
		<!-------------------- 헤더부분 -------------------->
		<jsp:include page="inc/header.jsp"></jsp:include>
	
		<!-------------------- 메인시작 -------------------->
		<div id="divMain">
			<!-- 서브메뉴나오는 부분 -->
			<jsp:include page="inc/subMenu.jsp"></jsp:include>
		
			<!-- 내용출력되는 부분 -->
			<div id="mainContent">
				여기에 내용을 입력
			</div>
		</div>
	</div>
</body>
</html>