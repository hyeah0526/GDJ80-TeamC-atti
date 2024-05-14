package atti;

import java.sql.*;
import java.util.*;

public class EmpDao {
	
	/*
	  	메소드: EmpDao#login()
	  	페이지: loginAction.jsp
	  	시작날짜: 2024-05-10
	  	담당자: 김인수
	*/
	public static HashMap<String, Object> login(int empNo, String empPw)throws Exception{
		
		//매개변수 값 출력
		//System.out.println("empNo = " + empNo);
		//System.out.println("empPw = " + empPw);
		
		//반환 값 변수
		HashMap<String, Object> resultMap = null;
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
	
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		//사용자 인증: 입력된 사번과 비밀번호가 일치하는 직원의 정보 조회
		String sql = "SELECT emp_no, emp_grade, emp_name "
				+ "FROM employee "
				+ "WHERE emp_no=? AND emp_pw = password(?)";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, empNo); //사용자의 사번
		stmt.setString(2, empPw); // 사용자의 비밀번호
		rs = stmt.executeQuery();
		
		
		if(rs.next()) {
			resultMap = new HashMap<>();
			resultMap.put("empNo",rs.getString("emp_no")); // 사용자의 사번 
			resultMap.put("empGrade",rs.getString("emp_grade"));  // 사용자의 직급
			resultMap.put("empName",rs.getString("emp_name"));  // 사용자의 아이디
		}
		
		//resultMap 값 디버깅
		//System.out.println(resultMap.get("empNo"));
		//System.out.println(resultMap.get("empGrade"));
		//System.out.println(resultMap.get("empName"));
		
		conn.close();
		return resultMap;
		
	}
	
	
	/*
	  	메소드: EmpDao#empPwUpdate()
	  	페이지: empPwUpdateAction.jsp
	  	시작날짜: 2024-05-12
	  	담당자: 김인수
	*/
	public static int empPwUpdate(String currentPw, String newPw, int empNo) throws Exception{
		
		//매개변수 값 출력
		//System.out.println("currentPw = " + currentPw);
		//System.out.println("newPw = " + newPw);
		//System.out.println("empNo = " + empNo);
		
		//반환 값 변수
		int updateRow = 0;
		
		PreparedStatement stmt = null;
	
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		//사용자의 새 비밀번호 업데이트: 새 비밀번호가 현재 비밀번호나 과거에 사용된 비밀번호와 다를 경우에만 업데이트
		String sql = "UPDATE employee SET emp_pw = PASSWORD(?) "
				+ "WHERE emp_no = ? AND emp_pw = PASSWORD(?) AND PASSWORD(?) <> PASSWORD(?) "
				+ "AND NOT EXISTS ("
				+ "    SELECT 1 FROM password_history "
				+ "    WHERE emp_no = ? AND previous_pw = PASSWORD(?)"
				+ ")";
	
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw); //변경할 비밀번호
		stmt.setInt(2, empNo); // 사용자의 사번
		stmt.setString(3, currentPw); //기존 비밀번호
		stmt.setString(4, currentPw); 
		stmt.setString(5, newPw); 
		stmt.setInt(6, empNo); 
		stmt.setString(7, newPw); 
		updateRow = stmt.executeUpdate();
		
		conn.close();
		return updateRow;
	}
	
	
	/*
	  	메소드: EmpDao#empPwHistory()
	  	페이지: empPwUpdateAction.jsp
	  	시작날짜: 2024-05-12
	  	담당자: 김인수
	 */
	public static int empPwHistory(int empNo, String previousPw) throws Exception{
		
		//매개변수 값 출력
		//System.out.println("empNo = " + empNo);
		//System.out.println("previousPw = " + previousPw);
		
		//반환 값 변수
		int insertRow = 0;
		PreparedStatement stmt = null;
		
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		//비밀번호 변경 이력 저장: 직원의 이전 비밀번호를 저장
		String sql = "INSERT INTO password_history (emp_no, previous_pw, update_date) "
				+ "VALUES (?,PASSWORD(?),NOW())";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, empNo); // 사용자의 사번
		stmt.setString(2, previousPw); //사용자가 변경한 비밀번호
		insertRow = stmt.executeUpdate();
		
		conn.close();
		return insertRow;
	}
	
	
	/*
	  	메소드: EmpDao#empAll()
	  	페이지: empList.jsp
	  	시작날짜: 2024-05-13
	  	담당자: 김인수
	*/
	public static  ArrayList<HashMap<String, Object>> empAll(String searchWord, String empGrade, int startRow, int rowPerPage) throws Exception{
		
		//매개변수 값 출력
		//System.out.println("searchWord = " + searchWord);
		//System.out.println("startRow = " + startRow);
		//System.out.println("rowPerPage = " + rowPerPage);
		
		//반환 값 변수
		ArrayList<HashMap<String, Object>> resultMap = new ArrayList<>();
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		//직원조회(이름): 사용자가 입력한 이름, 직책을 포함하는 모든 직원 정보 조회
		String sql =  "SELECT emp_no, emp_grade, emp_name,  COUNT(*) OVER() cnt "
		           + "FROM employee "
		           + "WHERE emp_name LIKE ? AND emp_grade LIKE ? ORDER BY hire_date DESC LIMIT ?,?";

		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchWord+"%"); 
		stmt.setString(2, empGrade);
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage); 
		rs = stmt.executeQuery();
		
		
		
		while(rs.next()) {
			HashMap<String, Object> emplist = new HashMap<String, Object>();
			emplist.put("empNo",rs.getString("emp_no")); // 사용자의 사번 
			emplist.put("empGrade",rs.getString("emp_grade"));  // 사용자의 직급
			emplist.put("empName",rs.getString("emp_name"));  // 사용자의 아이디
			emplist.put("cnt",rs.getString("cnt"));  // 전체인원
			resultMap.add(emplist);
		}
		
		//디버깅
		//System.out.println("resultMap = " + resultMap);
		
		conn.close();
		return resultMap;
	}
	
	
	/*
	  	메소드: EmpDao#empDetail()
	  	페이지: empDetail.jsp
	  	시작날짜: 2024-05-13
	  	담당자: 김인수
	*/
	public static  ArrayList<HashMap<String, Object>> empDetail(int empNo) throws Exception{
		
		//매개변수 값 출력
		//System.out.println("empNo = " + empNo);
		
		//반환 값 변수
		ArrayList<HashMap<String, Object>> resultMap = new ArrayList<>();
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		//직원 정보 상세 조회: 선택된 직원의 정보 상세 조회
		String sql = "SELECT emp_no, emp_major, emp_grade, emp_name, emp_birth, emp_gender, emp_tel, hire_date "
				+ "FROM employee "
				+ "WHERE emp_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, empNo);
		rs = stmt.executeQuery();
		
		
		if(rs.next()) {
			HashMap<String, Object> empList = new HashMap<String, Object>();
			empList.put("empNo",rs.getString("emp_no")); // 사용자의 사번 
			empList.put("empMajor",rs.getString("emp_major"));  // 사용자의 전공
			empList.put("empGrade",rs.getString("emp_grade"));  // 사용자의 직급
			empList.put("empName",rs.getString("emp_name"));  // 사용자의 아이디
			empList.put("empBirth",rs.getString("emp_birth"));  // 사용자의 생일
			empList.put("empGender",rs.getString("emp_gender"));  // 사용자의 성별
			empList.put("empTel",rs.getString("emp_tel"));  // 사용자의 전화번호
			empList.put("hireDate",rs.getString("hire_date"));  // 사용자의 입사일
			resultMap.add(empList);
		}
		
		//디버깅
		//System.out.println("resultMap = " + resultMap);
		
		conn.close();
		return resultMap;
	}
	
	
	/*
	  	메소드: EmpDao#empUpdate()
	  	페이지: empUpdateAction.jsp
	  	시작날짜: 2024-05-14
	  	담당자: 김인수
	*/
	public static int empUpdate(int empNo, String empMajor, String empTel) throws Exception{
		
		//매개변수 값 출력
		//System.out.println("empNo = " + empNo);
		//System.out.println("empMajor = " + empMajor);
		//System.out.println("empTel = " + empTel);
		
		
		//반환 값 변수
		int updateRow = 0;
		
		PreparedStatement stmt = null;
		
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		//직원 정보 변경: 직원의 전공 또는 전화번호 변경
		String sql = "UPDATE employee SET emp_major = ? , emp_tel = ? WHERE emp_no = ? ";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, empMajor); //변경될 직원의 전공
		stmt.setString(2, empTel); //변경될 직원의 전화번호
		stmt.setInt(3, empNo); // 선택된 직원의 사번

		updateRow = stmt.executeUpdate();
		
		conn.close();
		return updateRow;
	}
	
	
	/*
	  	메소드: EmpDao#empDelete()
	  	페이지: empDeleteAction.jsp
	  	시작날짜: 2024-05-14
	  	담당자: 김인수
	*/
	public static int empDelete(int empNo, String empGrade) throws Exception{
		
		//매개변수 값 출력
		//System.out.println("empNo = " + empNo);
		//System.out.println("empMajor = " + empMajor);
		//System.out.println("empTel = " + empTel);
		
		//반환 값 변수
		int updateRow = 0;
		
		PreparedStatement stmt = null;
		
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		//직원 정보 변경: 직원 퇴사 처리  
		String sql = "UPDATE employee SET emp_grade = ? WHERE emp_no = ? AND emp_grade = ? ";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "퇴사자"); //직원 퇴사처리
		stmt.setInt(2, empNo); // 퇴사한 직원의 사번
		stmt.setString(3, empGrade); // 퇴사한 직원의 직급

		updateRow = stmt.executeUpdate();
		
		conn.close();
		return updateRow;
	}
}
