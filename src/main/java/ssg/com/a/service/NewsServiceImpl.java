package ssg.com.a.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ssg.com.a.dao.NewsDao;
import ssg.com.a.dto.MypageNewsComment;
import ssg.com.a.dto.MypageParam;
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
	public boolean newsnotice(NewsDto dto) {		
		return dao.newsnotice(dto)>0?true:false;
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
	public boolean newsViewUpdate(NewsDto dto) {
		return dao.newsViewUpdate(dto)>0;
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
	public List<NewsComment> commentList(NewsParam param) {		
		return dao.commentList(param);
	}

	@Override
	public int getAllComment(int seq) {
		return dao.getAllComment(seq);
	}

	@Override
	public NewsComment commentGet(NewsComment comment) {
		return dao.commentGet(comment);
	}

	@Override
	public boolean commentDelete(NewsComment comment) {
		return dao.commentDelete(comment)>0;
	}

	@Override
	public boolean commentAnswer(NewsComment comment) {
		dao.commentAnswerUpdate(comment);
		return dao.commentAnswer(comment)>0;
	}

	@Override
	public NewsDto newsFind(NewsDto dto) {
		return dao.newsFind(dto);
	}
	
	
	
	@Override
	public int mypageNewsAllComment(String user_id) {
		return dao.mypageNewsAllComment(user_id);
	}
	
	@Override
	public List<MypageNewsComment> mypageNewsCommentList(MypageParam param) {
		return dao.mypageNewsCommentList(param);
	}

	@Override
	public boolean mypageNewsCommentDel(List<Integer> deleteList) {
		return dao.mypageNewsCommentDel(deleteList) == deleteList.size() ? true : false;
	}
}
