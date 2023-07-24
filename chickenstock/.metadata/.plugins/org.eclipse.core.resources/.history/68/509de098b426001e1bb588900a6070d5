package ssg.com.a.dao;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ssg.com.a.dto.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	SqlSession session;
//	SqlSessionTemplate session;
	
	String ns = "Member.";

	@Override
	public int idcheck(String id) {		
		int count = session.selectOne(ns + "idcheck", id);		
		return count;
	}

	@Override
	public int addmember(MemberDto dto) {
		return session.insert(ns + "addmember", dto);		
	}

	@Override
	public MemberDto login(MemberDto dto) {		
		return session.selectOne(ns + "login", dto);
	}
	
	
}





