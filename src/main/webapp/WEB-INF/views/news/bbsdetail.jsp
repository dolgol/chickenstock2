<%@page import="ssg.com.a.dto.NewsDto"%>
<%@page import="ssg.com.a.dto.UserDto"%>
<%@page import="ssg.com.a.dto.BbsDto"%>
<%@page import="ssg.com.a.dto.MemberDto"%>
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

<%	
	NewsDto dto = (NewsDto)request.getAttribute("newsdto");
%>    
    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
th{
	background-color: #fff;
	color: black;
}
td{
	text-align: left;	
}
</style>

</head>
<body>
<br><br>
<div class="center">

<% if(login != null){ %>

<table class="table">
<col width="150px"><col width="500px">

<tr>
	<th>작성자</th>
	<td><%=login.getUser_name()%></td><!-- dto.getWrite_id() --> 
</tr>
<tr>
	<th>작성일</th>
	<td><%=dto.getPublication_date() %></td>	
</tr>
<tr>
	<th>조회수</th>
	<td><%=dto.getViews() %></td>	
</tr>
<tr>	
	<td colspan="2" style="font-size: 22px;font-weight: bold;line-height: 28px;"><%=dto.getTitle() %></td>
</tr>
<tr>	
	<td colspan="2" style="background-color: white;">
		<textarea rows="3" cols="30" id="content" class="form-control" readonly style="border: none; font-size: 20px;font-family: 고딕, arial;background-color: white"><%=dto.getContent() %></textarea>
	</td>
</tr>
</table>

<% } %>

<div align="right">
<%
if(login != null && login.getAuth() == 0){
	%>
	<button type="button" class="btn btn-primary" onclick="updateBbs(<%=dto.getSeq() %>)">글수정</button>
	
	<button type="button" class="btn btn-primary" onclick="deleteBbs(<%=dto.getSeq() %>)">글삭제</button>
	<%	
}
%>

</div>
</div>
<br><br>

<script type="text/javascript">
$(document).ready(function(){		
	
	// textarea를 글자수와 개행수에 따라서 크기를 설정한다
	const contentRowCount = $("#content").val().split(/\r\n|\r|\n/).length;
	let fontcount = $("#content").val().length / 60
	$("#content").attr("rows", fontcount + contentRowCount + 2);
})

function answerBbs( seq ) {
	location.href = "bbsanswer.do?seq=" + seq;	
}
function updateBbs( seq ) {
	location.href = "bbsupdate.do?seq=" + seq;
}
function deleteBbs( seq ) {
	location.href = "bbsdelete.do?seq=" + seq;
}

</script>

<br><br>
<!-- 댓글 -->
<div id="app" class="container">
<form action="commentWriteAf.do" method="post">
<input type="hidden" name="seq" value="<%=dto.getSeq() %>">
<input type="hidden" name="id" value="<%=login.getUser_id() %>">

<table>
<col width="1500px"><col width="150px">
<tr>
	<td>comment</td>
	<td style="padding-left: 30px">올리기</td>
</tr>
<tr>
	<td>
		<textarea rows="3" class="form-control" name="content"></textarea>
	</td>
	<td style="padding-left: 30px ">
		<button type="submit" class="btn btn-primary btn-block p-4">완료</button>
	</td>
</tr>
</table>

</form>
<br><br>

<table class="table table-sm">
<col width="500"><col width="500">

<tbody id="tbody">
</tbody>

</table>

<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		url:"commentList.do",
		type:"get",
		data:{seq:<%=dto.getSeq() %>},
		success: function(list){
			/*
			alert('success');
			alert(JSON.stringify(list));
			*/
			/*
			for(i = 0; i < list.length; i++){
				list[i].seq
				list[i].content
			}
			*/
			
			// tbody 태그안의 값을 모두 초기화 후 다시 게시
			$("#tbody").html("");
			
			$.each(list, function(i, item){
				let str = "<tr class='table-info'>"
						+		"<td>작성자:" + item.id + "</td>"
						+		"<td>작성일:" + item.wdate + "</td>"
						+	"</tr>"
						+	"<tr>"
						+		"<td colspan='2'>" + item.content + "</td>"
						+	"</tr>";
				$("#tbody").append(str);
			});
		},
		error:function(){
			alert('error');
		}
		
	});
	
})

</body>
</html>







