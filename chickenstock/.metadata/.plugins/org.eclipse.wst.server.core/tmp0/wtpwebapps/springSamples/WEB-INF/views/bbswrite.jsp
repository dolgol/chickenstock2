<%@page import="ssg.com.a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	MemberDto mem = (MemberDto)session.getAttribute("login");
	if(mem == null || mem.getId().equals("")){
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
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<style type="text/css">
textarea{
	resize:none;
	border:none;
	background-color: #f0f8ff;
}

th{
	text-align: center;
	background-color: #f1dcff;
}

td{
	background-color: #f0f8ff;
}

input {
	background-color: #f0f8ff;

}

</style>
</head>
<body class="ml-5 mr-5">
<div class="ml-5 mr-5">
<div class="ml-5 mr-5">
<div class="ml-5 mr-5">
<h1 align="center">글쓰기</h1>
<br>
<div align="center">
<form id="frm" method="post">
<table class="table table-bordered">
<col width="200"><col width="400">
<tr>
	<th>아이디</th>
	<td>
		<input type="text" name="id"  size="50" value="<%=mem.getId() %>" readonly="readonly" style="border:none;">
	</td>
</tr>

<tr>
	<th>제목</th>
	<td><input type="text" id="title" name="title" size="50" placeholder="제목을 작성해 주세요." style="border:none;"></td>
</tr>

<tr>
	<th>내용</th>
	<td><textarea id="content" name="content"  placeholder="내용을 작성해 주세요."></textarea></td>
</tr>
</table>
	<!-- <input type="submit" id="sub" value="작성완료"> -->
<div style="margin-top: 15px;">
	<button type="button" id="finish" class="btn btn-success">작성완료</button>
	<button type="button" id="cancel" class="btn btn-success">취소</button>
</div>
</form>
</div>
</div>
</div>
</div>

<script type="text/javascript">
$(document).ready(function(){
	
	$("#finish").click(function(){
		//제목이 비었는가 조사
		if($("#title").val().trim() == ""){
			alert("제목을 기입해 주십시오");
			return;
		}
		//내용이 비었는지?
		
		if($("#content").val().trim() == ""){
			alert("내용을 기입해 주십시오");
			return;
		}
		
		$("#frm").attr("action", "bbswriteAf.do").submit();
	
	});
	
	$("#cancel").click(function(){
		window.open("bbslist.do");
	});
});

function txtsize() {
	let textarea = document.getElementById("content");
	
	let scrollHeight = textarea.scrollHeight;
    let style = window.getComputedStyle(textarea);
    let borderTop = parseInt(style.borderTop);
    let borderBottom = parseInt(style.borderBottom);

    textarea.style.height = (scrollHeight + borderTop + borderBottom)+"px";
	
}

window.addEventListener("load", resize);
window.addEventListener("resize", resize);



</script>

</body>
</html>