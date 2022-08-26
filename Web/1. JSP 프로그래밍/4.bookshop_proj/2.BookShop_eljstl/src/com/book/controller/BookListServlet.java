package com.book.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.book.dao.BookDaoImpl;
import com.book.dto.BookDTO;

@WebServlet(name = "listBook", urlPatterns = { "/listBook" })
public class BookListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<BookDTO> list=BookDaoImpl.getBookDao().listBook();
		
		if(list != null) {
			RequestDispatcher rd=request.getRequestDispatcher("book/bookList.jsp");
	        request.setAttribute("booklist",list);   // 리케스크명:book, 보낼 객체:list
	        rd.forward(request, response);           // bookList.jsp에게 권한을 위임
		}
	}
}















