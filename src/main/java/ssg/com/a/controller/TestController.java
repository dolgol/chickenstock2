package ssg.com.a.controller;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ssg.com.a.dto.NewsComment;
import ssg.com.a.dto.NewsParam;

@Controller
public class TestController {
	

	
	
	
	@GetMapping("home.do")
	public String home(Model model) {
		
		System.out.println("TestController home() " + new Date());
		
		model.addAttribute("content", "home");
		
		return "main";
	}
	
	@GetMapping("mypageLike.do")
	public String mypageLike(Model model) {
		
		System.out.println("TestController mypageLike() " + new Date());
		
		model.addAttribute("content", "user/mypage");
		model.addAttribute("mypageContent", "mypageLike");
		
		return "main";
	}
	
	@GetMapping("mypageComment.do")
	public String mypageComment(Model model) {
		
		System.out.println("TestController mypageComment() " + new Date());
		
		model.addAttribute("content", "user/mypage");
		model.addAttribute("mypageContent", "mypageComment");
		
		return "main";
	}
	
	@GetMapping("mypageEdit.do")
	public String mypageEdit(Model model) {
		
		System.out.println("TestController mypageEdit() " + new Date());
		
		model.addAttribute("content", "user/mypage");
		model.addAttribute("mypageContent", "mypageEdit");
		
		return "main";
	}

}
