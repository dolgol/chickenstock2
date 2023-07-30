package ssg.com.a.service;

import java.util.List;

import ssg.com.a.dto.UserDto;

public interface UserService {
	
	boolean idcheck(String user_id);
	boolean adduser(UserDto dto);
	boolean nicknamecheck(String nick_name);
	UserDto login(UserDto dto);
	
	// 아이디 찾기
	 UserDto findUserByAddressAndPhoneNumber(String address, String phone_number);
	 
	// 비밀번호 찾기
		UserDto findUserByAddressAndUserId(String address, String user_id);

		// 비밀번호 업데이트
		void updatePassword(UserDto dto);


	 
	 UserDto userGet(String user_id);
	 boolean mypageEdit(UserDto dto);
	 List<UserDto> userGetAll(int pageNumber);
	 boolean userDelete(List<Integer> deleteList);
}
