
import java.util.List;

import ssg.com.a.dto.StockParam;
import ssg.com.a.dto.StocksComment;
import ssg.com.a.dto.StocksDto;

public interface StocksDao {
	
	List<StocksDto> stockslist(StockParam param);
	int getstocks(StockParam param);
	StocksDto stocksdetail(String symbol);
	
	int stockscommentwrite(StocksComment comment); List<StocksComment>
	stockscommentlist(String symbol);
	
}