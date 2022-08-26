package com.study.hello.di4;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

//service
@Service(value="kor")
//@Scope(value="prototype")
public class HelloMessageKor implements HelloMessage {
	
	// Dao 호출 (객체 생성 안하면 NULL) -- 스프링 컨테이너에게 객체 생성 맡기기 (application.xml)
	@Autowired //자동 연결 (kor과 dao)
//	@Qualifier(value="t2dao") // type이 겹칠 때 지정
	private TestDao dao;
	
	 
//	//property : setDao, getDao 같은 것에서 set,get을 지우고 소문자로 변환한 것
//	public void setDao(TestDao dao) {
//		this.dao = dao;
//	}

	public HelloMessageKor() {
		System.out.println("HelloMessageKor Contructor Call!!!!!!!!!");
	}

	public String hello(String name) {
		name= dao.getName();
		return "안녕하세요 " + name;
	}
	
}
