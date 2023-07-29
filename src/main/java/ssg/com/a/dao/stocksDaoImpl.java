package ssg.com.a.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ssg.com.a.dto.MypageParam;
import ssg.com.a.dto.MypageStocksComment;
import ssg.com.a.dto.StockParam;
import ssg.com.a.dto.StocksComment;
import ssg.com.a.dto.StocksDto;

@Repository
public class StocksDaoImpl implements StocksDao{
	
	@Autowired
	SqlSessionTemplate session;	
	String ns = "stocks.";

	@Override
	public List<StocksDto> stockslist(StockParam param) {
		return session.selectList(ns + "stockslist", param);
	}

	@Override
	public int getstocks(StockParam param) {
		return session.selectOne(ns + "getstocks", param);
	}

	@Override
	public StocksDto stocksdetail(String symbol) {
		int symbolNum = Integer.parseInt(symbol);
		symbol = String.valueOf(symbolNum); 
		return session.selectOne(ns + "stocksdetail", symbol);
		// return session.selectOne(ns + "stocksdetail", symbol);
	}

	
	 @Override public int stockscommentwrite(StocksComment comment) {
		 return session.insert(ns + "stockscommentwrite",comment); 
	}
	 
	 @Override public List<StocksComment> stockscommentlist(String symbol) {
		 return session.selectList(ns +"stockscommentlist", symbol); 
	}
	
	 
	@Override
	public List<StocksDto> mypageLikeList(String user_id) {
		return session.selectList(ns + "mypageLikeList", user_id);
	}

	@Override
	public List<StocksDto> mypageLikeScroll(MypageParam param) {
		return session.selectList(ns + "mypageLikeScroll", param);
	}

	@Override
	public int mypageStocksAllComment(String user_id) {
		return session.selectOne(ns + "mypageStocksAllComment", user_id);
	}

	@Override
	public List<MypageStocksComment> mypageStocksCommentList(MypageParam param) {
		return session.selectList(ns + "mypageStocksCommentList", param);
	}

	@Override
	public int mypageStocksCommentDel(List<Integer> deleteList) {
		
		int count = 0;
		
		for (int i = 0; i < deleteList.size(); i++) {
			count += session.update(ns + "mypageStocksCommentDel", deleteList.get(i));
		}
		
		return count;
	}
}
