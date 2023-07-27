package ssg.com.a.dto;

import java.io.Serializable;

public class MypageNewsComment implements Serializable {
	
	private int ncseq;
	private String ncuser_id;
	private String content;
	private String write_date;
	private int ncdel;
	
	private int nseq;
	private String title;
	
	public MypageNewsComment() {
	}

	public MypageNewsComment(int ncseq, String ncuser_id, String content, String write_date, int ncdel, int nseq,
			String title) {
		super();
		this.ncseq = ncseq;
		this.ncuser_id = ncuser_id;
		this.content = content;
		this.write_date = write_date;
		this.ncdel = ncdel;
		this.nseq = nseq;
		this.title = title;
	}

	public int getNcseq() {
		return ncseq;
	}

	public void setNcseq(int ncseq) {
		this.ncseq = ncseq;
	}

	public String getNcuser_id() {
		return ncuser_id;
	}

	public void setNcuser_id(String ncuser_id) {
		this.ncuser_id = ncuser_id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWrite_date() {
		return write_date;
	}

	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}

	public int getNcdel() {
		return ncdel;
	}

	public void setNcdel(int ncdel) {
		this.ncdel = ncdel;
	}

	public int getNseq() {
		return nseq;
	}

	public void setNseq(int nseq) {
		this.nseq = nseq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public String toString() {
		return "MypageNewsComment [ncseq=" + ncseq + ", ncuser_id=" + ncuser_id + ", content=" + content
				+ ", write_date=" + write_date + ", ncdel=" + ncdel + ", nseq=" + nseq + ", title=" + title + "]";
	}

}