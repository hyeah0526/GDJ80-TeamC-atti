<%@page import="atti.PaymentDao"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	 * 기능 번호  : #42
	 * 상세 설명  : 결제 내역 상세
	 * 시작 날짜 : 2024-05-15
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
 	// 받아온 regiNo
 	int regiNo = Integer.parseInt(request.getParameter("regiNo"));
 	//System.out.println("paymentDetail.jsp regiNo--> " + regiNo);
 	
 	// 안내메세지
 	String infoMsg = request.getParameter("infoMsg");
 	
 	// 상세 결제정보 
 	HashMap<String, Object> paymentDetail = PaymentDao.paymentDetail(regiNo);
 	//System.out.println("paymentDetail.jsp paymentDetail--> " + paymentDetail);
 	
 	// view에 뿌려줄 값 저장
 	String petName = (String)paymentDetail.get("petName");					//동물이름
 	String customerName = (String)paymentDetail.get("customerName");		//보호자이름
 	String paymentState = (String)paymentDetail.get("paymentState");		//결제상태('완납' / '미납')
 	int clinicCost = (Integer)paymentDetail.get("clinicCost");				//진료비용
 	String clinicCostStr = String.format("%,d", clinicCost);					//진료비용 천단위 콤마표시
 	String examinationKind = (String)paymentDetail.get("examinationKind");	//검사종류
 	int examinationCost = (Integer)paymentDetail.get("examinationCost");	//검사비용
 	String examinationCostStr = String.format("%,d", examinationCost);			//검사비용 천단위 콤마표시
 	String surgeryKind = (String)paymentDetail.get("surgeryKind");			//수술종류
 	int surgeryCost = (Integer)paymentDetail.get("surgeryCost");			//수술비용
 	String surgeryCostStr = String.format("%,d", surgeryCost);					//수술비용 천단위 콤마표시
 	String hospitalRoom = (String)paymentDetail.get("hospitalRoom");		//입원호실
 	int hospitalCost = (Integer)paymentDetail.get("hospitalCost");			//입원비용
 	String hospitalCostStr = String.format("%,d", hospitalCost);				//입원비용 천단위 콤마표시
 	String medicineName = (String)paymentDetail.get("medicineName");		//약이름
 	int medicineCost = (Integer)paymentDetail.get("medicineCost");			//약비용
 	String medicineCostStr = String.format("%,d", medicineCost);				//약비용 천단위 콤마표시
 	
 	// 총금액 저장 (진료비용 + 검사비용 + 수술비용 + 입원비용 + 약비용)
 	int totalPrice = clinicCost + examinationCost + surgeryCost + hospitalCost + medicineCost;
 	
 	// 총금액 천단위 콤마표시
 	String totalPriceStr = String.format("%,d", totalPrice);
 	
 	
 	//디버깅
 	//System.out.println("paymentDetail.jsp petName--> " + petName);
 	//System.out.println("paymentDetail.jsp customerName--> " + customerName);
 	//System.out.println("paymentDetail.jsp paymentState--> " + paymentState);
 	//System.out.println("paymentDetail.jsp clinicCost--> " + clinicCost);
 	//System.out.println("paymentDetail.jsp examinationKind--> " + examinationKind);
 	//System.out.println("paymentDetail.jsp examinationCost--> " + examinationCost);
 	//System.out.println("paymentDetail.jsp surgeryKind--> " + surgeryKind);
 	//System.out.println("paymentDetail.jsp surgeryCost--> " + surgeryCost);
 	//System.out.println("paymentDetail.jsp hospitalRoom--> " + hospitalRoom);
 	//System.out.println("paymentDetail.jsp hospitalCost--> " + hospitalCost);
 	//System.out.println("paymentDetail.jsp medicineName--> " + medicineName);
 	//System.out.println("paymentDetail.jsp totalPrice--> " + totalPrice);
 	
 	System.out.println("====================================");
 %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>결제내역 상세</title>
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
			</div>
		</div>
	</aside>
	
	<!-------------------- main -------------------->
	<main id="paymentDetailMain">
		<h2>결제내역상세</h2>
		<!-- 에레메세지출력 -->
		<div id="paymentDetailInfoMsg">
			<% 
				if(infoMsg != null){
			%>
				<h4><%=infoMsg%></h4>
			<%}%>
		</div>
		
		<div id="paymentDetailTable">
			<table>
				<tr>
					<th colspan="2">영수증</th>
				</tr>
				<tr>
					<th>접수번호</th>
					<td><%=regiNo%></td>
				</tr>
				<tr>
					<th>환자이름</th>
					<td><%=petName%></td>
				</tr>
				<tr>
					<th>보호자이름</th>
					<td><%=customerName%></td>
				</tr>
				<tr>
					<th>결제상태</th>
					<td><%=paymentState%></td>
				</tr>
				<tr>
					<th>진료비용</th>
					<td><%=clinicCostStr%>원</td>
				</tr>
				<tr>
					<th>검사종류</th>
					<td><%=examinationKind%></td>
				</tr>
				<tr>
					<th>검사비용</th>
					<td><%=examinationCostStr%>원</td>
				</tr>
				<tr>
					<th>수술종류</th>
					<td><%=surgeryKind%></td>
				</tr>
				<tr>
					<th>수술비용</th>
					<td><%=surgeryCostStr%>원</td>
				</tr>
				<tr>
					<th>입원실</th>
					<td><%=hospitalRoom%></td>
				</tr>
				<tr>
					<th>입원비용</th>
					<td><%=hospitalCostStr%>원</td>
				</tr>
				<tr>
					<th>처방전</th>
					<td><%=medicineName%></td>
				</tr>
				<tr>
					<th>약비용</th>
					<td><%=medicineCostStr%>원</td>
				</tr>
				<tr>
					<th>전체요금</th>
					<td>합계 <%=totalPriceStr%>원</td>
				</tr>
				<%
					if(paymentState.equals("미납")){
				%>
						<tr>
							<th colspan="2">
								<!-- 결제하기 -->
								<form action="/atti/action/paymentAction.jsp">
									<input type="hidden" name="regiNo" value="<%=regiNo%>">
									<input type="hidden" name="totalPrice" value="<%=totalPrice%>">
									<input type="hidden" name="paymentState" value="<%=paymentState%>">
									<input type="number" name="customerPay" placeholder="결제금액입력">
									<button type="submit">결제</button>
								</form>
							</th>
						</tr>
				<%
					}else{
				%>
						<tr>
							<th colspan="2">결제완료</th>
						</tr>
				<%
					}
				%>
			</table>
		</div>
	</main>
</body>
</body>
</html>