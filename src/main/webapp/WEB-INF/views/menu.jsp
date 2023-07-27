<%@page import="ssg.com.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	UserDto login = (UserDto)session.getAttribute("login");
%> 
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHICKEN STOCK</title>

<style>

	.navbar {
		background-color: #fff;
	}
	
	.navbar-brand {
		margin-right: 40px;
	}
	
	.nav-item {
		margin-right: 12px;
	}

</style>

</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-light">
		<div class="container">
			<a class="navbar-brand" href="home.do">
				<img alt="CHICKEN STOCK 사이트 로고" src="./images/logo.png" width="120px"/>
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample07">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarsExample07">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active">
						<a class="nav-link" href="#">
							사이트소개
						</a>
					</li>
					<li class="nav-item active">
						<a class="nav-link" href="newslist.do">
							뉴스게시판
						</a>
					</li>
					<li class="nav-item active">
						<a class="nav-link" href="stockMain.do">
							종목게시판
						</a>
					</li>
				</ul>
				<div class="my-2 my-lg-0">
					<%
						if(login == null) {
							%>
							<a class="btn btn-primary my-2 my-sm-0" href="login.do">
								<span class="material-symbols-outlined">login</span>
								로그인
							</a>
							<%
						}
						else {
							%>
							<a class="btn btn-primary my-2 my-sm-0" href="mypageLike.do">
								<span class="material-symbols-outlined">face</span>
								마이페이지
							</a>
							<a class="btn btn-outline-primary my-2 my-sm-0" href="logout.do">
								<span class="material-symbols-outlined">logout</span>
								로그아웃
							</a>
							<%
						}
					%>
			    </div>
			</div>
		</div>
	</nav>
	
</body>
</html>