package com.study.product;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SAVE", urlPatterns = { "/save" })
public class SaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		String p=request.getParameter("item");
		HttpSession session=request.getSession();   // 세션객체획득
		
		ArrayList<String> list=(ArrayList<String>)session.getAttribute("shop");
		if(list==null) {
			list=new ArrayList<>();
			list.add(p);
			session.setAttribute("shop", list);
		}else {
			list.add(p);
		}
		//-----------------------------------------------------------------------------
		response.getWriter().append("<html><head></head><body>");
		response.getWriter().append("Product Added<br>");
		response.getWriter().append("<a href='/jsp/basket?type=0'>MyCart</a>");
		response.getWriter().append("</body></html>");
	}

}











