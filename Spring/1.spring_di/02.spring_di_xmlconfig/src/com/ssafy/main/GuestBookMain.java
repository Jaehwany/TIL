package com.ssafy.main;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ssafy.model.GuestBookDto;
import com.ssafy.model.service.GuestBookService;
import com.ssafy.model.service.GuestBookServiceImpl;

public class GuestBookMain {

	public static void main(String[] args) throws IOException {
		//1. spring container에게 객체 생성 요청
		ApplicationContext context = new ClassPathXmlApplicationContext("com/ssafy/configuration/applicationContext.xml");
		
		//2. guest_book service 호출
		GuestBookService guestBookService = context.getBean("gbService",GuestBookService.class);
		
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		GuestBookDto guestBookDto = new GuestBookDto();
		guestBookDto.setUserid("ssafy");
		System.out.print("제목 : ");
		guestBookDto.setSubject(in.readLine());
		System.out.print("내용 : ");
		guestBookDto.setContent(in.readLine());
		
		try {
			guestBookService.writeArticle(guestBookDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("================================== 글목록 ================================== ");
		System.out.println("글번호\t작성자\t작성일\t\t\t제목\t\t\t\t내용");
		System.out.println("----------------------------------------------------------------");
		try {
			List<GuestBookDto> list = guestBookService.listArticle("", "");
			for(GuestBookDto article : list) {
				System.out.println(article);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
