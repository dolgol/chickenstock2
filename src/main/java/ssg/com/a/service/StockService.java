package ssg.com.a.service;

import java.util.List;

<<<<<<< HEAD
import ssg.com.a.dto.StockLike;
=======
import ssg.com.a.dto.MypageNewsComment;
import ssg.com.a.dto.MypageParam;
import ssg.com.a.dto.MypageStocksComment;
>>>>>>> 466dfac7fecc27983dd6a11bef06efd9172e5c4e
import ssg.com.a.dto.StockParam;
import ssg.com.a.dto.StocksComment;
import ssg.com.a.dto.StocksDto;

public interface StockService {

	List<StocksDto> stockslist(StockParam param);
	int getstocks(StockParam param);
	StocksDto stocksdetail(String symbol);
	
	boolean stockscommentwrite(StocksComment comment); 
	List<StocksComment> stockscommentlist(String symbol);
	
<<<<<<< HEAD
	void insertlike(StockLike stocklike);
	void deletelike(StockLike stocklike);
	List<StockLike> getlike(String user_id);
	boolean checklike(StockLike stocklike);
	
	boolean stockcommentdelete(StocksComment comment);
	StocksComment stockcommentget(StocksComment comment);
	int stockgetall(int seq);

	 
=======
	
	
	List<StocksDto> mypageLikeList(String user_id);
	List<StocksDto> mypageLikeScroll(MypageParam param);
	
	int mypageStocksAllComment(String user_id);
	List<MypageStocksComment> mypageStocksCommentList(MypageParam param);
	boolean mypageStocksCommentDel(List<Integer> deleteList);
>>>>>>> 466dfac7fecc27983dd6a11bef06efd9172e5c4e
}
