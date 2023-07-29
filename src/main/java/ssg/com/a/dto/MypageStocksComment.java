package ssg.com.a.dto;

public class MypageStocksComment {
	
	private int scseq;
	private String user_id;
	private String content;
	private String write_date;
	private int del;
	
	private String Symbol;
	private String Market;
	private String Name;
	
	public MypageStocksComment() {
	}

	public MypageStocksComment(int scseq, String user_id, String content, String write_date, int del, String symbol,
			String market, String name) {
		super();
		this.scseq = scseq;
		this.user_id = user_id;
		this.content = content;
		this.write_date = write_date;
		this.del = del;
		Symbol = symbol;
		Market = market;
		Name = name;
	}

	public int getScseq() {
		return scseq;
	}

	public void setScseq(int scseq) {
		this.scseq = scseq;
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

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public String getSymbol() {
		return Symbol;
	}

	public void setSymbol(String symbol) {
		Symbol = symbol;
	}

	public String getMarket() {
		return Market;
	}

	public void setMarket(String market) {
		Market = market;
	}

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	@Override
	public String toString() {
		return "MypageStocksComment [scseq=" + scseq + ", user_id=" + user_id + ", content=" + content + ", write_date="
				+ write_date + ", del=" + del + ", Symbol=" + Symbol + ", Market=" + Market + ", Name=" + Name + "]";
	}
	
}
