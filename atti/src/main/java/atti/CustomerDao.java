package atti;


import java.sql.*;
import java.util.*;

public class CustomerDao {
	
	/*
	 * 메소드: CustomerDao#searchAll()
	 * 페이지: searchList.jsp
	 * 시작 날짜: 2024-05-12
	 * 담당자: 김지훈
	*/
	public static ArrayList<HashMap<String, Object>> searchAll() throws Exception {
		ArrayList<HashMap<String, Object>> searchAll = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT c.customer_no customerNo, c.customer_name customerName"
				+ " , c.customer_tel customerTel, p.pet_name petName, p.create_date createDate"
				+ " FROM customer c"
				+ " INNER JOIN pet p"
				+ " ON c.customer_no = p.customer_no"
				+ " ORDER BY p.create_date DESC";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("customerNo", rs.getInt("customerNo"));
			m.put("customerName", rs.getString("customerName"));
			m.put("customerTel", rs.getString("customerTel"));
			m.put("petName", rs.getString("petName"));
			m.put("createDate", rs.getString("createDate"));
			searchAll.add(m);
		}
		
		conn.close();
		return searchAll;
	}
	
	
	/*
	 * 메소드: CustomerDao#customerSearch()
	 * 페이지: searchList.jsp
	 * 시작 날짜: 2024-05-11
	 * 담당자: 김지훈
	*/
	
	public static ArrayList<HashMap<String, Object>> customerSearch() throws Exception {
		ArrayList<HashMap<String, Object>> customerSearch = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT *"
				+ " FROM customer"
				+ " ORDER BY customer_no DESC";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("customerNo", rs.getInt("customer_no"));
			m.put("customerName", rs.getString("customer_name"));
			m.put("customerTel", rs.getString("customer_tel"));
			customerSearch.add(m);
		}
		conn.close();
		return customerSearch;
		
	}
	
	/*
	 * 메소드: CustomerDao#customerDetail()
	 * 페이지: customerDetail.jsp
	 * 시작 날짜: 2024-05-10
	 * 담당자: 김지훈
	*/	
	
	public static ArrayList<HashMap<String, Object>>customerDetail(int customerNo) throws Exception {
		ArrayList<HashMap<String, Object>> customerDetail = new ArrayList<HashMap<String, Object>>();
		
		System.out.println("CustomerDao.customerDetail customerNo: " + customerNo);
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT *"
				+ " FROM customer"
				+ " WHERE customer_no =?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		
		System.out.println("CustomerDao.customerDetail: " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("customerNo", rs.getInt("customer_no"));
			m.put("customerName", rs.getString("customer_name"));
			m.put("customerTel", rs.getString("customer_tel"));
			m.put("customerAddress", rs.getString("customer_address"));
			customerDetail.add(m);
		}
		conn.close();
		
		return customerDetail;
	}
	
	
	/*
	 * 메소드: CustomerDao#customerRegistration()
	 * 페이지: customerRegiAction.jsp
	 * 시작 날짜: 2024-05-10
	 * 담당자: 김지훈
	*/
	public static int customerRegistration(String customerName, String customerTel, String customerAddress) throws Exception {
		
		// customerRegiForm -> customerRegiAction 매개 변수값 확인
		System.out.println("CustomerDao.customerRegistration customerName: " + customerName);
		System.out.println("CustomerDao.customerRegistration customerTel: " + customerTel);
		System.out.println("CustomerDao.customerRegistration customerAddress: " + customerAddress);
		
		
		int customerNo = 0; 
		int row = 0;

		// DB 연결 
		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO customer(customer_name, customer_tel, customer_address, create_date, update_date)"
				+ " VALUES(?, ?, ?, NOW(), NOW())";
		
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
																// DB 내에서 customerNo를 생성과 동시에 추출
		stmt.setString(1, customerName);
		stmt.setString(2, customerTel);
		stmt.setString(3, customerAddress);
		
		System.out.println("CustomerDao.customerRegistration: " + stmt);
		
		
		row = stmt.executeUpdate();
		
		
		if(row > 0) {
			ResultSet generatedKeys = stmt.getGeneratedKeys();
			if(generatedKeys.next()) {
				customerNo = generatedKeys.getInt(1); // DB 내 첫 번째 컬럼을 추출
			}
			generatedKeys.close(); // 실행 후 키 리소스 해제
		}
		
		conn.close(); // 자원 반납
		
		return customerNo; // customerNo를 반환
	}
}
