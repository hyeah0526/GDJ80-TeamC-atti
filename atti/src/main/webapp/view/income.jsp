<%@page import="java.util.HashMap"%>
<%@page import="atti.PaymentDao"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	 * 기능 번호  : #44
	 * 상세 설명  : 매출 조회
	 * 시작 날짜 : 2024-05-16
	 * 담당자 : 박혜아
 -->
 <%
 	int norang = 50;
 	int nam = 20;
 	int soda = 80;
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
	System.out.println("income.jsp First 년 달 --> "+firstYearStr+"년"+firstMonthStr+"달--> "+first);
	System.out.println("===================================");
	
	// Middle
	HashMap<String, Integer> middle = PaymentDao.income(middleYearStr, middleMonthStr);
	System.out.println("income.jsp middle 년 달 --> "+middleYearStr+"년"+middleMonthStr+"달--> "+middle);
	System.out.println("===================================");
	
	// Target
	HashMap<String, Integer> target = PaymentDao.income(targetYearStr, targetMonthStr);
	System.out.println("income.jsp target 년 달 --> "+targetYearStr+"년"+targetMonthStr+"달--> "+target);
	System.out.println("===================================");
	
	// norang 
	double totalIncome = first.get("monthSum") + middle.get("monthSum") + target.get("monthSum");
	double firstIncome = (first.get("monthSum")/totalIncome)*100;
	double middleIncome = (middle.get("monthSum")/totalIncome)*100;
	double targetIncome = (target.get("monthSum")/totalIncome)*100;
	
	System.out.println(totalIncome+"<--totalIncome");
	System.out.println(firstIncome+"<--firstIcome");
	System.out.println(middleIncome+"<--middleIcome");
	System.out.println(targetIncome+"<--targetIncome");
	System.out.println(middle.get("monthSum")+"<--middle get monthSum55555");
	
	// 디버깅
	//System.out.println(targetMonth현재달+" <--todayMonth");
	//System.out.println("===================================");
	//System.out.println("income.jsp firstYear--> "+firstYearStr);
	//System.out.println("income.jsp firstMonth(-2)전전월--> "+firstMonthStr);
	//System.out.println("===================================");
	//System.out.println("income.jsp middleYear--> "+middleYearStr);
	//System.out.println("income.jsp middleMonth(-1)전월--> "+middleMonthStr);
	//System.out.println("===================================");
	//System.out.println("income.jsp targetMonth-->해당월 "+targetMonthStr);
	//System.out.println("income.jsp targetYear--> "+targetYearStr);
	//System.out.println("===================================");
	//System.out.println(target+" <--target");
	System.out.println("-----------------------------------------------------------------------------------------------");
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
	
	<style>
		.wrap {
		  position: relative;
		  padding: 2%;
		}
		
		.container {
		  display: flex;
		  gap: 10px;
		  margin-bottom: 10px;
		}
		
		.chart {
		  position: relative;
		  width: 80px;
		  height: 80px;
		  border-radius: 50%;
		  transition: 0.3s;
		}
		
		span.center {
		  background: #fff;
		  position: absolute;
		  top: 50%;
		  left: 50%;
		  width: 40px;
		  height: 40px;
		  border-radius: 50%;
		  text-align: center;
		  line-height: 40px;
		  font-size: 15px;
		  transform: translate(-50%, -50%); 
		}

</style>
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
		<h2>매출관리</h2>
		<div>
			<div class='wrap'>
				<div class=''>
					<div class="chart doughnut1"><span class="center"><%=norang%>%</span></div>
				    <div class="chart doughnut2"><span class="center"><%=nam%>%</span></div>
				    <div class="chart doughnut3"><span class="center"><%=soda%>%</span></div>
				</div>
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
	
	makeChart(<%=norang%>, chart1, '#f5b914');
	makeChart(<%=nam%>, chart2, '#0A174E');
	makeChart(<%=soda%>, chart3, '#66d2ce');
</script>
</html>