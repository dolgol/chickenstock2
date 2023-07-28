package ssg.com.a.dto;

import java.io.Serializable;

public class NewsParam implements Serializable{
	
	private String choice;	// 카테고리(제목/내용/작성자)
	private String search;	// 검색어
	private int pageNumber;
	private int seq;
	
	
	private String newstitle;
	private String author;
	private String write_date;
	private String originContent;
	private String summaryContent;
	private String source;
	
	

	public NewsParam() {
	}
	
	public NewsParam(String summaryContent) {
		super();
		this.originContent = summaryContent;
	}
	
	public NewsParam(int seq, int pageNumber) {
		super();
		this.seq = seq;
		this.pageNumber = pageNumber;
	}
	
	public NewsParam( String newstitle, String author, String write_date, String originContent, String source ) {
		super();
		this.newstitle = newstitle;
		this.author = author;
		this.write_date = write_date;
		this.originContent = originContent;
		this.source = source;
		
	}

	public NewsParam(String choice, String search, int pageNumber) {
		super();
		this.choice = choice;
		this.search = search;
		this.pageNumber = pageNumber;
	}

	public NewsParam(String choice, String search, int pageNumber, String newstitle) {
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
	
	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	
	public String getWrite_date() {
		return write_date;
	}

	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}

	
	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String toStringNews() {
		return "NewsParam [choice=" + choice + ", search=" + search + ", pageNumber=" + pageNumber + ", originContent="
				+ originContent + ", summaryContent=" + summaryContent + ", newstitle=" + newstitle + "]";
	}
	
	public String toStringComment() {
		return "NewsSummary [seq= " + seq + ", pageNumber= " + pageNumber + "]";
		
	}
	
	@Override
	public String toString() {
		return "NewsSummary [newstitle= " + newstitle + ", author= " + author + ", write date= " + write_date + ", originContent=" + originContent + ", source= " + source + "]";
		
	}

	

}
