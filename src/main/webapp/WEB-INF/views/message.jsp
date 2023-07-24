<%@page import="ssg.com.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String message = (String)request.getAttribute("message");
if(message != null && message.equals("") == false){
	if(message.equals("USER_YES")){
		%>
		<script>
		alert("환영합니다. 가입을 축하드립니다 !");
		location.href = "login.do";
		</script>
		<%	
	}else{
		%>
		<script>
		alert("가입되지 않았습니다. 다시 가입해 주세요");
		location.href = "regi.do";
		</script>
		<%
	}	
}
String login = (String)request.getAttribute("loginmsg");
if(login != null && login.equals("") == false){
	if(login.equals("LOGIN_NO")){		
		%>
		<script>
		alert("아이디나 비밀번호를 확인해 주십시오");
		location.href = "login.do";
		</script>
		<%	
	}else{
		%>
		<script>
		alert("로그인 되었습니다");
		location.href = "main.do";
		</script>
		<%
	}
}
%>