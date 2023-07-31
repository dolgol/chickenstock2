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

import ssg.com.a.dto.NewsDto;
import ssg.com.a.dto.NewsParam;
import ssg.com.a.dto.StockParam;
import ssg.com.a.dto.StocksDto;
import ssg.com.a.dto.UserDto;
import ssg.com.a.service.NewsService;
import ssg.com.a.service.StockService;

@Controller
public class HomeController {
	
	@Autowired
	StockService stockService;
	
	@Autowired
	NewsService newsService;
	
	@GetMapping("home.do")
	public String home(Model model, @ModelAttribute ("param") StockParam param) throws Exception {
		
		System.out.println("HomeController home() " + new Date());
		
		/* newsList */
		
		List<NewsDto> newsList = newsService.newslist(new NewsParam("", "", 0));
		
		model.addAttribute("newsList", newsList);
		model.addAttribute("content", "home");
		
		// =======
		
		/* stocksList */
		
		String URL = "https://finance.naver.com/sise/sise_";
		
		System.out.println(param.toString());
		System.out.println("StockController stockMain()" + new Date());
		
		if(param == null || param.getSearch() == null || param.getChoice() == null) {
			param = new StockParam("", "");
		}
		
		List<StocksDto> list = stockService.stockslist(param);
		
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

		model.addAttribute("stockList", list);
		model.addAttribute("param", param);
		model.addAttribute("slist", slist);
		model.addAttribute("sslist", sslist);
		
		return "main";
	}
	
	public static String getcount(String KEY_WORD, int PAGE) {
		return KEY_WORD ;
	}
	
	public static String getParameter(String KEY_WORD, int PAGE) {
		return KEY_WORD + "?&page=" + PAGE;
	}
}



