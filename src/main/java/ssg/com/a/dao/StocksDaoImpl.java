package ssg.com.a.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ssg.com.a.dto.StockLike;
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
	}

	
	 @Override public int stockscommentwrite(StocksComment comment) {
		 return session.insert(ns + "stockscommentwrite",comment); 
	}
	 
	 @Override public List<StocksComment> stockscommentlist(String symbol) {
		 int symbolNum = Integer.parseInt(symbol);
			symbol = String.valueOf(symbolNum);
		 return session.selectList(ns +"stockscommentlist", symbol); 
	}
	 
	 // 찜기능

	@Override
	public void insertlike(StockLike stocklike) {
		System.out.println(stocklike.toString());
		int symbolNum = Integer.parseInt(stocklike.getSymbol());
		stocklike.setSymbol(String.valueOf(symbolNum));
		session.insert(ns + "insertlike", stocklike);
	}

	@Override
	public void deletelike(StockLike stocklike) {
		session.delete(ns + "deletelike", stocklike);		
	}

	@Override
	public List<StockLike> getlike(String user_id) {
		return session.selectList(ns + "getlike", user_id);
	}

	@Override
	public int checklike(StockLike stocklike) {
		return session.selectOne(ns + "checklike", stocklike);
	}

	@Override
	public int stockcommentdelete(StocksComment comment) {
		return session.delete(ns + "stockcommentdelete", comment);
	}

	@Override
	public StocksComment stockcommentget(StocksComment comment) {
		return session.selectOne(ns + "stockcommentget", comment);
	}

	@Override
	public int stockgetall(int seq) {
		return session.selectOne(ns + "stockgetall", seq);
	}
	
	

	
}
