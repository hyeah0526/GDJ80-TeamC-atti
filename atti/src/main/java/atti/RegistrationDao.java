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
	
	/*
	 * 메소드		: RegistrationDao#regiAccept()
	 * 페이지		: regiAction.jsp
	 * 시작 날짜	: 2024-05-22
	 * 담당자		: 한은혜
	*/
	public static int regiAccept(int empNo, int petNo, String regiContent, String regiDate, String regiState) throws Exception{

		int insertRow = 0;
		
		System.out.println(regiDate + "ㅎㅎㅎ확인 RegistrationDao#regiAccept() regiDate");
		// DB연결
		Connection conn = DBHelper.getConnection();
		/*
		 * 접수 등록 쿼리
		 * 의사, 접수내용, 접수상태, 진료날짜, 진료시간
		*/
		String sql = "INSERT INTO registration "
				+ "		(emp_no, pet_no, regi_content, create_date, regi_date, regi_state)"
				+ "		VALUES(?, ?, ?, NOW(), ?, ?)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, empNo);
		stmt.setInt(2, petNo);
		stmt.setString(3, regiContent);
		stmt.setString(4, regiDate);
		stmt.setString(5, regiState);
		
		System.out.println(stmt + " ====== RegistrationDao#regiAccept() stmt");
	
		insertRow = stmt.executeUpdate();
		System.out.println(insertRow + " ====== RegistrationDao#regiAccept() insertRow");
		
		conn.close();
		return insertRow;
	}
	
	/*
	 * 메소드		: RegistrationDao#regiInfo() 
	 * 페이지		: regiAction.jsp
	 * 시작 날짜	: 2024-05-22
	 * 담당자		: 한은혜
	*/
	public static HashMap<String, Object> regiInfo(int petNo) throws Exception{
		System.out.println(petNo + " ====== RegistrationDao#regiInfo() petNo");
		
		// DB연결
		Connection conn = DBHelper.getConnection();
		
		// petKind를 가져오는 첫번째 쿼리
		String sql1 = "SELECT pet_kind petKind"
				+ " FROM pet p"
				+ " WHERE pet_no = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setInt(1, petNo);
		
		String petKind = null;
		ResultSet rs1 = stmt1.executeQuery();
		if(rs1.next()) {
			
			petKind = rs1.getString("petKind");
		}
		System.out.println(petKind + " ====== RegistrationDao#regiInfo() petKind");
		
		// emp 정보를 가져오는 두번째 쿼리
		String sql2 = "SELECT emp_no empNo, emp_name empName"
				+ " FROM employee "
				+ " WHERE emp_no LIKE '1%'" // 의사 사번 조건 
				+ " OR emp_no LIKE '2%'";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		ResultSet rs2 = stmt2.executeQuery();
		
		ArrayList<HashMap<String, Object>> emplist = new ArrayList<HashMap<String, Object>>();
		while(rs2.next()) {
			HashMap<String, Object> empList = new HashMap<String, Object>();
			empList.put("empNo", rs2.getInt("empNo"));		
			empList.put("empName", rs2.getString("empName"));
			
			emplist.add(empList);
		}
		
		System.out.println(emplist + " ====== RegistrationDao#regiInfo() list");
		
		// 두 쿼리의 결과값을 하나의 HashMap에 넣기
        HashMap<String, Object> regiInfo = new HashMap<>();
        regiInfo.put("petKind", petKind);
        regiInfo.put("emplist", emplist);
		
        System.out.println(regiInfo + " ====== RegistrationDao#regiInfo() regiInfo");
        
		conn.close();
		return regiInfo;
	}
	
}
