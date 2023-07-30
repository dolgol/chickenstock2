package ssg.com.a.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ssg.com.a.dao.UserDao;
import ssg.com.a.dto.UserDto;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	UserDao dao;
	
	@Override
	public boolean nicknamecheck(String nick_name) {
		// TODO Auto-generated method stub
		return dao.nicknamecheck(nick_name)>0?true:false;
	}

	@Override
	public boolean idcheck(String user_id) {
		return dao.idcheck(user_id)>0?true:false;
	}

	@Override
	public boolean adduser(UserDto dto) {
		return dao.adduser(dto)>0?true:false;
	}

	
	@Override
	public UserDto findUserByAddressAndPhoneNumber(String address, String phone_number) {
	    // TODO Auto-generated method stub
	    return dao.findUserByAddressAndPhoneNumber(address, phone_number);
	}

	
	@Override
	public UserDto login(UserDto dto) {
		return dao.login(dto);
	}
	
	// 비밀번호 업데이트
	@Override
	public void updatePassword(UserDto dto) {
	    // newPassword 필드의 값이 null이 아닌 경우에만 password 필드로 복사
	    if (dto.getNewPassword() != null) {
	        dto.setPassword(dto.getNewPassword());
	    }
	    dao.updatePassword(dto);
	}
	
	// 비밀번호 찾기
	@Override
	public UserDto findUserByAddressAndUserId(String address, String user_id) {
	    return dao.findUserByAddressAndUserId(address, user_id);
	}

	
	
	@Override
	public boolean mypageEdit(UserDto dto) {
		return dao.mypageEdit(dto) > 0 ? true : false;
	}

	@Override
	public UserDto userGet(String user_id) {
		return dao.userGet(user_id);
	}

	@Override
	public List<UserDto> userGetAll(int pageNumber) {
		return dao.userGetAll(pageNumber);
	}

	@Override
	public boolean userDelete(List<Integer> deleteList) {
		return dao.userDelete(deleteList) == deleteList.size() ? true : false;
	}

}
