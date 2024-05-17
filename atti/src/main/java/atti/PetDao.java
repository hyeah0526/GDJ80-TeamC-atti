package atti;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class PetDao {
	
	/*
	 * 메소드: PetDao#searchPetCount()
	 * 페이지: searchList.jsp
	 * 시작 날짜: 2024-05-16
	 * 담당자: 김지훈
	*/
	public static int searchPetCount(String searchWord) throws Exception {
		
		// 검색된 searchWord값을 확인
		// System.out.println("PetDao#searchPetCount searchWord: " + searchWord);
		
		int cnt = 0;

		Connection conn = DBHelper.getConnection();
		
		// 전체 row의 개수 구하기
		String sql = "SELECT COUNT(*) cnt"
				+ " FROM pet p "
				+ " LEFT JOIN customer c "
				+ " ON p.customer_no = c.customer_no";
	    if (searchWord != null) {
	        sql += " WHERE p.pet_name LIKE ?"
        		+ " OR c.customer_name LIKE ?";
	    }
	    
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    if (searchWord != null) {
	        stmt.setString(1, "%" + searchWord + "%");
	        stmt.setString(2, "%" + searchWord + "%");
	    }
	    
	    ResultSet rs = stmt.executeQuery();
		
	    if (rs.next()) {
	        cnt = rs.getInt(1);
	    }
		conn.close();
		
		return cnt;
	}
	/*
	 * 메소드: PetDao#petByCustomer()
	 * 페이지: customerDetail.jsp
	 * 시작 날짜: 2024-05-14
	 * 담당자: 김지훈
	*/
	public static ArrayList<HashMap<String, Object>> petByCustomer(int customerNo) throws Exception {
		
		// customerNo값을 확인
		// System.out.println("PetDao#petByCustomer customerNo: " + customerNo);
		
		ArrayList<HashMap<String, Object>> petByCustomer = new ArrayList<HashMap<String, Object>>();
		
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT p.pet_no petNo, p.pet_name petName, r.regi_date regiDate"
				+ " FROM pet p"
				+ " LEFT JOIN registration r"
				+ " ON p.pet_no = r.pet_no"
				+ " WHERE p.customer_no = ?"
				+ " AND r.regi_date = (SELECT MAX(r.regi_date) FROM registration r WHERE r.pet_no = p.pet_no)"
				+ " ORDER BY r.regi_no DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		// 디버깅
		// System.out.println("PetDao#petByCustomer: " + stmt);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("petNo", rs.getInt("petNo")); // pet table
			m.put("petName", rs.getString("petName")); // pet table
			m.put("regiDate", rs.getString("regiDate")); // registration table
			petByCustomer.add(m);
		}
		conn.close(); // conn 반환
		return petByCustomer; // 위 메소드 실행 후 petBycustomer를 반환
	}
	
	
	/*
	 * 메소드: PetDao#petRegistration()
	 * 페이지: petRegiAction.jsp
	 * 시작 날짜: 2024-05-13
	 * 담당자: 김지훈
	*/
	public static int petRegistration(int customerNo, String empMajor, String petKind, String petName, String petBirth) throws Exception {
		
		// regiForm -> regiAction으로 넘어온 값을 확인
		// 디버깅
		//System.out.println("CustomerDao#petRegistration customerNo: " + customerNo);
		//System.out.println("CustomerDao#petRegistration empMajor: " + empMajor);
		//System.out.println("CustomerDao#petRegistration petKind" + petKind);
		//System.out.println("CustomerDao#petRegistration petName" + petName);
		//System.out.println("CustomerDao#petRegistration petBirth" + petBirth);
		
		int insertRow = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO pet(customer_no, emp_major, pet_kind,"
				+ " pet_name, pet_birth, create_date, update_date)"
				+ " VALUES(?, ?, ?, ?, ?, NOW(), NOW())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		stmt.setString(2, empMajor);
		stmt.setString(3, petKind);
		stmt.setString(4, petName);
		stmt.setString(5, petBirth);
		
		// 디버깅
		// System.out.println("PetDao#petRegistration: " + stmt);
		
		insertRow = stmt.executeUpdate();
		
		conn.close(); // conn 반환
		return insertRow; // 위 메소드 실행 후 insertRow 반환
	}
	
	
	/*
	 * 메소드: PetDao#petUpdate()
	 * 페이지: petUpdateAction.jsp
	 * 시작 날짜: 2024-05-13
	 * 담당자: 김지훈
	*/
	
	public static int petUpdate(int petNo, String petName) throws Exception {
		
		// petUpdateForm -> petUpdateAction으로 넘어온 값을 확인
		// System.out.println("PetDao#petUpdate petNo: " + petNo);
		// System.out.println("PetDao#petUpdate petName" + petName);
		
		int updateRow = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "UPDATE pet SET pet_name = ?"
				+ "WHERE pet_no = ?"; 
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, petName);
		stmt.setInt(2, petNo);
		
		// 디버깅
		// System.out.println("PetDao#customerUpdate: " + stmt);
		
		updateRow = stmt.executeUpdate();
		
		conn.close(); // conn 반환
		return updateRow; // 위 메소드 실행 후 updateRow 반환
	}
	
	/*
	 * 메소드: PetDao#petDetail()
	 * 페이지: petDetail.jsp
	 * 시작 날짜: 2024-05-13
	 * 담당자: 김지훈
	*/
	public static ArrayList<HashMap<String, Object>>petDetail(int petNo) throws Exception {
		ArrayList<HashMap<String, Object>> petDetail = new ArrayList<HashMap<String, Object>>();
		
		// 각 페이지에서 넘어온 petNo를 확인
		// System.out.println("PetDao#petDetail petNo: " + petNo);
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT p.pet_no petNo, p.pet_kind petKind, p.pet_birth petBirth, p.pet_name petName,"
				+ " p.emp_major empMajor, c.customer_no customerNo, c.customer_name customerName,"
				+ " c.customer_tel customerTel"
				+ " FROM pet p"
				+ " INNER JOIN customer c"
				+ " ON p.customer_no = c.customer_no"
				+ " WHERE pet_no = ?"; // petNo의 값에 따라 다른 값이 출력됨
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, petNo);
		
		// 디버깅
		// System.out.println("PetDao.petDetail: " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("petNo", rs.getInt("petNo")); // pet table
			m.put("petKind", rs.getString("petKind")); // pet table
			m.put("petBirth", rs.getString("petBirth")); // pet table
			m.put("petName", rs.getString("petName")); // pet table
			m.put("empMajor", rs.getString("empMajor")); // pet table
			m.put("customerNo", rs.getInt("customerNo")); // customer table
			m.put("customerName", rs.getString("customerName")); // customer table
			m.put("customerTel", rs.getString("customerTel")); // customer table
			petDetail.add(m);
		}
		conn.close(); // conn 반환
		
		return petDetail; // 위 메소드 실행 후 petDetail 반환
	}
	
	/*
	 * 메소드: PetDao#petSearch()
	 * 페이지: searchList.jsp
	 * 시작 날짜: 2024-05-12
	 * 담당자: 김지훈
	*/
	
	public static ArrayList<HashMap<String, Object>> petSearch(String searchWord, int startRow, int rowPerPage) throws Exception {
		
		// searchList에서 넘어온 searchWord, startRow, rowPerPage를 확인

		// System.out.println("PetDao#petSearch searchWord: " + searchWord);
		// System.out.println("PetDao#petSearch startRow: " + startRow);
		// System.out.println("PetDao#petSearch rowPerPage: " + rowPerPage);
		
		ArrayList<HashMap<String, Object>> petSearch = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = null;
		
		if(searchWord != null) { // 검색어가 null이 아닐 경우
			sql = "SELECT p.pet_no petNo, p.pet_name petName, p.customer_no customerNo,"
				+ " p.create_date createDate, c.customer_name customerName"
				+ " FROM pet p"
				+ " LEFT JOIN customer c"
				+ " ON p.customer_no = c.customer_no"
				+ " WHERE p.pet_name LIKE ? OR c.customer_name LIKE ?" // petName 또는 customerName에 검색 키워드가 포함된 값
				+ " ORDER BY p.create_date DESC"
				+ " LIMIT ?, ?"; // n부터 n개까지
		} else { // 검색어가 null일 경우
			sql = "SELECT p.pet_no petNo, p.pet_name petName, p.customer_no customerNo,"
				+ " p.create_date createDate, c.customer_name customerName"
				+ " FROM pet p"
				+ " LEFT JOIN customer c"
				+ " ON p.customer_no = c.customer_no"
				+ " ORDER BY p.create_date DESC"
				+ " LIMIT ?, ?"; // n부터 n개까지
		}
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		if(searchWord != null) { // 검색어가 null이 아닐 경우
			stmt.setString(1, "%" + searchWord + "%"); // petName
			stmt.setString(2, "%" + searchWord + "%"); // customerName
			stmt.setInt(3, startRow);
			stmt.setInt(4, rowPerPage);
		} else {
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		}
		
		ResultSet rs = stmt.executeQuery();
		
		// 디버깅
		// System.out.println("PetDao#petSearch: " + stmt);
		
		// petNo, customerNo, petName, customerName, createDate를 put
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("petNo", rs.getInt("petNo")); // pet table
			m.put("customerNo", rs.getInt("customerNo")); // pet table
			m.put("petName", rs.getString("petName")); // pet table
			m.put("customerName", rs.getString("customerName")); // customer table
			m.put("createDate", rs.getString("createDate")); // pet table
			petSearch.add(m);
		}
		conn.close(); // conn 반환
		return petSearch; // 위 메소드 실행 결과 petSearch를 반환함
		
	}
}
