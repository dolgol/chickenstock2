package ssg.com.a.dao;

import java.util.List;

import ssg.com.a.dto.UserDto;

public interface UserDao {
	
	int idcheck(String id);
	int nicknamecheck(String nick_name);
	int adduser(UserDto dto);
	
	UserDto login(UserDto dto);
	
	// 아이디 찾기
	
	UserDto findUserByAddressAndPhoneNumber(String address,String phone_number);

	UserDto userGet(String user_id);
	int mypageEdit(UserDto dto);
	List<UserDto> userGetAll(int pageNumber);
	int userDelete(List<Integer> deleteList);
}
