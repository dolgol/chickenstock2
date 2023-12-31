package ssg.com.a.controller;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.tribes.ChannelMessage;
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

import ssg.com.a.dto.MypageNewsComment;
import ssg.com.a.dto.MypageParam;
import ssg.com.a.dto.MypageStocksComment;
import ssg.com.a.dto.StockLike;
import ssg.com.a.dto.StockParam;
import ssg.com.a.dto.StocksComment;
import ssg.com.a.dto.StocksDto;
import ssg.com.a.dto.UserDto;
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
			element.select(".blank_06").remove();
	        element.select(".blank_08").remove();
	        
	        element.select("tr").attr("onmouseover", "mouseOver(this)");
	        element.select("tr").attr("onmouseout", "mouseOut(this)");
	        element.select("tr:first-child").removeAttr("onmouseover");
	        element.select("tr:first-child").removeAttr("onmouseout");
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
		        element.select("td.center").remove();
		        element.select(".blank_06").remove();
		        element.select(".blank_08").remove();
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
		
		model.addAttribute("content","stocks/stockMain");
		
		return "main";			
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
	public String stockdetail(@RequestParam("symbol") String symbol, Model model,
			HttpSession session/* , @RequestParam("pageNumber") Integer pageNumber, int seq */, HttpServletResponse response) throws Exception{
		System.out.println("StockController stocksdetail() " + new Date());	

		String URL = "https://finance.naver.com/item/main.naver?code=";
		
		StocksDto dto = service.stocksdetail(symbol);
		List<StocksComment> comment = service.stockscommentlist(symbol);
		UserDto user = (UserDto)session.getAttribute("login");
		if(user == null ) {
			
			String msg = "로그인 해 주십시오";			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter w = response.getWriter();
			w.write("<script>alert('"+msg+"'); window.location.href='login.do';</script>");
			w.flush();
			w.close();
	        
		};
		
		String user_id = user.getUser_id();
		List<StockLike> list = service.getlike(user_id);
		
		/*
		 * StockParam param = new StockParam(symbol, pageNumber);
		 * 
		 * 
		 * int count = service.stockgetall(seq);
		 * 
		 * int pagecomment = count / 10; if((count % 10) > 0) { pagecomment =
		 * pagecomment + 1; } System.out.println(pagecomment);
		 * System.out.println(param);
		 */
		
		//크롤링시작-----------------------------------------------------------------------
		
		// 1. document가져오기
		Document doc = Jsoup.connect(URL + symbol).get();
		
		// 2.목록가져오기
		Elements elements = doc.select(".wrap_company");		
		//회사이름0x
		List<String> stock = new ArrayList<>();
			for(Element element : elements) {
			element.select("onclick").remove();
			element.select(".summary").remove();
			
			
			Element first = element.select(".wrap_company h2").first(); 
			Element ele = new Element("i"); // 폰트어썸아이콘추가 
			ele.html("<span id='icon'><i class=\"fas fa-solid fa-heart\"></i></span>"); 
			first.appendChild(ele);			
			
			stock.add(element.toString());
			
			}
			System.out.println(stock);
			
		//오늘가격1x
		elements = doc.select(".today");
			for(Element element : elements) {
				stock.add(element.toString());
				
			}
		// 전일, 시가, 고가, 저가, 거래량, 거래대금2,3x
			elements = doc.select(".no_info tbody tr:nth-child(1)");
			for(Element element : elements) {	
				element.select(".sptxt.sp_txt6").remove();
				element.select(".sptxt.sp_txt8").remove();
				element.select(".no_cha").remove();
				stock.add(element.toString());
				
			}
						
			elements = doc.select(".no_info tbody tr:nth-child(2)");
			for(Element element : elements) {
				element.select(".sptxt.sp_txt7").remove();
				element.select(".sptxt.sp_txt8").remove();
				element.select(".no_cha").remove();
				stock.add(element.toString());
				
			}
		//차트4 x
			elements = doc.select(".chart");
			for(Element element : elements) {			
				element.select(".chart_control_area").remove();	
				element.select("p").remove();	
				element.select("h5").remove();	
				stock.add(element.toString());
				
			}
			// 투자정보 5o
			elements = doc.select("#aside .aside_invest_info .tab_con1");
			for(Element element : elements) {
				
				element.select(".gray table tbody tr:nth-child(3) th a").remove();
				element.select(".per_table tbody tr th a").remove();
				element.select(".tab_con1").attr("class", "table text-center");
				element.select("table tr td").removeAttr("style");
				element.select("caption").remove();
				element.select(".tbl_type1 tbody tr th a img").remove();
				element.select(".lwidth tbody tr th a img").remove();
				element.select(".lwidth tbody tr th a").remove();
				element.select("#tab_con1 div:nth-child(6)").attr("class", "tdb");

				stock.add(element.toString());

			}
			// 매매동향6o
			elements = doc.select(".sub_section");
			for(Element element : elements) {
				element.select("caption").remove();
				Elements spanElements = doc.select(".h_th.th_deal_amount span");
					for(Element span : spanElements) {
						span.text("거래량");		//거개량으로 나오는 오류 수정				
					}				
				element.select("tb_type1").attr("class", "table");
				
				stock.add(element.toString());

			}						
		
		//크롤링끝------------------------------------------------------------------------------
		model.addAttribute("symbol", dto);
		model.addAttribute("stock", stock);
		model.addAttribute("comment", comment);	
		model.addAttribute("list", list);
		/*
		 * model.addAttribute("pagecomment", pagecomment); model.addAttribute("param",
		 * param);
		 */
		model.addAttribute("content","stocks/stocksdetail");
		
		
		return "main";
	}
	
	@PostMapping("commentWriteAf.do")
	public String commentWriteAf(StocksComment stocksComment, Model model, HttpServletResponse response) throws Exception{
		System.out.println("StockController commentWriteAf() " + new Date());
		
		int symbolNum = Integer.parseInt(stocksComment.getSymbol());
		String symbol = String.format("%06d", symbolNum);
		
		
		boolean isS = false;
		isS = service.stockscommentwrite(stocksComment);
		if(isS) {
			System.out.println("댓글 작성에 성공했습니다");
		}else {
			System.out.println("댓글 작성에 실패했습니다");
		}
		
		// model.addAttribute("content","redirect:/stocksdetail.do?symbol="+symbol);
		
		// redirect == sendRedirect  
		return "redirect:/stocksdetail.do?symbol="+symbol;
	}
	
	@GetMapping("like.do")
	@ResponseBody
	public String like(Model model, HttpSession session, StockLike stocklike) {
		
		String user_id = (String)session.getAttribute("user_id");
		
		StockLike like = new StockLike();
		like.setUser_id(user_id);
		like.setSymbol(stocklike.getSymbol());
		
		model.addAttribute("like", like);
		
		boolean isExist = service.checklike(stocklike);
		if (isExist) {
			service.deletelike(stocklike);
			return "deleted";
		} else {
			service.insertlike(stocklike);
			return "inserted";
		}
	}
	
	/*
	 * @GetMapping("commentDelete.do") public String commentDelete(String symbol,
	 * int seq, Model model) {
	 * System.out.println("StocksController commentDeleteAf() " + new Date());
	 * StocksComment temp = new StocksComment(symbol, seq); StocksComment comDto =
	 * service.stockcommentget(temp);
	 * 
	 * boolean isS = service.stockcommentdelete(comDto); String message =
	 * "COMMENTDELETE_YES"; if(isS == false) { message = "COMMENTDELETE_NO"; }
	 * model.addAttribute("commentDelete", message);
	 * 
	 * return "message";
	 * 
	 * }
	 */	
	
	@GetMapping("mypageLike.do")
	public String mypageLike(Model model, HttpServletRequest request) {
		
		System.out.println("StockController mypageLike() " + new Date());
		
		UserDto login = (UserDto)request.getSession().getAttribute("login");
		
		if(login == null || login.getUser_id().equals("")){
			return "redirect:/login.do";
		}
		
		List<StocksDto> list = service.mypageLikeList(login.getUser_id());
		
		model.addAttribute("content", "user/mypage");
//		model.addAttribute("mypageContent", "mypageLike");
		model.addAttribute("mypageContent", "mypageLikeScroll");
		model.addAttribute("mypageLikeList", list);
		
		return "main";
	}
	
	@ResponseBody
	@GetMapping("mypageScroll.do")
	public List<StocksDto> mypageScroll(MypageParam param) {
		
		System.out.println("StockController mypageScroll() " + new Date());
		System.out.println(param.toString());
		
		List<StocksDto> list = service.mypageLikeScroll(param);
		System.out.println(list.size());
		System.out.println(list);
		
		return list;
	}
	
	@GetMapping("mypageStocksComment.do")
	public String mypageStocksComment(HttpServletRequest request, Model model, MypageParam param) {
		
		System.out.println("StockController mypageStocksComment() " + new Date());
		
		UserDto login = (UserDto)request.getSession().getAttribute("login");
		
		if(login == null || login.getUser_id().equals("")){
			return "redirect:/login.do";
		}
		
		System.out.println(" 1 >> " + param.toString());
		if(param == null) {
			param = new MypageParam(login.getUser_id(), 0);
		}

		if(param.getUser_id() == null) {
			param.setUser_id(login.getUser_id());
		}
		System.out.println(" 2 >> " + param.toString());
		
		List<MypageStocksComment> list = service.mypageStocksCommentList(param);
		
		// 글의 총수
		int count = service.mypageStocksAllComment(login.getUser_id());
		
		// 페이지를 계산
		int pageBbs = count / 10;	
		if((count % 10) > 0) {
			pageBbs = pageBbs + 1;	
		}	
		
		model.addAttribute("mypageStocksCommentList", list);
		model.addAttribute("pageBbs", pageBbs);
		model.addAttribute("param", param);
		model.addAttribute("content", "user/mypage");
		model.addAttribute("mypageContent", "mypageCommentStocks");
		
		return "main";
	}
	
	@ResponseBody
	@GetMapping("mypageStocksCommentDel.do")
	public String mypageStocksCommentDel(@RequestParam(value="deleteList[]") List<Integer> deleteList) {
		
		System.out.println("StockController mypageStocksCommentDel() " + new Date());
		
		for (int i = 0; i < deleteList.size(); i++) {
			System.out.println("deleteList " + i + " / " + deleteList.get(i));
		}
		
		boolean isS = service.mypageStocksCommentDel(deleteList);
		String msg = "true";
		
		if(isS == false) {
			msg = "false";
		}
		
		return msg;
	}
}