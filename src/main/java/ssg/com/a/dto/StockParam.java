package ssg.com.a.dto;

import java.io.Serializable;

public class StockParam implements Serializable{

	private String choice;	// 카테고리(제목/내용/작성자)
	private String search;
	private int pageNumber;
	private int seq;
	private String symbol;
	
	public StockParam() {
	}	
	
	public StockParam(String choice, String search, int pageNumber, int seq, String symbol) {
		super();
		this.choice = choice;
		this.search = search;
		this.pageNumber = pageNumber;
		this.seq = seq;
		this.symbol = symbol;
	}


	public StockParam(String symbol, int pageNumber) {
		super();		
		this.symbol = symbol;
		this.pageNumber = pageNumber;
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
	
	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getSymbol() {
		return symbol;
	}

	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}

	@Override
	public String toString() {
		return "StockParam [choice=" + choice + ", search=" + search + ", pageNumber=" + pageNumber + ", seq=" + seq
				+ ", symbol=" + symbol + "]";
	}



	
	
}
