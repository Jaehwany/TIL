package com.study.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.study.dto.LoginDTO;

import common.DBConnection;

public class LoginDaoImpl implements LoginDao{
	public static LoginDaoImpl loginDaoImpl;
	
	public static LoginDao getLoginDao() {
		if(loginDaoImpl==null) {
			loginDaoImpl=new LoginDaoImpl();
		}
		return loginDaoImpl;
	}
	//--------------------------------------------------------------------
	public LoginDTO getLoginUser(String id, String pwd) {
		LoginDTO dto=null;
		String sql="select * from users where id=? and pwd=?";
		
		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			
			try ( ResultSet rs = pstmt.executeQuery();) {
				if(rs.next()) {
					dto=new LoginDTO();
					dto.setId(rs.getString("id"));  //컬럼명은 대.소문자 상관없음
					dto.setPwd(rs.getString("pwd"));
					dto.setName(rs.getString("name"));
					dto.setPoint(rs.getDouble("point"));
				}
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return dto;
	}
}
