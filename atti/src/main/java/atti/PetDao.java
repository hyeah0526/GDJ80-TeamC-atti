package atti;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class PetDao {
	/*
	 * 메소드: PetDao#petRegistration()
	 * 페이지: petRegiAction.jsp
	 * 시작 날짜: 2024-05-13
	 * 담당자: 김지훈
	*/
	public static int petRegistration(int customerNo, String major, String petKind, String petName, String petBirth) throws Exception {
		System.out.println("CustomerDao#petRegistration customerNo: " + customerNo);
		System.out.println("CustomerDao#petRegistration major: " + major);
		System.out.println("CustomerDao#petRegistration petKind" + petKind);
		System.out.println("CustomerDao#petRegistration petName" + petName);
		System.out.println("CustomerDao#petRegistration petBirth" + petBirth);
		
		int insertRow = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO pet(customer_no, emp_major, pet_kind,"
				+ " pet_name, pet_birth, create_date, update_date)"
				+ " VALUES(?, ?, ?, ?, ?, NOW(), NOW())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		stmt.setString(2, major);
		stmt.setString(3, petKind);
		stmt.setString(4, petName);
		stmt.setString(5, petBirth);
		
		insertRow = stmt.executeUpdate();
		conn.close();
		return insertRow;
	}
	
	
	/*
	 * 메소드: PetDao#petUpdate()
	 * 페이지: petUpdateAction.jsp
	 * 시작 날짜: 2024-05-13
	 * 담당자: 김지훈
	*/
	
	public static int petUpdate(int petNo, String petName) throws Exception {
		System.out.println("PetDao#petUpdate petNo: " + petNo);
		System.out.println("PetDao#petUpdate petName" + petName);
		
		int updateRow = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "UPDATE pet SET pet_name = ?"
				+ "WHERE pet_no = ?"; 
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, petName);
		stmt.setInt(2, petNo);
		
		System.out.println("PetDao#customerUpdate: " + stmt);
		updateRow = stmt.executeUpdate();
		
		conn.close();
		return updateRow;
	}
	
	/*
	 * 메소드: PetDao#petDetail()
	 * 페이지: petDetail.jsp
	 * 시작 날짜: 2024-05-13
	 * 담당자: 김지훈
	*/
	public static ArrayList<HashMap<String, Object>>petDetail(int petNo) throws Exception {
		ArrayList<HashMap<String, Object>> petDetail = new ArrayList<HashMap<String, Object>>();
		
		System.out.println("PetDao#petDetail petNo: " + petNo);
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT p.pet_no petNo, p.pet_kind petKind, p.pet_birth petBirth, p.pet_name petName,"
				+ " p.emp_major major, c.customer_no customerNo, c.customer_name customerName,"
				+ " c.customer_tel customerTel"
				+ " FROM pet p"
				+ " INNER JOIN customer c"
				+ " ON p.customer_no = c.customer_no"
				+ " WHERE pet_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, petNo);
		
		System.out.println("PetDao.petDetail: " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("petNo", rs.getInt("petNo"));
			m.put("petKind", rs.getString("petKind"));
			m.put("petBirth", rs.getString("petBirth"));
			m.put("petName", rs.getString("petName"));
			m.put("major", rs.getString("major"));
			m.put("customerNo", rs.getInt("customerNo"));
			m.put("customerName", rs.getString("customerName"));
			m.put("customerTel", rs.getString("customerTel"));
			petDetail.add(m);
		}
		conn.close();
		
		return petDetail;
	}
	
	

	/*
	 * 메소드: PetDao#petSearch()
	 * 페이지: searchList.jsp
	 * 시작 날짜: 2024-05-12
	 * 담당자: 김지훈
	*/
	
	public static ArrayList<HashMap<String, Object>> petSearch(String searchWord, int startRow, int rowPerPage) throws Exception {
		
		System.out.println("PetDao#petSearch searchWord: " + searchWord);
		System.out.println("PetDao#petSearch startRow: " + startRow);
		System.out.println("PetDao#petSearch rowPerPage: " + rowPerPage);
		
		ArrayList<HashMap<String, Object>> petSearch = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = null;
		
		if(searchWord != null) {
			sql = "SELECT p.pet_no petNo, p.pet_name petName, p.customer_no customerNo,"
				+ " p.create_date createDate, c.customer_name customerName"
				+ " FROM pet p"
				+ " LEFT JOIN customer c"
				+ " ON p.customer_no = c.customer_no"
				+ " WHERE p.pet_name LIKE ? OR c.customer_name LIKE ?"
				+ " ORDER BY p.create_date DESC"
				+ " LIMIT ?, ?";
		} else {
			sql = "SELECT p.pet_no petNo, p.pet_name petName, p.customer_no customerNo,"
				+ " p.create_date createDate, c.customer_name customerName"
				+ " FROM pet p"
				+ " LEFT JOIN customer c"
				+ " ON p.customer_no = c.customer_no"
				+ " ORDER BY p.create_date DESC"
				+ " LIMIT ?, ?";
		}
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		if(searchWord != null) {
			stmt.setString(1, "%" + searchWord + "%");
			stmt.setString(2, "%" + searchWord + "%");
			stmt.setInt(3, startRow);
			stmt.setInt(4, rowPerPage);
		} else {
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		}
		
		ResultSet rs = stmt.executeQuery();
		
		System.out.println("PetDao#petSearch: " + stmt);
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("petNo", rs.getInt("petNo"));
			m.put("customerNo", rs.getInt("customerNo"));
			m.put("petName", rs.getString("petName"));
			m.put("customerName", rs.getString("customerName"));
			m.put("createDate", rs.getString("createDate"));
			petSearch.add(m);
		}
		conn.close();
		return petSearch;
		
	}
}
