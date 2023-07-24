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
    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.bbswcenter{
	margin: auto;
	width: 800px;
	text-align: center;		
}
</style>
</head>
<body>

<br><br><br>

<div class="bbswcenter">

<form id="frm" method="post">

<% if(login != null){ %>
<input type="hidden" name="id" value="<%=login.getId() %>">
<% } %>

<table class="table table-borderless">
<col width="800px">
<tr>
	<td>
		<div align="left">제목:</div><br>		
		<input type="text" id="title" name="title" class="form-control"placeholder="제목을 기입">
	</td>
</tr>

<tr>	
	<td>
		<div align="left">내용:</div><br>	
		<textarea rows="17" cols="50" class="form-control" id="content" name="content" placeholder="내용을 기입"></textarea>
	</td>
</tr>

</table>
<br>
<button type="button" class="btn btn-primary">작성완료</button>

</form>
</div>
<br><br>
<br>

<script type="text/javascript">
$(document).ready(function(){
	
	$("button").click(function(){
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
		
		$("#frm").attr("action", "bbswriteAf.do").submit();		
	});
	
});
</script>


</body>
</html>







