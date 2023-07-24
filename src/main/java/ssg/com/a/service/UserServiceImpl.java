package ssg.com.a.service;

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

}
