package com.study.hello.di1;

public class HelloMain {

	public static void main(String[] args) {
		HelloMessageKor helloMessageKor = new HelloMessageKor();
//		HelloMessageEng helloMessageEng = new HelloMessageEng();
		
		String greeting = helloMessageKor.helloKor("이재환");
//		String greeting = helloMessageEng.helloEng("Mr. Lee");
		
		System.out.println(greeting);
	}
	
}
