<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
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
		alert("홈페이지 방문을 환영합니다");
		location.href = "home.do";
		</script>
		<%
	}
}

String newswrite = (String)request.getAttribute("newswrite");
if(newswrite != null && !newswrite.equals("")){
	if(newswrite.equals("NEWS_ADD_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 작성되었습니다");
		location.href = "newslist.do";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("다시 작성해 주십시오");
		location.href = "newswrite.do";
		</script>
		<%
	}
}

String newsupdate = (String)request.getAttribute("newsupdate");
if(newsupdate != null && newsupdate.equals("") == false){
	if(newsupdate.equals("NEWSUPDATE_YES")){
		int seq = Integer.parseInt(request.getParameter("seq"));
		%>
		<script>
		alert("수정되었습니다.");
		location.href = "newsdetail.do?seq=" + <%= seq %>;
		</script>
		<%
	}else if(newsupdate.equals("NEWSUPDATE_NO")){
		int seq = Integer.parseInt(request.getParameter("seq"));
		%>
		<script>
		alert("수정 실패했습니다.");
		location.href = "newsdetail.do?seq=" +<%= seq %>";
		</script>
		<%
	}
}
String newsdelete = (String)request.getAttribute("newsdelete");
if(newsdelete != null && newsdelete.equals("") == false){
	if(newsdelete.equals("NEWSDELETE_YES")){

		%>
		<script>
	    alert('글 삭제 성공!');
	    location.href = "newslist.do";
		</script>
		<%
	}else if(newsdelete.equals("NEWSDELETE_NO")){
		int seq = Integer.parseInt(request.getParameter("seq"));
		%>
		<script>
	    alert('글 삭제 실패~');
	    location.href = "newsdetail.do?seq=" + <%=seq %>;
		</script>
		<%		
	}
}

%>









