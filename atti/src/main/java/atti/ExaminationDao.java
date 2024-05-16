package atti;

import java.sql.*;
import java.util.*;

public class ExaminationDao {

	/*
	 * 메소드 : ExaminationDao#examinationList() 
	 * 페이지 : examinationList.jsp
	 * 시작 날짜 : 2024-05-10
	 * 담당자 : 한은혜 
	 */
	public static ArrayList<HashMap<String, Object>> examinationList(String searchDate, int startRow, int rowPerPage) throws Exception{
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연결
		Connection conn = DBHelper.getConnection();
		
		// 디버깅 
		System.out.println(searchDate + " ====== ExaminationDao#examinationList searchDate");
		System.out.println(startRow + " ====== ExaminationDao#examinationList startRow");
		System.out.println(rowPerPage + " ====== ExaminationDao#examinationList rowPerPage");
		
		/*
		 * 검사 리스트 출력 쿼리 
		 * 검사 리스트 검사 정보(examination_no, examinationKind, examination_content, examination_date) 
		 * + 반려 동물 정보(pet_kind, pet_name) 
		 * + 총 행 수 세기(페이징)
		 * + 검사 날짜 내림차순(최신순) 
		 * + 페이징
		 */
		String sql = "SELECT"
				+ " examination_no examinationNo, examination_kind examinationKind, examination_content examinationContent, examination_date examinationDate,"
				+ " pet_kind petKind, pet_name petName, "
				+ " (SELECT COUNT(examination_no) FROM examination"
				+ " WHERE DATE(examination_date) LIKE ?) totalRow"	// 총 행 수(페이징)
				+ " FROM examination e"
				+ " LEFT JOIN registration r"
				+ " ON e.regi_no = r.regi_no"						// 검사한 접수 번호 = 접수한 접수 번호 
				+ " LEFT JOIN pet p"
				+ " ON r.pet_no = p.pet_no"							// 접수한 반려동물 번호 = 동물 반려동물 번호 
				+ " WHERE DATE(examination_date) LIKE ?"			// 검색(선택)한 검사 날
				+ " ORDER BY examination_date DESC"					// 내림차순으로 정렬(최신순)
				+ " LIMIT ? , ?"; 									// 페이징
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + searchDate + "%");
		stmt.setString(2, "%" + searchDate + "%");
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage);
		
		System.out.println(stmt + " ====== ExaminationDao#examinationList stmt");
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> e = new HashMap<String, Object>();
			e.put("petKind", rs.getString("petKind"));							// 반려동물 종류
			e.put("petName", rs.getString("petName"));							// 반려동물 이름 
			e.put("examinationNo", rs.getInt("examinationNo"));					// 검사 번호 
			e.put("examinationKind", rs.getString("examinationKind"));			// 검사 종류
			e.put("examinationContent", rs.getString("examinationContent"));	// 검사 내용
			e.put("examinationDate", rs.getString("examinationDate"));			// 검사 날짜 
			e.put("totalRow", rs.getInt("totalRow"));							// 총 행 수(페이징)
			
			list.add(e);
		}
		conn.close();
		return list;
	}
	
	/*
	 * 메소드 : ExaminationDao#examinationDetail()
	 * 페이지 : examinationDetail.jsp
	 * 시작 날짜 : 2024-05-10
	 * 담당자 : 한은혜 
	 */
	public static ArrayList<HashMap<String, Object>> examinationDetail(int examinationNo) throws Exception{
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연결
		Connection conn = DBHelper.getConnection();
		// 받아온 값 확인 
		System.out.println(examinationNo + " ====== ExaminationDao#examinationDetail examinationNo");
		
		/*
		 * 검사 상세보기 쿼리 
		 * 검사 정보(examination_no, examinationKind, examination_content, examination_date)
		 * + 반려 동물 정보(pet_kind, pet_name)
		 * + 검사 사진 정보(pthot_no, photo_name)
		*/
		String sql = "SELECT"
				+ " e.examination_no examinationNo, examination_kind examinationKind, examination_content examinationContent, examination_date examinationDate"
				+ " pet_kind petKind, pet_name petName, "
				+ " photo_no photoNo, photo_name photoName, "
				+ " FROM examination e"
				+ " LEFT JOIN registration r"
				+ " ON e.regi_no = r.regi_no"
				+ " LEFT JOIN pet p"
				+ " ON r.pet_no = p.pet_no"
				+ " LEFT JOIN examination_photo ep"
				+ " ON e.examination_no = ep.examination_no"
				+ " WHERE e.examination_no = ?";
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, examinationNo);
		//System.out.println(stmt + " ====== ExaminationDao#examinationDetail stmt");
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> d = new HashMap<String, Object>();
			d.put("photoNo", rs.getInt("photoNo"));								// 사진 번호 
			d.put("photoName", rs.getString("photoName"));						// 사진 이름(파일이름)
			d.put("petKind", rs.getString("petKind"));							// 반려동물 종류
			d.put("petName", rs.getString("petName"));							// 반려동물 이름
			d.put("examinationNo", rs.getInt("examinationNo"));					// 검사 번호
			d.put("examinationKind", rs.getString("examinationKind"));			// 검사 종류
			d.put("examinationContent", rs.getString("examinationContent"));	// 검사 내용
			d.put("examinationDate", rs.getString("examinationDate"));			// 검사 날짜 
		
			list.add(d);
		}
		conn.close();
		return list;
	}
}
