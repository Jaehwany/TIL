package com.study.dao;

import com.study.dto.LoginDTO;

//DAO(Data Access Object):데이터베이스와 연동해서 CRUD를 처리
public interface LoginDao {
	public LoginDTO getLoginUser(String id, String pwd);
}