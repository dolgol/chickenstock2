<%@page import="ssg.com.a.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	MemberDto login = (MemberDto)session.getAttribute("login");
%>

<html>
<head>
<style type="text/css">
.header {
	background: #224941 url('./images/header.jpg') no-repeat center center/cover;
	margin: 0;
	color: white;
	height: 160px;
}
.headerLogin{	
	text-align:right;
	height: 60px;	
	font-size: 24px;		
}
.headerLogin a:hover {
	color: white;
	text-decoration: none;
}
</style>
</head>

<body>
<div class="header">
	<div style="height: 220px;" class="center">
	<h1>header</h1><br><br><br><br><br><br>
		<% 	if(login == null){ %>	<!-- 로그인이 안된 경우 -->
			<div class="headerLogin">
				<a href="./login.do">login</a>		
			</div>
		<% }else{ %>	<!-- 로그인이 된 경우 -->
			<div class="headerLogin">
			 	<a href="./logout.do">logout</a>		
			</div>
		<%	} %>
	</div>
</div>
</body>
</html>