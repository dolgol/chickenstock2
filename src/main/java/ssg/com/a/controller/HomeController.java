package ssg.com.a.controller;

import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import ssg.com.a.dto.UserDto;

@Controller
public class HomeController {
	
	@GetMapping("home.do")
	public String home(Model model) {
		
		System.out.println("HomeController home() " + new Date());
		
		model.addAttribute("content", "home");
		
		return "main";
	}

}