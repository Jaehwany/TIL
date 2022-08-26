package com.study.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.study.dto.EmpDTO;

public interface EmpDao {
	public int insertEmp(EmpDTO emp);
	public List<EmpDTO> listEmp();
	public int updateEmp(EmpDTO dto);
	public int deleteEmp(EmpDTO dto);
}













