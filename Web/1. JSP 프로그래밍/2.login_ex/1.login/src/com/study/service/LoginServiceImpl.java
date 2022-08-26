package com.study.service;

import com.study.dao.LoginDaoImpl;
import com.study.dto.LoginDTO;

public class LoginServiceImpl implements LoginService{
	public static LoginServiceImpl loginService;
	
	public static LoginService getLoginDaoImpl() {
		if(loginService==null) {
			loginService=new LoginServiceImpl();
		}
		return loginService;
	}

	public LoginDTO getLoginUser(String id, String pwd) {
		return LoginDaoImpl.getLoginDao().getLoginUser(id, pwd);
	}
}
