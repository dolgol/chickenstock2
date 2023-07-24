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

import ssg.com.a.dto.stockParam;
import ssg.com.a.dto.stocksDto;
import ssg.com.a.service.stockService;

@Controller
public class stockController {
	@Autowired
	stockService service;
	
	private static String URL = "https://finance.naver.com/sise/sise_";
	
	@GetMapping("stockMain.do")
	public String stockMain(stockParam param, Model model) throws Exception{
		System.out.println("stockController stockMain()" + new Date());
		
		if(param == null || param.getSearch() == null || param.getChoice() == null) {
			param = new stockParam("", "");
		}
		
		List<stocksDto> list = service.stockslist(param);
		
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
	        slist.add(element.toString());
		}
		
		
		// 시가총액 1-50
		
		String KEY_WORD1 = "market_sum.naver";

		System.out.println("URL :: " + URL + getParameter(KEY_WORD1, 1));

		// 1. document가져오기
		Document doc1 = Jsoup.connect(URL + getParameter(KEY_WORD1, 1)).get();

		// 2.목록가져오기
		/* System.out.println("" + doc.toString()); */
		Elements elements1 = doc1.select(".type_2 tbody");

		// 3. 배열에서 정보를 가져온다.
		List<String> sslist = new ArrayList<>();
		for (Element element : elements1) {
			element.select("thead tr th:last-child").remove();
	        element.select("td:last-child a").remove();
			sslist.add(element.toString());
		}
			
	// 시가총액 51- 100
		
		String KEY_WORD2 = "market_sum.naver";

		System.out.println("URL :: " + URL + getParameter1(KEY_WORD2, 2));

		// 1. document가져오기
		Document doc2 = Jsoup.connect(URL + getParameter1(KEY_WORD2, 2)).get();

		// 2.목록가져오기
		/* System.out.println("" + doc.toString()); */
		Elements elements2 = doc2.select(".type_2 tbody");

		// 3. 배열에서 정보를 가져온다.
		List<String> ssslist = new ArrayList<>();
		for (Element element : elements2) {
			element.select("thead tr th:last-child").remove();
	        element.select("td:last-child a").remove();
			ssslist.add(element.toString());
		}

		//------------------------------------------------------------------------
		model.addAttribute("stocklist", list);
		model.addAttribute("param", param);
		model.addAttribute("slist",slist);
		model.addAttribute("sslist",sslist);
		model.addAttribute("ssslist",ssslist);
		return "stockMain";
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
	
	public static String getParameter(String KEY_WORD1, int PAGE) {
		return KEY_WORD1 + "?&page=1";
	}
	
	public static String getParameter1(String KEY_WORD2, int PAGE) {
		return KEY_WORD2 + "?&page=2";
	}
	
	
}
