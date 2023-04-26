package com.cando.ashop.vo;

import java.util.Date;

public class AP_Product {
	
	private int product_no;
	private int user_admin_no;
	private String product_name;
	private int product_price;
	private int product_stock;
	private Date product_date;
	
	public AP_Product() {
		super();
	}

	public AP_Product(int product_no, int user_admin_no, String product_name, int product_price, int product_stock,
			Date product_date) {
		super();
		this.product_no = product_no;
		this.user_admin_no = user_admin_no;
		this.product_name = product_name;
		this.product_price = product_price;
		this.product_stock = product_stock;
		this.product_date = product_date;
	}

	public int getProduct_no() {
		return product_no;
	}

	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}

	public int getUser_admin_no() {
		return user_admin_no;
	}

	public void setUser_admin_no(int user_admin_no) {
		this.user_admin_no = user_admin_no;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public int getProduct_stock() {
		return product_stock;
	}

	public void setProduct_stock(int product_stock) {
		this.product_stock = product_stock;
	}

	public Date getProduct_date() {
		return product_date;
	}

	public void setProduct_date(Date product_date) {
		this.product_date = product_date;
	}
	
	
	

}
