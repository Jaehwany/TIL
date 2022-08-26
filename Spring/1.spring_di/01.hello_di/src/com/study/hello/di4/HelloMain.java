package com.study.hello.di4;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


//Controller
public class HelloMain {

	public static void main(String[] args) {
		//1. ApplicationContext(3.0 버전 이상) or BeanFactory(2.0 버전이하) - spring container에게 Bean 객체 생성 요청
		ApplicationContext context = new ClassPathXmlApplicationContext("com/study/hello/di4/application.xml");
		
		//service 호출
		//2. getBean을 이용해서 얻어오기
//		HelloMessage helloMessage = (HelloMessage) context.getBean("kor");
		HelloMessage helloMessage = context.getBean("kor", HelloMessageKor.class);
//		HelloMessage helloMessage = context.getBean("eng", HelloMessageEng.class);
		
		String greeting = helloMessage.hello("이재환");
//		String greeting = helloMessage.hello("Mr. Lee");
		
		System.out.println(greeting);
		
		
		System.out.println("----------------------------------------");
		
		//3. default : scope="singleton" : 하나의 객체 생성 / scope="prototype" : 다른 객체 생성
		HelloMessage kor1 = context.getBean("kor", HelloMessageKor.class);
		HelloMessage kor2 = context.getBean("kor", HelloMessageKor.class);
		System.out.println(kor1 + " ::::: " + kor2);
	}
	
}
