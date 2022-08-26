package com.book.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.book.dto.BookDTO;

import common.DBConnection;

public class BookDaoImpl implements BookDao{
	public static BookDaoImpl bookDao;
	
	public static BookDao getBookDao() {
		if(bookDao == null) {
			bookDao=new BookDaoImpl();
		}
		return bookDao;
	}
	//추가하기---------------------------------------------------------
	@Override
	public int insertBook(BookDTO dto) {
		String sql="insert into bookshop(isbn,title,author,company,price) values(?,?,?,?,?)";
		
		try (Connection conn = DBConnection.getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setString(1, dto.getIsbn());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getAuthor());
			pstmt.setString(4, dto.getCompany());
			pstmt.setInt(5, dto.getPrice());
			return pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	//전체보기---------------------------------------------------------
	@Override
	public List<BookDTO> listBook() {
		List<BookDTO> list=new ArrayList<>();
		BookDTO dto=null;
		String sql="select * from bookshop order by isbn desc";
		
		try (Connection conn = DBConnection.getConnection(); 
		     PreparedStatement pstmt = conn.prepareStatement(sql); 
			 ResultSet rs = pstmt.executeQuery();) {
			
			while(rs.next()) {
				dto=new BookDTO();
				dto.setIsbn(rs.getString("isbn"));    // isbn은 컬럼명이며 대.소문자 구별하지 않음
				dto.setTitle(rs.getString("title"));
				dto.setAuthor(rs.getString("author"));
				dto.setCompany(rs.getString("company"));
				dto.setPrice(rs.getInt("price"));
				list.add(dto);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	//수정하기---------------------------------------------------------
	@Override
	public int updateBook(BookDTO dto) {
		String sql="update bookshop set price=? where isbn=?";
		
		try (Connection conn = DBConnection.getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, dto.getPrice());
			pstmt.setString(2, dto.getIsbn());
			return pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	//삭제하기---------------------------------------------------------
	@Override
	public int deleteBook(BookDTO dto) {
		String sql="delete from bookshop where isbn=?";
		
		try (Connection conn = DBConnection.getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setString(1, dto.getIsbn());
			return pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
}
