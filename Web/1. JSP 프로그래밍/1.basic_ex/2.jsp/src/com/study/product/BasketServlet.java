package com.study.product;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "BASKET", urlPatterns = { "/basket" })
public class BasketServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().append("<html><head></head><body>");
		response.getWriter().append("Cart List<br>");
		
		HttpSession session=request.getSession();
		int t=Integer.parseInt(request.getParameter("type"));
		
		if(t==1) {
			session.removeAttribute("shop");
		}
				
		ArrayList<String> list=(ArrayList<String>)session.getAttribute("shop");
		if(list != null) {
			response.getWriter().append("Product: " + list + "<br>");
			response.getWriter().append(session.getId());	
		}else {
			response.getWriter().append("No Session");
		}
		
		response.getWriter().append("<br><a href='06.product_ex/product.html'>상품선택페이지</a>");
		response.getWriter().append("</body></html>");
	}
}








