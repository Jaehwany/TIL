package com.book.dto;

//기본생성자, 인자5개 받는 생성자, getter & setter
public class BookDTO {
	private String isbn;
	private String title;
	private String author;
	private String company;
	private int price;
	
	public BookDTO() {
		super();
	}
	public BookDTO(String isbn, String title, String author, String company, int price) {
		super();
		this.isbn = isbn;
		this.title = title;
		this.author = author;
		this.company = company;
		this.price = price;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
}
