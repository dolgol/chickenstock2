package ssg.com.a.dto;

import java.io.Serializable;

public class NewsParam implements Serializable{
	
	private String choice;	// 카테고리(제목/내용/작성자)
	private String search;	// 검색어
	private int pageNumber;
	
	private String originContent;
	private String summaryContent;
	private String newstitle;
	

	public NewsParam() {
	}
	
	public NewsParam(String summaryContent) {
		super();
		this.originContent = summaryContent;
	}
	
	public NewsParam(String newstitle, String originContent) {
		super();
		this.originContent = originContent;
		this.newstitle = newstitle;
	}

	public NewsParam(String choice, String search, int pageNumber) {
		super();
		this.choice = choice;
		this.search = search;
		this.pageNumber = pageNumber;
	}

	public NewsParam(String choice, String search, int pageNumber, String originContent, String newstitle) {
		super();
		this.choice = choice;
		this.search = search;
		this.pageNumber = pageNumber;
		this.originContent = originContent;
		this.newstitle = newstitle;
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

	public String getOriginContent() {
		return originContent;
	}

	public void setOriginContent(String originContent) {
		this.originContent = originContent;
	}

	public String getNewstitle() {
		return newstitle;
	}

	public void setNewstitle(String newstitle) {
		this.newstitle = newstitle;
	}

	public String getSummaryContent() {
		return summaryContent;
	}

	public void setSummaryContent(String summaryContent) {
		this.summaryContent = summaryContent;
	}

	@Override
	public String toString() {
		return "NewsParam [choice=" + choice + ", search=" + search + ", pageNumber=" + pageNumber + ", originContent="
				+ originContent + ", summaryContent=" + summaryContent + ", newstitle=" + newstitle + "]";
	}

	

}
