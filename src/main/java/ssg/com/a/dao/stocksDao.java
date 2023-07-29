package ssg.com.a.dao;

import java.util.List;

import ssg.com.a.dto.MypageNewsComment;
import ssg.com.a.dto.MypageParam;
import ssg.com.a.dto.MypageStocksComment;
import ssg.com.a.dto.StockParam;
import ssg.com.a.dto.StocksComment;
import ssg.com.a.dto.StocksDto;

public interface StocksDao {
	
	List<StocksDto> stockslist(StockParam param);
	int getstocks(StockParam param);
	StocksDto stocksdetail(String symbol);
	
	int stockscommentwrite(StocksComment comment); List<StocksComment>
	stockscommentlist(String symbol);
	
	
	
	List<StocksDto> mypageLikeList(String user_id);
	List<StocksDto> mypageLikeScroll(MypageParam param);
	
	int mypageStocksAllComment(String user_id);
	List<MypageStocksComment> mypageStocksCommentList(MypageParam param);
	int mypageStocksCommentDel(List<Integer> deleteList);
	
}