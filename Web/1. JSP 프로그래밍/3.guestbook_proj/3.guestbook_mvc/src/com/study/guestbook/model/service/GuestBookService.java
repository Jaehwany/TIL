package com.study.guestbook.model.service;

import java.util.List;

import com.study.guestbook.model.GuestBookDto;
import com.study.util.PageNavigation;

public interface GuestBookService {

	void registerArticle(GuestBookDto guestBookDto) throws Exception;
	List<GuestBookDto> listArticle(String pg, String key, String word) throws Exception;
	PageNavigation makePageNavigation(String pg, String key, String word) throws Exception;
	
//	구현해 보세요!!!
	GuestBookDto getArticle(int articleNo) throws Exception;
	void updateArticle(GuestBookDto guestBookDto) throws Exception;
	void deleteArticle(int articleNo) throws Exception;
	
}
