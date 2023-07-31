<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String login = (String)request.getAttribute("loginmsg");
if(login != null && !login.equals("")){
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
		console.log("글쓰기 성공");
		location.href = "newslist.do";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("다시 작성해주세요");
		location.href = "newswrite.do";
		</script>
		<%
	}
}

String newsupdate = (String)request.getAttribute("newsupdate");
if(newsupdate != null && !newsupdate.equals("")){
	if(newsupdate.equals("NEWSUPDATE_YES")){
		int seq = Integer.parseInt(request.getParameter("seq"));
		int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		%>
		<script>
		console.log("수정 완료");
		location.href = "newsdetail.do?seq=" + <%=seq %> +"&pageNumber=" + <%=pageNumber%>;
		</script>
		<%
	}else if(newsupdate.equals("NEWSUPDATE_NO")){
		int seq = Integer.parseInt(request.getParameter("seq"));
		int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		%>
		<script>
		console.log("수정 실패");
		
		location.href = "newsdetail.do?seq=" + <%=seq %> +"&pageNumber=" + <%=pageNumber%>;
		</script>
		<%
	}
}
String newsdelete = (String)request.getAttribute("newsdelete");
if(newsdelete != null && !newsdelete.equals("")){
	if(newsdelete.equals("NEWSDELETE_YES")){

		%>
		<script>
		console.log("글 삭제");
	    location.href = "newslist.do";
		</script>
		<%
	}else if(newsdelete.equals("NEWSDELETE_NO")){
		int seq = Integer.parseInt(request.getParameter("seq"));
		int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		%>
		<script>
		console.log("글 삭제 실패");
	    location.href = "newsdetail.do?seq=" + <%=seq %> +"&pageNumber=" + <%=pageNumber%>;
		</script>
		<%		
	}
}
String commentwrite = (String)request.getAttribute("commentwrite");
if(commentwrite != null && !commentwrite.equals("")){
	int seq = Integer.parseInt(request.getParameter("seq"));
	int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	if(commentwrite.equals("COMMENT_ADD_OK")){
		%>
		<script type="text/javascript">
		console.log("댓글 작성 완료");
		location.href = "newsdetail.do?seq=" + <%=seq %> +"&pageNumber=" + <%=pageNumber%>;
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		console.log("댓글 작성 실패");
		location.href = "newsdetail.do?seq=" + <%=seq %> +"&pageNumber=" + <%=pageNumber%>;
		</script>
		<%
	}
}

String commentDelete = (String)request.getAttribute("commentDelete");
if(commentDelete != null && !commentDelete.equals("")){
	int post_num = Integer.parseInt(request.getParameter("post_num"));
	int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	System.out.println("message=" + pageNumber);
	if(commentDelete.equals("COMMENTDELETE_YES")){
		%>
		<script type="text/javascript">
		console.log("댓글 삭제 완료");
		location.href = "newsdetail.do?seq=" + <%=post_num %> + "&pageNumber=" + <%=pageNumber%>;
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		console.log("댓글 삭제 실패");
		location.href = "newsdetail.do?seq=" + <%=post_num %> + "&pageNumber=" + <%=pageNumber%>;
		</script>
		<%
	}
}

String commentAnswer = (String)request.getAttribute("commentAnswer");
if(commentAnswer != null && !commentAnswer.equals("")){
	int post_num = Integer.parseInt(request.getParameter("post_num"));
	int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	if(commentAnswer.equals("COMMENTANSWER_YES")){
		%>
		<script type="text/javascript">
		console.log("답글 작성 완료");
		location.href = "newsdetail.do?seq=" + <%=post_num %> + "&pageNumber=" + <%=pageNumber%>;
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		console.log("답글 작성 실패");
		location.href = "newsdetail.do?seq=" + <%=post_num %> + "&pageNumber=" + <%=pageNumber%>;
		</script>
		<%
	}
}

%>

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
%>

<%
String mypageEditAf_message = (String)request.getAttribute("mypageEditAf_message");
if(mypageEditAf_message != null && mypageEditAf_message.equals("") == false){
	if(mypageEditAf_message.equals("false")){
		%>
			<script>
			    alert("내 정보 수정에 실패했습니다");
			    location.href = "mypageEdit.do";
			</script>
		<%	
	} 
	else if(mypageEditAf_message.equals("true")){
		%>
			<script>
			    alert("내 정보 수정에 성공했습니다");
			    location.href = "mypageEdit.do";
			</script>
		<%	
	} 
}

%>







