package atti;


import java.sql.*;
import java.util.*;

public class CustomerDao {
	
	/*
	 * 메소드: CustomerDao#searchCustomerCount()
	 * 페이지: searchList.jsp
	 * 시작 날짜: 2024-05-16
	 * 담당자: 김지훈
	*/
	
	public static int searchCustomerCount(String searchWord) throws Exception {
		// 검색된 값을 확인
		// System.out.println("CustomerDao#searchCustomerCount searchWord: " + searchWord);

		int cnt = 0; 
		Connection conn = DBHelper.getConnection();
		
		// 전체 row의 개수 구하기
		String sql = "SELECT COUNT(*) cnt"
				+ " FROM customer c"
				+ " LEFT JOIN pet p"
				+ " ON c.customer_no = p.pet_no";
		if(searchWord != null) {
			sql += " WHERE c.customer_name LIKE ?"
				+ " OR c.customer_tel LIKE ?";
		}
		PreparedStatement stmt = conn.prepareStatement(sql);
		if(searchWord != null) {
			stmt.setString(1, "%" + searchWord + "%");
			stmt.setString(2, "%" + searchWord + "%");
		}
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			cnt = rs.getInt(1);
		}
		
		conn.close();
		return cnt;
	}
	
	/*
	 * 메소드: CustomerDao#searchAllCount()
	 * 페이지: searchList.jsp
	 * 시작 날짜: 2024-05-16
	 * 담당자: 김지훈
	*/
	
	public static int searchAllCount(String searchWord) throws Exception {
		
		// 검색된 값을 확인
		// System.out.println("CustomerDao#searchAllCount searchWord: " + searchWord);
		
		int cnt = 0; // SELECT한 ROW의 총 개수

		Connection conn = DBHelper.getConnection();
		
		// 전체 row의 개수 구하기
		String sql = "SELECT COUNT(*) cnt"
				+ " FROM customer c"
				+ " INNER JOIN pet p"
				+ " ON c.customer_no = p.customer_no";
		
		if(searchWord != null) {
			sql += " WHERE c.customer_name LIKE ?" // 검색어가 customerName
				+ " OR c.customer_tel LIKE ?" // 또는 검색어가 customerTel
				+ " OR p.pet_name LIKE ?"; // 또는 검색어가 petName
		} // searchWord가 null이 아닐 경우(경색어가 있는 경우) 쿼리를 추가
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		if(searchWord != null) {
			stmt.setString(1, "%" + searchWord + "%"); // customerName
			stmt.setString(2, "%" + searchWord + "%"); // customerTel
			stmt.setString(3, "%" + searchWord + "%"); // petName
		}
		
		// 디버깅
		// System.out.println("CustomerDao#searchAllCount: " + stmt);
	
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			cnt = rs.getInt(1); // row의 개수 추출
		}
		conn.close();
		return cnt; // cnt를 반환
	}
	
	/*
	 * 메소드: CustomerDao#customerUpdate()
	 * 페이지: customerUpdateAction.jsp
	 * 시작 날짜: 2024-05-13
	 * 담당자: 김지훈
	*/
	
	public static int customerUpdate(int customerNo, String customerTel, String customerAddress) throws Exception {
		
		// updateForm -> updateAction 넘어온 데이터를 확인
		// System.out.println("CustomerDao#customerUpdate customerNo: " + customerNo);
		// System.out.println("CustomerDao#customerUpdate customerTel:" + customerTel);
		// System.out.println("CustomerDao#customerUpdate customerAddress:" + customerAddress);
		
		int updateRow = 0;
		
		Connection conn = DBHelper.getConnection();
		
		// 고객의 정보를 수정
		String sql = "UPDATE customer SET customer_tel = ?," // 변경 희망하는 전화번호 
				+ " customer_address = ?" // 변경 희망하는 주소
				+ " WHERE customer_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerTel);
		stmt.setString(2, customerAddress);
		stmt.setInt(3, customerNo);
		
		// 디버깅
		// System.out.println("CustomerDao#customerUpdate: " + stmt);
		
		updateRow = stmt.executeUpdate();
		
		conn.close(); // conn 반납
		return updateRow; // 위 메소드 실행 후 updateRow 반환
	}
	
	
	/*
	 * 메소드: CustomerDao#searchAll()
	 * 페이지: searchList.jsp
	 * 시작 날짜: 2024-05-12
	 * 담당자: 김지훈
	*/
	public static ArrayList<HashMap<String, Object>> searchAll(String searchWord, int startRow, int rowPerPage) throws Exception {
		
		// searchList에서 넘어온 searchWord, startRow, rowPerPage를 확인
		
		// 디버깅
		// System.out.println("CustomerDao#customerUpdate searchAll: " + searchWord);
		// System.out.println("CustomerDao#customerUpdate searchAll" + startRow);
		// System.out.println("CustomerDao#customerUpdate searchAll" + rowPerPage);
		
		ArrayList<HashMap<String, Object>> searchAll = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = null;
		if(searchWord != null) { // searchWord가 null이 아닐 경우
			sql = "SELECT c.customer_no customerNo, c.customer_name customerName,"
				+ " c.customer_tel customerTel, p.pet_no petNo, p.pet_name petName, p.create_date createDate"
				+ " FROM customer c"
				+ " INNER JOIN pet p"
				+ " ON c.customer_no = p.customer_no"
				+ " WHERE c.customer_name LIKE ?" // 검색어가 customerName
				+ " OR c.customer_tel LIKE ?" // 또는 검색어가 customerTel
				+ " OR p.pet_name LIKE ?" // 또는 검색어가 petName
				+ " ORDER BY p.create_date DESC"
				+ " LIMIT ?, ?"; // n부터 n개까지			
		} else {
			sql = "SELECT c.customer_no customerNo, c.customer_name customerName,"
				+ " c.customer_tel customerTel, p.pet_no petNo, p.pet_name petName, p.create_date createDate"
				+ " FROM customer c"
				+ " INNER JOIN pet p"
				+ " ON c.customer_no = p.customer_no"
				+ " ORDER BY p.create_date DESC"
				+ " LIMIT ?, ?"; // n부터 n개까지	
		}
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// 디버깅
		// System.out.println("CustomerDao#customerUpdate: " + stmt);
		
		if(searchWord != null) { // 검색어가 null이 아닐 경우
			stmt.setString(1, "%" + searchWord + "%"); // customerName
			stmt.setString(2, "%" + searchWord + "%"); // customerTel
			stmt.setString(3, "%" + searchWord + "%"); // petName
			stmt.setInt(4, startRow);
			stmt.setInt(5, rowPerPage);
		} else { // 검색어가 null일 경우
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);	
		}
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("customerNo", rs.getInt("customerNo")); // customer table
			m.put("customerName", rs.getString("customerName")); // customer table
			m.put("customerTel", rs.getString("customerTel")); // customer table
			m.put("petNo", rs.getInt("petNo")); // pet table
			m.put("petName", rs.getString("petName")); // pet table
			m.put("createDate", rs.getString("createDate")); // pet table
			searchAll.add(m);
		}
		
		conn.close(); // conn 반환
		return searchAll; // 메소드 실행 후 searchAll 반환
	}
	
	
	/*
	 * 메소드: CustomerDao#customerSearch()
	 * 페이지: searchList.jsp
	 * 시작 날짜: 2024-05-11
	 * 담당자: 김지훈
	*/
	
	public static ArrayList<HashMap<String, Object>> customerSearch(String searchWord, int startRow, int rowPerPage) throws Exception {
		
		// searchList에서 넘어온 searchWord, startRow, rowPerPage를 확인
		// 디버깅
		// System.out.println("CustomerDao#customerUpdate customerSearch searchWord: " + searchWord);
		// System.out.println("CustomerDao#customerUpdate customerSearch startRow: " + startRow);
		// System.out.println("CustomerDao#customerUpdate customerSearch rowPerPage: " + rowPerPage);
		
		ArrayList<HashMap<String, Object>> customerSearch = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = null;
		
		if(searchWord != null) { // 검색어가 null이 아닐 경우
			sql = "SELECT c.customer_no customerNo, c.customer_name customerName,"
				+ " c.customer_tel customerTel,"
				+ " COUNT(p.pet_no) petCnt, c.create_date createDate"
				+ " FROM customer c "
				+ " LEFT JOIN pet p"
				+ " ON c.customer_no = p.customer_no"
				+ " WHERE c.customer_name LIKE ? OR c.customer_tel LIKE ?"
				+ " GROUP BY c.customer_no, c.customer_name, c.customer_tel"
				+ " ORDER BY c.create_date DESC"
				+ " LIMIT ?, ?";
		} else { // 검색어가 null일 경우
			sql = "SELECT c.customer_no customerNo, c.customer_name customerName,"
				+ " c.customer_tel customerTel,"
				+ " COUNT(p.pet_no) petCnt, c.create_date createDate"
				+ " FROM customer c "
				+ " LEFT JOIN pet p"
				+ " ON c.customer_no = p.customer_no"
				+ " GROUP BY c.customer_no, c.customer_name, c.customer_tel"
				+ " ORDER BY c.create_date DESC"
				+ " LIMIT ?, ?";
		}
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// 디버깅
		// System.out.println("CustomerDao#customerUpdate customerSearch: " + stmt);
		
		if(searchWord != null) { // 검색어가 null이 아닐 경우
			stmt.setString(1, "%" + searchWord + "%"); // customerName
			stmt.setString(2, "%" + searchWord + "%"); // customerTel
			stmt.setInt(3, startRow);
			stmt.setInt(4, rowPerPage);
		} else {
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		}
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("customerNo", rs.getInt("customerNo")); // customer table
			m.put("customerName", rs.getString("customerName")); // customer table
			m.put("customerTel", rs.getString("customerTel")); // customer table
			m.put("petCnt", rs.getInt("petCnt")); // pet table - customerNo에 속하는 pet의 수
			m.put("createDate", rs.getString("createDate")); // customer table
			customerSearch.add(m);
		}
		conn.close(); // conn 자원 반납
		return customerSearch; // 메소드 실행 후 customerSearch 반환
		
	}
	
	/*
	 * 메소드: CustomerDao#customerDetail()
	 * 페이지: customerDetail.jsp
	 * 시작 날짜: 2024-05-10
	 * 담당자: 김지훈
	*/	
	
	public static ArrayList<HashMap<String, Object>>customerDetail(int customerNo) throws Exception {
		ArrayList<HashMap<String, Object>> customerDetail = new ArrayList<HashMap<String, Object>>();
		
		// 각 페이지에서 넘어온 customerNo값을 확인
		// System.out.println("CustomerDao#customerDetail customerNo: " + customerNo);
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT *"
				+ " FROM customer"
				+ " WHERE customer_no =?"; // customerNo에 따라 다른 값을 출력
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		
		// 디버깅
		// System.out.println("CustomerDao#customerDetail: " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("customerNo", rs.getInt("customer_no"));
			m.put("customerName", rs.getString("customer_name"));
			m.put("customerTel", rs.getString("customer_tel"));
			m.put("customerAddress", rs.getString("customer_address"));
			customerDetail.add(m);
		}
		conn.close(); // conn 자원 반납
		
		return customerDetail; // 위 메소드 실행 후 customerDetail 반납
	}
	
	
	/*
	 * 메소드: CustomerDao#customerRegistration()
	 * 페이지: customerRegiAction.jsp
	 * 시작 날짜: 2024-05-10
	 * 담당자: 김지훈
	*/
	public static int customerRegistration(String customerName, String customerTel, String customerAddress) throws Exception {
		
		// 디버깅
		// customerRegiForm -> customerRegiAction 매개 변수값 확인
		// System.out.println("CustomerDao#customerRegistration customerName: " + customerName);
		// System.out.println("CustomerDao#customerRegistration customerTel: " + customerTel);
		// System.out.println("CustomerDao#customerRegistration customerAddress: " + customerAddress);
		
		
		int customerNo = 0; 
		int row = 0;

		// DB 연결 
		Connection conn = DBHelper.getConnection();
		
		// 고객의 정보를 등록하는 쿼리
		String sql = "INSERT INTO customer(customer_name, customer_tel, customer_address, create_date, update_date)"
				+ " VALUES(?, ?, ?, NOW(), NOW())";
		
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
																// DB 내에서 customerNo를 생성과 동시에 추출
		stmt.setString(1, customerName);
		stmt.setString(2, customerTel);
		stmt.setString(3, customerAddress);
		
		// 디버깅
		// System.out.println("CustomerDao#customerRegistration: " + stmt);
		
		row = stmt.executeUpdate();
		
		if(row > 0) {
			ResultSet generatedKeys = stmt.getGeneratedKeys();
			if(generatedKeys.next()) {
				customerNo = generatedKeys.getInt(1); // DB 내 첫 번째 컬럼을 추출
			}
			generatedKeys.close(); // 실행 후 키 리소스 해제
		}
		
		conn.close(); // 자원 반납
		
		return customerNo; // 메소드 실행 후 customerNo를 반환
	}
}