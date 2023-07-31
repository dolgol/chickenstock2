<%@page import="ssg.com.a.dto.UserDto"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	UserDto login = (UserDto)session.getAttribute("login");
	if(login == null || login.getUser_id().equals("")){
		%>  
		<script>
		alert("로그인 해 주십시오");
		location.href = "login.do";
		</script>
		<%
	}
%>
    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.bbswcenter{
	margin: auto;
	width: 800px;
	text-align: center;		
}
.table-info{
	background-color: #FFFFFF;
}

.table-info > td{
	background-color: #FFFFFF;
}

textarea {
    resize: none; 
}
	.table {
	   border-color: #EAE8E6;
	}
	.table > thead > tr > th {
	    border-color: #EAE8E6;
	}
	.table > tbody > tr > td {
	    border-color: #EAE8E6;
	}
	.table-hover tbody tr{
	transition: 0.2s;
	}
	.table-hover tbody tr:hover {
	background-color: #EAE8E6;
	
	}
	.tr-hover tr{
	transition: 0.2s;
	}
	.tr-hover tr:hover {
	background-color: #EAE8E6;
	
	}
	.page-item.disabled .page-link {
		border-color: #EAE8E6;
	}
	
	.page-item.active .page-link {
		background-color: #ff9406;
	    border-color: #ff9406;
	}
	
	.page-link  {
		color: #4E4E4E;
	}
	
	.page-link:hover  {
		color: #4E4E4E;
		background-color: #EAE8E6;
	}
	a{
	color: #4E4E4E;
	}
	a:hover{
	color: #ff9406;
	text-decoration: none;
	}
	
	.mypage-container-top {
		font-size: 32px;
		font-weight: 500;
		color: #ff9406;
		margin-bottom: 20px;
		letter-spacing: -2px !important;
	}
	.mypage-delete {
	border: solid 1px #EAE8E6;
	transition: 0.2s;
	height: auto; /* This allows the height of the button to adapt based on its content */
    white-space: nowrap;
	}
	.mypage-delete:hover {
		color: #fff;
		border-color: #ff9406;
		background-color: #ff9406;
	}
</style>
</head>
<body>

<br><br><br>
<main class="container my-4 w-75 m-auto">
    
<div class="bbswcenter">
<div class="mypage-container-top" style="text-align: left">뉴스 게시판</div>
<form id="frm" method="post">

<% if(login != null){ %>
<input type="hidden" name="write_id" value="<%=login.getUser_id() %>">
<% } %>

<table class="table table-hover text-center">
<col width="100"><col width="500">
<tr>
   	<th>아이디</th>
   		<td style="text-align: left"><%=login.getUser_id() %></td><!-- 원본 기사 작성자로 수정해야함 -->
    </tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" id="title" name="title" class="form-control"placeholder="제목을 기입">
	</td>
</tr>

<tr>	
	<th>내용</th>
	<td style="padding-bottom: 0px">
		<textarea rows="17" cols="50" class="form-control" id="content" name="content" placeholder="내용을 기입"></textarea>
	</td>
</tr>

</table>
<div style="text-align: left; padding-left: 12px">
<button type="button" id="btn" class="btn mypage-delete" >작성완료</button>
<button type="button" class="btn mypage-delete" onclick="cancel()">취소</button>
</div>
</form>
</div>
<br><br>
<br>

<script type="text/javascript">
function cancel( ) {
	location.href = "newslist.do";
}
$(document).ready(function(){
	
	$("#btn").click(function(){
		// 제목이 비었는지?
		if( $("#title").val().trim() == ""){
			alert("제목을 기입해 주십시오");
			return;
		}				
		// 내용이 비었는지?
		if( $("#content").val().trim() == "" ){
			alert("내용을 기입해 주십시오");
			return;
		}
		
		$("#frm").attr("action", "newswriteAf.do").submit();		
	});
	
});
</script>
</main>

</body>
</html>







