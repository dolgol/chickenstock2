package ssg.com.a.dto;

import java.io.Serializable;

public class NewsComment implements Serializable {

	private int seq;
	private int post_num; 
	private String user_id;
	private String content;
	private String write_date;
	private int ref;
	private int step;
	private int depth;
	private int del;
	
	public NewsComment() {
	}
	
	public NewsComment(int post_num, int seq) {
		super();
		this.post_num = post_num;
		this.seq = seq;
	}
	
	public NewsComment( int post_num, int seq, String content, String user_id) {
		super();
		this.post_num = post_num;
		this.seq = seq;
		this.content = content;
		this.user_id = user_id;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
	}
	
	
	public NewsComment(int post_num, int seq, String content) {
		super();
		this.post_num = post_num;
		this.seq = seq;
		this.content =content;
	}

	public NewsComment(int seq, int post_num, String uesr_id, String content, String write_date, int ref, int step,
			int depth, int del) {
		super();
		this.seq = seq;
		this.post_num = post_num;
		this.user_id = uesr_id;
		this.content = content;
		this.write_date = write_date;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.del = del;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getPost_num() {
		return post_num;
	}

	public void setPost_num(int post_num) {
		this.post_num = post_num;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
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

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	@Override
	public String toString() {
		return "NewsComment [seq=" + seq + ", post_num=" + post_num + ", user_id=" + user_id + ", content=" + content
				+ ", write_date=" + write_date + ", ref=" + ref + ", step=" + step + ", depth=" + depth + ", del=" + del
				+ "]";
	}

	
	
}
