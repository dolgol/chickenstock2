
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%


String message = (String)request.getAttribute("message");
if(message != null && message.equals("") == false){
	if(message.equals("MEMBER_YES")){
		%>
		<script>
		alert("성공적으로 가입되었습니다.");
		location.href = "login.do";
		</script>
		<%
	}else{
		%>
		<script>
		alert("가입되지 않았습니다. 다시 가입해 주세요.");
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
		alert("로그인성공!");
		location.href = "bbslist.do";
		</script>
		<%
	}
}


String bbswrite = (String)request.getAttribute("bbswrite");
if(bbswrite != null && bbswrite.equals("") == false){
	if(bbswrite.equals("WRITE_YES")){
		%>
		<script>
		alert("게시글이 작성되었습니다");
		location.href = "bbslist.do";
		</script>
		<%
	}else{
		%>
		<script>
		alert("다시 작성해 주십시오");
		location.href = "bbswrite.do";
		</script>		
		<%
	}
}

String update = (String)request.getAttribute("update");
if(update != null && update.equals("") == false){
	if(update.equals("UPDATE_YES")){
		%>
		<script>
		alert("게시글이 수정되었습니다");
		location.href = "bbslist.do";
		</script>
		<%
	}else{
		%>
		<script>
		alert("다시 작성해 주십시오");
		location.href = "bbslist.do";
		</script>		
		<%
	}
}

String delete = (String)request.getAttribute("delete");
if(delete != null && delete.equals("") == false){
	if(delete.equals("DELETE_YES")){
		%>
		<script>
		alert("게시글이 삭제되었습니다");
		location.href = "bbslist.do"
		</script>
		<%
	}else{
		%>
		<script>
		alert("삭제에 실패하였습니다");
		location.href = "bbslist.do"
		</script>
		<%
	}
}

String answer = (String)request.getAttribute("answer");
if(answer != null && answer.equals("") == false){
	if(answer.equals("ANSWER_YES")){
		%>
		<script>
		alert("답글이 작성되었습니다");
		location.href = "bbslist.do"
		</script>
		<%
	}else{
		%>
		<script>
		alert("답글이 실패하였습니다");
		location.href = "bbslist.do"
		</script>
		<%
	}
}

String calwrite = (String)request.getAttribute("calwrite");
if(calwrite != null && calwrite.equals("") == false){
	if(calwrite.equals("CALWRITE_YES")){
		%>
		<script>
		alert("일정이 작성되었습니다");
		location.href = "./calendar?param=calendarList"
		</script>
		<%
	}else{
		%>
		<script>
		alert("일정 작성이 실패하였습니다");
		location.href = "./bbs?param=calendarList"
		</script>
		<%
	}
}

String calupAf = (String)request.getAttribute("calupAf");
if(calupAf != null && calupAf.equals("") == false){
	if(calupAf.equals("CALUPAF_YES")){
		%>
		<script>
		alert("일정이 수정되었습니다");
		location.href = "./calendar?param=calendarList"
		</script>
		<%
	}else{
		%>
		<script>
		alert("일정 수정이 실패하였습니다");
		location.href = "./bbs?param=calendarList"
		</script>
		<%
	}
}
%>