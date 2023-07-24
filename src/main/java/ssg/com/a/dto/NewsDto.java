package ssg.com.a.dto;

import java.io.Serializable;

// BBS Bulletin Board System
public class NewsDto implements Serializable{

	private int seq;		// sequence 글번호
	private String write_id;		// 작성자
	
	private String source; // 출처 
	private String title;	// 제목
	private int views;		//조회수
	private String content;	// 내용
	private int del;		// 삭제
	private String publication_date;	// 원본 기사 작성일
	private Long image;
	
	public NewsDto() {
	}

	public NewsDto(int seq, String write_id, String source, String title, int views, String content, int del,
			String publication_date, Long image) {
		super();
		this.seq = seq;
		this.write_id = write_id;
		this.source = source;
		this.title = title;
		this.views = views;
		this.content = content;
		this.del = del;
		this.publication_date = publication_date;
		this.image = image;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getWrite_id() {
		return write_id;
	}

	public void setWrite_id(String write_id) {
		this.write_id = write_id;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public String getPublication_date() {
		return publication_date;
	}

	public void setPublication_date(String publication_date) {
		this.publication_date = publication_date;
	}

	public Long getImage() {
		return image;
	}

	public void setImage(Long image) {
		this.image = image;
	}

	@Override
	public String toString() {
		return "NewsDto [seq=" + seq + ", write_id=" + write_id + ", source=" + source + ", title=" + title + ", views="
				+ views + ", content=" + content + ", del=" + del + ", publication_date=" + publication_date
				+ ", image=" + image + "]";
	}


	
}





