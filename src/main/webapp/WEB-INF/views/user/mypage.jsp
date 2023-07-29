<%@page import="ssg.com.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	UserDto user = (UserDto)session.getAttribute("login");

	if(user == null) {
		response.sendRedirect("login.do");
	}

	String mypageContent = (String)request.getAttribute("mypageContent");

	if(mypageContent == null) {
		mypageContent = "mypageLike";
	}
	
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHICKEN STOCK</title>

<style>

	a {
		color: #4E4E4E;
		transition: 0.2s;
	}
	
	a:hover {
		color: #ff9406;
	}

	.mypage-container {
		margin: auto;
		padding: 60px;
	}
	
	.mypage-container-top {
		font-size: 32px;
		font-weight: 500;
		color: #ff9406;
		margin-bottom: 20px;
		letter-spacing: -2px !important;
	}

	.mypage-content-container {
		display: flex;
	}
	
	.mypage-left {
		width: 20%;
		padding: 16px 0;
	}
	
	.mypage-left-menu {
		list-style: none;
		padding-left: 0;
	}
	
	.mypage-left-menu li {
		margin-bottom: 20px;
	}
	
	.mypage-right {
		width: 80%;
		padding: 16px;
	}
	
	.mypage-right .mypage-right-name {
		display: flex;
		align-items: center;
		margin-bottom: 20px;
		font-size: 20px;
		font-weight: 500;
	}
	
	.mypage-menu-active {
		color: #ff9406;
	}

</style>

</head>
<body>
	
	<div class="mypage-container w-75">
	
		<div class="mypage-container-top">마이페이지</div>
	
		<div class="mypage-content-container">
		
			<div class="mypage-left">
				<ul class="mypage-left-menu">
					<li>
						<a href="mypageLike.do" class="">관심 종목</a>
					</li>
					<li>
						<a href="mypageComment.do" class="">내가 쓴 댓글</a>
					</li>
					<li>
						<a href="mypageEdit.do" class="">내 정보 수정</a>
					</li>
				</ul>
			</div>
			
			<div class="mypage-right">
				<div class="mypage-right-name">
					<span class="material-symbols-outlined">face</span>
					<%-- &nbsp;&nbsp;<%=user.getNick_name() %> 님 --%>
					&nbsp;&nbsp;<%=user.getUser_id() %> 님
				</div>
				<hr/><br/>
				
				<jsp:include page='<%=mypageContent + ".jsp"%>' flush="false" />
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	$(document).ready(function() {
		
		switch("<%=mypageContent %>") {
			case "mypageLikeScroll":
				$(".mypage-left-menu").children().eq(0).children().addClass("mypage-menu-active");
				break;
			case "mypageComment":
				$(".mypage-left-menu").children().eq(1).children().addClass("mypage-menu-active");
				console.log("mypageComment");
				break;
			case "mypageCommentStocks":
				$(".mypage-left-menu").children().eq(1).children().addClass("mypage-menu-active");
				console.log("mypageCommentStocks");
				break;
			case "mypageEdit":
				$(".mypage-left-menu").children().eq(2).children().addClass("mypage-menu-active");
				console.log("mypageEdit");
				break;
		}
		
	});
	
	</script>

</body>
</html>