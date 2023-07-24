package ssg.com.a.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ssg.com.a.dto.NewsComment;
import ssg.com.a.dto.NewsDto;
import ssg.com.a.dto.NewsParam;

@Repository
public class NewsDaoImpl implements NewsDao{

	@Autowired
	SqlSessionTemplate session;
	
	String ns = "News.";

	@Override
	public List<NewsDto> newslist(NewsParam param) {
		return session.selectList(ns + "newslist", param);		
	}

	@Override
	public int getAllnews(NewsParam param) {
		return session.selectOne(ns + "getallnews", param);
	}

	@Override
	public int newswrite(NewsDto dto) {		
		return session.insert(ns + "newswrite", dto);
	}

	@Override
	public NewsDto newsdetail(int seq) {		
		return session.selectOne(ns + "newsdetail", seq);
	}

	@Override
	public NewsDto newsget(int seq) {
		return session.selectOne(ns + "newsget", seq);
	}

	@Override
	public int newsupdate(NewsDto dto) {
		return session.update(ns + "newsupdate", dto);
	}
	
	@Override
	public int newsdelete(NewsDto dto) {
		return session.update(ns + "newsdelete", dto);
	}

	@Override
	public int commentWrite(NewsComment comment) {		
		return session.insert(ns + "commentWrite", comment);
	}

	@Override
	public List<NewsComment> commentList(int seq) {		
		return session.selectList(ns + "commentList", seq);
	}

	
	
	
}
