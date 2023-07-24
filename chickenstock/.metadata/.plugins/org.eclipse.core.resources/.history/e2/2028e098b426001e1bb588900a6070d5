package ssg.com.a.controller;

import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mysql.cj.Session;

import ssg.com.a.dto.MemberDto;
import ssg.com.a.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	MemberService service;
	
	@RequestMapping(value = "login.do")
	public String login(Model model) {
		System.out.println("MemberController login() " + new Date());
		
		model.addAttribute("content", "member/login");
		return "main";
	}
	
	@RequestMapping(value = "logout.do")
	public String logout(HttpServletRequest request) {
		System.out.println("MemberController logout() " + new Date());		
		request.getSession().removeAttribute("login");		
		return "redirect:/login.do";
	}
	
	@PostMapping("loginAf.do")
	public String login(MemberDto mem, Model model, HttpServletRequest request) {
		System.out.println("MemberController login() " + new Date());
		
		MemberDto dto = service.login(mem);
		String loginmsg = "LOGIN_NO";
		if(dto != null) {
			request.getSession().setAttribute("login", dto);	// session에 저장			
			loginmsg = "LOGIN_YES";
		}
		model.addAttribute("loginmsg", loginmsg);
		
		return "message";
	}
	
	@GetMapping("regi.do")
	public String regi() {
		System.out.println("MemberController regi() " + new Date());
		return "regi";
	}
	
	@ResponseBody
	@PostMapping("idcheck.do")
	public String idcheck(String id) {
		System.out.println("MemberController idcheck() " + new Date());
		
		boolean isS = service.idcheck(id);
		String msg = "YES";
		if(isS == true) {
			msg = "NO";
		}
		
		return msg;
	}
	
	@PostMapping("regiAf.do")
	public String regiAf(MemberDto mem, Model model) {
		System.out.println("MemberController regiAf() " + new Date());
		
		boolean isS = service.addmember(mem);
		String message = "MEMBER_YES";
		if(isS == false) {
			message = "MEMBER_NO";
		}
		model.addAttribute("message", message);
		
		return "message";
	}	
	
	
}













