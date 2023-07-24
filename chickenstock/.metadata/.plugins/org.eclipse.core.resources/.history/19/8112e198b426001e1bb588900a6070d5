package ssg.com.a.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ssg.com.a.dao.MemberDao;
import ssg.com.a.dto.MemberDto;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberDao dao;

	@Override
	public boolean idcheck(String id) {		
		return dao.idcheck(id)>0?true:false;
	}

	@Override
	public boolean addmember(MemberDto dto) {		
		return dao.addmember(dto)>0?true:false;
	}

	@Override
	public MemberDto login(MemberDto dto) {		
		return dao.login(dto);
	}
	
	
}
