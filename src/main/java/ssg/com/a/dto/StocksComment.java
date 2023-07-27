package ssg.com.a.dto;

import java.io.Serializable;

public class StocksComment implements Serializable{
	private int seq;
	private String user_id;
	private String content;
	private String write_date;
	private int ref;
	private int step;
	private int depth;
	private int del;
	private String symbol;
	
	public StocksComment() {
	}
	
	

	public StocksComment(String user_id, String content, String write_date, String symbol) {
		super();
		this.user_id = user_id;
		this.content = content;
		this.write_date = write_date;
		this.symbol = symbol;
	}



	public StocksComment(int seq, String user_id, String content, String write_date, int ref, int step,
			int depth, int del) {
		super();
		this.seq = seq;
		this.user_id = user_id;
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
	
	public String getSymbol() {
		return symbol;
	}

	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}



	@Override
	public String toString() {
		return "StocksComment [seq=" + seq + ", user_id=" + user_id + ", content=" + content
				+ ", write_date=" + write_date + ", ref=" + ref + ", step=" + step + ", depth=" + depth + ", del=" + del
				+ ", symbol=" + symbol + "]";
	}

	
}


