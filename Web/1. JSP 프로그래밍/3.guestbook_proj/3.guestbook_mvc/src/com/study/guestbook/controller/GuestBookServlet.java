package com.study.guestbook.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.study.guestbook.model.GuestBookDto;
import com.study.guestbook.model.MemberDto;
import com.study.guestbook.model.service.GuestBookService;
import com.study.guestbook.model.service.GuestBookServiceImpl;
import com.study.util.PageNavigation;

@WebServlet("/article")
public class GuestBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private GuestBookService guestBookService = GuestBookServiceImpl.getGuestBookService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String act = request.getParameter("act");
		String path = "/index.jsp";
		if("mvregister".equals(act)) {
			response.sendRedirect(request.getContextPath() + "/guestbook/write.jsp");
		} else if ("register".equals(act)) {
			path = registerArticle(request, response);
//			response.sendRedirect(request.getContextPath() + path);
			request.getRequestDispatcher(path).forward(request, response);
		} else if ("list".equals(act)) {
			path = listArticle(request, response);
			request.getRequestDispatcher(path).forward(request, response);
		} else if ("mvmodify".equals(act)) {
			path = getArticle(request, response);
			request.getRequestDispatcher(path).forward(request, response);
		} else if ("modify".equals(act)) {
			path = modifyArticle(request, response);
			response.sendRedirect(request.getContextPath() + path);
//			request.getRequestDispatcher(path).forward(request, response);
		} else if ("delete".equals(act)) {
			path = deleteArticle(request, response);
			response.sendRedirect(request.getContextPath() + path);
//			request.getRequestDispatcher(path).forward(request, response);
		}
	}

	private String deleteArticle(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			int articleNo = Integer.parseInt(request.getParameter("articleno"));
			
			try {
				guestBookService.deleteArticle(articleNo);
				
				return "/article?act=list";
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("msg", "글 얻기중 에러가 발생했습니다.");
				return "/error/error.jsp";
			}
		} else {			
			return "/user?act=mvlogin";
		}
	}

	private String modifyArticle(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			GuestBookDto guestBookDto = new GuestBookDto();
			guestBookDto.setArticleNo(Integer.parseInt(request.getParameter("articleno")));
			guestBookDto.setSubject(request.getParameter("subject"));
			guestBookDto.setContent(request.getParameter("content"));
			try {
				guestBookService.updateArticle(guestBookDto);
				return "/guestbook/writesuccess.jsp";
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("msg", "글 수정중 에러가 발생했습니다.");
				return "/error/error.jsp";
			}
		} else {			
			return "/user?act=mvlogin";
		}
	}

	private String getArticle(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			int articleNo = Integer.parseInt(request.getParameter("articleno"));
			
			try {
				GuestBookDto guestBookDto = guestBookService.getArticle(articleNo);
				request.setAttribute("article", guestBookDto);
				return "/guestbook/modify.jsp";
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("msg", "글 얻기중 에러가 발생했습니다.");
				return "/error/error.jsp";
			}
		} else {			
			return "/user?act=mvlogin";
		}
	}

	private String registerArticle(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			GuestBookDto guestBookDto = new GuestBookDto();
			guestBookDto.setUserId(memberDto.getUserId());
			guestBookDto.setSubject(request.getParameter("subject"));
			guestBookDto.setContent(request.getParameter("content"));
			try {
				guestBookService.registerArticle(guestBookDto);
				return "/guestbook/writesuccess.jsp";
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("msg", "글 작성중 에러가 발생했습니다.");
				return "/error/error.jsp";
			}
		} else {			
			return "/user?act=mvlogin";
		}
	}

	private String listArticle(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			String pg = request.getParameter("pg");
			String key = request.getParameter("key");
			String word = request.getParameter("word");
			try {
				List<GuestBookDto> list = guestBookService.listArticle(pg, key, word);
				PageNavigation navigation = guestBookService.makePageNavigation(pg, key, word);
				
				request.setAttribute("articles", list);
				request.setAttribute("navi", navigation);
				request.setAttribute("key", key);
				request.setAttribute("word", word);
				
				return "/guestbook/list.jsp";
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("msg", "글목록 얻기중 에러가 발생했습니다.");
				return "/error/error.jsp";
			}
		} else {			
			return "/user?act=mvlogin";
		}
	}

}
