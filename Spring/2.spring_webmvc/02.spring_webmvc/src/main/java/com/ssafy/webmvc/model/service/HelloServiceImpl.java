package com.ssafy.webmvc.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.webmvc.model.HelloDto;
import com.ssafy.webmvc.model.dao.HelloDao;


@Service
public class HelloServiceImpl implements HelloService {

	@Autowired
	private HelloDao helloDao;
	
	@Override
	public HelloDto greeting() {
		HelloDto helloDto = new HelloDto();
		helloDto.setMessage(helloDao.greeting());
		return helloDto;
	}

}