package com.book.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.dao.BookDaoImpl;
import com.book.dto.BookDTO;

@WebServlet(name = "deleteBook", urlPatterns = { "/deleteBook" })
public class BookDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BookDTO dto=new BookDTO();
		dto.setIsbn(request.getParameter("isbn"));
		int n=BookDaoImpl.bookDao.deleteBook(dto);
		
		if(n>0)
			response.sendRedirect("/bkshop/listBook");
		else
			System.out.println("삭제실패");
	}
}
