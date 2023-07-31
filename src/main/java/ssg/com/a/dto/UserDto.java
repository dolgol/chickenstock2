package ssg.com.a.dto;

import java.io.Serializable;

public class UserDto implements Serializable{
	private String user_id;
	private String password;
	private String user_name;
	private String birthday;
	private String sex;
	private String phone_number;
	private String address;
	private String nick_name;
	private int auth;
	
	
	public UserDto() {
		
	}

	public UserDto(String user_id, String password, String user_name, String birthday, String sex, String phone_number,
			String address, String nick_name, int auth) {
		super();
		this.user_id = user_id;
		this.password = password;
		this.user_name = user_name;
		this.birthday = birthday;
		this.sex = sex;
		this.phone_number = phone_number;
		this.address = address;
		this.nick_name = nick_name;
		this.auth = auth;
	}


	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getUser_name() {
		return user_name;
	}


	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}


	public String getBirthday() {
		return birthday;
	}


	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}


	public String getSex() {
		return sex;
	}


	public void setSex(String sex) {
		this.sex = sex;
	}


	public String getPhone_number() {
		return phone_number;
	}


	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getNick_name() {
		return nick_name;
	}


	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}


	public int getAuth() {
		return auth;
	}


	public void setAuth(int auth) {
		this.auth = auth;
	}


	@Override
	public String toString() {
		return "UserDto [user_id=" + user_id + ", password=" + password + ", user_name=" + user_name + ", address=" + address + ", auth=" + auth
				+ ", nick_name=" + nick_name + ", birthday=" + birthday + ", phone_number=" + phone_number + ", sex=" + sex +"]";
	}
}

