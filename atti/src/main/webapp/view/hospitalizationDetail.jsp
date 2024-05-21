<%@ page import="java.util.*"%>
<%@ page import="atti.HospitalRoomDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	 * 기능 번호  : #40
	 * 상세 설명  : 입원실 입원환자 정보 상세보기
	 * 시작 날짜 : 2024-05-13
	 * 담당자 : 박혜아
 -->
 <%
 	// 입원환자의 해당하는 접수번호
 	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
 	//System.out.println("hospitalizationDetail.jsp regiNo--> " + regiNo);
 	
 	// 해당 환자(1마리)의 상세 입원정보 출력
 	ArrayList<HashMap<String, Object>> hospitalOne = HospitalRoomDao.hospitalizationDetail(regiNo);
 	//System.out.println("hospitalizationDetail.jsp hospitalOne--> " + hospitalOne);
 	
 	// 퇴원 / 등록 실패시 보여줄 에러메세지
 	String errMsg = request.getParameter("errMsg");
 %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>입원환자 상세보기</title>
	
	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- CSS 공통적용CSS파일 -->
	<link rel="stylesheet" href="../css/css_all.css">
	<link rel="stylesheet" href="../css/css_hyeah.css">
</head>
<body id="fontSet">
	
	<!-------------------- header -------------------->
	<jsp:include page="../inc/header.jsp"></jsp:include>

	<!-------------------- aside-------------------->
	<aside>
		<!-- 서브메뉴나오는 부분 -->
		<div id="subMenu">
			<div id="subMenuBtnContainer">
				<button type="button" onclick="location.href='./hospitalRoomList.jsp'">입원실</button><br><br>
				<button type="button" onclick="location.href='./hospitalizationList.jsp'">입원 환자</button><br><br>
			</div>
		</div>
	</aside>
	
	<!-------------------- main -------------------->
	<main>
		<!-- 내용출력되는 부분 -->
		<div>
			<h2>입원실 환자 상세보기</h2>
			<!-- 퇴원처리 / 내용 등록 실패시 화면 안내 -->
			<%
				if(errMsg != null){
			%>
					<div style="text-align: center; color: red;">에러 : <%=errMsg%></div>
			<%
				}
			%>
			
			<!-- 환자 기본보기 상세 -->
			<%
				for(HashMap<String, Object> p : hospitalOne){
			%>
					<div style="float: left; width: 50%; box-sizing: border-box;">
						<!-- 입원정보 -->
						<table border="1">
							<tr>
								<th colspan="2"><h5>입원 정보</h5></th>
							</tr>
							<tr>
								<th>입원실</th>
								<td><%=(String)p.get("roomName")%></td>
							</tr>
							<tr>
								<th>입원날짜</th>
								<td><%=(String)p.get("createDate")%></td>
							</tr>
							<tr>
								<th>퇴원날짜</th>
								<td><%=(String)p.get("dischargeDate")%></td>
							</tr>
							<tr>
								<th>담당의사</th>
								<td><%=(String)p.get("empName")%></td>
							</tr>
							<%
								// 입원상태가 '입원'중일 경우에만 퇴원버튼 활성화
								String hospitalState = (String)p.get("hospitalState");
								if(hospitalState.equals("입원")){
							%>
									<tr>
										<th>현재상태</th>
										<td>
											입원중<a href="/atti/action/hospitalDischargeAction.jsp?roomName=<%=(String)p.get("roomName")%>&regiNo=<%=regiNo%>">[퇴원처리]</a>
										</td>
									</tr>
							<%
								}else{
							%>
								<tr>
									<th>현재상태</th>
									<td>퇴원완료</td>
								</tr>	
							<%
								}
							%>
						</table><br>
						
						<!-- 입원 환자정보 -->
						<table border="1">
							<tr>
								<th colspan="2"><h5>환자 정보</h5></th>
							</tr>
							<tr>
								<td colspan="2">
									<%
										String empMajor = (String)p.get("empMajor");
										if(empMajor.equals("포유류")){
									%>
											<img id="iconAnimal"  src="../inc/icon_dog.png">
									<%
										}else if(empMajor.equals("파충류")){
									%>
											<img id="iconAnimal"  src="../inc/icon_lizard.png">
									<%
										}else if(empMajor.equals("조류")){
									%>
											<img id="iconAnimal"  src="../inc/icon_bird.png">
									<%
										}
									%>
								</td>
							</tr>
							<tr>
								<th>환자 이름</th>
								<td><%=(String)p.get("petName")%></td>
							</tr>
							<tr>
								<th>환자 종류</th>
								<td><%=(String)p.get("petKind")%></td>
							</tr>
							<tr>
								<th>환자 나이</th>
								<td><%=(String)p.get("petBirth")%></td>
							</tr>
							<tr>
								<th>보호자</th>
								<td><%=(String)p.get("customerName")%>(<%=(String)p.get("customerTel")%>)</td>
							</tr>
						</table>
					</div>
					
					<!-- 입원내용 출력 및 작성 -->
					<div style="float: right; width: 50%; box-sizing: border-box; border: 1px solid red;">
						<h5>입원 간호기록</h5><br>
						<!-- 작성된 입원내용 전부 출력 -->
						<div>
							<%
								// hospitalContent값을 \n -> <br>엔터 치환
								String hospiContent = (String)p.get("hospitalContent");
								String hospiContentChange =  hospiContent.replaceAll("\n", "<br/>");
							%>
							<%=hospiContentChange%>
						</div><br><br>
						
						<!-- 입원내용 추가등록 -->
						<%
							// 입원상태가 '입원'중일때만 작성 가능
							if(hospitalState.equals("입원")){
						%>
								<div>
									<form action="/atti/action/hospitalContentAction.jsp" method="post">
										<input type="datetime-local" id="hospiContentToday" name="hospiContentDate" readonly="readonly">
										
										<textarea rows="" cols="" name="hospiContent"></textarea>
										
										<input type="hidden" value="<%=(Integer)p.get("hospitalNo") %>" name="hospitalNo">
										<input type="hidden" value="<%=regiNo%>" name="regiNo">
										<input type="hidden" value="박임시" name="hospiEmpName">
										<button type="submit">추가등록</button>
									</form>
								</div>
						<%
							}
						%>
					</div>
				<%
					}
				%>
		</div>
	</main>
</body>

<!-- 날짜등록 사용자타임(한국시간)에 맞게 변경 -->
<script>
  var userTimezoneOffset = new Date().getTimezoneOffset() * 60000;
  var localTime = new Date(Date.now() - userTimezoneOffset);
  var localISOString = localTime.toISOString().slice(0, -1);
  document.getElementById('hospiContentToday').value = localISOString.slice(0, 16);
</script>
</html>