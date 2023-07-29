package ssg.com.a.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ssg.com.a.dto.MypageNewsComment;
import ssg.com.a.dto.MypageParam;
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
	public int newsnotice(NewsDto dto) {		
		return session.insert(ns + "newsnotice", dto);
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
	public int newsViewUpdate(NewsDto dto) {
		return session.update(ns + "newsViewUpdate", dto);
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
	public List<NewsComment> commentList(NewsParam param) {		
		return session.selectList(ns + "commentList", param);
	}

	@Override
	public int getAllComment(int seq) {
		return session.selectOne(ns + "getAllComment", seq);
	}

	@Override
	public NewsComment commentGet(NewsComment comment) {
		return session.selectOne(ns + "commentGet", comment);
	}

	@Override
	public int commentDelete(NewsComment comment) {
		return session.update(ns + "commentDelete", comment);
	}

	@Override
	public int commentAnswer(NewsComment comment) {
		return session.insert(ns + "commentAnswer", comment);
	}

	@Override
	public void commentAnswerUpdate(NewsComment comment) {
		session.selectList(ns + "commentAnswerUpdate", comment);
	}

	@Override
	public NewsDto newsFind(NewsDto dto) {
		return session.selectOne(ns + "newsFind", dto);
	}

	
	

	
	@Override
	public int mypageNewsAllComment(String user_id) {
		return session.selectOne(ns + "mypageNewsAllComment", user_id);
	}
	
	@Override
	public List<MypageNewsComment> mypageNewsCommentList(MypageParam param) {
		return session.selectList(ns + "mypageNewsCommentList", param);
	}

	@Override
	public int mypageNewsCommentDel(List<Integer> deleteList) {
		
		int count = 0;
		
		for (int i = 0; i < deleteList.size(); i++) {
			count += session.update(ns + "mypageNewsCommentDel", deleteList.get(i));
		}
		
		return count;
	}
	
}
