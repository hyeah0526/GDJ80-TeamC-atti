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
		System.out.println("PaymentDao#regiStateStateUpdate() regiNo--> "+regiNo);
		
		//DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		
		// '진행' -> '완료'로 상태변경
		String sql = "UPDATE registration "
				+ " SET regi_state = '완료'"
				+ " WHERE regi_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, regiNo);
		System.out.println("PaymentDao#regiStateStateUpdate() stmt --> "+stmt);
		
		updateRow = stmt.executeUpdate();
		System.out.println("PaymentDao#paymentStateUpdate() updateRow --> "+updateRow);
		
		conn.close();
		return updateRow;
	}

	
	/*
	 * 메소드		: RegistrationDao##regiList()
	 * 페이지		: regiList.jsp
	 * 시작 날짜	: 2024-05-20
	 * 담당자		: 한은혜
	*/
	public static ArrayList<HashMap<String, Object>> regiList(String date, int startRow, int rowPerPage) throws Exception{
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연결
		Connection conn = DBHelper.getConnection();
		
		// 디버깅 
		System.out.println(date + " ====== RegistrationDao#regiList date");
		System.out.println(startRow + " ====== RegistrationDao#regiList startRow");
		System.out.println(rowPerPage + " ====== RegistrationDao#regiList rowPerPage");
			
		/*
		 *  접수 리스트 출력 쿼리 
		 *  조건 : regi_state = 예약, 대기 / regi_date = 오늘 날짜
		 * + 접수 정보(regi_no, regi_content, regi_state, regi_date) 
		 * + 동물 정보(pet_kind, pet_name) 
		 * + 의사정보(emp_no, emp_name) 
		 * + 총 행 개수
		 * + emp_no, pet_no로 left join
		 * + 페이징
		 */
		
		String sql = "SELECT regi_no regiNo, regi_content regiContent, regi_state regiState, regi_date regiDate,"
				+ " pet_name petName, pet_kind petKind,"
				+ " r.emp_no empNo, emp_name empName,"
				+ " (SELECT COUNT (*) FROM "
				+ "		(SELECT r2.regi_no FROM registration r2"
				+ "		WHERE DATE(regi_date) LIKE ?"
				+ "		AND (r2.regi_state = '예약' OR r2.regi_state = '대기')) cnt) totalRow"
				+ " FROM registration r"
				+ " LEFT JOIN pet p"
				+ " ON r.pet_no = p.pet_no"
				+ " LEFT JOIN employee e"
				+ " ON r.emp_no = e.emp_no"
				+ " WHERE DATE(regi_date) LIKE ?"
				+ " AND (r.regi_state = '예약' OR r.regi_state = '대기')"
				+ " ORDER BY regi_date DESC"
				+ " LIMIT ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + date + "%");
		stmt.setString(2, "%" + date + "%");
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage);
		
		System.out.println(stmt + " ====== RegistrationDao#regiList stmt");

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
	 * 메소드		: RegistrationDao##regiCancel()
	 * 페이지		: regiList.jsp
	 * 시작 날짜	: 2024-05-20
	 * 담당자		: 한은혜
	*/
	public static int regiCancel(int regiNo) throws Exception{
		int updateRow = 0;
		
		//받아온 값 디버깅
		System.out.println(regiNo + " ====== RegistrationDao##regiCancel() regiNo");
		
		//DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		
		// 접수 대기/예약 취소
		String sql = "UPDATE registration"
				+ "SET regi_state = '취소'"
				+ "WHERE regi_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, regiNo);
		System.out.println("PaymentDao#regiStateStateUpdate() stmt --> "+stmt);
		
		updateRow = stmt.executeUpdate();
		System.out.println(updateRow + " ====== ");
		
		conn.close();
		return updateRow;
	}
	
	
}
