package ssg.com.a.service;

import java.util.List;

import ssg.com.a.dto.MypageNewsComment;
import ssg.com.a.dto.MypageParam;
import ssg.com.a.dto.NewsComment;
import ssg.com.a.dto.NewsDto;
import ssg.com.a.dto.NewsParam;

public interface NewsService {

	List<NewsDto> newslist(NewsParam param);
	int getAllnews(NewsParam param);	
	boolean newswrite(NewsDto dto);	
	boolean newsnotice(NewsDto dto);
	NewsDto newsdetail(int seq);
	
	NewsDto newsget(int seq);
	boolean newsViewUpdate(NewsDto dto); 
	
	boolean newsupdate(NewsDto dto);
	
	boolean newsdelete(NewsDto dto);
	
	boolean commentWrite(NewsComment comment);
	List<NewsComment> commentList(NewsParam param);
	int getAllComment(int seq);
	NewsComment commentGet(NewsComment comment);
	boolean commentDelete(NewsComment comment);
	
	boolean commentAnswer(NewsComment comment);
	//List<NewsComment> commentAnswerUpdate(NewsComment comment);
	
	
	int mypageNewsAllComment(String user_id);
	List<MypageNewsComment> mypageNewsCommentList(MypageParam param);
	boolean mypageNewsCommentDel(List<Integer> deleteList);
	NewsDto newsFind(NewsDto dto);
}








