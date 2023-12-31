package ssg.com.a.dao;

import java.util.List;

import ssg.com.a.dto.MypageNewsComment;
import ssg.com.a.dto.MypageParam;
import ssg.com.a.dto.NewsComment;
import ssg.com.a.dto.NewsDto;
import ssg.com.a.dto.NewsParam;

public interface NewsDao {
	
	List<NewsDto> newslist(NewsParam param);
	int getAllnews(NewsParam param);	
	int newswrite(NewsDto dto);	
	int newsnotice(NewsDto dto);
	NewsDto newsdetail(int seq);
	
	NewsDto newsget(int seq);
	int newsViewUpdate(NewsDto dto);
	
	int newsupdate(NewsDto dto);
	
	int newsdelete(NewsDto dto);
	
	int commentWrite(NewsComment comment);
	List<NewsComment> commentList(NewsParam param);
	int getAllComment(int seq);
	NewsComment commentGet(NewsComment comment);
	int commentDelete(NewsComment comment);
	
	int commentAnswer(NewsComment comment);
	void commentAnswerUpdate(NewsComment comment);
	
	
	int mypageNewsAllComment(String user_id);
	List<MypageNewsComment> mypageNewsCommentList(MypageParam param);
	int mypageNewsCommentDel(List<Integer> deleteList);
	NewsDto newsFind(NewsDto dto);
	
}





