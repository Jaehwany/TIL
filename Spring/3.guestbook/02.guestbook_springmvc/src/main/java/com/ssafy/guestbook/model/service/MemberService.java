package com.ssafy.guestbook.model.service;

import java.util.Map;

import com.ssafy.guestbook.model.MemberDto;

public interface MemberService {

	int idCheck(String id) throws Exception;
	void registerMember(MemberDto memberDto) throws Exception;
	MemberDto login(Map<String, String> map) throws Exception;
	
//	MemberDto getMember(String id) throws Exception;
//	void updateMember(MemberDto memberDto) throws Exception;
//	void deleteMember(String id) throws Exception;
	
}
