package atti;

import java.sql.*;
import java.util.*;

public class HospitalizationDao {

	/*
		메소드: HospitalizationDao#hospitalRoomList()
	  	페이지: clinicDetailForm.jsp
	  	시작날짜: 2024-05-16
	  	담당자: 김인수
	*/
	public static ArrayList<HashMap<String, Object>> hospitalRoomList() throws Exception{
		
		//반환 값 변수
		ArrayList<HashMap<String, Object>> resultMap = new ArrayList<>();
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		//입원실 정보 조회 : 사용하지 않는 입원실 침대 조회: 상태가 OFF인 침대만 조회
		String sql = "SELECT room_name FROM hospital_room WHERE state = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "OFF"); // 사용하지 않는 입원실 침대 
		rs = stmt.executeQuery();
		
		
		while(rs.next()) {
			HashMap<String, Object> empList = new HashMap<String, Object>();
			 empList.put("room_name", rs.getString("room_name")); // 사용하지 않는 침대 이름
			 resultMap.add(empList);
		}
		
		//디버깅
		//System.out.println("resultMap = " + resultMap);

		conn.close();
		return resultMap;

	}
	
	
	/*
  		메소드: HospitalizationDao#hospitalizationDetail()
	  	페이지: clinicAction.jsp
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
		 String sql = "SELECT "
	                + "    p.emp_major,"
	                + "    p.pet_name,"
	                + "    CASE "
	                + "        WHEN h.regi_no = ? THEN h.room_name "
	                + "        ELSE NULL "
	                + "    END AS room_name,"
	                + "    CASE "
	                + "        WHEN h.regi_no = ? THEN h.state "
	                + "        ELSE NULL "
	                + "    END AS state,"
	                + "    CASE "
	                + "        WHEN h.regi_no = ? THEN h.create_date "
	                + "        ELSE NULL "
	                + "    END AS create_date,"
	                + "    CASE "
	                + "        WHEN h.regi_no = ? THEN h.discharge_date "
	                + "        ELSE NULL "
	                + "    END AS discharge_date "
	                + "FROM "
	                + "    pet p "
	                + "LEFT JOIN "
	                + "    registration r ON r.pet_no = p.pet_no "
	                + "LEFT JOIN "
	                + "    hospitalization h ON h.regi_no = r.regi_no "
	                + "WHERE "
	                + "    r.regi_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, regiNo); // 고객의 접수 번호
		stmt.setInt(2, regiNo); 
		stmt.setInt(3, regiNo); 
		stmt.setInt(4, regiNo); 
		stmt.setInt(5, regiNo); 
		rs = stmt.executeQuery();
		
		
		if(rs.next()) {
			resultMap = new HashMap<>();
			resultMap.put("empMajor",rs.getString("emp_major")); // 입원 동물 분류군
			resultMap.put("petName",rs.getString("pet_name")); // 입원 동물 이름
			resultMap.put("roomName",rs.getString("room_name")); // 입원실 베드 이름 
			resultMap.put("state",rs.getString("state")); // 입원 상태
			resultMap.put("createDate",rs.getString("create_date"));  // 입원한 날짜
			resultMap.put("dischargeDate",rs.getString("discharge_date"));  // 퇴원할 날짜
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
	
	
	/*
		메소드: HospitalizationDao#hospitalizationUpdate()
	  	페이지: clinicAction.jsp
	  	시작날짜: 2024-05-16
	  	담당자: 김인수
	*/
	public static int hospitalizationUpdate(String roomName, int regiNo) throws Exception{
		
		//매개변수 값 출력
		//System.out.println("roomName = " + roomName);
		//System.out.println("regiNo = " + regiNo);
		
		// 반환 값 변수
		int updateRow = 0;
		
		PreparedStatement stmt = null;
		
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		//입원 정보 등록 : 입원한 환자는 입원 정보를 수정하고 신규 환자는 입원 등록
		String sql = "INSERT INTO hospitalization (room_name, regi_no, hospitalization_content, create_date, discharge_date) "
	            + "VALUES (?, ?, ?, NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY)) "
	            + "ON DUPLICATE KEY UPDATE "
	            + "state = '입원', "
	            + "room_name = VALUES(room_name), "
	            + "create_date = VALUES(create_date), "
	            + "discharge_date = VALUES(discharge_date)";
	         
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, roomName); // 침대 이름
		stmt.setInt(2, regiNo); // 진료 번호
		stmt.setString(3, ""); // 입원 내용
		
		updateRow = stmt.executeUpdate();
		
		conn.close();
		return updateRow;
		
	}
	
	
	/*
		메소드: HospitalizationDao#hospitalRoomUpdate()
	  	페이지: clinicAction.jsp
	  	시작날짜: 2024-05-20
	  	담당자: 김인수
	*/
	public static int hospitalRoomUpdate(String roomName) throws Exception{
		
		//매개변수 값 출력
		//System.out.println("roomName = " + roomName);
		
		// 반환 값 변수
		int updateRow = 0;
		
		PreparedStatement stmt = null;
		
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		//입원 호실 상태 수정 : 환자가 입원하면 입원 침대 상태를 수정
		String sql = "UPDATE hospital_room SET state = 'ON' WHERE room_name = ?";
	         
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, roomName); // 침대 이름
		
		updateRow = stmt.executeUpdate();
		
		conn.close();
		return updateRow;
		
	}
}
