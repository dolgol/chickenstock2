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

	nav {
		border-bottom: solid 1px #EAE8E6;
	}
	
	.navbar-brand {
		margin-left: 80px;
		margin-right: 40px;
	}
	
	.navbar-right {
		margin-right: 80px;
	}
	
	.nav-item {
		padding: 0 24px;
	}
	
	.nav-link {
		color: #4E4E4E !important;
		transition: 0.2s;
	}
	
	.nav-link:hover {
		color: #ff9406 !important;
	}
	
	.menu-icon {
	  display: inline-block;
	}

	.menu-icon span {
	  display: inline-block;
	  vertical-align: middle;
	  transition: 0.2s;
	}
	
	.menu-icon:hover span {
	  color: #ff9406;
	}
	
	.menu-logout {
		margin-left: 20px;
	}

</style>

</head>
<body>
	
	<nav class="navbar navbar-expand-md navbar-light">
		<a class="navbar-brand" href="home.do">
			<img alt="CHICKEN STOCK 사이트 로고" src="./images/logo4.png" width="120px"/>
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample04" aria-controls="navbarsExample04" aria-expanded="false" aria-label="Toggle navigation">
		  <span class="navbar-toggler-icon"></span>
		</button>
		
		<div class="collapse navbar-collapse" id="navbarsExample04">
			<div class="navbar-nav mr-auto d-flex justify-content-around">
				<div class="nav-item">
					<a class="nav-link" href="#">
						사이트소개
					</a>
				</div>
				<div class="nav-item">
					<a class="nav-link" href="newslist.do">
						뉴스게시판
					</a>
				</div>
				<div class="nav-item">
					<a class="nav-link" href="stockMain.do">
						종목게시판
					</a>
				</div>
			</div>
			
			<div class="form-inline my-2 my-md-0 navbar-right">
	        	<%
					if(login == null) {
						%>
						<div class="menu-icon">
							<a href="login.do">
								<span class="material-symbols-outlined">login</span>
								<span>&nbsp;&nbsp;로그인</span>
							</a>
						</div>
						<%
					}
					else {
						if(login.getAuth() == 0) {
							%>
							<div>
								<div class="menu-icon">
									<a href="adminuser.do">
										<span class="material-symbols-rounded">face</span>
										<span>&nbsp;&nbsp;회원목록</span>
									</a>
								</div>
								<div class="menu-icon menu-logout">
									<a href="logout.do">
										<span class="material-symbols-rounded">logout</span>
										<span>&nbsp;&nbsp;로그아웃</span>
									</a>
								</div>
							</div>
							<%
						}
						else {
							%>
							<div>
								<div class="menu-icon">
									<a href="mypageLike.do">
										<span class="material-symbols-rounded">face</span>
										<span>&nbsp;&nbsp;마이페이지</span>
									</a>
								</div>
								<div class="menu-icon menu-logout">
									<a href="logout.do">
										<span class="material-symbols-rounded">logout</span>
										<span>&nbsp;&nbsp;로그아웃</span>
									</a>
								</div>
							</div>
							<%
						}
					}
				%>
	        </div>
		</div>
	</nav>
	
</body>
</html>