package com.study.hello.di4;

import org.springframework.stereotype.Repository;

@Repository(value="dao")
public class TestDao {
	
	public TestDao() {
		System.out.println("TestDao 생성자 호출!");
	}
	
	public String getName() {
		return "LEE";
	}

}
