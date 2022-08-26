package com.study.service;

import java.util.List;

import com.study.dao.EmpDao;
import com.study.dto.EmpDTO;

public interface EmpService {
	public int insertEmp(EmpDTO emp);
	public List<EmpDTO> listEmp();
	public int updateEmp(EmpDTO entity);
	public int deleteEmp(EmpDTO entity);
}











