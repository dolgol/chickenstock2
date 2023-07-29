package ssg.com.a.controller;

import java.net.http.HttpResponse;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import ssg.com.a.dto.StockLike;
import ssg.com.a.dto.UserDto;
import ssg.com.a.service.StockService;

@Controller
public class TestController {
	
	@Autowired
	StockService stockService;
	
	@GetMapping("home.do")
	public String home(Model model) {
		
		System.out.println("TestController home() " + new Date());
		
		model.addAttribute("content", "home");
		
		return "main";
	}
	
	@GetMapping("mypageLike.do")
	public String mypageLike(Model model, HttpSession session) {
		
		System.out.println("TestController mypageLike() " + new Date());
		
		model.addAttribute("content", "user/mypage");
		model.addAttribute("mypageContent", "mypageLike");
		
		// 세션에서 로그인한 사용자 정보 가져오기
		UserDto user = (UserDto)session.getAttribute("login");
		if (user == null) {
			// 만약 user가 null이면, (로그인한 상태가 아니면)
			return "redirect:/login.do";
		}
		// 로그인한 상태면,
		String user_id = user.getUser_id();
		List<StockLike> list = stockService.getlike(user_id);
		
		model.addAttribute("listList", list);
		
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
