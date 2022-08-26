package com.ssafy.guestbook.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.guestbook.model.FileInfoDto;
import com.ssafy.guestbook.model.GuestBookDto;
import com.ssafy.util.DBUtil;

@Repository
public class GuestBookDaoImpl implements GuestBookDao {
	
	@Autowired
	private DBUtil dbUtil;
	
	@Autowired
	private DataSource dataSource;

	@Override
	public void registerArticle(GuestBookDto guestBookDto) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			StringBuilder registerArticle = new StringBuilder();
			registerArticle.append("insert into guestbook (userid, subject, content, regtime) \n");
			registerArticle.append("values (?, ?, ?, now())");
			pstmt = conn.prepareStatement(registerArticle.toString());
			pstmt.setString(1, guestBookDto.getUserId());
			pstmt.setString(2, guestBookDto.getSubject());
			pstmt.setString(3, guestBookDto.getContent());
			pstmt.executeUpdate();
			pstmt.close();
			
			List<FileInfoDto> fileInfos = guestBookDto.getFileInfos();
	
			if(fileInfos!=null)
			{
				String lastNo = "select last_insert_id()";
				pstmt = conn.prepareStatement(lastNo);
				rs = pstmt.executeQuery();
				rs.next();
				int articleno = rs.getInt(1);
				pstmt.close();
				if(!fileInfos.isEmpty()) {
					StringBuilder reigsterFile = new StringBuilder();
					reigsterFile.append("insert into file_info (articleno, savefolder, originfile, savefile) \n");
					reigsterFile.append("values");
					int size = fileInfos.size();
					for(int i=0;i<size;i++) {
						reigsterFile.append("(?, ?, ?, ?)");
						if(i != fileInfos.size() - 1)
							reigsterFile.append(",");
					}
					pstmt = conn.prepareStatement(reigsterFile.toString());
					int idx = 0;
					for(int i=0;i<size;i++) {
						FileInfoDto fileInfo = fileInfos.get(i);
						pstmt.setInt(++idx, articleno);
						pstmt.setString(++idx, fileInfo.getSaveFolder());
						pstmt.setString(++idx, fileInfo.getOriginFile());
						pstmt.setString(++idx, fileInfo.getSaveFile());
					}
					pstmt.executeUpdate();
				}
			}
			conn.commit();
		
		} catch(SQLException e) {
			e.printStackTrace();
			conn.rollback();
		} finally {
			dbUtil.close(rs, pstmt, conn);
		}
	}

	@Override
	public List<GuestBookDto> listArticle(Map<String, Object> map) throws Exception {
		List<GuestBookDto> list = new ArrayList<GuestBookDto>();
		
		String key = (String) map.get("key");
		String word = (String) map.get("word");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dataSource.getConnection();
			StringBuilder listArticle = new StringBuilder();
			listArticle.append("select g.articleno, g.userid, g.subject, g.content, g.regtime, m.username \n");
			listArticle.append("from guestbook g, ssafy_member m \n");
			listArticle.append("where g.userid = m.userid \n");
			if(!word.isEmpty()) {
				if(key.equals("subject"))
					listArticle.append("and g.subject like ? \n");
				else 
					listArticle.append("and g." + key + " = ? \n");
			}
			listArticle.append("order by g.articleno desc \n");
			listArticle.append("limit ?, ?");
			pstmt = conn.prepareStatement(listArticle.toString());
			int idx = 0;
			if(!word.isEmpty()) {
				if(key.equals("subject"))
					pstmt.setString(++idx, "%" + word + "%");
				else 
					pstmt.setString(++idx, word);
			}
			pstmt.setInt(++idx, (int) map.get("start"));
			pstmt.setInt(++idx, (int) map.get("spp"));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				GuestBookDto guestBookDto = new GuestBookDto();
				int articleno = rs.getInt("articleno");
				guestBookDto.setArticleNo(articleno);
				guestBookDto.setUserId(rs.getString("userid"));
				guestBookDto.setUserName(rs.getString("username"));
				guestBookDto.setSubject(rs.getString("subject"));
				guestBookDto.setContent(rs.getString("content"));
				guestBookDto.setRegTime(rs.getString("regtime"));
				
				PreparedStatement pstmt2 = null;
				ResultSet rs2 = null;
				try {
					StringBuilder fileInfos = new StringBuilder();
					fileInfos.append("select savefolder, originfile, savefile \n");
					fileInfos.append("from file_info \n");
					fileInfos.append("where articleno = ?");
					pstmt2 = conn.prepareStatement(fileInfos.toString());
					pstmt2.setInt(1, articleno);
					rs2 = pstmt2.executeQuery();
					List<FileInfoDto> files = new ArrayList<FileInfoDto>();
					while(rs2.next()) {
						FileInfoDto fileInfoDto = new FileInfoDto();
						fileInfoDto.setSaveFolder(rs2.getString("savefolder"));
						fileInfoDto.setOriginFile(rs2.getString("originfile"));
						fileInfoDto.setSaveFile(rs2.getString("savefile"));
						
						files.add(fileInfoDto);
					}
					
					guestBookDto.setFileInfos(files);
				} finally {
					dbUtil.close(rs2, pstmt2);
				}
				
				list.add(guestBookDto);
			}
		} finally {
			dbUtil.close(rs, pstmt, conn);
		}
		return list;
	}
	
	@Override
	public int getTotalCount(Map<String, String> map) throws Exception {
		int cnt = 0;
		
		String key = map.get("key");
		String word = map.get("word");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dataSource.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select count(articleno) \n");
			sql.append("from guestbook \n");
			if(!word.isEmpty()) {
				if(key.equals("subject"))
					sql.append("where subject like ? \n");
				else 
					sql.append("where " + key + " = ? \n");
			}
			pstmt = conn.prepareStatement(sql.toString());
			if(!word.isEmpty()) {
				if(key.equals("subject"))
					pstmt.setString(1, "%" + word + "%");
				else 
					pstmt.setString(1, word);
			}
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1);
		} finally {
			dbUtil.close(rs, pstmt, conn);
		}
		return cnt;
	}

	@Override
	public GuestBookDto getArticle(int articleNo) throws Exception {
		GuestBookDto guestBookDto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = dataSource.getConnection();
			StringBuilder getArticle = new StringBuilder();
			getArticle.append("select subject, content \n");
			getArticle.append("from guestbook \n");
			getArticle.append("where articleno = ? \n");
			pstmt = conn.prepareStatement(getArticle.toString());
			pstmt.setInt(1, articleNo);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				guestBookDto = new GuestBookDto();
				guestBookDto.setArticleNo(articleNo);
				guestBookDto.setSubject(rs.getString("subject"));
				guestBookDto.setContent(rs.getString("content"));
			}
		} finally {
			dbUtil.close(rs, pstmt, conn);
		}
		return guestBookDto;
	}

	@Override
	public void updateArticle(GuestBookDto guestBookDto) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = dataSource.getConnection();
			StringBuilder registerArticle = new StringBuilder();
			registerArticle.append("update guestbook \n");
			registerArticle.append("set subject = ?, content = ? \n");
			registerArticle.append("where articleno = ?");
			pstmt = conn.prepareStatement(registerArticle.toString());
			pstmt.setString(1, guestBookDto.getSubject());
			pstmt.setString(2, guestBookDto.getContent());
			pstmt.setInt(3, guestBookDto.getArticleNo());
			pstmt.executeUpdate();
		} finally {
			dbUtil.close(pstmt, conn);
		}
	}

	@Override
	public void deleteArticle(int articleNo) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = dataSource.getConnection();
			StringBuilder registerArticle = new StringBuilder();
			registerArticle.append("delete from guestbook \n");
			registerArticle.append("where articleno = ?");
			pstmt = conn.prepareStatement(registerArticle.toString());
			pstmt.setInt(1, articleNo);
			pstmt.executeUpdate();
		} finally {
			dbUtil.close(pstmt, conn);
		}
	}

}
