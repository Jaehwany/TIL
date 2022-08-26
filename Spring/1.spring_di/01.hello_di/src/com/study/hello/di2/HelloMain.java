package com.study.hello.di2;

public class HelloMain {

	public static void main(String[] args) {
		HelloMessage helloMessage = new HelloMessageKor();
//		HelloMessage helloMessage = new HelloMessageEng();
		
		String greeting = helloMessage.hello("이재환");
//		String greeting = helloMessage.hello("Mr. Lee");
		
		System.out.println(greeting);
	}
	
}
