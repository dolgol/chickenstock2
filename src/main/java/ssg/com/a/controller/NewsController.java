package ssg.com.a.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import ssg.com.a.dto.NewsDto;
import ssg.com.a.dto.NewsParam;
import ssg.com.a.service.NewsService;

@Controller
public class NewsController {

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
		model.addAttribute("newsdto", dto);
		
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
			message = "NEWSDELETE_YES";
		}
		model.addAttribute("newsdelete", message);
		
		return "message";
		
	}
}



















