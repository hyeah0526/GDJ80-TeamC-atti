package atti;

import java.sql.*;
import java.util.*;

public class HospitalRoomDao {
	
	// 테스트
	public static void main(String[] args) throws Exception {
		
		//HospitalRoomDao #hospitalRoomList() 디버깅
		//System.out.println(HospitalRoomDao.hospitalRoomList());
	}
	
	/*
	 * 메소드: #hospitalRoomList()
	 * 페이지: hospitalRoomList.jsp
	 * 시작 날짜: 2024-05-10
	 * 담당자: 박혜아
	*/
	public static ArrayList<HashMap<String, Object>> hospitalRoomList() throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		//DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		/* SELECT(조회화면에서 보여줄 것)
		 * hospital_room : 입원실 번호, 입원실상태, 입원실수정날짜
		 * hospitalization : 입원번호, 접수번호, 퇴원날짜
		 * pet : 동물이름, 동물종류
		*/
		String sql = "SELECT r.room_name roomName, r.state state, r.update_date updateDate"
					+ ", h.hospitalization_no hospitalizationNo, h.regi_no regiNo, h.discharge_date dischargeDate"
					+ ", p.pet_name petName, p.pet_kind petKind, p.pet_birth petBirth, p.emp_major empMajor"
					+ " FROM hospital_room r"
					+ " LEFT JOIN hospitalization h"
					+ " ON r.room_name = h.room_name" //입원실번호 = 입원환자의 입원실번호
					+ " LEFT JOIN registration regi"
					+ " ON h.regi_no = regi.regi_no" //입원환자의 접수번호 = 접수의 접수번호
					+ " LEFT JOIN pet p"
					+ " ON p.pet_no = regi.pet_no"	//동물의 동물번호 = 접수의 동물번호
					+ " WHERE h.discharge_date IS NULL OR h.discharge_date =" //퇴원일이 null인 것 OR 퇴원일이 제일 먼 것을 가져오기
					+ " (SELECT MAX(discharge_date)"
					+ " FROM hospitalization h"
					+ " WHERE h.room_name = r.room_name)"
					+ " ORDER BY roomName ASC"; //입원실 이름순으로 정렬
		
		stmt = conn.prepareStatement(sql);
		//System.out.println("HospitalRoomDao #hospitalRoomList() sql ---> "+stmt);
		
		rs = stmt.executeQuery();
		
		Calendar calendar = Calendar.getInstance();
		int currentYear = calendar.get(Calendar.YEAR);
		//System.out.println("HospitalRoomDao #hospitalRoomList() currentYear --> "+currentYear);
		int petAge = 0;
		
		// 담아주기
		while(rs.next()) {
			HashMap<String, Object> hashMap = new HashMap<>();
			hashMap.put("roomName", rs.getString("roomName")); //입원실번호(A01, A02, A03...)
			hashMap.put("state", rs.getString("state")); //입원실상태(on 혹은 off)
			hashMap.put("updateDate", rs.getString("updateDate")); //입원실 수정날짜
			hashMap.put("hospitalizationNo", rs.getInt("hospitalizationNo")); //입원번호
			hashMap.put("regiNo", rs.getInt("regiNo")); //접수번호
			hashMap.put("dischargeDate", rs.getString("dischargeDate")); //퇴원날짜
			hashMap.put("petName", rs.getString("petName")); //동물이름
			hashMap.put("petKind", rs.getString("petKind")); //동물 세부종류
			hashMap.put("empMajor", rs.getString("empMajor")); //포유류, 파충류, 조류 구분
			
			if(rs.getString("petBirth") != null) {
				//동물나이구하기
				String petBirth = rs.getString("petBirth").substring(0,4);
				int petBirthInt = Integer.parseInt(petBirth);
				//System.out.println("HospitalRoomDao #hospitalRoomList() 동물년도 확인-->" + petBirthInt);
				
				petAge = currentYear-petBirthInt;
				hashMap.put("petAge", petAge); //동물생일
			}else {
				hashMap.put("petAge", rs.getString("petBirth")); //동물종류
			}
			
			list.add(hashMap);
		}
		
		conn.close();
		return list;
	}
	
	
	/*
	 * 메소드: #hospitalizationDetail(int regiNo) 
	 * 페이지: hospitalizationDetail.jsp
	 * 시작 날짜: 2024-05-13
	 * 담당자: 박혜아
	*/
	public static ArrayList<HashMap<String, Object>> hospitalizationDetail(int regiNo) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		//System.out.println("HospitalRoomDao #hospitalizationDetail() 접수번호 확인--> " + regiNo);
		
		//DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
				
		/* SELECT(조회화면에서 보여줄 것)
		 * registration : 접수번호, 
		 * hospitalization : 입원번호, 입원실번호, 입원날짜, 퇴원날짜, 입원내용
		 * employee : 담당의사이름
		 * pet : 동물이름, 동물종류, 생년월일
		 * customer : 보호자이름, 보호자번호
		 */
		
		String sql = "SELECT regi.regi_state regiState, regi.regi_no regiNo, h.hospitalization_no hospitalNo, h.room_name roomName,"
				+ " h.hospitalization_content hospitalContent, h.create_date createDate, h.discharge_date dischargeDate ,"
				+ " e.emp_name empName, e.emp_major empMajor,"
				+ " p.pet_name petName, p.pet_birth petBirth, p.pet_kind petKind,"
				+ " c.customer_name customerName, c.customer_tel customerTel"
				+ " FROM registration regi"
				+ " LEFT JOIN hospitalization h"
				+ " ON regi.regi_no = h.regi_no"		// 접수 = 입원
				+ " LEFT JOIN clinic cn"
				+ " ON h.regi_no = cn.regi_no"			// 입원 = 진료
				+ " LEFT JOIN employee e"
				+ " ON regi.emp_no = e.emp_no"			// 접수 = 직원
				+ " LEFT JOIN pet p"
				+ " ON regi.pet_no = p.pet_no"			// 접수 = 동물
				+ " LEFT JOIN customer c"
				+ " ON p.customer_no = c.customer_no"	// 동물 = 보호자
				+ " WHERE h.regi_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, regiNo);
		//System.out.println("HospitalRoomDao #hospitalizationDetail() sql ---> "+stmt);
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> hashMap = new HashMap<>();
			hashMap.put("regiNo", rs.getInt("regiNo"));							//접수번호
			hashMap.put("regiState", rs.getString("regiState"));				//접수상태
			hashMap.put("hospitalNo", rs.getInt("hospitalNo"));					//입원번호
			hashMap.put("roomName", rs.getString("roomName"));					//입원실번호
			hashMap.put("hospitalContent", rs.getString("hospitalContent"));	//입원내용
			hashMap.put("createDate", rs.getString("createDate"));				//입원날짜
			hashMap.put("dischargeDate", rs.getString("dischargeDate"));		//퇴원날짜
			hashMap.put("empName", rs.getString("empName"));					//의사이름
			hashMap.put("empMajor", rs.getString("empMajor"));					//환자(동물)대분류
			hashMap.put("petName", rs.getString("petName"));					//환자(동물)이름
			hashMap.put("petBirth", rs.getString("petBirth"));					//환자(동물)생년월일
			hashMap.put("petKind", rs.getString("petKind"));					//환자(동물)소분류
			hashMap.put("customerName", rs.getString("customerName"));			//보호자이름
			hashMap.put("customerTel", rs.getString("customerTel"));			//보호자연락처
			
			list.add(hashMap);
		}
		
		conn.close();
		return list;
	}
	
	
	/*
	 * 메소드: #hospitalizationContent(int hospitalNo, String hospitalizationContent) 
	 * 페이지: hospitalizationDetail.jsp
	 * 시작 날짜: 2024-05-13
	 * 담당자: 박혜아
	*/
	public static int hospitalizationContent(int hospitalNo, String hospitalizationContent) throws Exception{
		int row = 0;
		
		// 받아온 값 디버깅
		//System.out.println("HospitalRoomDao #hospitalizationContent() hospitalNo---> "+hospitalNo);
		//System.out.println("HospitalRoomDao #hospitalizationContent() hospitalizationContent---> "+hospitalizationContent);
		
		//DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		
		String sql = "UPDATE hospitalization"
				+ " SET hospitalization_content = CONCAT(hospitalization_content, ?)"
				+ " WHERE hospitalization_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, hospitalizationContent);
		stmt.setInt(2, hospitalNo);
		//System.out.println("HospitalRoomDao #hospitalizationContent() sql ---> "+stmt);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}

	
	/*
	 * 메소드: #hospitalizationDischarge(String roomName) 
	 * 페이지: hospitalizationDetail.jsp
	 * 시작 날짜: 2024-05-13
	 * 담당자: 박혜아
	*/
	public static int hospitalizationDischarge(String roomName) throws Exception{
		int row = 0;
		
		// 받아온 값 디버깅
		System.out.println("HospitalRoomDao #hospitalizationContent() roomName--> "+roomName);
		
		// DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		
		// 퇴원시 입원실 상태변경 'ON' -> 'OFF'
		String sql = "UPDATE hospital_room h SET state = 'OFF'"
				+ " WHERE h.room_name = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, roomName);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	
	
	
	
	
}
