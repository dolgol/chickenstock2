<%@page import="ssg.com.a.dto.BbsDto"%>
<%@page import="ssg.com.a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	MemberDto login = (MemberDto)session.getAttribute("login");
	if(login == null || login.getId().equals("")){
		%>  
		<script>
		alert("로그인 해 주십시오");
		location.href = "login.do";
		</script>
		<%
	}
%>

<%	
	BbsDto dto = (BbsDto)request.getAttribute("bbsdto");
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
	<td><%=dto.getId() %></td>
</tr>
<tr>
	<th>작성일</th>
	<td><%=dto.getWdate() %></td>	
</tr>
<tr>
	<th>조회수</th>
	<td><%=dto.getReadcount() %></td>	
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

<button type="button" class="btn btn-primary" onclick="answerBbs(<%=dto.getSeq() %>)">답글</button>

<%
if(login != null && login.getId().equals(dto.getId())){
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
	location.href = "bbsupdate.do?&seq=" + seq;
}
function deleteBbs( seq ) {
	location.href = "bbsdelete.do?seq=" + seq;
}
</script>


</body>
</html>







