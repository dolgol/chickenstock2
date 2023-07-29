package ssg.com.a.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ssg.com.a.dao.StocksDao;
<<<<<<< HEAD
import ssg.com.a.dto.StockLike;
=======
import ssg.com.a.dto.MypageParam;
import ssg.com.a.dto.MypageStocksComment;
>>>>>>> 466dfac7fecc27983dd6a11bef06efd9172e5c4e
import ssg.com.a.dto.StockParam;
import ssg.com.a.dto.StocksComment;
import ssg.com.a.dto.StocksDto;

@Service
public class StockServiceImpl implements StockService{

		@Autowired
		StocksDao dao;

		@Override
		public List<StocksDto> stockslist(StockParam param) {
			return dao.stockslist(param);
		}

		@Override
		public int getstocks(StockParam param) {
			return dao.getstocks(param);
		}

		@Override
		public StocksDto stocksdetail(String symbol) {
			return dao.stocksdetail(symbol);
		}


		@Override 
		public boolean stockscommentwrite(StocksComment comment) { 
			return dao.stockscommentwrite(comment)>0?true:false; 
		}
		
		@Override 
		public List<StocksComment> stockscommentlist(String symbol) {
			return dao.stockscommentlist(symbol); 
		}
		
		// 찜기능

		@Override
		public void insertlike(StockLike stocklike) {
			dao.insertlike(stocklike);
		}

		@Override
		public void deletelike(StockLike stocklike) {
			dao.deletelike(stocklike);
			
		}

		@Override
		public List<StockLike> getlike(String user_id) {
			return dao.getlike(user_id);
		}

		@Override
		public boolean checklike(StockLike stocklike) {
			int count = dao.checklike(stocklike);
			return count > 0?true:false;
		}

		@Override
		public boolean stockcommentdelete(StocksComment comment) {
			return dao.stockcommentdelete(comment)>0;
		}

		@Override
		public StocksComment stockcommentget(StocksComment comment) {
			return dao.stockcommentget(comment);
		}

		@Override
		public int stockgetall(int seq) {
			return dao.stockgetall(seq);
		}

	
		
		
		
		@Override
		public List<StocksDto> mypageLikeList(String user_id) {
			return dao.mypageLikeList(user_id);
		}

		@Override
		public List<StocksDto> mypageLikeScroll(MypageParam param) {
			return dao.mypageLikeScroll(param);
		}

		@Override
		public int mypageStocksAllComment(String user_id) {
			return dao.mypageStocksAllComment(user_id);
		}

		@Override
		public List<MypageStocksComment> mypageStocksCommentList(MypageParam param) {
			return dao.mypageStocksCommentList(param);
		}

		@Override
		public boolean mypageStocksCommentDel(List<Integer> deleteList) {
			return dao.mypageStocksCommentDel(deleteList) == deleteList.size() ? true : false;
		}
}
