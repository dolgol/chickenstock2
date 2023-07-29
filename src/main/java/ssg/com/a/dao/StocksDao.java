package ssg.com.a.dao;

import java.util.List;

import ssg.com.a.dto.StockLike;
import ssg.com.a.dto.StockParam;
import ssg.com.a.dto.StocksComment;
import ssg.com.a.dto.StocksDto;

public interface StocksDao {
	
	List<StocksDto> stockslist(StockParam param);
	int getstocks(StockParam param);
	StocksDto stocksdetail(String symbol);

	void insertlike(StockLike stocklike);
	void deletelike(StockLike stocklike);
	List<StockLike> getlike(String user_id);
	int checklike(StockLike stocklike);
	
	int stockscommentwrite(StocksComment comment); 
	List<StocksComment> stockscommentlist(String symbol);
	
	
	StocksComment stockcommentget(StocksComment comment);
	int stockcommentdelete(StocksComment comment);
	int stockgetall(int seq);

}
