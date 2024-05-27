<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="atti.PaymentDao"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	 * 기능 번호  : #44
	 * 상세 설명  : 매출 조회
	 * 시작 날짜 : 2024-05-16
	 * 담당자 : 박혜아
 -->
 <%
 
	//로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}
 
 %>
<%
	// 매출계산을 위한 달/년 설정
	Calendar cal = Calendar.getInstance( );
	
	// 현재 달을 기준으로 전달(-1)과 전전달(-2) 구하기
	int targetMonth = cal.get(Calendar.MONTH)+1;
	int firstMonth = 0;		//전달(현재 달-1)
	int middleMonth = 0;	//전전달(현재 달-2)
	
	// 년도설정
	int targetYear = cal.get(Calendar.YEAR);
	int firstYear = 0;
	int middleYear = 0;
	
	if(targetMonth == 1){
		// 1월일 경우
		firstYear = targetYear -1;
		middleYear = targetYear -1;
		
		firstMonth = targetMonth +10;
		middleMonth = targetMonth +11;
		
	}else if(targetMonth == 2){
		// 2월일 경우
		firstYear = targetYear -1;
		middleYear = targetYear;
		
		firstMonth = targetMonth +10;
		middleMonth = targetMonth -1;
		
	}else{
		// 나머지 달
		firstYear = targetYear;
		middleYear = targetYear;
		
		firstMonth = targetMonth-2;
		middleMonth = targetMonth-1;
	}
	
	// String으로 형변환(1~9월까지는 앞에 0을 붙여주기)
	String targetYearStr = Integer.toString(targetYear);
	String firstYearStr = Integer.toString(firstYear);
	String middleYearStr = Integer.toString(middleYear);
	
	String targetMonthStr = String.format("%02d", targetMonth);
    String firstMonthStr = String.format("%02d", firstMonth);
    String middleMonthStr = String.format("%02d", middleMonth);
	
	
	// First
	HashMap<String, Integer> first = PaymentDao.income(firstYearStr, firstMonthStr);
	//System.out.println("income.jsp First 년 달 --> "+firstYearStr+"년"+firstMonthStr+"달--> "+first);
	//System.out.println("=======================================");
	
	// Middle
	HashMap<String, Integer> middle = PaymentDao.income(middleYearStr, middleMonthStr);
	//System.out.println("income.jsp middle 년 달 --> "+middleYearStr+"년"+middleMonthStr+"달--> "+middle);
	//System.out.println("=======================================");
	
	// Target
	HashMap<String, Integer> target = PaymentDao.income(targetYearStr, targetMonthStr);
	//System.out.println("income.jsp target 년 달 --> "+targetYearStr+"년"+targetMonthStr+"달--> "+target);
	//System.out.println("=======================================");
	
	// 각달에 매출 %로 변환 
	double totalIncome = first.get("monthSum") + middle.get("monthSum") + target.get("monthSum");
	double firstIncome = Math.round((first.get("monthSum")/totalIncome)*100);
	double middleIncome = Math.round((middle.get("monthSum")/totalIncome)*100);
	double targetIncome = Math.round((target.get("monthSum")/totalIncome)*100);
	
	// 상세 금액 표시를 위해 천단위마다 콤마(,)붙여기
	NumberFormat numberFormat = NumberFormat.getNumberInstance();	// 콤마(,)표시를 위한 NumberFormat 클래스사용
	String firstIncomeStr = numberFormat.format((first.get("monthSum")));		// 전전달 총 매출 금액
	String middleIncomeStr = numberFormat.format((middle.get("monthSum")));		// 전달 총 매출 금액
	String targetIncomeStr = numberFormat.format((target.get("monthSum")));		// 해당달 총 매출 금액
	
	// 디버깅
	//System.out.println("income.jsp 전전달 총매출 콤마표시 firstIncomeStr--> "+firstIncomeStr);
	//System.out.println("income.jsp 전달 총매출 콤마표시 middleIncomeStr--> "+middleIncomeStr);
	//System.out.println("income.jsp 해당달 총매출 콤마표시 targetIncomeStr--> "+targetIncomeStr);
	//System.out.println("income.jsp 3개월 총 매출금액totalIncome--> "+totalIncome);
	//System.out.println("income.jsp 전전달 firstIncome--> "+middleIcome);
	//System.out.println("income.jsp 전달 middleIcome--> "+middleIcome);
	//System.out.println("income.jsp 해당달 targetIncome--> "+targetIncome);
	System.out.println("-----------------------------------------------------------------------------------------------");
%>
<%
	/* 각 달 상세보기 */
	String incomeDetail = request.getParameter("incomeDetail");

	if(incomeDetail == null)
	{
		incomeDetail = "";
	}
	//System.out.println("income.jsp incomeDetail--> "+incomeDetail);
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>매출관리</title>
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
				<button type="button" onclick="location.href='./paymentList.jsp'">결제내역</button><br><br>
				<button type="button" onclick="location.href='./income.jsp'">매출관리</button><br><br>
			</div>
		</div>
	</aside>
	
	<!-------------------- main -------------------->
	<main>
		<h2 id="incomeTitle">매출관리</h2>
		<div>
			<div id="wrap">
				<!-- 현재달(target)을 기준으로 전달과 전전달의 매출이 총 3개의 달이 100%로 계산되어 출력 -->
				<div>
					<!-- 첫번째달 -->
					<div id="incomeYearMonth">
						<h5><%=firstYear%>년 <%=firstMonth%>월</h5>
						<button value="firstDetail" name="incomeDetail" type="submit" onClick="location.href='./income.jsp?incomeDetail=firstDetail'">상세보기</button>
					</div>
					
					<div id="chart" class="doughnut1">
						<span class="center"><%=firstIncome%>%</span>
					</div>
					<div id="incomeTotalPrice"><%=firstIncomeStr%>원</div><br>
					
				    <!-- 두번째달 -->
				    <div id="incomeYearMonth">
				    	<h5><%=middleYear%>년 <%=middleMonth%>월</h5>
				    	<button value="middleDetail" name="incomeDetail" type="submit" onClick="location.href='./income.jsp?incomeDetail=middleDetail'">상세보기</button>
				    </div>
				    
				    <div id="chart" class="doughnut2">
				    	<span class="center"><%=middleIncome%>%</span>
				    </div>
					<div id="incomeTotalPrice"><%=middleIncomeStr%>원</div><br>
				    
				    
				    <!-- 세번째달 -->
				    <div id="incomeYearMonth">
				    	<h5><%=targetYear%>년 <%=targetMonth%>월</h5>
				    	<button value="targetDetail" name="incomeDetail" type="submit" onClick="location.href='./income.jsp?incomeDetail=targetDetail'">상세보기</button>
				    </div>
				    
				    <div id="chart" class="doughnut3">
				    	<span class="center"><%=targetIncome%>%</span>
				    </div>
				    <div id="incomeTotalPrice"><%=targetIncomeStr%>원</div><br>
				</div>
			</div>
			
			<div id="incomeDetailMain">
			<h4>상세 매출</h4>
			<%
				if(incomeDetail.equals("firstDetail")){
			%>
					<h5><%=firstYear%>년 <%=firstMonth%>월 상세매출</h5>
					<table id="detailPrice">
						<tr>
							<th>진료비</th>
							<td><%=numberFormat.format((first.get("clinicSum")))%>원</td>
						</tr>
						<tr>
							<th>검사비</th>
							<td><%=numberFormat.format((first.get("examinationSum")))%>원</td>
						</tr>
						<tr>
							<th>수술비</th>
							<td><%=numberFormat.format((first.get("surgerySum")))%>원</td>
						</tr>
						<tr>
							<th>입원비</th>
							<td><%=numberFormat.format((first.get("hospitalSum")))%>원</td>
						</tr>
						<tr>
							<th>처방비</th>
							<td><%=numberFormat.format((first.get("medicineSum")))%>원</td>
						</tr>
					</table>
			<%
				}else if(incomeDetail.equals("middleDetail")){
			%>
					<h5><%=middleYear%>년 <%=middleMonth%>월 상세매출</h5>
					<table id="detailPrice">
						<tr>
							<th>진료비</th>
							<td><%=numberFormat.format((middle.get("clinicSum")))%>원</td>
						</tr>
						<tr>
							<th>검사비</th>
							<td><%=numberFormat.format((middle.get("examinationSum")))%>원</td>
						</tr>
						<tr>
							<th>수술비</th>
							<td><%=numberFormat.format((middle.get("surgerySum")))%>원</td>
						</tr>
						<tr>
							<th>입원비</th>
							<td><%=numberFormat.format((middle.get("hospitalSum")))%>원</td>
						</tr>
						<tr>
							<th>처방비</th>
							<td><%=numberFormat.format((middle.get("medicineSum")))%>원</td>
						</tr>
					</table>	
			<%
				}else if(incomeDetail.equals("targetDetail")){
			%>
					<h5><%=targetYear%>년 <%=targetMonth%>월 상세매출</h5>
					<table id="detailPrice">
						<tr>
							<th>진료비</th>
							<td><%=numberFormat.format((target.get("clinicSum")))%>원</td>
						</tr>
						<tr>
							<th>검사비</th>
							<td><%=numberFormat.format((target.get("examinationSum")))%>원</td>
						</tr>
						<tr>
							<th>수술비</th>
							<td><%=numberFormat.format((target.get("surgerySum")))%>원</td>
						</tr>
						<tr>
							<th>입원비</th>
							<td><%=numberFormat.format((target.get("hospitalSum")))%>원</td>
						</tr>
						<tr>
							<th>처방비</th>
							<td><%=numberFormat.format((target.get("medicineSum")))%>원</td>
						</tr>
					</table>			
			<%
				}
			%>
			</div>
		</div>
	</main>
</body>
<script>
	const chart1 = document.querySelector('.doughnut1');
	const chart2 = document.querySelector('.doughnut2');
	const chart3 = document.querySelector('.doughnut3');
	
	const makeChart = (percent, classname, color) => {
	  let i = 1;
	  let chartFn = setInterval(function() {
	    if (i <= percent) {
	      colorFn(i, classname, color);
	      i++;
	    } else {
	      clearInterval(chartFn);
	    }
	  }, 10);
	}
	
	const colorFn = (i, classname, color) => {
	  classname.style.background = "conic-gradient(" + color + " 0% " + i + "%, #dedede " + i + "% 100%)";
	}
	
	makeChart(<%=firstIncome%>, chart1, '#f5b914');
	makeChart(<%=middleIncome%>, chart2, '#0A174E');
	makeChart(<%=targetIncome%>, chart3, '#66d2ce');
</script>
</html>