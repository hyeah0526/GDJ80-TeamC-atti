package atti;


import java.sql.*;
import java.util.*;

public class CustomerDao {

	
	/*
	 * 메소드: CustomerDao#customerDetail()
	 * 페이지: customerDetail.jsp
	 * 시작 날짜: 2024-05-10
	 * 담당자: 김지훈
	*/	
	
	public static ArrayList<HashMap<String, Object>>customerDetail() throws Exception {
		ArrayList<HashMap<String, Object>> customerDetail = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT *"
				+ " FROM customer"
				+ " WHERE customer_no =?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("customerNo", "customer_no");
			m.put("customerName", "customer_name");
			m.put("customerTel", "customer_tel");
			m.put("customerAddress", "customer_address");
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
		
		
		int customerNo = 0; // customerNo를 생성과 동시에 추출
		int row = 0;

		// DB 연결 
		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO customer(customer_name, customer_tel, customer_address, create_date, update_date)"
				+ " VALUES(?, ?, ?, NOW(), NOW())";
		
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		
		stmt.setString(1, customerName);
		stmt.setString(2, customerTel);
		stmt.setString(3, customerAddress);
		
		System.out.println("CustomerDao.customerRegistration: " + stmt);
		
		
		row = stmt.executeUpdate();
		
		
		if(row > 0) {
			ResultSet generatedKeys = stmt.getGeneratedKeys();
			if(generatedKeys.next()) {
				customerNo = generatedKeys.getInt(1);
			}
			generatedKeys.close(); // 실행 후 키 리소스 해제
		}
		
		conn.close();
		
		return customerNo;
	}
}
