package atti;

import java.sql.*;
import java.util.*;

public class HospitalizationDao {

	
	/*
  		메소드: HospitalizationDao#hospitalizationDetail()
	  	페이지: clinicDetailForm.jsp
	  	시작날짜: 2024-05-16
	  	담당자: 김인수
	*/
	public static HashMap<String, Object> hospitalizationDetail(int regiNo) throws Exception{
		
		//매개변수 값 출력
		//System.out.println("regiNo = " + regiNo);
		
		//반환 값 변수
		HashMap<String, Object> resultMap = null;
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
	
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		//입원 환자 정보 조회: 접수 번호를 통해 일치하는 입원 내역, 입원 환자 정보 조회
		String sql = "SELECT p.emp_major, p.pet_kind, h.room_name, h.hospitalization_content, h.create_date, h.discharge_date "
				+ "FROM hospitalization h "
				+ "LEFT JOIN registration r ON h.regi_no = r.regi_no "
				+ "LEFT JOIN pet p ON p.pet_no = r.pet_no "
				+ "WHERE h.regi_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, regiNo); // 고객의 접수 번호
		rs = stmt.executeQuery();
		
		
		if(rs.next()) {
			resultMap = new HashMap<>();
			resultMap.put("empMajor",rs.getString("p.emp_major")); // 입원할 동물 분류군
			resultMap.put("petKind",rs.getString("p.pet_kind")); // 입원할 동물 종류
			resultMap.put("roomName",rs.getString("h.room_name")); // 입원실 베드 이름 
			resultMap.put("hospitalizationContent",rs.getString("h.hospitalization_content")); // 입원 내용
			resultMap.put("createDate",rs.getString("h.create_date"));  // 입원한 날짜
			resultMap.put("dischargeDate",rs.getString("h.discharge_date"));  // 퇴원할 날짜
		}
		
		//resultMap 값 디버깅
		//System.out.println(resultMap.get("empMajor"));
		//System.out.println(resultMap.get("petKind"));
		//System.out.println(resultMap.get("roomName"));
		//System.out.println(resultMap.get("hospitalizationContent"));
		//System.out.println(resultMap.get("createDate"));
		//System.out.println(resultMap.get("dischargeDate"));
		
		
		conn.close();
		return resultMap;
	}
	
}
