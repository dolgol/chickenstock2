package ssg.com.a.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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

import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.nio.charset.StandardCharsets;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import org.apache.commons.text.StringEscapeUtils;
import com.google.gson.Gson;

import ssg.com.a.dto.NewsComment;
import ssg.com.a.dto.NewsDto;
import ssg.com.a.dto.NewsParam;
import ssg.com.a.service.NewsService;

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
	@GetMapping("commentList.do")
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
    public List<NewsParam> newsScrap(String[] args) throws Exception {
		System.out.println("NewsController newsScrap() " + new Date());
        
		List<NewsParam> newsOrigins = new ArrayList<NewsParam>();
		
		Document doc = Jsoup.connect(url).get();
        Elements newsHeadlines = doc.select(".largeTitle > article");
        
        
        int count = 0;
        for (Element headline : newsHeadlines) {
        	if (count > 5) {
        		break;
        	}
        	count ++;
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
        		// 기사 내용 저장
        		StringBuilder articleContent = new StringBuilder();
        		for (int i = 1; i < paragraphs.size(); i++) {
        			articleContent.append(paragraphs.get(i).text()); // 각 <p> 태그의 텍스트 추출
                    articleContent.append("\n\n"); // 줄바꿈 추가
        		}
        		String content = articleContent.toString();
        		
        		NewsParam newsOrigin = new NewsParam(title, content);
        		
        		newsOrigins.add(newsOrigin); // 각각 title, content 정보가 들어있는 NewsParam 객체 리스트 
        		
        		//System.out.println("title: " + title + "\n link: " + link + "\n Author: " + articleAuthor 
        			//	+ "\nContent: " + content + "\nDate: " + articleDate);
        	} catch(IOException e) {
        		e.printStackTrace();
        	}
        	newsSummary(newsOrigins).toString();
        }  
        return newsSummary(newsOrigins); // 요약 기사 NewsParam 객체 리스트 
    }
	
	private List<NewsParam> newsSummary(List<NewsParam> newsList) throws Exception {
		Gson gson = new Gson();
        String apiKey = ""; // OpenAI API Key
        String engine = "text-davinci-002"; // Engine id
        int maxTokens = 60; // Maximum number of tokens in the response
        // Prepare the API URL
        String apiUrl = String.format("https://api.openai.com/v1/engines/%s/completions", engine);
        
        List<NewsParam> summaryList = new ArrayList<NewsParam>(); // to store summaries

        // Create HTTP client
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
        	HttpPost httpPost = new HttpPost(apiUrl);
        	
        	// Set headers
            httpPost.setHeader("Content-Type", "application/json");
            httpPost.setHeader("Authorization", "Bearer " + apiKey);
            
            for (int i = 0; i < newsList.size(); i++) {
            	
            	String prompt = "Original text: " + newsList.get(i).getOriginContent() + "\nSummarize for a beginner investor"; // Prompt for summary
            	
            	// Create request body as a map
                Map<String, Object> requestBody = new HashMap<>();
                requestBody.put("prompt", prompt);
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
                NewsParam summaryTemp = new NewsParam(summary);
                
                summaryList.add(summaryTemp);
                System.out.println(response);

            }
        }
        return summaryList; // 요약 기사 NewsParam 객체 리스트     
    }
	
	private String extractSummaryFromResponse(String response) {
		JsonElement responseJson = JsonParser.parseString(response);
	    System.out.println(responseJson.toString());  // Add this line to print the JSON structure
		/*
		
		JsonElement responseJson = JsonParser.parseString(response);
	    String summary = responseJson.getAsJsonObject().get("choices").getAsJsonArray().get(0).getAsJsonObject().get("text").getAsString();
	    */
	    return null;
	    
	}
}


















