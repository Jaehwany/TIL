package com.study.service;

import com.study.dto.LoginDTO;

public interface LoginService {
	public LoginDTO getLoginUser(String id, String pwd);
}
