package ssg.com.a.controller;

import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	@GetMapping("home.do")
	public String home() {
		System.out.println("HomeController home() " + new Date());
		return "main";
	}
	
	@GetMapping("home2.do")
	public String home2(Model model) {
		System.out.println("HomeController home() " + new Date());
		
		model.addAttribute("content", "home2");
		return "main";
	}
}
