package ssg.com.a.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ssg.com.a.dao.NewsDao;
import ssg.com.a.dto.NewsComment;
import ssg.com.a.dto.NewsDto;
import ssg.com.a.dto.NewsParam;

@Service
public class NewsServiceImpl implements NewsService{

	@Autowired
	NewsDao dao;

	@Override
	public List<NewsDto> newslist(NewsParam param) {		
		return dao.newslist(param);
	}

	@Override
	public int getAllnews(NewsParam param) {		
		return dao.getAllnews(param);
	}

	@Override
	public boolean newswrite(NewsDto dto) {		
		return dao.newswrite(dto)>0?true:false;
	}
	
	@Override
	public NewsDto newsdetail(int seq) {		
		return dao.newsdetail(seq);
	}
	
	@Override
	public NewsDto newsget(int seq) {
		return dao.newsget(seq);
	}

	@Override
	public boolean newsupdate(NewsDto dto) {
		return dao.newsupdate(dto)>0?true:false;
	}
	
	@Override
	public boolean newsdelete(NewsDto dto) {
		return dao.newsdelete(dto)>0;
	}

	@Override
	public boolean commentWrite(NewsComment comment) {		
		return dao.commentWrite(comment)>0?true:false;
	}

	@Override
	public List<NewsComment> commentList(int seq) {		
		return dao.commentList(seq);
	}

	
			
	
}
