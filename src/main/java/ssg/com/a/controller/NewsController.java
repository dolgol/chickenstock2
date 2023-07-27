package ssg.com.a.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import org.apache.commons.text.StringEscapeUtils;
import com.google.gson.Gson;

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
import ssg.com.a.service.NewsService;
import util.NewsUtil;

@Controller
public class NewsController {

	@Autowired
	NewsService service;
	
	private static String url = "https://www.investing.com/news/stock-market-news";
	
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
	
	//@GetMapping("newsFind.do")
//	@GetMapping("newswrite.do")
	public String newsFind(NewsDto news, Model model) {
	    //for (NewsDto news : newsList) {

	    	NewsDto existingNews = service.newsFind(news);
	        System.out.println("existingNews= " + existingNews);
	        if (existingNews == null) {
	            NewsDto newNews = new NewsDto(news.getTitle(), news.getWrite_id(), news.getPublication_date(), news.getContent(), news.getSource());
	            System.out.println("newNews= " + newNews);
	            boolean isS = service.newswrite(newNews);
	            
	            String newswrite = "NEWS_ADD_OK";
	    		if(isS == false) {
	    			newswrite = "NEWS_ADD_NO";
	    		}
	    		model.addAttribute("newswrite", newswrite);
	    		
	    		//return "message";
	     //   }
	    }
	        return "message";
	}
	
    //@Scheduled(fixedRate = 3600000)  // 1시간마다 실행
	@GetMapping("newswrite.do")
    public void scheduleNewsSaving(Model model) throws Exception {
        List<NewsDto> newsList = newsScrap();  // 뉴스를 가져오고 번역하는 메소드
        //newsFind(newsList);
        for (NewsDto news : newsList) {
        	newsFind(news, model);
        }
    }
	/*
	@GetMapping("newswrite.do")
	public String newswrite(Model model) {
		System.out.println("NewsController newswrite() " + new Date());
		
		model.addAttribute("content", "news/newswrite");
		return "main";
	}
	
	@PostMapping("newswriteAf.do")
	public String newswriteAf(NewsDto dto, Model model) {
		System.out.println("NewsController newswriteAf() " + new Date());
		
		boolean isS = service.newswrite(dto);
		String newswrite = "NEWS_ADD_OK";
		if(isS == false) {
			newswrite = "NEWS_ADD_NO";
		}
		model.addAttribute("newswrite", newswrite);
		
		return "message";
	}
	*/
	@GetMapping("newsdetail.do")
	public String newsdetail(int seq, Model model) {
		System.out.println("NewsController newsdetail() " + new Date());
		
		NewsDto dto = service.newsdetail(seq);
		List<NewsComment> comDto = service.commentList(seq);
		
		model.addAttribute("newsdto", dto);
		model.addAttribute("comdto", comDto);
		model.addAttribute("content", "news/newsdetail");
		return "main";
	}
	
	@GetMapping("newsupdate.do")
	public String newsupdate(int seq, Model model) {
		System.out.println("NewsController newsupdate() " + new Date());
		
		NewsDto dto = service.newsget(seq);

		model.addAttribute("newsDto", dto);

		
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
	public List<NewsComment> commentList(int seq){
		System.out.println("newsController commentList() "+ seq + " " + new Date());
		List<NewsComment> temp = service.commentList(seq);
		System.out.println(temp.toString());
				
		return temp;
	}
	
	@GetMapping("commentDelete.do")
	public String commentDelete(int post_num, int seq, Model model) {
		System.out.println("NewsController commentDeleteAf() " + new Date());
		NewsComment temp = new NewsComment(post_num, seq);
		NewsComment comDto = service.commentGet(temp);

		boolean isS = service.commentDelete(comDto);

		String message = "COMMENTDELETE_YES";
		if(isS == false) {
			message = "COMMENTDELETE_NO";
		}
		model.addAttribute("commentDelete", message);
		
		return "message";
		
	}
	@ResponseBody
	@PostMapping("commentAnswer.do")
	public String commentAnswer(int post_num, int seq, String content, String user_id, Model model) {
		System.out.println("NewsController commentAnswer() " + new Date());
		System.out.println(content);
		NewsComment temp = new NewsComment(post_num, seq, content, user_id);
		NewsComment comDto = service.commentGet(temp);	
		comDto.setContent(content);
		boolean isS = service.commentAnswer(comDto);
		String message = "COMMENTANSWER_YES";
		if(isS == false) {
			message = "COMMENTANSWER_NO";
		}
		
		model.addAttribute("commentAnswer", message);
		
		return "message";
	}
	
	@GetMapping("newsScrap.do")
    public List<NewsDto> newsScrap() throws Exception {
		System.out.println("NewsController newsScrap() " + new Date());
        
		List<NewsDto> newsOrigins = new ArrayList<NewsDto>();
		
		Document doc = Jsoup.connect(url).get();
        Elements newsHeadlines = doc.select(".largeTitle > article");
        
        
        int count = 0;
        for (Element headline : newsHeadlines) {
        	if (count >= 1) {
        		break;
        	}
        	
        	String title = headline.select("div > a").text();
        	
        	Element linkElement = headline.selectFirst("a");
        	String link = linkElement.absUrl("href");
        	
        	//Element articleAuthorTemp = headline.select(".textDiv > .articleDetails > span").first(); // 기사 작성자
        	//String articleAuthor = articleAuthorTemp.text();
        	
        	try {
        		Document articleDoc = Jsoup.connect(link).get();
        		
        		Element articleDateTemp = articleDoc.select("div.contentSectionDetails > span").first(); // 기사 작성일
                if (articleDateTemp == null) {
        			continue;
        		}
                String articleDate = articleDateTemp.text();
        		
        		Elements paragraphs = articleDoc.select("div.WYSIWYG.articlePage > p "); // 기사 내용(모든 <p> 태그 선택)
        		// 작성자 저장
        		String articleAuthor = paragraphs.get(0).text();
        		if(articleAuthor.length()> 15) {
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
        		String content = articleContent.toString();
        		//System.out.println("test: " + content);
        		NewsDto newsOrigin = new NewsDto(title, articleAuthor, articleDate, content, link);
        		
        		newsOrigins.add(newsOrigin); // 각각 Author, title, content 정보가 들어있는 NewsParam 객체 리스트 
       
        		//System.out.println("title: " + title + "\n link: " + link + "\n Author: " + articleAuthor 
        			//	+ "\nContent: " + content + "\nDate: " + articleDate);
        	} catch(IOException e) {
        		e.printStackTrace();
        	}
        	
        	count ++;
        }  
        
        return newsSummary(newsOrigins);//(newsOrigins); // 요약 기사 NewsParam 객체 리스트 
    }
	
	private List<NewsDto> newsSummary(List<NewsDto> newsList) throws Exception {
		Gson gson = new Gson();
        String apiKey = ""; // OpenAI API Key
        //String engine = "gpt-3.5-turbo"; // Engine id
        int maxTokens = 50;//300; // Maximum number of tokens in the response
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
            	
            	/*
            	String prompt = "Original text: " + newsList.get(i).getOriginContent() + "\nSummarize for a beginner investor"; // Prompt for summary
            	
            	// Create request body as a map
                Map<String, Object> requestBody = new HashMap<>();
                requestBody.put("prompt", prompt);
                requestBody.put("max_tokens", maxTokens);
				*/
            	
            	// Extract content outside of the inner class
            	final Object summaryContent = "You are a helpful assistant that summarizes news articles.";
            	
            	Object originalTextTemp = "";
            	if(NewsUtil.isMostlyKorean(newsList.get(i).getContent())){
            		originalTextTemp = "Original text: " + newsList.get(i).getContent() + "\nSummarize for a beginner investor in Korean";
            	}else {
            		originalTextTemp = "Original text: " + newsList.get(i).getContent() + "\nSummarize for a beginner investor";
            	}
            	final Object originalText = originalTextTemp;
            	//System.out.print("originalText= " + originalText);
            	//System.out.println(originalText);
            	// Create request body as a map
            	
                Map<String, Object> requestBody = new HashMap<>();
                requestBody.put("model", "gpt-3.5-turbo");
                requestBody.put("messages", Arrays.asList(
            		new MessageDto("system", summaryContent),
                    new MessageDto("user", originalText)
                ));
                //System.out.println(requestBody.toString());
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
                //String summary = responseJson.get("choices").getAsJsonArray().get(0).getAsJsonObject().get("message").getAsJsonObject().get("content").getAsString();
                
                NewsDto summaryTemp = new NewsDto(newsList.get(i).getTitle(), newsList.get(i).getWrite_id(), newsList.get(i).getPublication_date() , summary, newsList.get(i).getSource());
                
                summaryList.add(summaryTemp);
                //System.out.println(response);

            }
        }
        for (int i = 0; i < summaryList.size(); i++) {
        	
        	//System.out.print(summaryList.get(i).toString()+"\n");
        }
        return summaryList; // 요약 기사 NewsParam 객체 리스트     
    }
	
	private String extractSummaryFromResponse(String response) {
		JsonElement responseJson = JsonParser.parseString(response);
	    //System.out.println(responseJson.toString());  // Add this line to print the JSON structure
		/*
		
		JsonElement responseJson = JsonParser.parseString(response);
	    String summary = responseJson.getAsJsonObject().get("choices").getAsJsonArray().get(0).getAsJsonObject().get("text").getAsString();
	    */
		//System.out.print("\nin extractSummary\n");
		String responseJsonTemp = responseJson.getAsJsonObject() 
									.get("choices")
									.getAsJsonArray()
									.get(0)
									.getAsJsonObject()
									.get("message").getAsJsonObject()
									.get("content").getAsString();
		
		System.out.print("\n after extractSummary\n: " + responseJsonTemp);
		String responseJsonResult = translateToKorean(responseJsonTemp);
		System.out.print("\n last extractSummary\n: " + responseJsonResult + "\n");
	    return responseJsonResult; 
	    
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
		        String clientId = "EmpNiTFgTYBn4eJ30Af1";
		        String clientSecret = "";
		        String apiUrl = "https://openapi.naver.com/v1/papago/n2mt";
	
		        // HTTP 클라이언트를 생성
		        CloseableHttpClient httpClient = HttpClients.createDefault();
	
		        // POST 메소드를 생성하고 헤더를 설정
		        HttpPost httpPost = new HttpPost(apiUrl);
		        httpPost.addHeader("X-Naver-Client-Id", clientId);
		        httpPost.addHeader("X-Naver-Client-Secret", clientSecret);
		        //System.out.println("text= " + text);
		        // 번역할 텍스트를 List 형태로 요청 본문에 추가
		        List<NameValuePair> params = new ArrayList<>();
		        params.add(new BasicNameValuePair("source", "en"));
		        params.add(new BasicNameValuePair("target", "ko"));
		        params.add(new BasicNameValuePair("text", text));
		        System.out.println("\n body= " + params + "\n");
		        httpPost.setEntity(new UrlEncodedFormEntity(params, "UTF-8"));
	
		        // 요청을 실행하고 응답을 받아옴
		        HttpResponse response = httpClient.execute(httpPost);
		        String responseJson = EntityUtils.toString(response.getEntity(), "UTF-8");
		        
		        JSONObject jsonResponse = new JSONObject(responseJson);
		        System.out.println("\n jsonResponse= " + jsonResponse.toString() + "\n");
		        // 응답 JSON에서 번역된 텍스트를 가져옴
		        String translatedText = jsonResponse.getJSONObject("message").getJSONObject("result").getString("translatedText");
		        System.out.println(translatedText);
		        
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


















