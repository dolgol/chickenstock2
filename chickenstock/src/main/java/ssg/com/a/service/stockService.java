package ssg.com.a.service;

import java.util.List;

import ssg.com.a.dto.stockParam;
import ssg.com.a.dto.stocksDto;

public interface stockService {

	List<stocksDto> stockslist(stockParam param);
	int getstocks(stockParam param);
}
