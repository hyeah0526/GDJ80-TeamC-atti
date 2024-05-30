package atti;

import java.sql.*;
import java.util.*;

public class ClinicDao {

	/*
	 * 메소드: #clinic(int regiNo, String clinicContent) 
	 * 페이지: hospitalizationDetail.jsp
	 * 시작 날짜: 2024-05-30
	 * 담당자: 김지훈
	*/
	public static int clinicUpdate(int regiNo, String clinicContent) throws Exception{
		int updateRow = 0;
		
		// 받아온 값 디버깅
		//System.out.println("ClinicDao #ClinicUpdate() clinicNo: + clinicNo);
		//System.out.println("ClinicDao #ClinicContent() clinicConten:" + clinicContent);
		
		//DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		
		String sql = "UPDATE clinic"
				+ " SET clinic_content = CONCAT(clinic_content, ?)"
				+ " WHERE regi_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, clinicContent);
		stmt.setInt(2, regiNo);
		//System.out.println("HospitalRoomDao #hospitalizationContent() sql ---> "+stmt);
		
		updateRow = stmt.executeUpdate();
		
		conn.close();
		return updateRow;
	}
	
	
	/*
	 * 메소드 : ClinicDao#clinicInfo() 페이지 : clinicDetailForm.jsp 시작 날짜 : 2024-05-27
	 * 담당자 : 김지훈
	 */

	// 진료 페이지 내 접수한 고객의 정보를 출력
	public static ArrayList<HashMap<String, Object>> clinicInfo(int regiNo) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// 넘어온 값을 확인
		// 디버깅
		// System.out.println(regiNo + " ====== ClinicDao#clinicUpdate() regiNo");
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT r.regi_no regiNo, r.regi_date regiDate, r.regi_content regiContent,"
				+ " p.pet_no petNo, p.pet_name petName, p.pet_kind petKind,"
				+ " c.customer_no customerNo, c.customer_name customerName," + " e.emp_major empMajor"
				+ " FROM registration r" + " INNER JOIN pet p" + " ON r.pet_no = p.pet_no" + " INNER JOIN customer c"
				+ " ON p.customer_no = c.customer_no" + " INNER JOIN employee e" + " ON r.emp_no = e.emp_no"
				+ " WHERE r.regi_no = ?" + " ORDER BY r.regi_date DESC" + " LIMIT 1";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, regiNo);
		// 디버깅
		// System.out.println(stmt + " ====== ClinicDao#clinicUpdate() stmt");

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> info = new HashMap<String, Object>();
			info.put("regiNo", rs.getInt("regiNo"));
			info.put("regiDate", rs.getString("regiDate"));
			info.put("regiContent", rs.getString("regiContent"));
			info.put("petNo", rs.getInt("petNo"));
			info.put("petName", rs.getString("petName"));
			info.put("petKind", rs.getString("petKind"));
			info.put("customerNo", rs.getInt("customerNo"));
			info.put("customerName", rs.getString("customerName"));
			info.put("empMajor", rs.getString("empMajor"));
			list.add(info);
		}
		conn.close(); // db 자원 반납
		return list;
	}

	/*
	 * 메소드 : ClinicDao#clinicInsert() 
	 * 페이지 : clinicAction.jsp
	 * 시작 날짜 : 2024-05-30
	 * 담당자 : 김지훈 
	 */
	public static int clinicInsert(int regiNo) throws Exception {

		// 받아 온 값을 확인
		//System.out.println(regiNo  + " ====== ClinicDao#clinicInsert() regiNo");

		int insertRow = 0;
		Connection conn = DBHelper.getConnection();

		// Insert 시 중복된 regi_no가 있다면 엔터 후 추가 내용을 입력
		String sql = "INSERT INTO clinic(regi_no, create_date, update_date)"
				+ " VALUES(?, NOW(), NOW())";


		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, regiNo); // regiNo에 따른 진료 정보 수정

		// 디버깅
		//System.out.println(stmt  + " ====== ClinicDao#clinicUpdate() stmt");

		insertRow = stmt.executeUpdate();

		conn.close();		// db 자원 반납
		return insertRow;	// updateRow 반환
	}


	/*
	 * 메소드 : ClinicDatail#clinicDetail() 페이지 : clinicDetailFrom.jsp 시작 날짜 :
	 * 2024-05-26 담당자 : 김지훈
	 */

	public static ArrayList<HashMap<String, Object>> clinicDetail(int petNo) throws Exception {

		// 디버깅
		// System.out.println("ClinicDatail#clinicDetailByClinic() regiNo: " + regiNo);

		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		Connection conn = DBHelper.getConnection();
		/*
		 * String sql = "SELECT clinic_no clinicNo, regi_no regiNo," +
		 * " clinic_content clinicContent, create_date createDate," +
		 * " update_date updateDate" + " FROM clinic" + " WHERE regi_no = ?";
		 */

		String sql = "SELECT r.regi_no regiNo, cl.clinic_no clinicNo, cl.clinic_content clinicContent,"
				+ " cl.create_date createDate, cl.update_date updateDate" + " FROM pet p" + " INNER JOIN customer c"
				+ " ON p.customer_no = c.customer_no" + " INNER JOIN registration r" + " ON p.pet_no = r.pet_no"
				+ " INNER JOIN clinic cl" + " ON r.regi_no = cl.regi_no" + " WHERE p.pet_no = ?"
				+ " ORDER BY cl.update_date ASC;";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, petNo);

		// 디버깅
		// System.out.println("ClinicDatail#clinicDetailByClinic(): " + stmt);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> clinicList = new HashMap<String, Object>();
			clinicList.put("clinicNo", rs.getInt("clinicNo")); // 진료 번호
			clinicList.put("regiNo", rs.getInt("regiNo")); // 접수 번호
			clinicList.put("clinicContent", rs.getString("clinicContent")); // 진료 내용
			clinicList.put("createDate", rs.getString("createDate")); // 생성 일자
			clinicList.put("updateDate", rs.getString("updateDate")); // 수정 일자
			list.add(clinicList);
		}
		conn.close(); // db 자원 반납
		return list; // list를 반환
	}

	/*
	 * 메소드 : ClinicDao#clinicList() 페이지 : clinicList.jsp 시작 날짜 : 2024-05-23 담당자 :
	 * 한은혜
	 */
	public static ArrayList<HashMap<String, Object>> clinicList(int empNo) throws Exception {

		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연결
		Connection conn = DBHelper.getConnection();
		/*
		 * 진료 리스트 쿼리 조건 : 오늘 날짜의 진료 상태가 대기나 예약인 것, 사번이 로그인 사번과 같음 + 접수 정보(emp_no,
		 * regi_no, regi_content, regi_state, regi_date) + 동물 정보(pet_no, pet_name,
		 * pet_kind, pet_birth)
		 */
		String sql = "SELECT  r.emp_no empNo, r.regi_no regiNo, r.regi_content regiContent, r.regi_state regiState, r.regi_date regiDate,"
				+ " r.pet_no petNo, pet_name petName, pet_kind petKind, pet_birth petBirth,"
				+ " (SELECT COUNT(regi_no) FROM registration" + " 	WHERE DATE(regi_date) = DATE(NOW())"
				+ "		AND emp_no = ?" + "		AND (regi_state = '대기' OR regi_state ='예약')) totalRow" // 총 행 수
				+ " FROM registration r" + " LEFT JOIN pet p" + " ON r.pet_no = p.pet_no "
				+ " WHERE DATE(r.regi_date) = DATE(NOW())" // regi_date = 오늘 날짜
				+ " AND r.emp_no = ?" + " AND (r.regi_state = '대기' OR r.regi_state ='예약' OR r.regi_state = '진행')"
				+ " ORDER BY r.regi_date ASC";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, empNo);
		stmt.setInt(2, empNo);

		System.out.println(stmt + " ====== ClinicDao#clinicList stmt");

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> clinicList = new HashMap<String, Object>();
			clinicList.put("empNo", rs.getInt("empNo"));
			clinicList.put("regiNo", rs.getInt("regiNo"));
			clinicList.put("regiContent", rs.getString("regiContent"));
			clinicList.put("regiState", rs.getString("regiState"));
			clinicList.put("regiDate", rs.getString("regiDate"));
			clinicList.put("petNo", rs.getInt("petNo"));
			clinicList.put("petName", rs.getString("petName"));
			clinicList.put("petKind", rs.getString("petKind"));
			clinicList.put("petBirth", rs.getString("petBirth"));
			clinicList.put("totalRow", rs.getInt("totalRow"));

			list.add(clinicList);
		}

		conn.close();
		return list;
	}

}
