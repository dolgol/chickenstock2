package ssg.com.a.service;

import ssg.com.a.dto.UserDto;

public interface UserService {
	
	boolean idcheck(String user_id);
	boolean adduser(UserDto dto);
	boolean nicknamecheck(String nick_name);
	UserDto login(UserDto dto);
	
	// 아이디 찾기
	 UserDto findUserByAddressAndPhoneNumber(String address, String phone_number);
}
