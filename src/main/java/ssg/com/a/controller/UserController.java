package ssg.com.a.controller;

import java.util.Date;
import java.util.regex.Pattern;
import java.net.URL;
import java.security.MessageDigest;
import java.net.HttpURLConnection;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

// 카카오 연동
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


// 추가 임포트 (아이디 찾기용)
import org.springframework.web.bind.annotation.RequestParam;
import java.util.Map;
import java.util.HashMap;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;

import ssg.com.a.dto.UserDto;
import ssg.com.a.dao.UserDao; // 카카오 로그인 DB 저장을 위함
import ssg.com.a.service.UserService;

@Controller
public class UserController {

	@Autowired
	UserService service;
	
	@Autowired
	private UserDao userDao; // 카카오 로그인 db 저장
	
	@RequestMapping(value = "login.do")
	public String login() {
		System.out.println("UserController login() " + new Date());
		return "login";
	}
	
	@PostMapping("loginAf.do")
	   public String login(UserDto user, Model model, HttpServletRequest request) {
	      System.out.println("UserController loginAf() " + new Date());

	      UserDto dto = service.login(user);
	      String loginmsg = "LOGIN_NO";

	      // 사용자가 입력한 비밀번호를 해시화하여 저장된 해시된 비밀번호와 비교
	      String hashedPassword = sha256(user.getPassword()); // 해시 함수를 적용한 비밀번호

	       System.out.println("해시화 전 원래 비밀번호 : " + user.getPassword());
	       System.out.println("해시화된 비밀번호 : " + hashedPassword);
	       System.out.println("db에 저장된 비밀번호 : " + dto.getPassword());

	      if (dto != null && dto.getPassword().equals(hashedPassword)) {
	         request.getSession().setAttribute("login", dto); // session에 저장
	         request.getSession().setAttribute("loginType", "local"); // 로컬 로그인 유형 세션 저장
	         loginmsg = "LOGIN_YES";
	      }

	      model.addAttribute("loginmsg", loginmsg);

	      return "message";
	   }
	
	@RequestMapping(value = "logout.do")
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    System.out.println("UserController logout() " + new Date());

	    // 로컬 로그인 유형 확인
	    String loginType = (String) request.getSession().getAttribute("loginType");

	    //로그아웃 처리 (로컬 or 카카오)
	    request.getSession().removeAttribute("login");


	    // 로그인 유형에 따른 리다이렉트
	    if ("kakao".equals(loginType)) {
	        // 카카오 로그아웃 페이지로 리다이렉트
	        response.sendRedirect("https://accounts.kakao.com/logout?continue=http://localhost:9600/chickenstock/login.do");
	    } else {
	        response.sendRedirect("home.do");
	    }
	}



	@GetMapping("regi.do")
	public String regi() {
		System.out.println("UserController regi() " + new Date());
		return "regi";
	}
	
	@PostMapping("regiAf.do")
	   public String regiAf(UserDto user, Model model) {
	      System.out.println("UserController regiAf() " + new Date());

	      // 클라이언트에서 전송한 원래 비밀번호
	      String originalPassword = user.getPassword();

	      if (!isValidUserInfo(user)) {
	         model.addAttribute("message", "USER_NO");
	         return "message";
	      }

	      // 비밀번호 해시화
	      String hashedPassword = sha256(originalPassword);
	      user.setPassword(hashedPassword);

	      boolean isS = service.adduser(user);
	      String message = "USER_YES";
	      if (isS == false) {
	         message = "USER_NO";
	      }
	      model.addAttribute("message", message);

	      return "message";
	   }	
	
	private boolean isValidUserInfo(UserDto user) {
		
		// 아이디, 비밀번호, 이름, 이메일이 비어있을경우 false
	    if (user.getUser_id().trim().isEmpty()
	        || user.getPassword().trim().isEmpty()
	        || user.getUser_name().trim().isEmpty()
	        || user.getAddress().trim().isEmpty()) {
	        return false;
	    }
	    
	 
	    String addressRegex = "^[a-zA-Z0-9]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
	    if (!Pattern.matches(addressRegex, user.getAddress().trim())) {
	        return false; // 유효하지 않은 이메일 형식일 경우 false를 반환합니다.
	    }
	    
	    return true;
	}
	
	@ResponseBody
	@PostMapping("idcheck.do")
	public String idcheck(String user_id) {
		System.out.println("UserController idcheck() " + new Date());
		
		boolean isS = service.idcheck(user_id);
		String msg = "YES";
		if(isS == true) {
			msg = "NO";
		}
		return msg;
	}
	
	@ResponseBody
	@PostMapping("nicknamecheck.do")
	public String nicknamecheck(String nick_name) {
		System.out.println("UserController nicknamecheck() " + new Date());
		
		boolean isS = service.nicknamecheck(nick_name);
		String msg = "YES";
		if(isS == true) {
			msg = "NO";
		}
		return msg;
	}
	
	// 아이디 찾기
	@ResponseBody
	@PostMapping("findId.do")
	public ResponseEntity<?> findId(@RequestParam(value="address", required=false) String address,
	                                @RequestParam(value="phone_number", required=false) String phone_number) {
	    Map<String, String> response = new HashMap<>();
	    
	    // 폰번호랑 이메일 둘 다 안적으면 안됨
	    if (address == null || phone_number == null) {
	        response.put("errorMessage", "이메일 주소와 전화번호 둘 다 제공해주세요.");
	        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
	    }

	    // 폰번호랑 이메일 둘다 있어야 찾아짐
	    UserDto user = service.findUserByAddressAndPhoneNumber(address, phone_number);
	    
	    if (user != null) {
	        response.put("user_id", user.getUser_id());
	        return new ResponseEntity<>(response, HttpStatus.OK);
	    } else {
	        response.put("errorMessage", "해당 정보로 가입된 아이디가 없습니다.");
	        return new ResponseEntity<>(response, HttpStatus.OK);
	    }
	}

	
	// 카카오톡 로그인
	
	@PostMapping("kakaoLogin.do")
	public String kakaoLogin(@RequestParam("access_token") String accessToken, HttpSession session, RedirectAttributes redirectAttributes) {
	    // 카카오 API를 이용하여 사용자 정보를 가져오는 URL
	    String apiUrl = "https://kapi.kakao.com/v2/user/me";
	    System.out.println("kakaoLogin Success (1)");

	    try {
	        URL url = new URL(apiUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
	        System.out.println("kakaoLogin Success (2)");

	        int responseCode = conn.getResponseCode();
	        if (responseCode == 200) { // 요청에 성공한 경우
	            ObjectMapper mapper = new ObjectMapper();
	            JsonNode jsonNode = mapper.readTree(conn.getInputStream());
	            System.out.println("kakaoLogin Success (3)");

	            // 카카오로부터 받아온 사용자 정보
	            String userId = jsonNode.get("id").asText();
	            String nickname = jsonNode.get("properties").get("nickname").asText();
	            String email = jsonNode.get("kakao_account").get("email").asText();
	            System.out.println("kakaoLogin Success (4)");

	            // 카카오 API로부터 받아온 사용자 정보를 이용하여 UserDto를 만듭니다.
	            UserDto userDto = new UserDto();
	            userDto.setUser_id(userId);
	            userDto.setAddress(email);
	            userDto.setNick_name(nickname);
	            userDto.setAuth(2);
	            userDto.setBirthday(null);
	            userDto.setSex(null);
	            userDto.setPhone_number(null);
	            userDto.setUser_name(null);
	            userDto.setPassword(null);
	            // 여기에 필요한 다른 필드를 null 또는 기본값으로 설정하세요.

	            // UserDao를 이용하여 DB에서 해당 user_id의 사용자를 찾습니다.
	            int idCount = userDao.idcheck(userDto.getUser_id());  // userDao.idcheck 메소드를 호출합니다.

	            // user_id가 DB에 없는 경우에만 사용자 정보를 DB에 저장합니다.
	            if (idCount == 0) {
	                int result = userDao.adduser(userDto);  // userDao.addUser 메소드를 호출합니다.
	                if(result > 0){
	                    System.out.println("User added successfully");
	                }
	                else{
	                    System.out.println("Failed to add user");
	                }
	            } else {
	                System.out.println("User already exists");
	            }

	            // 세션에 사용자 정보 저장
	            session.setAttribute("login", userDto);
	            // session.setAttribute("access_token", accessToken);
	            session.setAttribute("loginType", "kakao"); // 로그인 유형 세션에 저장
	            System.out.println("kakaoLogin Success (5)");

	            // 로그인 성공 후 메인 페이지로
	            return "redirect:/main.do";
	        } else {
	            // 요청에 실패한 경우, 실패 메시지를 RedirectAttributes에 담아서 리다이렉트
	            redirectAttributes.addFlashAttribute("errorMsg", "카카오 로그인에 실패했습니다.");
	            return "redirect:/login.do";
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	        // 예외 발생 시, 예외 메시지를 RedirectAttributes에 담아서 리다이렉트
	        redirectAttributes.addFlashAttribute("errorMsg", "카카오 API 연동 중 오류가 발생했습니다.");
	        return "login";
	    }
	}
	
	
	@GetMapping("main.do")
	public String main() {
		System.out.println("UserController main() " + new Date());
		return "main";
	}
	
	// 비밀번호 해시화 (SHA-256 사용)
	   public static String sha256(String pw) {
	      try {
	         MessageDigest md = MessageDigest.getInstance("SHA-256");
	         byte[] hash = md.digest(pw.getBytes("UTF-8"));
	         StringBuffer hexString = new StringBuffer();

	         for (int i = 0; i < hash.length; i++) {
	            String hex = Integer.toHexString(0xff & hash[i]);
	            if (hex.length() == 1) {
	               hexString.append('0');
	            }
	            hexString.append(hex);
	         }
	         return hexString.toString();
	      } catch (Exception e) {
	         return "";
	      }
	   
}
	   
	   
	   @GetMapping("mypageEdit.do")
		public String mypageEdit(HttpServletRequest request, Model model) {
			
			System.out.println("UserController mypageEdit() " + new Date());
			
			UserDto login = (UserDto)request.getSession().getAttribute("login");
			UserDto userDto = service.userGet(login.getUser_id());
			
			model.addAttribute("content", "user/mypage");
			model.addAttribute("mypageContent", "mypageEdit");
			model.addAttribute("userDto", userDto);
			
			return "main";
		}
		
		@PostMapping("mypageEditAf.do")
		public String mypageEditAf(UserDto dto, Model model) {
			
			System.out.println("UserController mypageEditAf() " + new Date());
			System.out.println(dto.toString());
			
			boolean isS = service.mypageEdit(dto);
			String mypageEditAf_message = "true";
			
			if(isS == false) {
				mypageEditAf_message = "false";
			}
			
			model.addAttribute("mypageEditAf_message", mypageEditAf_message);
			return "message";
		}
}
