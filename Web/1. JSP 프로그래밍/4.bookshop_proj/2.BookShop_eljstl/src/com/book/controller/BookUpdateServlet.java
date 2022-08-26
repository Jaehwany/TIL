package com.book.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.dao.BookDaoImpl;
import com.book.dto.BookDTO;

@WebServlet(name = "updateBook", urlPatterns = { "/updateBook" })
public class BookUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		BookDTO dto=new BookDTO();
		dto.setIsbn(request.getParameter("isbn"));
		dto.setTitle(request.getParameter("title"));
		dto.setAuthor(request.getParameter("author"));
		dto.setCompany(request.getParameter("company"));
		dto.setPrice(Integer.parseInt(request.getParameter("price")));
		
		int n=BookDaoImpl.getBookDao().updateBook(dto);
		
		if(n>0)
			response.sendRedirect("/bkshop/listBook");
		else
			System.out.println("수정실패");
	}
}
