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
	public static ArrayList<HashMap<String, Object>> examinationList(String searchDate) throws Exception{
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연결
		Connection conn = DBHelper.getConnection();
		
		// 검사 정보 출력 쿼리  
		// 검사 내용 전체 + 최신순 정렬(examination_date 내림차순)
		String sql = "SELECT examination_no examinationNo, examination_kind examinationKind, examination_content examinationContent, examination_date examinationDate"
				+ " FROM examination"
				+ " WHERE DATE(examination_date) = ?"
				+ " ORDER BY examination_date DESC;";
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, searchDate);
		System.out.println(stmt + " ====== examinationList stmt");
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> e = new HashMap<String, Object>();
			e.put("examinationNo", rs.getInt("examinationNo"));
			e.put("examinationKind", rs.getString("examinationKind"));
			e.put("examinationContent", rs.getString("examinationContent"));
			e.put("examinationDate", rs.getString("examinationDate"));
			list.add(e);
			
		}
		
		conn.close();
		return list;
		
	}
	
}
