package com.ssafy.guestbook.model.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ssafy.guestbook.model.GuestBookDto;

public interface GuestBookDao {

	public void writeArticle(GuestBookDto guestBookDto) throws SQLException;
	public List<GuestBookDto> listArticle(Map<String, String> map) throws SQLException;
	public int getTotalCount(Map<String, String> map) throws SQLException;
	
	public GuestBookDto getArticle(int articleno) throws SQLException;
	public void modifyArticle(GuestBookDto guestBookDto) throws SQLException;
	public void deleteArticle(int articleno) throws SQLException;
	
}
