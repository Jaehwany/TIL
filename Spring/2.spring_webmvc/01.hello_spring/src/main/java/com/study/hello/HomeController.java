package com.study.hello;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//act, doget
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		 
		
		//request.setAttribute
		model.addAttribute("msg", "안녕 스프링이야 컨트롤러 당겨왔어!!!" );
		
		//forward
		return "index";
	}
	
}

//tomcat -> web.xml ->context 메모리에 load -> load가 되는 순간을 인식해서 root-context.xml 읽기 ->serviceImpl,DAO,VO 생성
//request from client -> dispatcher servlet 생성 -> servlet-context 호출 ->Controller


//root-context ==> non - WEB
//servlet-context --> web

//dispatcher Servlet은 프로젝트 안에서 만들어지는것

//1. web.xml ->dispatcher servlet 메모리에 올림
//2. servlet-context[web에 관련된  정보] 읽어오기  ->HomeController정보 들어있음

