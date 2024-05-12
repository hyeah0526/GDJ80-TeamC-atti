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
		
		
		String sql = "SELECT emp_no, emp_grade, emp_name FROM employee WHERE emp_no=? AND emp_pw = password(?)";
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
		
		conn.close();
		return resultMap;
		
	}
}
