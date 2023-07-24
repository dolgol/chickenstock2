
<%@page import="ssg.com.a.dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

BbsDto dto = (BbsDto)request.getAttribute("seq");


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<style type="text/css">
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
<body>

<div class="ml-5 mr-5">
<div class="ml-5 mr-5">
<div class="ml-5 mr-5">

<h1 align="center">게시글</h1>
<div class="container" style="margin-bottom: 17px;text-align: right;">
<div  class="btn-group">

</div>
</div>

<div align="center">

<form action="updateAf.do" method="post">
<input type="hidden" name="seq" value="<%=dto.getSeq() %>">

<table class="table table-bordered" >
<col width="200"><col width="500">
<tr>
	<th>작성자</th>
	<td>
		<%=dto.getId() %>
	</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" size="60" name="title"  value="<%= dto.getTitle() %>">
	</td>
</tr>

<tr>
	<th>내용</th>
	<td style="background-color: #ffffff;">
		<textarea rows="10" cols="60" name="content" style="border: none;"><%= dto.getContent()%></textarea>
	</td>
</tr>

</table>
<button type="submit" class="btn btn-success" >수정완료</button>
</form>
</div>

</div>
</div>
</div>


</body>
</html>