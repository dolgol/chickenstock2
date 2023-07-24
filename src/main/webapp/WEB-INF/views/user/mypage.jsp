<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	String mypageContent = (String)request.getAttribute("mypageContent");

	if(mypageContent == null) {
		mypageContent = "mypageLike";
	}
	
	System.out.println("mypageContent >> " + mypageContent);
	
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>

	.mypage-container {
		background-color: #f9f9f9;
		width: 80%;
		margin: auto;
		padding: 40px;
	}

	.mypage-content-container {
		display: flex;
	}
	
	.mypage-left {
	}
	
	.mypage-right {
	}
	
	.mypage-right .mypage-right-name {
		display: flex;
		align-items: center;
	}

</style>

</head>
<body>
	
	<div class="mypage-container">
	
		<h1>마이페이지</h1>
	
		<div class="mypage-content-container">
		
			<div class="mypage-left">
				<ul class="nav flex-column">
					<li>
						<a href="mypageLike.do" class="nav-link">관심 종목</a>
					</li>
					<li>
						<a href="mypageComment.do" class="nav-link">내가 쓴 댓글</a>
					</li>
					<li>
						<a href="mypageEdit.do" class="nav-link">내 정보 수정</a>
					</li>
				</ul>
			</div>

			<jsp:include page='<%=mypageContent + ".jsp"%>' flush="false" />
			
		</div>
		
		<div>
			<a href="#">회원 탈퇴</a>
		</div>
	</div>

</body>
</html>