<%@page import="ssg.com.a.dto.MemberDto"%>
<%@page import="ssg.com.a.dto.BbsDto"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <%
  
  
  MemberDto mem = (MemberDto)session.getAttribute("login");
	BbsDto dto = (BbsDto)request.getAttribute("bbsdto");
  
	
  
  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 글보기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<style>
h1{
	margin-top: 25px;
	margin-bottom: 20px;
}
th{
	text-align: center;
	background-color: #f1dcff;
}
td{
	background-color: #f0f8ff;
}

textarea{
	resize: none;
	box-sizing: border-box;
	border: 1px solid rgb(42, 42, 42);
	width: 100%;
}
</style>
</head>
<body class="ml-5 mr-5">
<div class="ml-5 mr-5">
<div class="ml-5 mr-5">
<div class="ml-5 mr-5">

<h1 align="center">게시글</h1>
<div class="container" style="margin-bottom: 17px;text-align: right;">
<div  class="btn-group">
<%
	if(mem.getId().equals(dto.getId())){
		
	
	%>
	<button type="button" onclick="deleteBbs(<%=dto.getSeq() %>)" class="btn btn-success">글삭제</button>
	<button type="button" onclick="updateBbs(<%=dto.getSeq() %>)" class="btn btn-success">글수정</button>
	<% 
	}
	
	%>
</div>
</div>

<div align="center">

<form action="">
<table class="table table-bordered" >
<col width="200"><col width="500">
<tr>
	<th>작성자</th>
	<td>
		<%= dto.getId() %>
	</td>
</tr>

<tr>
	<th>작성일</th>
	<td>
		<%= dto.getWdate() %>
	</td>
</tr>

<tr>
	<th>조회수</th>
	<td>
		<%= dto.getReadcount() %>
	</td>
</tr>

<tr>
	<th>제목</th>
	<td>
		<%= dto.getTitle() %>
	</td>
</tr>

<tr>
	<th>내용</th>
	<td style="background-color: #ffffff;">
		<textarea class="form-control -sm" style="border: none;"><%= dto.getContent()%></textarea>
	</td>
</tr>

</table>
<br>
<div style="margin-top: 15px;">
<button type="button" id ="back" class="btn btn-success" >글목록</button>
<button type="button" onclick="answerBbs(<%=dto.getSeq() %>)" class="btn btn-success" >답글</button>
</div>
</form>
</div>
</div>
</div>
</div>
<script type="text/javascript">
function answerBbs(seq){
	location.href = "answer.do?seq=" + seq;
}

function updateBbs(seq){
	location.href = "bbsUpdate.do?seq=" + seq;
}

function deleteBbs(seq){
	location.href = "bbsDelete.do?seq=" + seq;
}


// 뒤로돌아가는 함수

$(document).ready(function(){
	
	$("#back").click(function() {
		history.back();
	});
});


</script>

<br><br>
<%-- 댓글 --%>
<div id="app" class="container">

<form action="commentWriteAf.do" method="post">
<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
<input type="hidden" name="id" value="<%=mem.getId()%>">

<table>
<col width="1500px"><col width="150px">
<tr>
	<td>comment</td>
	<td style="padding-left": 30px">올리기</td>
</tr>
<tr>
	<td>
		<textarea rows="3" cols="form-control" name="content"></textarea>
	</td>
	<td style="padding-left">
		<button type="submit" class="btn btn-primary btn-block p-4">완료</button>
	</td>
</tr>
</table>

</form>

<br><br>

<table class="table tamle-sm">
<col width="500px"><col width="500px">
<tbody id="tbody">
</tbody>

</table>

<script type="text/javascript">
$(document).ready(function(){
	
	$.ajax({
		url:"commentList.do",
		type:"get",
		data:{ seq:<%=dto.getSeq()%>},
		success:function( list ){
			/* alert('success'); */
			/* alert(JSON.stringify(list));
			alert(list[0].content);
			
			for(i = 0; i < list.length; i++){
				list[i].seq
				list[i].content
			} */
			
			$("#tbody").html("");
			
			$.each(list, function(i, item){
				let str = "<tr class='table-info'>"
					+	"<td>작성자:" + item.id + "</td>"
					+	"<td>작성일:" + item.wdate + "</td>"
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

</script>


</div>

</body>
</html>