package atti;

import java.sql.*;
import java.util.*;

public class SurgeryDao {
	
	/*
	 * 메소드 : SurgeryDao#surgeryList() 
	 * 페이지 : surgeryList.jsp
	 * 시작 날짜 : 2024-05-14
	 * 담당자 : 한은혜 
	 */
	public static ArrayList<HashMap<String, Object>> surgeryList(String searchDate, int startRow, int rowPerPage) throws Exception{
			
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연결
		Connection conn = DBHelper.getConnection();
		// 디버깅 
		System.out.println(searchDate + " ====== SurgeryDao#surgeryList() searchDate");
		System.out.println(startRow + " ====== SurgeryDao#surgeryList() startRow");
		System.out.println(rowPerPage + " ====== SurgeryDao#surgeryList() rowPerPage");
		
		/*
		 * 수술 리스트 출력 쿼리 
		 * 수술 정보(surgery_no, surgery_kind, surgery_date)
		 * + 접수번호(regi_no) 
		 * + 동물 정보(pet_kind, pet_name) 
		 * + 담당 의사 정보(emp_no, emp_name)
		 * + 총 행 수 세기(페이징)
		 * + 수술 날짜 내림차순(최신순)
		 * + 페이징
		 */
		String sql = "SELECT "
				+ " surgery_no surgeryNo, surgery_kind surgeryKind, surgery_state surgeryState, "
				+ " surgery_date surgeryDate, s.regi_no regiNo, "	 
				+ " pet_kind petKind, pet_name petName, " 
				+ " r.emp_no empNo, emp_name empName, "
				+ " (SELECT COUNT(surgery_no) FROM surgery"
				+ " WHERE DATE(surgery_date) LIKE ?) totalRow " 
				+ " FROM surgery s "
				+ " LEFT JOIN registration r "
				+ " ON s.regi_no = r.regi_no "			// 수술의 접수 번호 = 접수한 접수 번호
				+ " LEFT JOIN pet p "
				+ " ON r.pet_no = p.pet_no "			// 접수의 반려동물 번호 = 반려동물에서 반려동물 번호 
				+ " LEFT JOIN employee e "
				+ " ON r.emp_no = e.emp_no "			// 접수의 사번 = 직원의 사번 
				+ " WHERE DATE(s.surgery_date) LIKE ? "	// 수술 날짜가 언제인지 검색
				+ " ORDER BY s.surgery_date DESC"
				+ " LIMIT ?, ?"; 
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchDate +"%");
		stmt.setString(2, "%"+searchDate +"%");
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage);
		
		System.out.println(stmt + " ====== SurgeryDao#surgeryList stmt");
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> surgerylist = new HashMap<String, Object>();
			surgerylist.put("surgeryNo", rs.getInt("surgeryNo"));			// 수술 번호 
			surgerylist.put("surgeryKind", rs.getString("surgeryKind"));	// 수술 종류
			surgerylist.put("surgeryDate", rs.getString("surgeryDate"));	// 수술 날짜
			surgerylist.put("surgeryState", rs.getString("surgeryState"));  // 수술 대기 / 완료의 상태
			surgerylist.put("regiNo", rs.getInt("regiNo"));					// 접수 번호
			surgerylist.put("petKind", rs.getString("petKind"));			// 반려동물 종류
			surgerylist.put("petName", rs.getString("petName"));			// 반려동물 이름
			surgerylist.put("empNo", rs.getInt("empNo"));					// 직원 사번
			surgerylist.put("empName", rs.getString("empName"));			// 직원 이름
			surgerylist.put("totalRow", rs.getInt("totalRow"));				// 총 행 개수 
			
			list.add(surgerylist);
		}	
		conn.close();
		return list;
	}
	
	/*
	 * 메소드 : SurgeryDao#surgeryDetail() 
	 * 페이지 : surgeryDetail.jsp
	 * 시작 날짜 : 2024-05-14
	 * 담당자 : 한은혜 
	 */
	public static ArrayList<HashMap<String, Object>> surgeryDetail(int surgeryNo) throws Exception{
			
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연결
		Connection conn = DBHelper.getConnection();
		
		/* 
		* 수술 상세보기 쿼리 
		* 수술 정보(surgery_no, surgery_kind, surgery_content, surgery_date)
		* + 접수번호(regi_no) 
		* + 동물 정보(pet_no, pet_kind, pet_name) 
		* + 담당 의사 정보(emp_no, emp_grade, emp_name)
		* + 보호자 정보(customer_no, customer_tel)
		*/
		String sql = "SELECT"
				+ " surgery_no surgeryNo, surgery_kind surgeryKind, surgery_date surgeryDate, surgery_content surgeryContent,"
				+ " s.regi_no regiNo, s.surgery_state surgeryState, s.surgery_date surgeryDate,"
				+ " r.pet_no petNo, pet_kind petKind, pet_name petName,"
				+ " r.emp_no empNo, emp_grade empGrade, emp_name empName,"
				+ " customer_name customerName, customer_tel customerTel"
				+ " FROM surgery s"
				+ " INNER JOIN registration r"
				+ " ON s.regi_no = r.regi_no"			// 수술에서 접수번호 = 접수에서 접수 번호 
				+ " LEFT JOIN pet p"
				+ " ON r.pet_no = p.pet_no"				
				+ " LEFT JOIN employee e"
				+ " ON r.emp_no = e.emp_no"
				+ " LEFT JOIN customer c"
				+ " ON p.customer_no = c.customer_no"
				+ " WHERE s.surgery_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, surgeryNo);
		System.out.println(stmt + " ====== SurgeryDao#surgeryDetail stmt");
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> surDetail = new HashMap<String, Object>();
			
			surDetail.put("surgeryNo", rs.getInt("surgeryNo"));					// 수술 번호 
			surDetail.put("surgeryKind", rs.getString("surgeryKind"));			// 수술 종류
			surDetail.put("surgeryDate", rs.getString("surgeryDate"));			// 수술 날짜 
			surDetail.put("surgeryContent", rs.getString("surgeryContent"));	// 수술 내용 
			surDetail.put("surgeryState", rs.getString("surgeryState"));		// 수술 대기 / 완료의 상태
			surDetail.put("regiNo", rs.getInt("regiNo"));						// 접수 번호 
			surDetail.put("petNo", rs.getInt("petNo"));							// 반려동물 번호 
			surDetail.put("petKind", rs.getString("petKind"));					// 반려동물 종류
			surDetail.put("petName", rs.getString("petName"));					// 반려동물 이름
			surDetail.put("empNo", rs.getInt("empNo"));							// 직원 사번
			surDetail.put("empGrade", rs.getString("empGrade"));				// 직원 역할
			surDetail.put("empName", rs.getString("empName"));					// 직원 이름
			surDetail.put("customerName", rs.getString("customerName"));		// 직원 이름
			surDetail.put("customerTel", rs.getString("customerTel"));			// 직원 이름
		
			list.add(surDetail);
		}
		conn.close();
		return list;
	}
	
	/*
	 * 메소드 : SurgeryDao#surgeryKind() 
	 * 페이지 : clinicDetailForm.jsp
	 * 시작 날짜 : 2024-05-23
	 * 담당자 : 김지훈 
	 */
	public static ArrayList<HashMap<String, String>> surgeryKind() throws Exception {
		ArrayList<HashMap<String, String>> surgeryKind = new ArrayList<HashMap<String, String>>();

		Connection conn = DBHelper.getConnection();
		String sql = "SELECT surgery_kind surgeryKind"
				+ " FROM surgery_kind";
		
		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, String> list = new HashMap<String, String>();
			list.put("surgeryKind", rs.getString("surgeryKind"));
			surgeryKind.add(list);
		}
		conn.close();
		return surgeryKind;
	}
	
	/*
	 * 메소드 : SurgeryDao#surgeryUpdate() 
	 * 페이지 : clinicSurgeryAction.jsp
	 * 시작 날짜 : 2024-05-23
	 * 담당자 : 김지훈 
	 */
	
	public static int surgeryUpdate(int regiNo, int surgeryNo, String surgeryContent) throws Exception {
		System.out.println(regiNo  + " ====== SurgeryDao#surgeryUpdate() regiNo");
		System.out.println(surgeryNo  + " ====== SurgeryDao#surgeryUpdate() surgeryNo");
		System.out.println(surgeryContent  + " ====== SurgeryDao#surgeryUpdate() surgeryContent");
		
		int updateRow = 0;
		Connection conn = DBHelper.getConnection();
		
		String sql = "UPDATE surgery"
				+ " SET surgery_content = ?"
				+ " WHERE regi_no = ?"
				+ " AND surgery_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, surgeryContent); // 수술 정보를 수정
		stmt.setInt(2, regiNo); // regi_no에 따른 수술 정보를 수정
		stmt.setInt(3, surgeryNo);
		System.out.println(stmt  + " ====== SurgeryDao#surgeryUpdate() stmt");
		
		updateRow = stmt.executeUpdate();
		
		conn.close();
		return updateRow;
	}
	
	/*
	 * 메소드 : SurgeryDao#surgeryDetail() 
	 * 페이지 : clinicDetailForm.jsp
	 * 시작 날짜 : 2024-05-23
	 * 담당자 : 김지훈 
	 */
	
	public static ArrayList<HashMap<String, Object>> surgeryDetailByClinic(int regiNo) throws Exception {
		
		System.out.println(regiNo  + " ====== SurgeryDao#surgeryDetailByClinic() regiNo");
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT surgery_no surgeryNo, regi_no regiNo, surgery_kind surgeryKind,"
				+ " surgery_content surgeryContent, surgery_state surgeryState, surgery_date surgeryDate"
				+ " FROM surgery"
				+ " WHERE regi_no = ?;";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, regiNo);
		
		System.out.println(regiNo  + " ====== SurgeryDao#surgeryDetailByClinic() stmt");
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> surgeryList = new HashMap<String, Object>();
			surgeryList.put("surgeryNo", rs.getInt("surgeryNo"));
			surgeryList.put("regiNo", rs.getInt("regiNo"));
			surgeryList.put("surgeryKind", rs.getString("surgeryKind"));
			surgeryList.put("surgeryContent", rs.getString("surgeryContent"));
			surgeryList.put("surgeryState", rs.getString("surgeryState"));
			surgeryList.put("surgeryDate", rs.getString("surgeryDate"));
			list.add(surgeryList);
		}
		
		conn.close();
		return list;
		
	}
	
	/*
	 * 메소드 : SurgeryDao#surgeryInsert() 
	 * 페이지 : clinicSurgeryAction.jsp
	 * 시작 날짜 : 2024-05-22
	 * 담당자 : 김지훈 
	 */
	
	public static int surgeryInsert(int regiNo, String surgeryKind, String surgeryContent, String surgeryDate) throws Exception {
		
		// clinicDetailForm -> clinicSurgeryAction
		// 디버깅
		System.out.println(regiNo  + " ====== SurgeryDao#surgeryInsert() regiNo");
		System.out.println(surgeryKind  + " ====== SurgeryDao#surgeryInsert() surgeryKind");
		System.out.println(surgeryContent  + " ====== SurgeryDao#surgeryInsert() surgeryContent");
		System.out.println(surgeryDate  + " ====== SurgeryDao#surgeryInsert() surgeryDate");
		
		int insertRow = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO surgery(regi_no, surgery_kind, surgery_content, surgery_date)"
				+ " VALUES(?, ?, ?, ?)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, regiNo); 			// 접수 번호
		stmt.setString(2, surgeryKind); 	// 수술 종류 
		stmt.setString(3, surgeryContent);	// 수술 내용
		stmt.setString(4, surgeryDate);		// 수술 일자
		
		System.out.println(stmt  + " ====== SurgeryDao#surgeryInsert() stmt");
		
		insertRow = stmt.executeUpdate();
		
		conn.close(); // db 자원 반납
		return insertRow; // insertRow를 반환
	}
	
	
	/*
	 * 메소드 : SurgeryDao#surgeryStateUpdate() 
	 * 페이지 : surgeryStateAction.jsp
	 * 시작 날짜 : 2024-05-22
	 * 담당자 : 김지훈 
	 */
	
	public static int surgeryStateUpdate(int surgeryNo) throws Exception {
		
		System.out.println(surgeryNo  + " ====== SurgeryDao#surgeryStateUpdate() surgeryNo");
		
		int updateRow = 0;

		Connection conn = DBHelper.getConnection();
		String sql = "UPDATE surgery"
				+ " SET surgery_state = '완료'"
				+ " WHERE surgery_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, surgeryNo);
		
		System.out.println(stmt  + " ====== SurgeryDao#surgeryInsert() surgeryStateUpdate");
		
		updateRow = stmt.executeUpdate();
		
		conn.close();
		return updateRow;
	}
}
