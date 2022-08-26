package com.study.guestbook.model.service;

import java.util.List;

import com.study.guestbook.model.GuestBookDto;
import com.study.guestbook.model.ListParameterDto;
import com.study.guestbook.model.dao.GuestBookDao;
import com.study.guestbook.model.dao.GuestBookDaoImpl;
import com.study.util.PageNavigation;

public class GuestBookServiceImpl implements GuestBookService {
	
	private GuestBookDao guestBookDao = GuestBookDaoImpl.getGuestBookDao();
	
	private static GuestBookService guestBookService = new GuestBookServiceImpl();
	
	private GuestBookServiceImpl() {}

	public static GuestBookService getGuestBookService() {
		return guestBookService;
	}

	@Override
	public void registerArticle(GuestBookDto guestBookDto) throws Exception {
		guestBookDao.registerArticle(guestBookDto);
	}

	@Override
	public List<GuestBookDto> listArticle(String pg, String key, String word) throws Exception {
		int pgno = pg != null ? Integer.parseInt(pg) : 1;
		int countPerPage = 10;
		int start= (pgno - 1) * countPerPage;
		
		ListParameterDto listParameterDto = new ListParameterDto();
		listParameterDto.setKey(key == null ? "" : key.trim());
		listParameterDto.setWord(word == null ? "" : word.trim());
		listParameterDto.setStart(start);
		listParameterDto.setCurrentPerPage(countPerPage);
		return guestBookDao.listArticle(listParameterDto);
	}
	
	@Override
	public PageNavigation makePageNavigation(String pg, String key, String word) throws Exception {
		PageNavigation pageNavigation = new PageNavigation();
		int currentPage = pg != null ? Integer.parseInt(pg) : 1;
		int naviSize = 5;
		int countPerPage = 10;
		pageNavigation.setCurrentPage(currentPage);
		pageNavigation.setCountPerPage(countPerPage);
		pageNavigation.setNaviSize(naviSize);
		
		ListParameterDto listParameterDto = new ListParameterDto();
		listParameterDto.setKey(key == null ? "" : key.trim());
		listParameterDto.setWord(word == null ? "" : word.trim());
		
		int totalCount = guestBookDao.getTotalCount(listParameterDto);
		pageNavigation.setTotalCount(totalCount);
		int totalPageCount = (totalCount - 1) / countPerPage + 1;
		pageNavigation.setTotalPageCount(totalPageCount);
		pageNavigation.setStartRange(currentPage <= naviSize);
		boolean endRange = (totalPageCount - 1) / naviSize * naviSize < currentPage;
		pageNavigation.setEndRange(endRange);
		pageNavigation.makeNavigator();
		return pageNavigation;
	}

	@Override
	public GuestBookDto getArticle(int articleNo) throws Exception {
		return guestBookDao.getArticle(articleNo);
	}

	@Override
	public void updateArticle(GuestBookDto guestBookDto) throws Exception {
		guestBookDao.updateArticle(guestBookDto);
	}

	@Override
	public void deleteArticle(int articleNo) throws Exception {
		guestBookDao.deleteArticle(articleNo);
	}

}




















