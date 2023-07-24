package ssg.com.a.service;

import java.util.List;

import ssg.com.a.dto.NewsComment;
import ssg.com.a.dto.NewsDto;
import ssg.com.a.dto.NewsParam;

public interface NewsService {

	List<NewsDto> newslist(NewsParam param);
	int getAllnews(NewsParam param);	
	boolean newswrite(NewsDto dto);	
	NewsDto newsdetail(int seq);
	
	NewsDto newsget(int seq);
	
	boolean newsupdate(NewsDto dto);
	
	boolean newsdelete(NewsDto dto);
	
	boolean commentWrite(NewsComment comment);
	List<NewsComment> commentList(int seq);
}








