package ssg.com.a.dto;

import java.io.Serializable;

public class StockParam implements Serializable{

	private String choice;	// 카테고리(제목/내용/작성자)
	private String search;
	
		
	public StockParam() {
	}	

	public StockParam(String choice, String search) {
		super();
		this.choice = choice;
		this.search = search;
	}

	

	public String getChoice() {
		return choice;
	}

	public void setChoice(String choice) {
		this.choice = choice;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	@Override
	public String toString() {
		return "stockParam [choice=" + choice + ", search=" + search + "]";
	}
	
}
