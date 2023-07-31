<%@page import="ssg.com.a.dto.UserDto"%>
<%@page import="ssg.com.a.dto.NewsParam"%>
<%@page import="ssg.com.a.dto.NewsDto"%>
<%@page import="util.BbsUtil"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	List<NewsDto> list = (List)request.getAttribute("newslist");
	int pageBbs = (Integer)request.getAttribute("pagenews");
	
	NewsParam param = (NewsParam)request.getAttribute("param");
	int pageNumber = param.getPageNumber();
	String choice = param.getChoice();
	String search = param.getSearch();
	
	
%>    
    
<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">

    <!-- Pagination CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
<style type="text/css">
.rounded-card {
    border-radius: 15px;
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
}
.center{
	margin: auto;
	/* text-align: center; */
}
.center th{
	background: white;
	color: black;
}
.input-group-text {
    border: none;
    background: none;
}

.form-control {
    border: none;
    box-shadow: none;
}

.input-group {
    border: 0px solid #ced4da;
    border-radius: .25rem;
    box-shadow: none;
    width: 100%;
    padding-left: 0px;
    padding-right: 0px;
    margin-left: 0px;
    margin-right: 0px;
    text-align: center;
    align-content: center;
}


	.table {
	   border-color: #EAE8E6;
	}
	.table > thead > tr > th {
	    border-color: #EAE8E6;
	}
	.table > tbody > tr > td {
	    border-color: #EAE8E6;
	}
	.table-hover tbody tr{
	transition: 0.2s;
	}
	.table-hover tbody tr:hover {
	background-color: #EAE8E6;
	
	}
	.page-item.disabled .page-link {
		border-color: #EAE8E6;
	}
	
	.page-item.active .page-link {
		background-color: #ff9406;
	    border-color: #ff9406;
	}
	
	.page-link  {
		color: #4E4E4E;
	}
	
	.page-link:hover  {
		color: #4E4E4E;
		background-color: #EAE8E6;
	}
	a{
	color: #4E4E4E;
	}
	a:hover{
	color: #ff9406;
	text-decoration: none;
	}
	
	.mypage-container-top {
		font-size: 32px;
		font-weight: 500;
		color: #ff9406;
		margin-bottom: 20px;
		letter-spacing: -2px !important;
	}
	.mypage-delete {
	border: solid 1px #EAE8E6;
	transition: 0.2s;
	}
	
	.mypage-delete:hover {
		color: #fff;
		border-color: #ff9406;
		background-color: #ff9406;
	}


main > .navbar{
	border-radius: 30px;
	padding: 0em;
	width: 80%;
}

.stocknavbar{
	border-radius: 10px;
	
}

.my-navbar{
	background-color: #FF9406;
}

.news-nav-container {
border: none;
}

.news-search-left {
border: solid 1px #EAE8E6;
border-radius: 20px 0 0 20px;
}

.news-search-right {
border: solid 1px #EAE8E6;
border-radius: 20px;
}

.news-search-div {
border: solid 1px #EAE8E6;
border-radius: 0 20px 20px 0;
}

.btn.news-search-right {
background-color: #FF9406;
border: none;
}

.btn.news-search-right > i{
color: #fff;
}
</style>

<!-- <script type="text/javascript" src="jquery/jquery.twbsPagination.min.js"></script> -->
<script src="jquery/jquery.twbsPagination.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css">
</head>
<body>

<br><br><br>
<!-- 주황: FF8205 대표 색상: FF9406 글자색: 4E4E4E 마우스오버: EAE8E6 배경:FFFFFF-->
<main class="container my-4 w-75 m-auto">
<div class="mypage-container-top" style="margin-bottom: 20px">뉴스 게시판</div>
<!-- <div class="center"> -->
<!-- Search Bar -->
<nav class="navbar navbar-expand-md navbar-dark container news-nav-container">
<div class="input-group w-75 m-auto">
<select id="choice" class="form-control mx-auto news-search-left" style="flex:1;">
<option value="title">제목</option>
<option value="content">내용</option>
<option value="writer">작성자</option>
</select>
<input type="text" id="search" class="form-control news-search-right" value="<%=search %>" style="flex:4;" placeholder="검색어를 입력해주세요">
<div class="input-group-append news-search-div" style="background-color: #FFFFFF">
<button type="button" onclick="searchBtn()" class="btn btn-outline-secondary news-search-right">
<i class="fas fa-search" ></i>
</button>
</div>
</div>
</nav>


 <!-- News List -->
 <!-- 
<div style="margin-top: 20px;">
		<form>
			<div class="nav nav-tabs">
				<a href="newslist.do" class="nav-link active w-50 text-center">국내 뉴스</a>
				<a href="newsListOverseas.do" class="nav-link w-50 text-center">해외 뉴스</a>
			</div>
-->
<div class="card-body">
<table class="table table-hover text-center">

<thead>
<tr>
	<th>번호</th><th style="text-align: left">제목</th><th>조회수</th><th>작성자</th>
</tr>
</thead>

<tbody>
<%
if(list == null || list.size() == 0){
	%>
	<tr>
		<td colspan="4">작성된 글이 없습니다</td>
	</tr>
	<%
}else{
	NewsParam paramTemp = new NewsParam();
	for(int i = 0;i < list.size(); i++){
		NewsDto news = list.get(i);
		paramTemp.setSeq(news.getSeq());
		paramTemp.setPageNumber(pageNumber);
		%>
		<tr>
			<td><%=i + 1 %></td>
			
			<%
			if(news.getDel() == 0){
				%>				
				<td style="text-align: left;">
					<%-- <a href="newsdetail.do?seq=<%=paramTemp.getSeq() %>&pageNumber=<%=paramTemp.getPageNumber()%>"> --%>
					<a href="javascript:goToNewsDetail(<%=paramTemp.getSeq() %>, <%=paramTemp.getPageNumber()%>)">
						<%-- <%=BbsUtil.arrow(news.getDepth()) %> --%>
						<%=BbsUtil.titleDot(news.getTitle()) %>
					</a>
				</td>
				<% 
			}else{
			%>
				<td style="text-align: left;">
					<%-- <%=BbsUtil.arrow(news.getDepth()) %> --%>
					<font color="#ff0000" style="opacity: 0.5;"> ****** 이 글은 작성자에 의해서 삭제되었습니다</font>
				</td>			
			<%
			}
			%>
			
			<td><%=news.getViews() %></td>
			<td><%=news.getWrite_id() %></td>
		</tr>
		<% 
	}
}
%>
</tbody>
</table>
</div>

<!-- Pagination -->
<a href="newsnotice.do" class="btn mypage-delete">글쓰기</a>
<div class="container">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination" style="justify-content:center"></ul>
    </nav>
    

</div>

<br><br>

<!-- <a href="newsScrap.do">뉴스 스크랩</a> -->

</main>
<br><br>
<br>
<!-- Additional JS -->
<script type="text/javascript">	
function goToNewsDetail(seq, pageNumber) {
    <% UserDto login = (UserDto) session.getAttribute("login"); %>
    <% if(login == null) { %>
    	alert("로그인 해주세요");
        location.href = "login.do";
    <% } else { %>
        location.href = "newsdetail.do?seq=" + seq + "&pageNumber=" + pageNumber;
    <% } %>
}
// Java -> JavaScript
let search = "<%=search %>"; 	// 문자열일 경우
	
if(search != ""){
	let obj = document.getElementById("choice");
	obj.value = "<%=choice %>";
	obj.setAttribute("selected", "selected");
} 

function searchBtn() {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;

	location.href = "newslist.do?choice=" + choice + "&search=" + search;
}

$("#pagination").twbsPagination({
	startPage:<%=pageNumber+1 %>,
	totalPages:<%=pageBbs %>,
	visiblePages:10,
	first:'<span srid-hidden="true">«</span>',		// 처음 페이지로 이동
	prev:"이전",
	next:"다음",
	last:'<span srid-hidden="true">»</span>',
	initiateStartPageClick:false,					// 자동 실행이 되지 않도록 설정
	onPageClick:function(event, page){
		// alert(page);
		let choice = $("#choice").val();
		let search = $("#search").val();

		location.href = "newslist.do?choice=" + choice + "&search=" + search + "&pageNumber=" + (page - 1);
	}
});
</script>
</body>
</html>











