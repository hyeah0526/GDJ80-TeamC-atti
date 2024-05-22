package atti;

import java.sql.*;
import java.util.*;

public class PrescriptionDao {
	
	/*
	 * 메소드 : PrescriptionDao#prescriptionList()
	 * 페이지 : prescriptionList.jsp
	 * 시작 날짜 : 2024-05-16
	 * 담당자 : 한은혜 
	 */
	public static ArrayList<HashMap<String, Object>> prescriptionList(String searchDate, int startRow, int rowPerPage) throws Exception{
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연결
		Connection conn = DBHelper.getConnection();

		// 디버깅 
		System.out.println(searchDate + " ====== PrescriptionDao#prescriptionList searchDate");
		System.out.println(startRow + " ====== PrescriptionDao#prescriptionList startRow");
		System.out.println(rowPerPage + " ====== PrescriptionDao#prescriptionList rowPerPage");
						
		/*
		 * 처방 리스트 출력 쿼리 
		 *  처방 정보(p.regi_no, prescription_no, medicine_no, prescription_content, prescription_date)
		 * + 약 정보(medicine_name)
		 * + 담당 의사(emp_no, emp_name)
		 * + 반려동물 정보(pet_no, pet_name)
		 * + 출력된 행 수 세기(페이징)
		 * + 처방 날짜 내림차순(최신순) + 페이징 
		 * ---------------------------------
		 * 처방 내용을 접수 번호가 같은 것끼리 묶어서 출력하기(약이름, 처방내용)
		 * 그 결과의 행 수를 totalRow로 처리
		 */
		String sql = "SELECT"
				+ " p.regi_no regiNo,"
				+ " GROUP_CONCAT(DISTINCT p.prescription_no) prescriptionNo,"		// 처방 번호 묶어주기 	ex) 4,5,6 
				+ " GROUP_CONCAT(DISTINCT p.medicine_no) medicineNo,"				// 약 번호 묶어주기 	
				+ " GROUP_CONCAT(p.prescription_content) prescriptionContents,"		// 처방 내용 묶어주기 
				+ " GROUP_CONCAT(m.medicine_name) medicineNames,"					// 약 이름 묶어주기 
				+ " MAX(p.prescription_date) prescriptionDate,"						// 처방 날짜 가져오기(가장 나중에 처방한 날짜)
				+ " e.emp_no empNo, e.emp_name empName,"
				+ " pet.pet_no petNo, pet.pet_name petName,"
				+ " (SELECT COUNT(*) FROM"
				+ "    (SELECT regi_no"
				+ "    FROM prescription"
				+ "    WHERE DATE(prescription_date) LIKE ?"						// 검색한 처방 날짜의 접수 번호 행 수 = totalRow
				+ "    GROUP BY regi_no) cntRow) totalRow"
				+ " FROM prescription p"
				+ " LEFT JOIN registration r"
				+ " ON p.regi_no = r.regi_no"
				+ " LEFT JOIN medicine m"
				+ " ON p.medicine_no = m.medicine_no"
				+ " LEFT JOIN employee e"
				+ " ON r.emp_no = e.emp_no"
				+ " LEFT JOIN pet pet"
				+ " ON pet.pet_no = r.pet_no"
				+ " WHERE DATE(p.prescription_date) LIKE ?"
				+ " GROUP BY p.regi_no"												// 처방에서의 접수번호가 같은 것끼리 묶어주기(한개의 접수에서 여러개의 처방)
				+ " ORDER BY MAX(p.prescription_date) DESC"
				+ " LIMIT ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchDate +"%");
		stmt.setString(2, "%"+searchDate +"%");
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage);
		System.out.println(stmt + " ====== PrescriptionDao#prescriptionList stmt");
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> presList = new HashMap<String, Object>();
			presList.put("regiNo", rs.getString("regiNo"));								// 접수 번호 
			presList.put("prescriptionNo", rs.getString("prescriptionNo"));				// 처방 번호 .
			presList.put("medicineNo", rs.getString("medicineNo"));						// 약 번호 .
			presList.put("prescriptionContents", rs.getString("prescriptionContents"));	// 처방 내용 . 
			presList.put("medicineNames", rs.getString("medicineNames"));				// 약 이름 .
			presList.put("prescriptionDate", rs.getString("prescriptionDate"));			// 처방 날짜 .
			presList.put("empNo", rs.getInt("empNo"));									// 의사 사번 . 
			presList.put("empName", rs.getString("empName"));							// 의사 이름 . 
			presList.put("petNo", rs.getInt("petNo"));									// 반려동물 번호
			presList.put("petName", rs.getString("petName"));							// 반려동물 이름
			presList.put("totalRow", rs.getInt("totalRow"));
			
			list.add(presList);
		}
		conn.close();
		return list;
	}
	
	/*
	 * 메소드 : PrescrptionDao#medicineList()
	 * 페이지 : clinicDetailForm.jsp
	 * 시작 날짜 : 2024-05-22
	 * 담당자 : 박혜아 
	 */
	public static ArrayList<HashMap<String, Object>> medicineList() throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		// DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// 약 리스트 : 약번호, 약이름
		String sql = "SELECT medicine_no medicineNo, medicine_name medicineName"
				+ " FROM medicine";
		
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		//System.out.println("PrescrptionDao#medicineList() stmt--> "+stmt);
		
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("medicineNo", rs.getInt("medicineNo"));			// 약 고유번호
			map.put("medicineName",rs.getString("medicineName"));	// 약 이름
			
			list.add(map);
		}
		
		//System.out.println("PrescrptionDao#medicineList() list--> "+list);
		
		conn.close();
		return list;
	}
	
	
	/*
	 * 메소드 : PrescrptionDao#prescrptionInsert()
	 * 페이지 : clinicDetailForm.jsp
	 * 시작 날짜 : 2024-05-22
	 * 담당자 : 박혜아 
	 */
	public static int prescrptionInsert(int regiNo, int medicineNo, String prescriptionContent) throws Exception{
		int insertRow = 0;
		
		// 값 디버깅
		//System.out.println("PrescrptionDao#prescrptionInsert() regiNo--> "+regiNo);
		//System.out.println("PrescrptionDao#prescrptionInsert() medicineNo--> "+medicineNo);
		//System.out.println("PrescrptionDao#prescrptionInsert() prescriptionContent--> "+prescriptionContent);
		
		// DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		
		// 처방등록
		String sql = "INSERT INTO prescription(regi_no, medicine_no, prescription_content, prescription_date)"
				+ " VALUES (?, ?, ?, NOW())";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, regiNo);
		stmt.setInt(2, medicineNo);
		stmt.setString(3, prescriptionContent);
		//System.out.println("PrescrptionDao#prescrptionInsert() stmt--> "+stmt);
		
		insertRow = stmt.executeUpdate();
		
		conn.close();
		return insertRow;
	}
	
	
	
	/*
	 * 메소드 : PrescrptionDao#prescrptionDetail(int regiNo)
	 * 페이지 : clinicDetailForm.jsp
	 * 시작 날짜 : 2024-05-22
	 * 담당자 : 박혜아 
	 */
	public static ArrayList<HashMap<String, Object>> prescrptionDetail(int regiNo) throws Exception{
		 ArrayList<HashMap<String, Object>> list = new  ArrayList<HashMap<String, Object>>();
		 
		// 값 디버깅
		//System.out.println("PrescrptionDao#prescrptionDetail() regiNo--> "+regiNo);
		 
		// DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		/*
		 * SELECT
		 * 처방prescription : 접수번호, 처방내용, 처방날짜, 처방번호
		 * 약medicine : 약번호, 약이름
		 */
		String sql = "SELECT p.regi_no regiNo, p.prescription_content prescriptionContent, p.prescription_date prescriptionDate, p.prescription_no prescriptionNo"
				+ " , m.medicine_no medicineNo, m.medicine_name medicineName"
				+ " FROM prescription p"
				+ " INNER JOIN medicine m ON p.medicine_no = m.medicine_no"
				+ " WHERE p.regi_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, regiNo);
		//System.out.println("PrescrptionDao#prescrptionDetail() stmt--> "+stmt);
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("prescriptionContent", rs.getString("prescriptionContent"));	//처방내용
			map.put("prescriptionDate", rs.getString("prescriptionDate"));			//처방날짜
			map.put("prescriptionNo", rs.getInt("prescriptionNo"));				//처방번호
			map.put("medicineNo", rs.getInt("medicineNo"));							//약번호
			map.put("medicineName", rs.getString("medicineName"));					//약이름
			
			list.add(map);
		}
		
		//System.out.println("PrescrptionDao#prescrptionDetail() list--> "+list);
		
		conn.close();
		return list;
	}
}
