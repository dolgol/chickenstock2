package ssg.com.a.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class MainApp {

	private static String URL = "https://finance.naver.com/item/main.naver";
	
	public static void main(String[] args) throws Exception{
		String KEY_WORD = "107600";
		
		System.out.println("URL :: " + URL + getParameter(KEY_WORD, 2));
		
		//1. document가져오기
		Document doc = Jsoup.connect(URL + getParameter(KEY_WORD, 2)).get();
		
		
		//2.목록가져오기
		/* System.out.println("" + doc.toString()); */
		
		Elements elements = doc.select("#middle .blind dd");
		
		// 3. 배열에서 정보를 가져온다.
		List<String> list = new ArrayList<>();
		int idx = 0;	
		for(Element element : elements) {
			list.add(++idx + "" + element.text());	
		}	
		System.out.println(list);
	}
	/**
	* URL 완성
	*@Param KEY_WORD
	*@Param PAGE
	*@return
	*/
	public static String getParameter(String KEY_WORD, int PAGE) {
		return "?code=" + KEY_WORD + "" 
								 + "&itemTotalCnt:3"
								 + "&item_list:[,...]"
								 + "&login:'true'"
								 + "&next_page: 0"
								 + "&page: 1"
								 + "&prev_page:0"
								 + "&sel_cid:null"
								 + "&type:'recent'";
	}
	
}
