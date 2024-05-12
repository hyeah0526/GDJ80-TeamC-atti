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
		
		HashMap<String, Object> resultMap = null;
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
	
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		
		String sql = "SELECT emp_no, emp_grade, emp_name "
				+ "FROM employee "
				+ "WHERE emp_no=? AND emp_pw = password(?)";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, empNo); //사용자의 사번
		stmt.setString(2, empPw); // 사용자의 비밀번호
		rs = stmt.executeQuery();
		
		
		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
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

		int updateRow = 0;
		
		PreparedStatement stmt = null;
	
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		// 사용자의 새 비밀번호가 현재 비밀번호 또는 과거 비밀번호와 다를 때만 업데이트
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
		
		int insertRow = 0;
		PreparedStatement stmt = null;
		
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO password_history (emp_no, previous_pw, update_date) "
				+ "VALUES (?,PASSWORD(?),NOW())";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, empNo); // 사용자의 사번
		stmt.setString(2, previousPw); //사용자가 변경한 비밀번호
		insertRow = stmt.executeUpdate();
		
		conn.close();
		return insertRow;
	}
	
}
