<%@page import="ssg.com.a.dto.BbsParam"%>
<%@page import="util.BbsUtil"%>
<%@page import="ssg.com.a.dto.MemberDto"%>
<%@page import="ssg.com.a.dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	List<BbsDto> list = (List)request.getAttribute("bbslist");
	int pageBbs = (Integer)request.getAttribute("pageBbs");
	
	BbsParam param = (BbsParam)request.getAttribute("param");
	int pageNumber = param.getPageNumber();
	String choice = param.getChoice();
	String search = param.getSearch();
%>    
    
<!DOCTYPE html>
<html>
<head>

<style type="text/css">
.center{
	margin: auto;
	/* text-align: center; */
}
.center th{
	background: white;
	color: black;
}
</style>

<script type="text/javascript" src="jquery/jquery.twbsPagination.min.js"></script>
</head>
<body>
<br><br><br>

<div class="center">

<div class="form-row align-items-center d-flex justify-content-center align-items-center container">
<select id="choice" class="form-control" style="width:auto;">
	<option value="start">검색</option>
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="writer">작성자</option>
</select>

<div class="col-sm-3 my-1" style="width:auto;">
	<input type="text" id="search" class="form-control" value="<%=search %>">
</div>

<button type="button" onclick="searchBtn()" class="btn btn-primary">검색</button>
</div>

<br><br>

<table class="table table-hover">
<!-- <col width="70"><col width="650"><col width="130"><col width="150"> -->
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
	
	for(int i = 0;i < list.size(); i++){
		BbsDto bbs = list.get(i);
		%>
		<tr>
			<td><%=i + 1 %></td>
			
			<%
			if(bbs.getDel() == 0){
				%>				
				<td style="text-align: left;">
					<a href="bbsdetail.do?seq=<%=bbs.getSeq() %>">
						<%=BbsUtil.arrow(bbs.getDepth()) %>
						<%=BbsUtil.titleDot(bbs.getTitle()) %>
					</a>
				</td>
				<% 
			}else{
			%>
				<td style="text-align: left;">
					<%=BbsUtil.arrow(bbs.getDepth()) %>
					<font color="#ff0000"> ****** 이 글은 작성자에 의해서 삭제되었습니다</font>
				</td>			
			<%
			}
			%>
			
			<td><%=bbs.getReadcount() %></td>
			<td><%=bbs.getId() %></td>
		</tr>
		<% 
	}
}
%>
</tbody>

</table>
<br>

<div class="container">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination" style="justify-content:center"></ul>
    </nav>
</div>

<br><br>
<a href="bbswrite.do">글쓰기</a>
</div>

<br><br>
<br>
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
	location.href = "bbslist.do?choice=" + choice + "&search=" + search;
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

		location.href = "bbslist.do?choice=" + choice + "&search=" + search + "&pageNumber=" + (page - 1);
	}
});
</script>
</body>
</html>











