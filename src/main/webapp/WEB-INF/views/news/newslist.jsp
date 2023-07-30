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
    border: 1px solid #ced4da;
    border-radius: .25rem;
    box-shadow: none;
}

/* Add this to reduce the size of the select field */
.select-field {
    width: 10%;
}

/* Add this to adjust the size of the input field */
.input-field {
    width: 90%;
}
</style>

<!-- <script type="text/javascript" src="jquery/jquery.twbsPagination.min.js"></script> -->
<script src="jquery/jquery.twbsPagination.min.js"></script>
</head>
<body>
<br><br><br>
<main class="container my-4">
<!-- <div class="center"> -->
<!-- Search Bar -->
        <div class="card rounded-card">
            <div class="card-body">
                <div class="input-group mb-3">
                    <!-- <div class="input-group-prepend">
                        <label class="input-group-text" for="choice">검색</label>
                    </div> -->
                    <select id="choice" class="form-control select-field">
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                        <option value="writer">작성자</option>
                    </select>
                    <input type="text" id="search" class="form-control input-field" value="<%=search %>">
                    <div class="input-group-append">
                        <button type="button" onclick="searchBtn()" class="btn btn-outline-secondary">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
<br><br>
 <!-- News List -->
<div class="card rounded-card">
<div class="card-body">
<table class="table table-hover">

<thead>
<tr>
	<th>번호</th><th>제목</th><th>조회수</th><th>작성자</th>
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
					<a href="newsdetail.do?seq=<%=paramTemp.getSeq() %>&pageNumber=<%=paramTemp.getPageNumber()%>">
						<%-- <%=BbsUtil.arrow(news.getDepth()) %> --%>
						<%=BbsUtil.titleDot(news.getTitle()) %>
					</a>
				</td>
				<% 
			}else{
			%>
				<td style="text-align: left;">
					<%-- <%=BbsUtil.arrow(news.getDepth()) %> --%>
					<font color="#ff0000"> ****** 이 글은 작성자에 의해서 삭제되었습니다</font>
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
</div>
<br>
<!-- Pagination -->
<a href="newsnotice.do">글쓰기</a>
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
// Java -> JavaScript
let search = "<%=search %>"; 	// 문자열일 경우
	
if(search != ""){
	let obj = document.getElementById("choice");
	obj.value = "<%=choice %>";
	obj.setAttribute("selected", "selected");
} 

function searchBtn() {
	let choice = document.getElementById("choice").value;
//	let choice = $("#choice").val();
	let search = document.getElementById("search").value;
	/*
	if(choice.trim() == ""){
		alert("카테고리를 선택해 주십시오");
		return;
	}
	if(search.trim() == ""){
		alert("검색어를 입력해 주십시오");
		return;
	}
	*/
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











