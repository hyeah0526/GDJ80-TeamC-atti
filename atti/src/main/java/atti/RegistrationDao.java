package atti;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class RegistrationDao {
	
	/*
	 * 메소드		: #regiStateStateUpdate(int regiNo) ==> 추후 regiDAO로 이동예정!
	 * 페이지		: paymentDetail.jsp
	 * 시작 날짜	: 2024-05-16
	 * 담당자		: 박혜아 
	*/
	public static int regiStateStateUpdate(int regiNo) throws Exception{
		int updateRow = 0;
		
		//받아온 값 디버깅
		//System.out.println("PaymentDao#regiStateStateUpdate() regiNo--> "+regiNo);
		
		//DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		
		// '진행' -> '완료'로 상태변경
		String sql = "UPDATE registration "
				+ " SET regi_state = '완료'"
				+ " WHERE regi_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, regiNo);
		//System.out.println("PaymentDao#regiStateStateUpdate() stmt --> "+stmt);
		
		updateRow = stmt.executeUpdate();
		System.out.println("PaymentDao#paymentStateUpdate() updateRow --> "+updateRow);
		
		conn.close();
		return updateRow;
	}

	
	/*
	 * 메소드		: RegistrationDao#regiList()
	 * 페이지		: regiList.jsp
	 * 시작 날짜	: 2024-05-20
	 * 담당자		: 한은혜
	*/
	public static ArrayList<HashMap<String, Object>> regiList(String date, int startRow, int rowPerPage) throws Exception{
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연결
		Connection conn = DBHelper.getConnection();
		
		// 디버깅 
		//System.out.println(date + " ====== RegistrationDao#regiList date");
		//System.out.println(startRow + " ====== RegistrationDao#regiList startRow");
		//System.out.println(rowPerPage + " ====== RegistrationDao#regiList rowPerPage");
			
		/*
		 *  접수 리스트 출력 쿼리 
		 *  조건 : regi_state = 예약, 대기 / regi_date = 오늘 날짜
		 * + 접수 정보(regi_no, regi_content, regi_state, regi_date) 
		 * + 동물 정보(pet_kind, pet_name) 
		 * + 의사정보(emp_no, emp_name) 
		 * + 총 행 개수
		 * + emp_no, pet_no로 left join
		 * + 오름차순으로 정렬(regi_date가 가장 빠른 것부터 보이도록)
		 * + 페이징
		 */
		String sql = "SELECT regi_no regiNo, regi_content regiContent, regi_state regiState, regi_date regiDate,"
				+ " pet_name petName, pet_kind petKind,"
				+ " r.emp_no empNo, emp_name empName,"
				+ " COUNT(*) OVER() totalRow "		
				+ " FROM registration r"
				+ " LEFT JOIN pet p"
				+ " ON r.pet_no = p.pet_no"
				+ " LEFT JOIN employee e"
				+ " ON r.emp_no = e.emp_no"
				+ " WHERE DATE(regi_date) LIKE ?"
				+ " AND (r.regi_state = '예약' OR r.regi_state = '대기')"	// regi_state가 예약 또는 대기인 것
				+ " ORDER BY regi_date ASC"
				+ " LIMIT ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + date + "%");
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		
		//System.out.println(stmt + " ====== RegistrationDao#regiList stmt");

		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> regiList = new HashMap<String, Object>();
			regiList.put("regiNo", rs.getInt("regiNo"));
			regiList.put("regiContent", rs.getString("regiContent"));	
			regiList.put("regiState", rs.getString("regiState"));	
			regiList.put("regiDate", rs.getString("regiDate"));	
			regiList.put("petName", rs.getString("petName"));	
			regiList.put("petKind", rs.getString("petKind"));	
			regiList.put("empNo", rs.getInt("empNo"));	
			regiList.put("empName", rs.getString("empName"));	
			regiList.put("totalRow", rs.getInt("totalRow"));	
		
			list.add(regiList);
		}
		conn.close();
		return list;
	}
	
	/*
	 * 메소드		: RegistrationDao#regiCancel()
	 * 페이지		: regiList.jsp
	 * 시작 날짜	: 2024-05-20
	 * 담당자		: 한은혜
	*/
	public static int regiCancel(int regiNo, String regiState) throws Exception{
		int updateRow = 0;
		// 예약, 접수 리스트의 취소 버튼값 바꿔주기 
		if(regiState.equals("예약취소") || regiState.equals("접수취소")) {
			regiState = "취소";
		}
		//받아온 값 디버깅
		//System.out.println(regiNo + " ====== RegistrationDao##regiCancel() regiNo");
		//System.out.println(regiState + " ====== RegistrationDao##regiCancel() regiState");

		//DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		
		// 접수 상태 변경 쿼리
		String sql = "UPDATE registration"
				+ " SET regi_state = ?"
				+ " WHERE regi_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, regiState);
		stmt.setInt(2, regiNo);
		//System.out.println(stmt + " ====== RegistrationDao##regiCancel() stmt");
		
		updateRow = stmt.executeUpdate();
		System.out.println(updateRow + " ====== RegistrationDao##regiCancel() updateRow");
		
		conn.close();
		return updateRow;
	}
	
	/*
	 * 메소드		: RegistrationDao#rsvnList()
	 * 페이지		: reservationList.jsp
	 * 시작 날짜	: 2024-05-20
	 * 담당자		: 한은혜
	*/
	public static ArrayList<HashMap<String, Object>> rsvnList(String searchDate, String searchWord) throws Exception{
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연결
		Connection conn = DBHelper.getConnection();
		// 디버깅 
		//System.out.println(searchDate + " ====== RegistrationDao#rsvnList() searchDate");
		//System.out.println(searchWord + " ====== RegistrationDao#rsvnList() searchWord");
		
		/*
		 * 예약 리스트 쿼리 
		 * + 접수 정보(regi_no, regi_content, regi_state, regi_date) 
		 * + 동물 정보(pet_kind, pet_name) 
		 * + 보호자 정보(customer_tel) 
		 * + 의사정보(emp_no, emp_name)
		 * + 총 행 개수 
		 * + regi_date --> searchDate로 검색 
		 * + customer_tel, pet_name, customer_name --> searchWord로 검색 
		 */
		String sql = "SELECT "
				+ " regi_no regiNo, regi_content regiContent, regi_state regiState, regi_date regiDate,"
				+ " pet_name petName, pet_kind petKind,"
				+ " customer_name customerName, customer_tel customerTel,"
				+ " r.emp_no empNo, emp_name empName,"
				+ " COUNT (*) OVER() totalRow"
				+ " FROM registration r"
				+ " LEFT JOIN pet p"
				+ " ON r.pet_no = p.pet_no"
				+ " LEFT JOIN employee e"
				+ " ON r.emp_no = e.emp_no"
				+ " LEFT JOIN customer c"
				+ " ON p.customer_no = c.customer_no "
				+ " WHERE r.regi_state = '예약'"			// regi_state가 예약인 것 중에서
				+ " AND DATE(regi_date) LIKE ?"			// 날짜 검색 
				+ " AND (customer_tel LIKE ?"			// 단어 검색
				+ " OR p.pet_name LIKE ?"
				+ " OR customer_name LIKE ?)"
				+ " ORDER BY regi_date ASC";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchDate +"%");
		stmt.setString(2, "%"+searchWord +"%");
		stmt.setString(3, "%"+searchWord +"%");
		stmt.setString(4, "%"+searchWord +"%");
		
		//System.out.println(stmt + " ====== RegistrationDao#rsvnList() stmt");

		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> rsvnList = new HashMap<String, Object>();
			rsvnList.put("regiNo", rs.getInt("regiNo"));		
			rsvnList.put("regiContent", rs.getString("regiContent"));
			rsvnList.put("regiState", rs.getString("regiState"));
			rsvnList.put("regiDate", rs.getString("regiDate"));
			rsvnList.put("petName", rs.getString("petName"));
			rsvnList.put("petKind", rs.getString("petKind"));
			rsvnList.put("customerName", rs.getString("customerName"));
			rsvnList.put("customerTel", rs.getString("customerTel"));
			rsvnList.put("empNo", rs.getInt("empNo"));
			rsvnList.put("empName", rs.getString("empName"));
			rsvnList.put("totalRow", rs.getInt("totalRow"));
		
			list.add(rsvnList);
		}
		conn.close();
		return list;
	}
	
}
