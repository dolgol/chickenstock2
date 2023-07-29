<%@page import="ssg.com.a.dto.NewsParam"%>
<%@page import="java.util.List"%>
<%@page import="ssg.com.a.dto.NewsComment"%>
<%@page import="ssg.com.a.dto.NewsDto"%>
<%@page import="ssg.com.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	UserDto login = (UserDto)session.getAttribute("login");
	if(login == null || login.getUser_id().equals("")){
		%>  
		<script>
		alert("로그인 해 주십시오");
		location.href = "login.do";
		</script>
		<%
	}
%>

<%	

	NewsDto dto = (NewsDto)request.getAttribute("newsdto");
	List<NewsComment> comDtoList = (List)request.getAttribute("comdto");
	int j = 0;
	int pageBbs = (Integer)request.getAttribute("pagenews");
	NewsParam param = (NewsParam)request.getAttribute("param");
%>    
    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
th{
	background-color: #fff;
	color: black;
}
td{
	text-align: left;	
}
</style>
<script type="text/javascript" src="jquery/jquery.twbsPagination.min.js"></script>
</head>
<body onload="newsViewUpdate(<%=dto.getSeq() %>)">
<br><br>
<div class="center">

<% if(login != null){ %>

<table class="table">
<col width="150px"><col width="500px">

<tr>
	<th>작성자</th>
	<td><%=dto.getWrite_id()%></td><!-- dto.getWrite_id() --> 
</tr>
<tr>
	<th>작성일</th>
	<td><%=dto.getPublication_date() %></td>	
</tr>
<tr>
	<th>조회수</th>
	<td><%=dto.getViews() %></td>	
</tr>
<%if (dto.getSource() != null){ %>
<tr>
	<th>원본 기사</th>
	<td><a href='<%=dto.getSource()%>' target='_blank' rel='noreferrer noopener'><%=dto.getSource()%></a></td>	
</tr>
<%} %>
<tr>	
	<td colspan="2" style="font-size: 22px;font-weight: bold;line-height: 28px;"><%=dto.getTitle() %></td>
</tr>
<tr>	
	<td colspan="2" style="background-color: white;">
		<textarea rows="3" cols="30" id="content" class="form-control" readonly style="border: none; font-size: 20px;font-family: 고딕, arial;background-color: white"><%=dto.getContent() %></textarea>
	</td>
</tr>
</table>

<% } %>

<div align="right">
<%
if(login != null && login.getAuth() == 1){
	%>
	<button type="button" class="btn btn-primary" onclick="updatenews(<%=dto.getSeq() %>, <%=param.getPageNumber()%>)">글수정</button>
	
	<button type="button" class="btn btn-primary" onclick="deletenews(<%=dto.getSeq() %>)">글삭제</button>
	<%	
}
%>

</div>

<br><br>

<script type="text/javascript">

$(document).ready(function(){		
	
	// textarea를 글자수와 개행수에 따라서 크기를 설정한다
	const contentRowCount = $("#content").val().split(/\r\n|\r|\n/).length;
	let fontcount = $("#content").val().length / 60
	$("#content").attr("rows", fontcount + contentRowCount + 2);
})

function answernews( seq ) {
	location.href = "newsanswer.do?seq=" + seq;	
}
function updatenews( seq, pageNumber ) {
	location.href = "newsupdate.do?seq=" + seq + "&pageNumber=" + pageNumber;
}
function deletenews( seq ) {
	location.href = "newsdelete.do?seq=" + seq;
}

</script>

<br><br>
<!-- 댓글 -->
<div id="app" class="container">
<form action="commentWrite.do" method="post">
<input type="hidden" name="seq" id="seq" value="<%=dto.getSeq() %>">
<input type="hidden" name="user_id" id="user_id" value="<%=login.getUser_id() %>">
<input type="hidden" name="pageNumber" id="pageNumber" value="<%=param.getPageNumber() %>">

<table>
<col width="1500px"><col width="150px">
<tr>
	<td>comment</td>
	<td style="padding-left: 30px">올리기</td>
</tr>
<tr>
	<td>
		<textarea rows="3" class="form-control" name="content" id="content"></textarea>
	</td>
	<td style="padding-left: 30px ">
		<button type="submit" class="btn btn-primary btn-block p-4">완료</button>
	</td>
</tr>


<tr>
<%
if (comDtoList.size() == 0){ 
%>
<td colspan="4"><p style="display: inline-block; margin-right: 10px;">총 댓글 수: <h4 style="display: inline-block; color:red;">0</h4></p></td>
<%}else{%>
	<td colspan="4"><p style="display: inline-block; margin-right: 10px;">총 댓글 수: <h4 style="display: inline-block; color:red;" id="comment-count"></h4></p></td>
<%} %>
</tr>
</table>

</form>
<br><br>

<table class="table table-sm">
<col width="500"><col width="500">

<tbody id="tbody">
	<div id="replyInput" style="display: none;">
	    <b id="replyUsername"></b>
	    <br>
	    <input type="hidden" id="post_num">
	    <input type="hidden" id="seq">
	    <input type="hidden" id="ref">
	    <input type="hidden" id="step">
	    <input type="hidden" id="depth">
	    <input type="text" id="replyContent" class="form-control">
	    <button type="button" class="btn btn-primary" onclick="sendReply()">OK</button>
	    <button type="button" class="btn btn-secondary" onclick="cancelReply()">Cancel</button>
	</div>
</tbody>

</table>

<br>

<div class="container">
    <nav aria-label="Page navigation">
        <ul class="paginationComment" id="paginationComment" style="justify-content:center"></ul>
    </nav>
</div>

<br><br>

<script type="text/javascript">
$("#paginationComment").twbsPagination({
	startPage:<%=param.getPageNumber()+1 %>,
	totalPages:<%=pageBbs %>,
	visiblePages:10,
	first:'<span srid-hidden="true">«</span>',		// 처음 페이지로 이동
	prev:"이전",
	next:"다음",
	last:'<span srid-hidden="true">»</span>',
	initiateStartPageClick:false,					// 자동 실행이 되지 않도록 설정
	onPageClick:function(event, page){
		// alert(page);

		location.href = "newsdetail.do?seq=" + <%=dto.getSeq()%> + "&pageNumber=" + (page - 1);
	}
});

$(document).ready(function(){
	$.ajax({
		url:"newscommentList.do",
		type:"get",
		data:{seq:<%=dto.getSeq() %>,
			  pageNumber:<%=param.getPageNumber()%> },
		success: function(list){
			/*
			alert('success');
			alert(JSON.stringify(list));
			*/
			/*
			for(i = 0; i < list.length; i++){
				list[i].seq
				list[i].content
			}
			*/
			
			// tbody 태그안의 값을 모두 초기화 후 다시 게시
			$("#tbody").html("");
			let count = 0;
			$.each(list, function(i, item){
				let post_num = <%=dto.getSeq()%>;
				let del = item.del;
				let str = "";
				let padding_range = (item.depth*25);
				if (del == 0){
					count ++;
					console.log("Condition met: del == 0");
					str = "<tr class='table-info' >"
						+		"<td><div ' style='padding-left:" + padding_range + "px;'>작성자:" + item.user_id + "</div></td>"
						+		"<td>작성일:" + item.write_date + "</td>"
						+		"<td>"
						+			"<button type='button' id='replyBtn-" + item.seq + "' class='reply' onclick='reply(" + post_num + ", \"" + item.user_id + "\"," + item.seq + ")'>답글</button>"
						+		"</td>"
						+		"<td>"
						+			"<button type='button' class='commentDelete' onclick='commentDelete(" + post_num + "," + item.seq + ")'>X</button>"
						+		"</td>"
						+	"</tr>"
						+	"<tr id='commentRow-" + item.seq + "'>"
						+		"<td colspan='2' class='table-content'><div <div ' style='padding-left:" + padding_range + "px;'>" + item.content + "</div></td>"
						+	"</tr>"
				}else{
					console.log("Condition met: del == 1 '");
					str = "<tr class='table-info'>"
						+		"<td><div ' style='padding-left:" + padding_range + "px;'>작성자:" + item.user_id + "</div></td>"
						+		"<td>작성일:" + item.write_date + "</td>"
						+	"<tr>"
						+		"<td><div ' style='padding-left:" + padding_range + "px;'>"
						+			"<font color='#ff0000'> ****** 이 글은 작성자에 의해서 삭제되었습니다</font>"
						+	  	"</div></td>"
						+	"</tr>"
						+	"</tr>"

				}

						
				$("#tbody").append(str);
			});
			$("#comment-count").text(count);

		},
		error:function(){
			alert('error');
		}
		
	});
	
})

function reply(post_num, comment_user_id, seq) {
    const replyInputBox = $("#replyInput");
    const commentRow = $("#commentRow-" + seq);

    replyInputBox.insertAfter(commentRow);
    replyInputBox.show();

    $("#replyUsername").text("" + comment_user_id );
    $("#post_num").val(post_num);
    $("#seq").val(seq);
    
	//location.href = "commentAnswer.do?user_id=" + user_id + "&post_num=" + post_num + "&seq=" + seq;
}
function commentDelete( post_num, seq ) {

	location.href = "commentDelete.do?post_num=" + post_num + "&seq=" + seq;
}

function sendReply() {
    const post_num = $("#post_num").val();
    const seq = $("#seq").val(); // 댓글에 대한 답글이므로 이것을 parent_seq로 사용합니다.
    const replyContent = $("#replyContent").val();
    const user_id = "<%=login.getUser_id() %>"; // 현재 로그인한 사용자 ID
    const ref = $("#ref").val();
    const step = $("#step").val();
    const depth = $("#depth").val();

    $.ajax({
        url: "commentAnswer.do",
        type: "post",
        data: {
            post_num: post_num,
            seq: seq,
            content: replyContent,
            user_id: user_id,
            ref: ref,
            step: step,
            depth: depth
        },
        success: function() {
            // 서버에서 성공적으로 응답하면 댓글 목록을 새로 고침합니다.
            location.reload();
        },
        error: function() {
            alert('Error while requesting server');
        }
    });
}

function cancelReply(){
	const replyInputBox = $("#replyInput");
	replyInputBox.hide();
}

function newsViewUpdate(seq) {
    $.ajax({
        url: 'newsViewUpdate.do',
        type: 'GET',
        data: { seq: seq },
        success: function(response) {
            console.log('조회수 증가 성공');
        },
        error: function(error) {
            console.log('조회수 증가 실패');
        }
    });
}
</script>

</div>
</div>

</body>
</html>







