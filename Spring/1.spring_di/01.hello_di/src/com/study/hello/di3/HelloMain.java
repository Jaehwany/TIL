package com.study.hello.di3;

public class HelloMain {

	public static void main(String[] args) {
		HelloMessage helloMessage = HelloMessageFactory.getHelloMessage("kor");
//		HelloMessage helloMessage = HelloMessageFactory.getHelloMessage("eng");
		
		String greeting = helloMessage.hello("이재환");
//		String greeting = helloMessage.hello("Mr. Lee");
		
		System.out.println(greeting);
		
		System.out.println("----------------------------------------");
		
		HelloMessage kor1 = HelloMessageFactory.getHelloMessage("kor");
		HelloMessage kor2 = HelloMessageFactory.getHelloMessage("kor");
		System.out.println(kor1 + " ::::: " + kor2);
	}
	
}
