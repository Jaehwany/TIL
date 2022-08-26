package com.study.guestbook.model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.study.guestbook.model.GuestBookDto;
import com.study.guestbook.model.ListParameterDto;
import com.study.util.DBUtil;

public class GuestBookDaoImpl implements GuestBookDao {
	
	private DBUtil dbUtil = DBUtil.getInstance();
	
	private static GuestBookDao guestBookDao = new GuestBookDaoImpl();
	
	private GuestBookDaoImpl() {}

	public static GuestBookDao getGuestBookDao() {
		return guestBookDao;
	}

	@Override
	public void registerArticle(GuestBookDto guestBookDto) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = dbUtil.getConnection();
			StringBuilder registerArticle = new StringBuilder();
			registerArticle.append("insert into guestbook (userid, subject, content, regtime) \n");
			registerArticle.append("values (?, ?, ?, now())");
			pstmt = conn.prepareStatement(registerArticle.toString());
			pstmt.setString(1, guestBookDto.getUserId());
			pstmt.setString(2, guestBookDto.getSubject());
			pstmt.setString(3, guestBookDto.getContent());
			pstmt.executeUpdate();
		} finally {
			dbUtil.close(pstmt, conn);
		}
	}

	@Override
	public List<GuestBookDto> listArticle(ListParameterDto listParameterDto) throws SQLException {
		List<GuestBookDto> list = new ArrayList<GuestBookDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			StringBuilder listArticle = new StringBuilder();
			listArticle.append("select g.articleno, g.userid, g.subject, g.content, m.username,  \n");
			listArticle.append(" 		case when date_format(g.regtime, '%y%m%d') = date_format(now(), '%y%m%d') \n");
			listArticle.append("			then date_format(g.regtime, '%H:%i:%d') \n");
			listArticle.append("			else date_format(g.regtime, '%y.%m.%d') \n");
			listArticle.append("		end regtime \n");
			listArticle.append("from guestbook g, member m \n");
			listArticle.append("where g.userid = m.userid \n");
			String key = listParameterDto.getKey();
			String word = listParameterDto.getWord();
			if(!word.isEmpty()) {
				if(key.equals("subject")) {
					listArticle.append("and g.subject like concat('%', ?, '%') \n");
				} else {
					listArticle.append("and g." + key + " = ? \n");
				}
			}
			listArticle.append("order by g.articleno desc limit ?, ? \n");
			pstmt = conn.prepareStatement(listArticle.toString());
			int idx = 0;
			if(!word.isEmpty()) {
				pstmt.setString(++idx, word);
			}
			pstmt.setInt(++idx, listParameterDto.getStart());
			pstmt.setInt(++idx, listParameterDto.getCurrentPerPage());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				GuestBookDto guestBookDto = new GuestBookDto();
				guestBookDto.setArticleNo(rs.getInt("articleno"));
				guestBookDto.setUserId(rs.getString("userid"));
				guestBookDto.setUserName(rs.getString("username"));
				guestBookDto.setSubject(rs.getString("subject").replace("<", "&lt;"));
				guestBookDto.setContent(rs.getString("content"));
				guestBookDto.setRegTime(rs.getString("regtime"));
				
				list.add(guestBookDto);
			}
		} finally {
			dbUtil.close(rs, pstmt, conn);
		}
		return list;
	}
	
	@Override
	public int getTotalCount(ListParameterDto listParameterDto) throws SQLException {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			StringBuilder listArticle = new StringBuilder();
			listArticle.append("select count(articleno) \n");
			listArticle.append("from guestbook \n");
			String key = listParameterDto.getKey();
			String word = listParameterDto.getWord();
			if(!word.isEmpty()) {
				if(key.equals("subject")) {
					listArticle.append("where subject like concat('%', ?, '%') \n");
				} else {
					listArticle.append("where " + key + " = ? \n");
				}
			}

			pstmt = conn.prepareStatement(listArticle.toString());
			if(!word.isEmpty())
				pstmt.setString(1, word);
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1);
		} finally {
			dbUtil.close(rs, pstmt, conn);
		}
		return cnt;
	}

	@Override
	public GuestBookDto getArticle(int articleNo) throws SQLException {
		GuestBookDto guestBookDto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			StringBuilder listArticle = new StringBuilder();
			listArticle.append("select g.articleno, g.userid, g.subject, g.content, m.username,  g.regtime \n");
			listArticle.append("from guestbook g, member m \n");
			listArticle.append("where g.userid = m.userid \n");
			listArticle.append("and g.articleno = ? \n");
			System.out.println(listArticle.toString());
			pstmt = conn.prepareStatement(listArticle.toString());
			pstmt.setInt(1, articleNo);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				guestBookDto = new GuestBookDto();
				guestBookDto.setArticleNo(rs.getInt("articleno"));
				guestBookDto.setUserId(rs.getString("userid"));
				guestBookDto.setUserName(rs.getString("username"));
				guestBookDto.setSubject(rs.getString("subject"));
				guestBookDto.setContent(rs.getString("content"));
				guestBookDto.setRegTime(rs.getString("regtime"));
			}
		} finally {
			dbUtil.close(rs, pstmt, conn);
		}
		return guestBookDto;
	}

	@Override
	public void updateArticle(GuestBookDto guestBookDto) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = dbUtil.getConnection();
			StringBuilder updateArticle = new StringBuilder();
			updateArticle.append("update guestbook \n");
			updateArticle.append("set subject = ?, content = ? \n");
			updateArticle.append("where articleno = ?");
			pstmt = conn.prepareStatement(updateArticle.toString());
			pstmt.setString(1, guestBookDto.getSubject());
			pstmt.setString(2, guestBookDto.getContent());
			pstmt.setInt(3, guestBookDto.getArticleNo());
			pstmt.executeUpdate();
		} finally {
			dbUtil.close(pstmt, conn);
		}
	}

	@Override
	public void deleteArticle(int articleNo) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = dbUtil.getConnection();
			StringBuilder updateArticle = new StringBuilder();
			updateArticle.append("delete from guestbook \n");
			updateArticle.append("where articleno = ?");
			pstmt = conn.prepareStatement(updateArticle.toString());
			pstmt.setInt(1, articleNo);
			pstmt.executeUpdate();
		} finally {
			dbUtil.close(pstmt, conn);
		}
	}

	

}
