package ssg.com.a.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ssg.com.a.dto.stockParam;
import ssg.com.a.dto.stocksDto;

@Repository
public class stocksDaoImpl implements stocksDao{
	
	@Autowired
	SqlSessionTemplate session;	
	
	String ns = "stocks.";

	@Override
	public List<stocksDto> stockslist(stockParam param) {
		return session.selectList(ns + "stockslist", param);
	}

	@Override
	public int getstocks(stockParam param) {
		return session.selectOne(ns + "getstocks", param);
	}
	
}
