package ssg.com.a.dao;

import java.util.List;

import ssg.com.a.dto.stockParam;
import ssg.com.a.dto.stocksDto;

public interface stocksDao {
	
	List<stocksDto> stockslist(stockParam param);
	int getstocks(stockParam param);
}
