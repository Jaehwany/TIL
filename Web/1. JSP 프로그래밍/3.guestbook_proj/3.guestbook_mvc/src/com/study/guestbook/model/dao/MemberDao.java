package com.study.guestbook.model.dao;

import java.sql.SQLException;

import com.study.guestbook.model.MemberDto;

public interface MemberDao {

	int idCheck(String id);
	void registerMember(MemberDto memberDto) throws SQLException;
	MemberDto login(String id, String pass) throws SQLException;
	
}
