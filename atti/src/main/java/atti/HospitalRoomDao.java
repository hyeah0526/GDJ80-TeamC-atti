package atti;

import java.sql.*;
import java.util.*;

public class HospitalRoomDao {
	
	// 테스트
	public static void main(String[] args) throws Exception {
		
		//HospitalRoomDao #hospitalRoomList() 디버깅
		System.out.println(HospitalRoomDao.hospitalRoomList());
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
					+ ", p.pet_name petName, p.pet_kind petKind, p.pet_birth petBirth"
					+ " FROM hospital_room r"
					+ " LEFT JOIN hospitalization h"
					+ " ON r.room_name = h.room_name" //입원실번호 = 입원환자의 입원실번호
					+ " LEFT JOIN registration regi"
					+ " ON h.regi_no = regi.regi_no" //입원환자의 접수번호 = 접수의 접수번호
					+ " LEFT JOIN pet p"
					+ " ON p.pet_no = regi.pet_no" //동물의 동물번호 = 접수의 동물번호
					+ " ORDER BY roomName ASC"; //입원실 이름순으로 정렬
		
		stmt = conn.prepareStatement(sql);
		//System.out.println("HospitalRoomDao #hospitalRoomList() ---> "+stmt);
		
		rs = stmt.executeQuery();
		
		Calendar calendar = Calendar.getInstance();
		int currentYear = calendar.get(Calendar.YEAR);
		System.out.println(currentYear);
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
			hashMap.put("petKind", rs.getString("petKind")); //동물종류
			
			if(rs.getString("petBirth") != null) {
				//동물나이구하기
				String petBirth = rs.getString("petBirth").substring(0,4);
				int petBirthInt = Integer.parseInt(petBirth);
				//System.out.println("동물년도 확인-->" + petBirthInt);
				
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

}
