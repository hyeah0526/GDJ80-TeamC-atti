<%@ page import="atti.PaymentDao"%>
<%@ page import="atti.RegistrationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<!-- 
	 * 기능 번호  	: #43
	 * 상세 설명  	: 결제 완료 처리 (결제상태'미납' -> '완납' 상태변경 AND 진료상태'진행' -> '완료' 상태변경)
	 * 시작 날짜 	: 2024-05-16
	 * 담당자 	: 박혜아
 -->
<%
	//로그인한 사용자인지 검증
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/atti/view/loginForm.jsp");
		return;
	}

	// 받아온 변수
	int regiNo = Integer.parseInt(request.getParameter("regiNo"));				//접수번호
	int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));		//총금액
	int customerPay = Integer.parseInt(request.getParameter("customerPay"));	//고객이 지불한 금액	
	String paymentState = request.getParameter("paymentState");	//결제상태(미납)
	System.out.println("paymentAction.jsp regiNo--> "+regiNo);
	System.out.println("paymentAction.jsp totalPrice--> "+totalPrice);
	System.out.println("paymentAction.jsp customerPay--> "+customerPay);
	System.out.println("paymentAction.jsp paymentState--> "+paymentState);
	
	// 에러메세지 안내
	String infoMsg = "";
	
	// 총금액과 고객이 지불한 금액이 동일하지 않을경우 결제실패이므로 되돌려보내기
	if(totalPrice != customerPay){
		System.out.println("paymentAction.jsp 결제실패 : 금액이 동일하지않음");
		
		infoMsg = URLEncoder.encode("금액이 맞지않습니다", "UTF-8");
		response.sendRedirect("/atti/view/paymentDetail.jsp?regiNo="+regiNo+"&infoMsg="+infoMsg);
	}else{
		// 총금액과 고객이 지불한 금액이 동일한 경우에만 상태변경진행

		//1. 결제 상태 변경 ('미납 -> 완납')
		int payState = PaymentDao.paymentStateUpdate(regiNo, paymentState);
		int regiState = 0;
		
		if(payState == 0){
			//실패 : 결제상태 변경 실패로 paymentDetail.jsp로 에러메세지와 redirect
			System.out.println("paymentAction.jsp 결제실패 : paymentStateUpdate에러");
					
			infoMsg = URLEncoder.encode("결제에 실패하였습니다. 다시 시도해주세요", "UTF-8");
			response.sendRedirect("/atti/view/paymentDetail.jsp?regiNo="+regiNo+"&infoMsg="+infoMsg);
		}else{
			//성공 : 접수상태 변경 DAO로 이동
			System.out.println("paymentAction.jsp 결제성공 : 진료상태변경DAO로 이동");
			
			//2. 접수 상태 변경 ('진행 -> 완료')
			regiState = RegistrationDao.regiStateStateUpdate(regiNo);
			
			// 성공 : 모든 프로세스 종료로 paymentDetail.jsp로 redirect
			if(regiState == 0){
				// 실패 : 결제 상태를 다시 '미납'으로 변경 후 paymentDetail.jsp로 redirect
				System.out.println("paymentAction.jsp 결제실패 : 진료상태변경 실패로 결제상태를 미납으로 변경하기위해 진료상태변경DAO로 이동");
				
				// '완납 -> 미납'으로 다시 변경
				paymentState = "완납";
				int paymentStateFail = PaymentDao.paymentStateUpdate(regiNo, paymentState);
				infoMsg = URLEncoder.encode("결제에 실패하였습니다. 다시 시도해주세요", "UTF-8");
				response.sendRedirect("/atti/view/paymentDetail.jsp?regiNo="+regiNo+"&infoMsg="+infoMsg);
				
			}else{
				System.out.println("paymentAction.jsp 결제성공 : 접수상태변경까지 전부 완료!");
				
				infoMsg = URLEncoder.encode("결제 완료되었습니다.", "UTF-8");
				response.sendRedirect("/atti/view/paymentDetail.jsp?regiNo="+regiNo+"&infoMsg="+infoMsg);
			}
			
		}
	}
	System.out.println("====================================");	
%>
