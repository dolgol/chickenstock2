package ssg.com.a.dto;

import java.io.Serializable;

public class MypageParam implements Serializable {
	
	private String user_id;
	private int pageNumber;
	
	public MypageParam() {
	}

	public MypageParam(String user_id, int pageNumber) {
		super();
		this.user_id = user_id;
		this.pageNumber = pageNumber;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	@Override
	public String toString() {
		return "MypageParam [user_id=" + user_id + ", pageNumber=" + pageNumber + "]";
	}

}