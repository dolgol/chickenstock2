package ssg.com.a.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ssg.com.a.dto.StockParam;
import ssg.com.a.dto.StocksComment;
import ssg.com.a.dto.StocksDto;
import ssg.com.a.service.StockService;

@Controller
public class StockController {
	@Autowired
	StockService service;
	
	
	
	@GetMapping("stockMain.do")
	public String stockMain(Model model, @ModelAttribute ("param") StockParam param) throws Exception{
		
		 String URL = "https://finance.naver.com/sise/sise_";
		
		System.out.println(param.toString());
		System.out.println("StockController stockMain()" + new Date());
		
		if(param == null || param.getSearch() == null || param.getChoice() == null) {
			param = new StockParam("", "");
		}
	
		
		
		
		List<StocksDto> list = service.stockslist(param);
		int count = service.getstocks(param);
		
		

		//------------------------------------------------------------------------
		
		// 거래량
		
		String KEY_WORD = "quant.naver";

		System.out.println("URL :: " + URL + getcount(KEY_WORD, 1));

		// 1. document가져오기
		Document doc = Jsoup.connect(URL + getcount(KEY_WORD, 1)).get();

		// 2.목록가져오기
		/* System.out.println("" + doc.toString()); */

		Elements elements = doc.select(".type_2 tbody");

		// 3. 배열에서 정보를 가져온다.
		List<String> slist = new ArrayList<>();
		for (Element element : elements) {
			/* element.select("tr"). */
			Elements aTags = element.select("a");
			
			for(Element aTag : aTags) {
				String hrefValue = aTag.attr("href");
				if (hrefValue != null && hrefValue.startsWith("/item/main.naver")) {
					String codeNumber = hrefValue.split("=")[1];
					String newHref = "stocksdetail.do?symbol="+ codeNumber;
					aTag.attr("href", newHref);
				}
			}
	        slist.add(element.toString());
		}
		
		List<String> sslist = new ArrayList<>();
		for(int i=1;i<3;i++) {
			// 시가총액 1-50, 51-100
			String KEY_WORD1 = "market_sum.naver";
			// 1. document가져오기 [1-50] [51-100]
			Document doc1 = Jsoup.connect(URL + getParameter(KEY_WORD1, i)).get();
			// 2.목록가져오기
			Elements elements1 = doc1.select(".type_2 tbody");
			// 3. 배열에서 정보를 가져온다.
			
			for (Element element : elements1) {		
				element.select("thead tr th:last-child").remove();
		        element.select("td:last-child a").remove();
		        Elements aTags = element.select("a");
				for(Element aTag : aTags) {
					String hrefValue = aTag.attr("href");
					if (hrefValue != null && hrefValue.startsWith("/item/main.naver")) {
						String codeNumber = hrefValue.split("=")[1];
						String newHref = "stocksdetail.do?symbol="+ codeNumber;
						aTag.attr("href", newHref);
					}
				}
				sslist.add(element.toString());			
			}
		}

		//------------------------------------------------------------------------
		model.addAttribute("stocklist", list);
		model.addAttribute("param", param);
		model.addAttribute("slist",slist);
		model.addAttribute("sslist",sslist);
		
		
		return "stocks/stockMain";			
	}
	
	/**
	* URL 완성
	*@Param KEY_WORD
	*@Param PAGE
	*@return
	*/
	
	public static String getcount(String KEY_WORD, int PAGE) {
		return KEY_WORD ;
	}
	
	public static String getParameter(String KEY_WORD, int PAGE) {
		return KEY_WORD + "?&page=" + PAGE;
	}
	
	
	
	@GetMapping("stocksdetail.do")
	public String stockdetail(@RequestParam ("symbol") String symbol, Model model) throws Exception{
		System.out.println("StockController stocksdetail() " + new Date());
		System.out.println(symbol);
		
		
		
		
		String URL = "https://finance.naver.com/item/main.naver?code=";
		
		StocksDto dto = service.stocksdetail(symbol);
		System.out.println(dto.toString());
		
		
		//크롤링시작-----------------------------------------------------------------------
		

		System.out.println("URL :: " + URL + symbol);
		
		// 1. document가져오기
		Document doc = Jsoup.connect(URL + symbol).get();
		
		// 2.목록가져오기
		Elements elements = doc.select(".wrap_company");		
		//회사이름0
		List<String> stock = new ArrayList<>();
			for(Element element : elements) {
			element.select("onclick").remove();
			element.select(".summary").remove();
			stock.add(element.toString());
			}
			
		//오늘가격1
		elements = doc.select(".today");
			for(Element element : elements) {
				stock.add(element.toString());
			}
		// 전일, 시가, 고가, 저가, 거래량, 거래대금2,3
			elements = doc.select(".no_info tbody tr:nth-child(1)");
			for(Element element : elements) {
				stock.add(element.toString());
			}
						
			elements = doc.select(".no_info tbody tr:nth-child(2)");
			for(Element element : elements) {
				stock.add(element.toString());
			}
		//차트4
			elements = doc.select(".chart");
			for(Element element : elements) {			
				element.select(".chart_control_area").remove();	
				element.select("p").remove();	
				element.select("h5").remove();	
				stock.add(element.toString());
			}
		// 매매동향5,6
			elements = doc.select(".sub_section");
			for(Element element : elements) {
				element.select("caption").remove();
				stock.add(element.toString());
			}			
		// 투자정보, 7,8
			elements = doc.select("#aside .aside_invest_info .tab_con1");
			for(Element element : elements) {
				stock.add(element.toString());
			}
			
		
		//크롤링끝-------------------------------------------------------------------------
		model.addAttribute("symbol", dto);
		model.addAttribute("stock", stock);
				
		return "stocks/stocksdetail";
	}
	
	@PostMapping("commentWriteAf.do")
	public String commentWriteAf(StocksComment stocksComment, Model model) {
		System.out.println("StockController commentWriteAf() " + new Date());
		System.out.println("------------------------------");	
		System.out.println("작성자 아이디 :"+stocksComment.getUser_id());
		System.out.println("작성일:"+stocksComment.getWrite_date());
		System.out.println("작성내용:"+stocksComment.getContent());
		System.out.println("주식 코드:"+stocksComment.getSymbol());
		
		boolean isS = false;
		isS = service.stockscommentwrite(stocksComment);
		if(isS) {
			System.out.println("댓글 작성에 성공했습니다");
		}else {
			System.out.println("댓글 작성에 실패했습니다");
		}
		
		// redirect == sendRedirect  
		return "redirect:/stocksdetail.do?symbol="+stocksComment.getSymbol();
	}
	
	@ResponseBody
	@GetMapping("commentList.do")
	public List<StocksComment> commentList(String symbol){
		System.out.println("StockController commentList() " + new Date());
		
		return service.stockscommentlist(symbol);
	}
	
	
	
	
}
