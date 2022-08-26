package com.study.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.study.dto.EmpDTO;

import common.DBConnection;

public class EmpDaoImpl implements EmpDao {
	public static EmpDaoImpl empDao;
	
	public static EmpDao getEmpDao() {
		if(empDao == null) {
			empDao=new EmpDaoImpl();
		}
		return empDao;
	}
	//추가하기------------------------------------------------------
	public int insertEmp(EmpDTO dto) {
		String sql="insert into emp(eno,ename,phone,dept) values(eno,?,?,?)";
		
		try (Connection conn = DBConnection.getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setString(1, dto.getEname());
			pstmt.setString(2, dto.getPhone());
			pstmt.setString(3, dto.getDept());
			return pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	//전체보기---------------------------------------------------
	public List<EmpDTO> listEmp() {
		List<EmpDTO> list=new ArrayList<>();
		EmpDTO dto=null;
		String sql="select * from emp order by eno desc";
		
		try (Connection conn = DBConnection.getConnection(); 
		     PreparedStatement pstmt = conn.prepareStatement(sql); 
			 ResultSet rs = pstmt.executeQuery();) {
			
			while(rs.next()) {
				dto=new EmpDTO();
				dto.setEno(rs.getInt("eno"));
				dto.setEname(rs.getString("ename"));
				dto.setPhone(rs.getString("phone"));
				dto.setDept(rs.getString("dept"));
				list.add(dto);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	//수정하기-------------------------------------------------------
	public int updateEmp(EmpDTO dto) {
		String sql="update emp set phone=?,dept=? where eno=?";
		
		try (Connection conn = DBConnection.getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setString(1, dto.getPhone());
			pstmt.setString(2, dto.getDept());
			pstmt.setInt(3, dto.getEno());
			return pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	//-----------------------------------------------------------------
	public int deleteEmp(EmpDTO dto) {
		String sql="delete from emp where eno=?";
		
		try (Connection conn = DBConnection.getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, dto.getEno());
			return pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}	
}
