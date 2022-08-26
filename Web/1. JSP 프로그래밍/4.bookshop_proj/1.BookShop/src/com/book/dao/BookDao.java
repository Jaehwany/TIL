package com.book.dao;

import java.util.List;
import com.book.dto.BookDTO;

public interface BookDao {
	public int insertBook(BookDTO dto);
	public List<BookDTO> listBook();
	public int updateBook(BookDTO dto);
	public int deleteBook(BookDTO dto);
}
