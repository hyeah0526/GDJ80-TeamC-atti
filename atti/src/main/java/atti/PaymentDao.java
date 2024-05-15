package atti;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class PaymentDao {
	
	
	/*
	 * 메소드: #paymentList(String selectState, int startRow, int rowPerPage)
	 * 페이지: paymentList.jsp
	 * 시작 날짜: 2024-05-15
	 * 담당자: 박혜아
	*/
	public static ArrayList<HashMap<String, Object>> paymentList(String selectState, int startRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		
		System.out.println("PaymentDao#paymentList() startRow --> "+startRow);
		System.out.println("PaymentDao#paymentList() rowPerPage --> "+rowPerPage);
		System.out.println("PaymentDao#paymentList() selectState변경전 --> "+selectState);
		// 전체 선택일경우 공백처리 
		if(selectState.equals("전체")) {
			selectState = "";
		}
		System.out.println("PaymentDao#paymentList() selectState변경후 --> "+selectState);
		
		//DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		/* SELECT(조회화면에서 보여줄 것)
		 * pet : 동물이름
		 * payment : 접수번호, 결제상태, 생성날짜
		*/
		String sql = "SELECT pm.regi_no regiNo, p.pet_name petName, pm.payment_state paymentState, pm.create_date createDate, COUNT(*) OVER() totalRow"
				+ " FROM payment pm"
				+ " INNER JOIN registration r ON r.regi_no = pm.regi_no" //접수의 접수번호 = 결제의 접수번호
				+ " INNER JOIN pet p ON r.pet_no = p.pet_no"			//레지의 동물번호 = 동물의 동물번호
				+ " WHERE pm.payment_state LIKE ?"
				+ " GROUP BY pm.regi_no" 			
				+ " ORDER BY pm.create_date DESC"						//최신순으로 정렬
				+ " LIMIT ?, ?"; 					
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+selectState+"%");
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		//System.out.println("PaymentDao#paymentList() stmt --> "+stmt);
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("regiNo", rs.getInt("regiNo"));					//접수번호
			map.put("petName", rs.getString("petName"));			//동물이름
			map.put("paymentState", rs.getString("paymentState"));	//결제상태
			map.put("createDate", rs.getString("createDate"));		//생성날짜
			map.put("totalRow", rs.getInt("totalRow"));				//페이징totalRow
			
			list.add(map);
		}
		
		conn.close();
		return list;
	}
	
	
	/*
	 * 메소드: #paymentDetail(int regiNo)
	 * 페이지: paymentDetail.jsp
	 * 시작 날짜: 2024-05-15
	 * 담당자: 박혜아
	*/
	public static HashMap<String, Object> paymentDetail(int regiNo) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//받아온 값 디버깅
		System.out.println("PaymentDao#paymentDetail() regiNo --> "+regiNo);
		
		//DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
				
		/* SELECT(조회화면에서 보여줄 것)
		 * pet, customer : 동물이름, 보호자이름 
		 * payment : 접수번호
		 * 그 외 모든 결제정보(진료/검사/수술/입원/처방)
		*/
		String sql = "SELECT pay.regi_no regiNo"
				+ " , pet.pet_name petName" 
				+ " , c.customer_name customerName"
				+ " , pay.payment_state paymentState"
				+ " , cn.clinic_cost clinicCost"
				+ " , GROUP_CONCAT(DISTINCT  ek.examination_kind SEPARATOR ', ') examinationKind"
				+ " , SUM(DISTINCT ek.examination_cost) examinationCost"
				+ " , sg.surgery_kind surgeryKind"
				+ " , sk.surgery_cost surgeryCost"
				+ " , hr.room_name hospitalRoom"
				+ " , hr.cost hospitalCost"
				+ " , GROUP_CONCAT(DISTINCT md.medicine_name SEPARATOR ', ') medicineName"
				+ " , SUM(DISTINCT md.medicine_cost) medicineCost"
				+ " FROM payment pay"
				+ " INNER JOIN registration regi ON pay.regi_no = regi.regi_no" // 결제의 접수번호 = 접수의 접수번호
				+ " INNER JOIN pet pet ON regi.pet_no = pet.pet_no" // 접수의 동물번호 = 동물의 동물번호
				+ " INNER JOIN customer c ON pet.customer_no = c.customer_no" // 동물의 보호자번호 = 보호자의 보호자번호
				+ " LEFT JOIN clinic cn ON pay.regi_no = cn.regi_no" // 결제의 접수번호 = 진료의 접수번호
				+ " LEFT JOIN examination ex ON pay.regi_no = ex.regi_no" // 결제의 접수번 = 검사의 접수번호
				+ " LEFT JOIN examination_kind ek ON ex.examination_kind = ek.examination_kind" //검사의 검사종류 = 검사종류의 검사종류
				+ " LEFT JOIN surgery sg ON pay.regi_no = sg.regi_no" //결제의 접수번호 = 수술의 접수번호
				+ " LEFT JOIN surgery_kind sk ON sg.surgery_kind = sk.surgery_kind" //수술의 수술종류 = 수술종류의 수술종류
				+ " LEFT JOIN hospitalization hp ON pay.regi_no = hp.regi_no" //결제의 접수번호 = 입원의 접수번호
				+ " LEFT JOIN hospital_room hr ON hp.room_name = hr.room_name" //입원의 입원호실 = 입원호실의 입원호실
				+ " LEFT JOIN prescription ps ON regi.regi_no = ps.regi_no" //결제의 접수번호 = 처방의 접수번호
				+ " LEFT JOIN medicine md ON ps.medicine_no = md.medicine_no" //처방의 약번호 = 약의 약번호
				+ " WHERE pay.regi_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, regiNo);
		
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			map = new HashMap<>();
			map.put("regiNo", rs.getInt("regiNo"));							//접수번호
			map.put("petName", rs.getString("petName"));					//동물이름
			map.put("customerName", rs.getString("customerName"));			//보호자이름
			map.put("paymentState", rs.getString("paymentState"));			//결제상태
			map.put("clinicCost", rs.getInt("clinicCost"));					//진료비용
			map.put("examinationKind", rs.getString("examinationKind"));	//검사종류
			map.put("examinationCost", rs.getInt("examinationCost"));		//검사비용
			map.put("surgeryKind", rs.getString("surgeryKind"));			//수술종류
			map.put("surgeryCost", rs.getInt("surgeryCost"));				//수술비용
			map.put("hospitalRoom", rs.getString("hospitalRoom"));			//입원실
			map.put("hospitalCost", rs.getInt("hospitalCost"));				//입원비용
			map.put("medicineName", rs.getString("medicineName"));			//약이름
			map.put("medicineCost", rs.getInt("medicineCost"));				//약비용
		}
		
		System.out.println("PaymentDao#paymentDetail() map--> "+map);
		
		conn.close();
		return map;
	}
	
}
