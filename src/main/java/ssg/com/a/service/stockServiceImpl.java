package ssg.com.a.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ssg.com.a.dao.stocksDao;
import ssg.com.a.dto.stockParam;
import ssg.com.a.dto.stocksDto;

@Service
public class stockServiceImpl implements stockService{

		@Autowired
		stocksDao dao;

		@Override
		public List<stocksDto> stockslist(stockParam param) {
			return dao.stockslist(param);
		}

		@Override
		public int getstocks(stockParam param) {
			return dao.getstocks(param);
		}
		
		
}
