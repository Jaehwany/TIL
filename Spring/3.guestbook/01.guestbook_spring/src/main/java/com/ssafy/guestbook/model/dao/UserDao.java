package com.ssafy.guestbook.model.dao;

import java.sql.SQLException;
import java.util.Map;

import com.ssafy.guestbook.model.MemberDto;

public interface UserDao {

	public MemberDto login(Map<String, String> map) throws SQLException;
	
}
