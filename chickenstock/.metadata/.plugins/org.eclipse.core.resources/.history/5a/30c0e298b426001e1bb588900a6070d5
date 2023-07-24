<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("utf-8");

String content = (String)request.getAttribute("content");
if(content == null){
	content = "home";	
}
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<style type="text/css">
*{
	margin: 0;
	padding: 0;
}
.center{
	margin: auto;
	width: 1000px;
	text-align: center;
}
th{
	background: royalblue;
	color: white;
} 
tr {
   line-height: 12px;   
}
td {
	margin-top: 0px;
	padding-top: 0px;
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body>

<div align="center">
<table style="width:100%">
<tr>
	<td>
		<jsp:include page="header.jsp" flush="false" />
	</td>
</tr>
<tr>
	<td>
		<jsp:include page="menu.jsp" flush="false" />
	</td>
</tr>
<tr>
	<td>
		<jsp:include page='<%=content + ".jsp" %>' flush="false" />
	</td>
</tr>
<tr>
	<td>
		<jsp:include page="footer.jsp" flush="false" />
	</td>
</tr>
</table>
</div>

</body>
</html>






