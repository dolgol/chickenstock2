package ssg.com.a.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

import ssg.com.a.dto.UserDto;

@Repository
public class UserDaoImpl implements UserDao{

	@Autowired
	SqlSession session;
	
	String ns = "User.";
	
	@Override
	public int idcheck(String user_id) {
		int count = session.selectOne(ns+ "idcheck", user_id);
		return count;
	}

	@Override
	public int adduser(UserDto dto) {
		return session.insert(ns + "adduser", dto);
	}

	@Override
	public UserDto login(UserDto dto) {
		return session.selectOne(ns + "login", dto);
	}

	@Override
	public UserDto findUserByAddressAndPhoneNumber(String address, String phone_number) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("address", address);
	    params.put("phone_number", phone_number);
	    return session.selectOne(ns + "findUserByAddressAndPhoneNumber", params);
	}

	

	@Override
	public int nicknamecheck(String nick_name) {
		int count = session.selectOne(ns+ "nicknamecheck", nick_name);
		return count;
	}
	
	
	
	@Override
	public int mypageEdit(UserDto dto) {
		return session.update(ns + "mypageEdit", dto);
	}

	@Override
	public UserDto userGet(String user_id) {
		return session.selectOne(ns + "userGet", user_id);
	}

	@Override
	public List<UserDto> userGetAll(int pageNumber) {
		return session.selectList(ns + "userGetAll", pageNumber);
	}

	@Override
	public int userDelete(List<Integer> deleteList) {
		
		int count = 0;
		
		for (int i = 0; i < deleteList.size(); i++) {
			count += session.update(ns + "userDelete", deleteList.get(i));
		}
		
		return count;
	}

}
