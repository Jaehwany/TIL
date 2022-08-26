package com.ssafy.guestbook.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.guestbook.model.GuestBookDto;
import com.ssafy.util.PageNavigation;

public interface GuestBookService {

	void registerArticle(GuestBookDto guestBookDto) throws Exception;
	List<GuestBookDto> listArticle(Map<String, String> map) throws Exception;
	PageNavigation makePageNavigation(Map<String, String> map) throws Exception;
	GuestBookDto getArticle(int articleNo) throws Exception;
	void updateArticle(GuestBookDto guestBookDto) throws Exception;
	void deleteArticle(int articleNo) throws Exception;
	
}
