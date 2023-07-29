package ssg.com.a.dto;

public class StockLike {

	private int seq;
	private String symbol;
	private String companyName;
	private String user_id;
	
	public StockLike() {
	}

	
	public StockLike(int seq, String symbol, String companyName, String user_id) {
		super();
		this.seq = seq;
		this.symbol = symbol;
		this.companyName = companyName;
		this.user_id = user_id;
	}

	public StockLike(int seq, String symbol, String user_id) {
		super();
		this.seq = seq;
		this.symbol = symbol;
		this.user_id = user_id;
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

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public String getCompanyName() {
		return companyName;
	}


	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	@Override
	public String toString() {
		return "StockLike [seq=" + seq + ", symbol=" + symbol + ", companyName=" + companyName + ", user_id=" + user_id
				+ "]";
	}	
}
