package com.ssafy.webmvc.model;

import java.util.List;

public class ParameterDto {

	private String userid;
	private String username;
//	private String fruit[];
	private List<String> fruit;

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public List<String> getFruit() {
		return fruit;
	}

	public void setFruit(List<String> fruit) {
		this.fruit = fruit;
	}

//	public String[] getFruit() {
//		return fruit;
//	}
//
//	public void setFruit(String[] fruit) {
//		this.fruit = fruit;
//	}
	
}
