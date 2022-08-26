package com.ssafy.guestbook.model.dao;

import java.util.List;
import java.util.Map;

import com.ssafy.guestbook.model.GuestBookDto;

public interface GuestBookDao {
	
	void registerArticle(GuestBookDto guestBookDto) throws Exception;
	List<GuestBookDto> listArticle(Map<String, Object> map) throws Exception;
	int getTotalCount(Map<String, String> map) throws Exception;
	GuestBookDto getArticle(int articleNo) throws Exception;
	void updateArticle(GuestBookDto guestBookDto) throws Exception;
	void deleteArticle(int articleNo) throws Exception;
	
}
