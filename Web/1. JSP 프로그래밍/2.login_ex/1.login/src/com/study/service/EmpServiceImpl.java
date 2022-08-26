package com.study.service;

import java.util.List;

import com.study.dao.EmpDao;
import com.study.dao.EmpDaoImpl;
import com.study.dto.EmpDTO;

public class EmpServiceImpl implements EmpService{
	public static EmpServiceImpl empService;
	
	public static EmpService getEmpService() {
		if(empService == null) {
			empService=new EmpServiceImpl();
		}
		return empService;
	}
	//------------------------------------------------------
	public int insertEmp(EmpDTO emp) {
		return EmpDaoImpl.getEmpDao().insertEmp(emp);
	}

	public List<EmpDTO> listEmp() {
		return EmpDaoImpl.getEmpDao().listEmp();
	}
	
	public int updateEmp(EmpDTO dto) {
		return EmpDaoImpl.getEmpDao().updateEmp(dto);
	}
	
	public int deleteEmp(EmpDTO dto) {
		return EmpDaoImpl.getEmpDao().deleteEmp(dto);
	}
}
