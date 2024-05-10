package atti;

import java.sql.*;

public class DBHelper {
	public static Connection getConnection() throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		
		String id = "root";
		String pw = "java1234";
		
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/atti", id, pw);
		//System.out.println(conn+"연결");
		
		return conn;
	}
	
	public static void main(String[] args) throws Exception {
		DBHelper.getConnection(); 
		System.out.print("연결완료");
	}
}