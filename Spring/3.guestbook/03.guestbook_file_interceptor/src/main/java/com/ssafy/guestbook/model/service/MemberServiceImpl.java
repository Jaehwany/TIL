package com.ssafy.guestbook.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.guestbook.model.MemberDto;
import com.ssafy.guestbook.model.dao.MemberDao;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Override
	public int idCheck(String id) throws Exception {
		return memberDao.idCheck(id); // 0 or 1
	}

	@Override
	public void registerMember(MemberDto memberDto) throws Exception {
//		validation check
		memberDao.registerMember(memberDto);
	}

	@Override
	public MemberDto login(Map<String, String> map) throws Exception {
		return memberDao.login(map);
	}

}
