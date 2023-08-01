<%@page import="ssg.com.a.dto.NewsParam"%>
<%@page import="java.util.List"%>
<%@page import="ssg.com.a.dto.NewsComment"%>
<%@page import="ssg.com.a.dto.NewsDto"%>
<%@page import="ssg.com.a.dto.UserDto"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	UserDto login = (UserDto)session.getAttribute("login");
	if(login == null){
		%>  
		<script type="text/javascript">
		alert("로그인 해 주십시오");
		location.href("login.do");
		</script>
		<%
	}
%>

<%	

	NewsDto dto = (NewsDto)request.getAttribute("newsdto");
	List<NewsComment> comDtoList = (List)request.getAttribute("comdto");
	//String Dt = comDtoList.get(0).getUser_id()
	int commentCount = (Integer)request.getAttribute("commentCount");
	
	int pageBbs = (Integer)request.getAttribute("pagenews");
	NewsParam param = (NewsParam)request.getAttribute("param");
	int j = 0;
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


.replyInput {
    display: flex;
    flex-direction: column;
    align-items: start;
    width: 100%;
}

.buttonContainer {
    display: flex;
    justify-content: space-between;
    width: 100%;
    margin-top: 2px;
}
#replyUsername {
    padding: 5px;
    font-size: 0.9em;
}
#replyContent {
	flex-grow: 1; /* Add this line */

}

.table-info{
	background-color: #FFFFFF;
}

.table-info > td{
	background-color: #FFFFFF;
}

textarea {
    resize: none; 
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
	.tr-hover tr{
	transition: 0.2s;
	}
	.tr-hover tr:hover {
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
	height: auto; /* This allows the height of the button to adapt based on its content */
    white-space: nowrap;
	}
	
	.mypage-delete:hover {
		color: #fff;
		border-color: #ff9406;
		background-color: #ff9406;
	}
	.mypage-btn {
	border: solid 1px #EAE8E6;
	line-height: 25px;
	transition: 0.2s;
	height: 25px; /* This allows the height of the button to adapt based on its content */
    white-space: nowrap;
    font-size: 12px;
	display: flex;
	justify-content: center;
	align-items: center;
	padding-left: 8px;
	padding-right: 8px;
   
	}
	.mypage-btn:hover {
	color: #fff;
	border-color: #ff9406;
	background-color: #ff9406;
	}
</style>
<script type="text/javascript" src="jquery/jquery.twbsPagination.min.js"></script>
</head>
<body onload="newsViewUpdate(<%=dto.getSeq() %>)">
<br><br>
<main class="container my-4 w-75 m-auto">
    <div class="mypage-container-top">뉴스 게시판</div>
<br>

<% if(login != null){ %>

<table class="table table-hover">
<col width="150px"><col width="500px">
<tr>	
	<td colspan="2" style="font-size: 22px;font-weight: bold;line-height: 28px;"><%=dto.getTitle() %></td>
</tr>
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
<%if (dto.getSource() == null || dto.getSource().equals("")){ %>
<%} else { %>
<tr>
	<th>원본 기사</th>
	<td><a href='<%=dto.getSource()%>' target='_blank' rel='noreferrer noopener'><%=dto.getSource()%></a></td>	
</tr>
<%} %>

<tr>	
	<td colspan="2" style="background-color: white;padding:30px;font-family: 고딕, arial;" >
		<!-- <input rows="3" cols="30" id="content" class="form-control" readonly style="border: none; font-size: 20px;font-family: 고딕, arial;background-color: white; padding: 0px"></input> -->
		<%=dto.getContent() %>
	</td>
</tr>
</table>

<% } %>

<div align="right">
<button type="button" class="btn mypage-delete" onclick="cancel()">목록</button>
<%
if(login != null && login.getAuth() == 0){
	%>
	

	<button type="button" class="btn mypage-delete" onclick="updatenews(<%=dto.getSeq() %>, <%=param.getPageNumber()%>)">수정</button>
	
	<button type="button" class="btn mypage-delete" onclick="deletenews(<%=dto.getSeq() %>)">삭제</button>
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
<form onsubmit="return checkInput();" action="commentWrite.do" method="post">
<input type="hidden" name="seq" id="seq" value="<%=dto.getSeq() %>">
<% if (login != null) { %>
<input type="hidden" name="user_id" id="user_id" value="<%=login.getUser_id() %>">
<% } else { %>
<input type="hidden" name="user_id" id="user_id" value="">
<% } %>
<input type="hidden" name="pageNumber" id="pageNumber" value="<%=param.getPageNumber() %>">

<table>
<col width="1500px"><col width="150px">
<tr>
	<td>comment</td>
</tr>
<tr>
	<td>
		<textarea rows="3" class="form-control" name="content" id="content"></textarea>
	</td>
	<td style="padding-left: 10px ">
		<button type="submit" class="btn mypage-delete btn-block p-4" >완료</button>
	</td>
</tr>


<tr>
<%
if (comDtoList.size() == 0){ 
%>
<td colspan="4"><p style="display: inline-block; margin-right: 10px;">총 댓글 수: <h4 style="display: inline-block; color:#FF9406;">0</h4></p></td>
<%}else{%>
	<td colspan="4"><p style="display: inline-block; margin-right: 10px;">총 댓글 수: <h4 style="display: inline-block; color:#FF9406;" id="comment-count"></h4></p></td>
<%} %>
</tr>
</table>

</form>


<table class="table table-sm">
<col width="500"><col width="500">

<tbody id="tbody" class="tr-hover">
<table>
<col width="1500px"><col width="150px"><col width="150px"><col width="150px">
<td colspan="2" id="replyInput" class="table-content" style="display: none;">
    <input type="hidden" id="post_num">
    <input type="hidden" id="seq">
    <input type="hidden" id="ref">
    <input type="hidden" id="step">
    <input type="hidden" id="depth">
    <b id="replyUsername"></b>
    <div class="replyInput">
        <textarea rows="3" class="form-control" name="replyContent" id="replyContent"></textarea>
        <div class="buttonContainer">
            <button type="button" class="btn mypage-btn" onclick="sendReply()">완료</button> 
            <button type="button" class="btn mypage-btn" onclick="cancelReply()">취소</button>
        </div>
    </div>
</td>

</table>
</tbody>

</table>

<br>

<div class="container">
    <nav aria-label="Page navigation">
        <ul class="paginationComment" id="paginationComment" style="justify-content:center"></ul>
    </nav>
</div>
</main>
<br><br>

<script type="text/javascript">
function checkInput() {
	var inputText = document.querySelector('.form-control').value;
	if (inputText.trim().length < 1) {
		alert("1글자 이상 입력해주세요");
		return false;
	}
}

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
			  pageNumber:<%=param.getPageNumber()%>,
			  },
		success: function(list){
			
			// tbody 태그안의 값을 모두 초기화 후 다시 게시
			
			$("#tbody").html("");
			let count = 0;
			$.each(list, function(i, item){
				
				let pageNumber = <%=param.getPageNumber()%>;
				let post_num = <%=dto.getSeq()%>;
				let del = item.del;
				let str = "";
				let padding_range = (item.depth*25);
				const user_id = "<%=login.getUser_id() %>";

				if (del == 0){
					
					console.log("Condition met: del == 0");
					
					str = "<tr class='tr-hover' >"
						+		"<td><div ' style='padding-left:" + padding_range + "px;'>" + item.user_id + "</div></td>"
						+		"<td class='text'>" + item.write_date + "</td>"
						+		"<td style='padding: 2px;'>"
						+			"<button type='button' id='replyBtn-" + item.seq + "' class='btn mypage-btn' onclick='reply(" + post_num + ", \"" + user_id + "\"," + item.seq + ")'>답글</button>"
						+		"</td>"
						+		"<td style='padding: 2px;'>"
						+			"<button type='button' class='commentDelete btn mypage-btn' onclick='commentDelete(" + post_num + "," + item.seq + "," + pageNumber + ")'>삭제</button>"
						+		"</td>"
						+	"</tr>"
						+	"<tr id='commentRow-" + item.seq + "'>"
						+		"<td colspan='2' class='table-content'><div ' style='padding-left:" + padding_range + "px;'>" + item.content + "</div></td>"
						+	"</tr>"
				}else{
					console.log("Condition met: del == 1 '");
					str = "<tr class='table-info'>"
						+		"<td><div ' style='padding-left:" + padding_range + "px;'>" + item.user_id + "</div></td>"
						+		"<td>" + item.write_date + "</td>"
						+	"<tr>"
						+		"<td colspan='2'><div ' style='padding-left:" + padding_range + "px;'>"
						+			"<font color='#ff0000' style='opacity: 0.5;'> ****** 이 글은 작성자에 의해서 삭제되었습니다</font>"
						+	  	"</div></td>"
						+	"</tr>"
						+	"</tr>"

				}

				<%=j = j+1%>
				$("#tbody").append(str);
			});
			$("#comment-count").text(<%=commentCount%>);

		},
		error:function(){
			alert('error');
		}
		
	});
	
})
function cancel( ) {
	location.href = "newslist.do";
}
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
function commentDelete( post_num, seq, pageNumber ) {
	console.log("pageNumber = " + pageNumber);

	location.href = "commentDelete.do?post_num=" + post_num + "&seq=" + seq + "&pageNumber=" + pageNumber ;
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


$(document).ready(function() {
    // Existing code
	$('textarea').on('input', function () {
	    this.style.height = 'auto';
	    this.style.height = (this.scrollHeight) + 'px';
	});


});


</script>

</div>
</div>

</body>
</html>







