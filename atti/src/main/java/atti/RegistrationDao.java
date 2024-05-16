package atti;

import java.sql.*;

public class RegistrationDao {
	
	/*
	 * 메소드		: #regiStateStateUpdate(int regiNo) ==> 추후 regiDAO로 이동예정!
	 * 페이지		: paymentDetail.jsp
	 * 시작 날짜	: 2024-05-16
	 * 담당자		: 박혜아 
	*/
	public static int regiStateStateUpdate(int regiNo) throws Exception{
		int updateRow = 0;
		
		//받아온 값 디버깅
		System.out.println("PaymentDao#regiStateStateUpdate() regiNo--> "+regiNo);
		
		//DB연결
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		
		// '진행' -> '완료'로 상태변경
		String sql = "UPDATE registration "
				+ " SET regi_state = '완료'"
				+ " WHERE regi_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, regiNo);
		System.out.println("PaymentDao#regiStateStateUpdate() stmt --> "+stmt);
		
		updateRow = stmt.executeUpdate();
		System.out.println("PaymentDao#paymentStateUpdate() updateRow --> "+updateRow);
		
		conn.close();
		return updateRow;
	}

}
