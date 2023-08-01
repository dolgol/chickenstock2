package ssg.com.a.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import org.apache.commons.text.StringEscapeUtils;

import org.jsoup.nodes.TextNode;
import com.google.gson.Gson;

import ssg.com.a.dto.MypageNewsComment;
import ssg.com.a.dto.MypageParam;
import org.json.JSONObject;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import ssg.com.a.dto.MessageDto;
import ssg.com.a.dto.NewsComment;
import ssg.com.a.dto.NewsDto;
import ssg.com.a.dto.NewsParam;
import ssg.com.a.dto.UserDto;
import ssg.com.a.service.NewsService;
import util.NewsUtil;

@Configuration
@EnableAsync
@EnableScheduling
@Controller
public class NewsController {

	public int hour = 0;
	public int minute = 0;
	public int sec = 0;
	
	@Autowired
	NewsService service;
	
	@GetMapping("newslist.do")
	public String newslist(NewsParam param, Model model) {
		System.out.println("NewsController newslist() " + new Date());
		System.out.println(param.toString());
		
		if(param == null || param.getSearch() == null || param.getChoice() == null) {
			param = new NewsParam("", "", 0);
		}
		
		List<NewsDto> list = service.newslist(param);
				
		// 글의 총수
		int count = service.getAllnews(param);	
		// 페이지를 계산
		int pagenews = count / 10;	
		if((count % 10) > 0) {
			pagenews = pagenews + 1;	
		}		
		
		model.addAttribute("newslist", list);
		model.addAttribute("pagenews", pagenews);
		model.addAttribute("param", param);
		
		model.addAttribute("content", "news/newslist");
		
		return "main";
	}	
	
	public void newsFind(NewsDto news) {
		System.out.println("NewsController newsFind() " + new Date());
    	NewsDto existingNews = service.newsFind(news);
        
        if (existingNews == null) {
            NewsDto newNews = new NewsDto(news.getTitle(), news.getWrite_id(), news.getPublication_date(), news.getContent(), news.getSource());
            
            service.newswrite(newNews);
	    }else {
	    	System.out.println("NewsController newsFind() no news to add " + new Date());
	    }
	        
	}
	
	//@PostConstruct
    @Scheduled(fixedRate = 0*(60*60*1000)/*시*/ + 10*(60*1000)/*분*/ + 0*(1000)/*초*/)  // m/s단위 ((시간) + (분) + (초) ex)(1*60)*(60)*(1000) + (0*60)*(1000) + (0*1000) << 1시간마다 실행)
    public void scheduleNewsSaving() throws Exception {
    	int investing = 0;
    	int naver = 1;
    	int scrapCount = 3;
    	/*
        List<NewsDto> investingNewsList = newsScrap(investing, scrapCount);  // 뉴스를 가져오고 번역하는 메소드
        
        for (NewsDto news : investingNewsList) {
        	System.out.println("NewsController scheduleNewsSaving() " + new Date());
        	newsFind(news);
        }
        
        List<NewsDto> naverNewsList = newsScrap(naver, scrapCount);  // 뉴스를 가져오고 번역하는 메소드
        for (NewsDto news : naverNewsList) {
        	System.out.println("NewsController scheduleNewsSaving() " + new Date());
        	newsFind(news);
        }
        */
    }
	
	@GetMapping("newsnotice.do")
	public String newswrite(Model model) {
		System.out.println("NewsController newswrite() " + new Date());
		
		model.addAttribute("content", "news/newswrite");
		return "main";
	}
	
	@PostMapping("newswriteAf.do")
	public String newswriteAf(NewsDto dto, Model model) {
		System.out.println("NewsController newswriteAf() " + new Date());
		
		boolean isS = service.newsnotice(dto);
		String newswrite = "NEWS_ADD_OK";
		if(isS == false) {
			newswrite = "NEWS_ADD_NO";
		}
		model.addAttribute("newswrite", newswrite);
		
		return "message";
	}
	
	@GetMapping("newsdetail.do")
	public String newsdetail(int seq, int pageNumber, Model model) {
		System.out.println("NewsController newsdetail() " + new Date());
		NewsParam param = new NewsParam(seq, pageNumber);
		if(param == null) {
			System.out.println("param null?? "+ param.toStringComment());
			model.addAttribute("content", "news/newslist");
			
			return "main";
		}
		
		NewsDto dto = service.newsdetail(param.getSeq());
		List<NewsComment> comDto = service.commentList(param);
		
		// 글의 총수
		int count = service.getAllComment(seq);	
		// 페이지를 계산
		int pagenews = count / 10;	
		if((count % 10) > 0) {
			pagenews = pagenews + 1;	
		}	
		
		model.addAttribute("pagenews", pagenews);
		model.addAttribute("newsdto", dto);
		model.addAttribute("comdto", comDto);
		model.addAttribute("param", param);
		model.addAttribute("commentCount", count);
		model.addAttribute("content", "news/newsdetail");
		return "main";
	}
	
	
	@GetMapping("newsViewUpdate.do")
	public void newsViewUpdate(int seq, Model model) {
		NewsDto dto = service.newsget(seq);
		service.newsViewUpdate(dto);
		System.out.println("NewsController newsViewUpdate() " + new Date() + "\n views = " + dto.getViews());
	}
	
	@GetMapping("newsupdate.do")
	public String newsupdate(int seq, int pageNumber, Model model) {
		System.out.println("NewsController newsupdate() " + new Date());
		
		NewsDto dto = service.newsget(seq);
		NewsParam param = new NewsParam(seq, pageNumber);
		model.addAttribute("newsDto", dto);
		model.addAttribute("param", param);
		
		model.addAttribute("content", "news/newsupdate");
		return "main";
	}
	
	@PostMapping("newsupdateAf.do")
	public String newsupdateAf(NewsDto dto, Model model) {
		System.out.println("NewsController newsupdateAf() " + new Date());
		
		boolean isS = service.newsupdate(dto);
		
		String message = "NEWSUPDATE_YES";
		if (isS == false) {
			message = "NEWSUPDATE_NO";
		}
		model.addAttribute("newsupdate", message);
		
		return "message";
	}
	
	@GetMapping("newsdelete.do")
	public String newsdelete(int seq, Model model) {
		System.out.println("NewsController bbsdeleteAf() " + new Date());
		
		NewsDto dto = service.newsget(seq);
		
		boolean isS = service.newsdelete(dto);
		
		String message = "NEWSDELETE_YES";
		if(isS == false) {
			message = "NEWSDELETE_NO";
		}
		model.addAttribute("newsdelete", message);
		
		return "message";
		
	}
	
	@PostMapping("commentWrite.do")
	public String commentWrite(NewsComment dto, Model model) {
		System.out.println("NewsController commentWriteAf " + new Date());
		
		boolean isS = service.commentWrite(dto);
		String commentwrite = "COMMENT_ADD_OK";
		if(isS == false) {
			commentwrite = "COMMENT_ADD_NO";
		}
		model.addAttribute("commentwrite", commentwrite);
		
		return "message";
		
	}
	
	@ResponseBody
	@GetMapping("newscommentList.do")
	public List<NewsComment> commentList(int seq, int pageNumber){
		System.out.println("newsController commentList() "+ seq + " " + new Date());
		NewsParam param = new NewsParam(seq, pageNumber);
		List<NewsComment> temp = service.commentList(param);
		
		return temp;
	}
	
	
	
	@GetMapping("commentDelete.do")
	public String commentDelete(int post_num, int seq, int pageNumber, Model model) {
		System.out.println("NewsController commentDeleteAf() " + new Date());

		NewsComment temp = new NewsComment(post_num, seq);
		NewsComment comDto = service.commentGet(temp);

		boolean isS = service.commentDelete(comDto);

		String message = "COMMENTDELETE_YES";
		if(isS == false) {
			message = "COMMENTDELETE_NO";
		}
		model.addAttribute("commentDelete", message);
		model.addAttribute("pageNumber" + pageNumber);
		
		return "message";
		
	}
	@ResponseBody
	@PostMapping("commentAnswer.do")
	public String commentAnswer(int post_num, int seq, String content, String user_id, Model model) {
		System.out.println("NewsController commentAnswer() " + new Date());

		NewsComment temp = new NewsComment(post_num, seq, content, user_id);
		NewsComment comDto = service.commentGet(temp);	

		comDto.setContent(content);
		comDto.setUser_id(user_id);
		boolean isS = service.commentAnswer(comDto);
		String message = "COMMENTANSWER_YES";
		if(isS == false) {
			message = "COMMENTANSWER_NO";
		}
		
		model.addAttribute("commentAnswer", message);
		
		return "message";
	}
	
	@GetMapping("newsScrap.do")
    public List<NewsDto> newsScrap(int num, int scrapCount) throws Exception {
		System.out.println("NewsController newsScrap() " + new Date());
		
		String articleAuthor = null;
		String articleDate = null;
		String content = null;
		
		int CrawlLimit = scrapCount;
		int count = 0;
		
		List<NewsDto> newsOrigins = new ArrayList<NewsDto>();
		
		if (num == 0) {
			System.out.println("NewsController newsScrap() Investing " + new Date());
			String url = "https://www.investing.com/news/stock-market-news";
			Document doc = Jsoup.connect(url).get();
	        Elements newsHeadlines = doc.select(".largeTitle > article");
 
	        for (Element headline : newsHeadlines) {
	        	// 한번에 기사를 크롤링 하는 개수
	        	if (count >= CrawlLimit) {
	        		break;
	        	}
	        	
	        	String title = headline.select("div > a").text();

	        	Element linkElement = headline.selectFirst("a");
	        	String link = linkElement.absUrl("href");

        		Document articleDoc = Jsoup.connect(link).get();
        		
        		Elements articleDateTempList = articleDoc.select("div.contentSectionDetails"); // 기사 작성일

        		String articleDateTemp = "";
        		for (Element articleDateTempOne: articleDateTempList) {
        			articleDateTemp = articleDateTempOne.select("span").text();
        			if (articleDateTemp.trim().isEmpty()) {
	                	articleDateTemp = "";
	        		}else {
	        			break;
	        		}
        		}
        		
        		String specificString = "Published ";
                int findPublished = articleDateTemp.indexOf("Published ");
                if(findPublished != -1) {
                	findPublished = findPublished + specificString.length() - 1;
                }else {
                	findPublished = 0;
                }

                int findET = articleDateTemp.indexOf("ET");
                /*
                Date DateTemp = new Date();
                SimpleDateFormat Date = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                articleDate = Date.format(DateTemp);
				*/
                articleDateTemp.substring(findPublished, findET);
        		Elements paragraphs = articleDoc.select("div.WYSIWYG.articlePage > p "); // 기사 내용(모든 <p> 태그 선택)
        		// 작성자 저장
        		articleAuthor = paragraphs.get(0).text();
        		if(articleAuthor.length() > 20 || articleAuthor.length() > 20 ) {
        			articleAuthor = "investing.com";
        			if(articleAuthor.isBlank() || articleAuthor.isEmpty()) {
        				articleAuthor = "investing.com";
        			}else if(articleAuthor.contains("(Reuters)")) {
        				articleAuthor = "Reuters";
        			}else {
        				articleAuthor = "Reuters";
        			}
        		}
        		
        		
        		// 기사 내용 저장
        		StringBuilder articleContent = new StringBuilder();
        		for (int i = 1; i < paragraphs.size(); i++) {
        			articleContent.append(paragraphs.get(i).text()); // 각 <p> 태그의 텍스트 추출
                    articleContent.append("\n\n"); // 줄바꿈 추가
        		}
        		
        		content = articleContent.toString();
        		String contentTemp = articleContent.toString();
        		if (contentTemp.trim().isEmpty()) {
        			content = title;
        		}
	        	
        		NewsDto newsOrigin = new NewsDto(title, articleAuthor, articleDate, content, link);
        		// 동일한 제목이 있으면 해당 제목 return
        		if(service.newsFind(newsOrigin) != null) {
        			
        			System.out.println("\n news skip check: \n" + service.newsFind(newsOrigin));
        			break;
        		}
        		newsOrigins.add(newsOrigin); // 각각 Author, title, content 정보가 들어있는 NewsParam 객체 리스트 
        		//System.out.println("title: " + title + "\n link: " + link + "\n Author: " + articleAuthor 
        		//		+ "\nContent: " + content + "\nDate: " + articleDate);
        	count ++;
	        }
        	
        }else if(num == 1) {
        	System.out.println("NewsController newsScrap() Naver " + new Date());
        	String url = "https://finance.naver.com/news/news_list.naver?mode=LSS2D&section_id=101&section_id2=258";
        	Document doc = Jsoup.connect(url).get();
        	Elements newsElementsAuthor = doc.select("#contentarea_left > .realtimeNewsList > li > dl > .articleSummary");
        	Elements newsElementsLink = doc.select("#contentarea_left > .realtimeNewsList > li > dl > .articleSubject");
        	for (int i = 0; i < newsElementsLink.size(); i++) {
        		if (count >= CrawlLimit) {
	        		break;
	        	}
        		Element elementAuthor = newsElementsAuthor.get(i);
        		Element elementLink = newsElementsLink.get(i);
        		articleAuthor = elementAuthor.select("span.press").text();
        		articleDate = elementAuthor.select("span.wdate").text();
        		String link = "https://finance.naver.com" + elementLink.select("a").attr("href");
        		Document articleDoc = Jsoup.connect(link).get();

        		String title = articleDoc.selectFirst("div.article_info > h3").text();
        		Elements paragraphs = articleDoc.select("div.articleCont");
        		paragraphs.select("span").remove();
        		paragraphs.select("ul").remove();
        		paragraphs.select("h3").remove();
        		paragraphs.select("b").remove();
        		for (Element br : paragraphs.select("br")) {
        			br.replaceWith(new TextNode("\n"));
        		}
        		content = paragraphs.text();

	    	    NewsDto newsOrigin = new NewsDto(title, articleAuthor, articleDate, content, link);
	        	if(service.newsFind(newsOrigin) != null) {
	    			System.out.println("\n news skip check \n");
	    			break;
	    		}
        	newsOrigins.add(newsOrigin); // 각각 Author, title, content 정보가 들어있는 NewsParam 객체 리스트
        	//System.out.println("title: " + title + "\n link: " + link + "\n Author: " + articleAuthor 
			//	+ "\nContent: " + content + "\nDate: " + articleDate);
        	count++;
        	}	
        }
		
        return newsSummary(newsOrigins);//(newsOrigins); // 요약 기사 NewsParam 객체 리스트 
    }
	
	private List<NewsDto> newsSummary(List<NewsDto> newsList) throws Exception {
		Gson gson = new Gson();
        String apiKey = ""; // OpenAI API Key
        //String engine = "gpt-3.5-turbo"; // Engine id
        int maxTokens = 1000; // Maximum number of tokens in the response
        // Prepare the API URL
        String apiUrl = "https://api.openai.com/v1/chat/completions";
        
        List<NewsDto> summaryList = new ArrayList<NewsDto>(); // to store summaries

        // Create HTTP client
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {

        	HttpPost httpPost = new HttpPost(apiUrl);
        	
        	// Set headers
            httpPost.setHeader("Content-Type", "application/json");
            httpPost.setHeader("Authorization", "Bearer " + apiKey);
            
            for (int i = 0; i < newsList.size(); i++) {

            	// Extract content outside of the inner class
            	final Object summaryContent = "You are a helpful assistant that summarizes news articles.";
            	
            	Object originalTextTemp = "";
            	if(NewsUtil.isMostlyKorean(newsList.get(i).getContent())){
            		originalTextTemp = "Original text: " + newsList.get(i).getContent() + "\nSummarize for a beginner investor in Korean";
            	}else {
            		originalTextTemp = "Original text: " + newsList.get(i).getContent() + "\nSummarize for a beginner investor";
            	}
            	final Object originalText = originalTextTemp;

            	// Create request body as a map
                Map<String, Object> requestBody = new HashMap<>();
                requestBody.put("model", "gpt-3.5-turbo");
                requestBody.put("messages", Arrays.asList(
            		new MessageDto("system", summaryContent),
                    new MessageDto("user", originalText)
                ));
                requestBody.put("max_tokens", maxTokens);
                // Convert the map to JSON string
                String requestBodyJson = gson.toJson(requestBody);

                // Set the request body
                StringEntity body = new StringEntity(requestBodyJson, StandardCharsets.UTF_8);
                httpPost.setEntity(body);

                // Execute the request and get the response
                String response = httpClient.execute(httpPost, httpResponse -> 
                        EntityUtils.toString(httpResponse.getEntity(), StandardCharsets.UTF_8));
                
                // Extract summary from response JSON (you should replace this with actual code to parse JSON)
                String summary = extractSummaryFromResponse(response);
                // 마침표 뒤에 줄 바꿈
                
                summary = summary.replace(". ", ".<br/><br/>");
                
                NewsDto summaryTemp = new NewsDto(newsList.get(i).getTitle(), newsList.get(i).getWrite_id(), newsList.get(i).getPublication_date() , summary, newsList.get(i).getSource());
                
                summaryList.add(summaryTemp);
            }
        }
        return summaryList; // 요약 기사 NewsParam 객체 리스트     
    }
	
	private String extractSummaryFromResponse(String response) {
		JsonElement responseJson = JsonParser.parseString(response);

		String responseJsonTemp = responseJson.getAsJsonObject() 
									.get("choices")
									.getAsJsonArray()
									.get(0)
									.getAsJsonObject()
									.get("message").getAsJsonObject()
									.get("content").getAsString();
		
		String responseJsonResult = translateToKorean(responseJsonTemp);
		//String responseJsonResult = responseJsonTemp;
		System.out.print("\n last extractSummary\n: " + responseJsonResult + "\n");
	    return responseJsonResult; 
	    
	}
	
	
	
	@GetMapping("mypageComment.do")
	public String mypageComment(HttpServletRequest request, Model model, MypageParam param) {
		
		System.out.println("NewsController mypageComment() " + new Date());
		
		UserDto login = (UserDto)request.getSession().getAttribute("login");
		
		System.out.println(" 1 >> " + param.toString());
		if(param == null) {
			param = new MypageParam(login.getUser_id(), 0);
		}

		if(param.getUser_id() == null) {
			param.setUser_id(login.getUser_id());
		}
		System.out.println(" 2 >> " + param.toString());
		
		List<MypageNewsComment> list = service.mypageNewsCommentList(param);
		
		// 글의 총수
		int count = service.mypageNewsAllComment(login.getUser_id());
		
		// 페이지를 계산
		int pageBbs = count / 10;	
		if((count % 10) > 0) {
			pageBbs = pageBbs + 1;	
		}	
		
		model.addAttribute("mypageNewsCommentList", list);
		model.addAttribute("pageBbs", pageBbs);
		model.addAttribute("param", param);
		model.addAttribute("content", "user/mypage");
		model.addAttribute("mypageContent", "mypageComment");
		
		return "main";
	}
	
	@ResponseBody
	@GetMapping("mypageNewsCommentDel.do")
	public String mypageNewsCommentDel(@RequestParam(value="deleteList[]") List<Integer> deleteList) {
		
		System.out.println("NewsController mypageNewsCommentDel() " + new Date());
		
		for (int i = 0; i < deleteList.size(); i++) {
			System.out.println("deleteList " + i + " / " + deleteList.get(i));
		}
		
		boolean isS = service.mypageNewsCommentDel(deleteList);
		String msg = "true";
		
		if(isS == false) {
			msg = "false";
		}
		
		return msg;
	}
	
	private Map<String, String> translationCache = new HashMap<>();
	
	public String translateToKorean(String text) {
		if(NewsUtil.isMostlyKorean(text)) {
			return text;
		}else {
			// Check if the translation is already in the cache
			if (translationCache.containsKey(text)) {
				return translationCache.get(text);
			}
			try {
		        // Papago API에 필요한 정보를 설정
		        String clientId = "";
		        String clientSecret = "";
		        String apiUrl = "https://openapi.naver.com/v1/papago/n2mt";
	
		        // HTTP 클라이언트를 생성
		        CloseableHttpClient httpClient = HttpClients.createDefault();
	
		        // POST 메소드를 생성하고 헤더를 설정
		        HttpPost httpPost = new HttpPost(apiUrl);
		        httpPost.addHeader("X-Naver-Client-Id", clientId);
		        httpPost.addHeader("X-Naver-Client-Secret", clientSecret);
		        // 번역할 텍스트를 List 형태로 요청 본문에 추가
		        List<NameValuePair> params = new ArrayList<>();
		        params.add(new BasicNameValuePair("source", "en"));
		        params.add(new BasicNameValuePair("target", "ko"));
		        params.add(new BasicNameValuePair("text", text));
		        httpPost.setEntity(new UrlEncodedFormEntity(params, "UTF-8"));
	
		        // 요청을 실행하고 응답을 받아옴
		        HttpResponse response = httpClient.execute(httpPost);
		        String responseJson = EntityUtils.toString(response.getEntity(), "UTF-8");
		        
		        JSONObject jsonResponse = new JSONObject(responseJson);
		        // 응답 JSON에서 번역된 텍스트를 가져옴
		        String translatedText = jsonResponse.getJSONObject("message").getJSONObject("result").getString("translatedText");
		        
		    	// Store the translation in the cache for future use
				translationCache.put(text, translatedText);
				
		        return translatedText;
		    } catch (Exception e) {
		        e.printStackTrace();
		        return null;
		    }
		}
	}
}


















