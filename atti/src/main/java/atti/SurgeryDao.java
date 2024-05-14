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
	public static ArrayList<HashMap<String, Object>> surgeryList(String searchDate) throws Exception{
			
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			// DB연결
			Connection conn = DBHelper.getConnection();
			
			/*
			 * 수술 리스트 출력 쿼리 
			 * 수술 정보(surgery_no, surgery_kind, surgery_date)
			 * + 접수번호(regi_no) 
			 * + 동물 정보(pet_kind, pet_name) 
			 * + 담당 의사, 간호사 정보(emp_grade, emp_name)
			 * + 수술 날짜 내림차순(최신순)
			 */
			String sql = "SELECT "
					+ "surgery_no surgeryNo, surgery_kind surgeryKind, surgery_date surgeryDate, "
					+ "s.regi_no regiNo, "	 
					+ "pet_kind petKind, pet_name petName, " 
					+ "emp_grade empGrade, emp_name empName " 
					+ "FROM surgery s "
					+ "LEFT JOIN registration r "
					+ "ON s.regi_no = r.regi_no "		// 수술의 접수 번호 = 접수한 접수 번호
					+ "LEFT JOIN pet p "
					+ "ON r.pet_no = p.pet_no "			// 접수의 반려동물 번호 = 반려동물에서 반려동물 번호 
					+ "LEFT JOIN employee e "
					+ "ON r.emp_no = e.emp_no "			// 접수의 사번 = 직원의 사번 
					+ "WHERE DATE(s.surgery_date) = ? "	// 수술 날짜가 언제인지 검색
					+ "ORDER BY s.surgery_date DESC"; 
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, searchDate);
			System.out.println(stmt + " ====== SurgeryDao#surgeryList stmt");
			
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> surgerylist = new HashMap<String, Object>();
				surgerylist.put("surgeryNo", rs.getInt("surgeryNo"));			// 수술 번호 
				surgerylist.put("surgeryKind", rs.getString("surgeryKind"));	// 수술 종류
				surgerylist.put("surgeryDate", rs.getString("surgeryDate"));	// 수술 날짜
				surgerylist.put("regiNo", rs.getInt("regiNo"));					// 접수 번호
				surgerylist.put("petKind", rs.getString("petKind"));			// 반려동물 종류
				surgerylist.put("petName", rs.getString("petName"));			// 반려동물 이름
				surgerylist.put("empGrade", rs.getString("empGrade"));			// 직원 역할
				surgerylist.put("empName", rs.getString("empName"));			// 직원 이름
				
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
			
			System.out.println(surgeryNo + " ====== SurgeryDao#surgeryDetail surgeryNo");
			/* 수술 상세보기 쿼리 
			* 수술 정보(surgery_no, surgery_kind, surgery_content, surgery_date)
			* + 접수번호(regi_no) 
			* + 동물 정보(pet_no, pet_kind, pet_name) 
			* + 담당 의사 정보(emp_no, emp_grade, emp_name)
			* + 해당 수술 번호
			*/
			String sql = "SELECT \n"
					+ "surgery_no surgeryNo, surgery_kind surgeryKind, surgery_date surgeryDate,surgery_content surgeryContent, s.regi_no regiNo, "
					+ "r.pet_no petNo, pet_kind petKind, pet_name petName, "
					+ "r.emp_no empNo, emp_grade empGrade, emp_name empName "
					+ "FROM surgery s "
					+ "LEFT JOIN registration r "
					+ "ON s.regi_no = r.regi_no "	// 수술의 접수 번호 = 접수의 접수 번호
					+ "LEFT JOIN pet p "
					+ "ON r.pet_no = p.pet_no "		// 접수의 반려동물 번호 = 반려동물의 반려동물 번호
					+ "LEFT JOIN employee e "
					+ "ON r.emp_no = e.emp_no "		// 접수의 사원 번호 = 직원의 사원 번호
					+ "WHERE s.surgery_no = ? ";	// 해당 수술의 수술 번호 
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, surgeryNo);
			System.out.println(stmt + " ====== surgeryDetail stmt");
			
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> surDetail = new HashMap<String, Object>();
				
				surDetail.put("surgeryNo", rs.getInt("surgeryNo"));					// 수술 번호 
				surDetail.put("surgeryKind", rs.getString("surgeryKind"));			// 수술 종류
				surDetail.put("surgeryDate", rs.getString("surgeryDate"));			// 수술 날짜 
				surDetail.put("surgeryContent", rs.getString("surgeryContent"));	// 수술 내용 
				surDetail.put("regiNo", rs.getInt("regiNo"));						// 접수 번호 
				surDetail.put("petNo", rs.getInt("petNo"));							// 반려동물 번호 
				surDetail.put("petKind", rs.getInt("petKind"));						// 반려동물 종류
				surDetail.put("petName", rs.getInt("petName"));						// 반려동물 이름
				surDetail.put("empNo", rs.getInt("empNo"));							// 직원 사번
				surDetail.put("empGrade", rs.getInt("empGrade"));					// 직원 역할
				surDetail.put("empName", rs.getInt("empName"));						// 직원 이름
			
			}
			
			conn.close();
			return list;
			
			//TODO : [한은혜] 검사, 수술 searchDate가 null일 때 -> 전체 출력 + 페이징
	}
}
