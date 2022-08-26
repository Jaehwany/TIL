package com.book.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.dao.BookDaoImpl;
import com.book.dto.BookDTO;

@WebServlet(name = "insertBook", urlPatterns = { "/insertBook" })
public class BookInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String isbn=request.getParameter("isbn");
		String title=request.getParameter("title");
		String author=request.getParameter("author");
		String company=request.getParameter("company");
		int price=Integer.parseInt(request.getParameter("price"));
		
		BookDTO dto=new BookDTO(isbn,title,author,company,price);
		int n=BookDaoImpl.getBookDao().insertBook(dto);
		
		if(n > 0) {
			response.sendRedirect("/bkshop/listBook");
		}else {
			System.out.println("저장실패");
		}
	}
}

























