package com.book.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.book.dto.LoginDTO;
import common.DBConnection;

public class LoginDaoImpl implements LoginDao{
	public static LoginDaoImpl loginDao;
	
	public static LoginDao getLoginDao() {
		if(loginDao==null) {
			loginDao=new LoginDaoImpl();
		}
		return loginDao;
	}
	
	@Override
	public boolean getLoginUser(String userid, String userpwd) {
		boolean ck=false;
		String sql="select * from member where userid=? and userpwd=?";
		
		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setString(1, userid);
			pstmt.setString(2, userpwd);
			
			try ( ResultSet rs = pstmt.executeQuery();) {
				if(rs.next()) {
					ck=true;
				}
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return ck;
	}
}
