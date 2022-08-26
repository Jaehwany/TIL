package com.ssafy.webmvc.model.dao;

import java.util.Calendar;
import java.util.GregorianCalendar;

import org.springframework.stereotype.Repository;


@Repository
public class HelloDaoImpl implements HelloDao {

	@Override
	public String greeting() {
		Calendar calendar = new GregorianCalendar();
		int hour = calendar.get(Calendar.HOUR_OF_DAY);
		if(hour > 7 && hour < 12) {
			return "좋은 아침입니다.";
		} else if(hour >= 12 && hour < 18) {
			return "즐거운 오후에요.";
		} else {
			return "굿 밤!!!!";
		}
	}

}
