package atti;

import java.sql.*;
import java.util.*;

public class EmpDao {
	
	public static HashMap<String, Object> login(int empNo, String empPw)throws Exception{
		
		HashMap<String, Object> resultMap = null;
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
	
		//DB연결 
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT emp_no, emp_grade, emp_name FROM employee WHERE emp_no=? AND emp_pw = password(?)";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, empNo);
		stmt.setString(2, empPw);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("empNo",rs.getString("emp_no")); 
			resultMap.put("empGrade",rs.getString("emp_grade")); 
			resultMap.put("empName",rs.getString("emp_name")); 
		}
		
		conn.close();
		return resultMap;
		
	}
}
