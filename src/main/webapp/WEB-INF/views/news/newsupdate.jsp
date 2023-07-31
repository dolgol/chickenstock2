<%@page import="ssg.com.a.dto.NewsParam"%>
<%@page import="ssg.com.a.dto.UserDto"%>
<%@page import="ssg.com.a.dto.NewsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	NewsDto dto = (NewsDto)request.getAttribute("newsDto");
	System.out.println(dto);
	UserDto login = (UserDto)session.getAttribute("login");
	NewsParam param = (NewsParam)request.getAttribute("param");
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

th {
    width: 10%; /* adjust this value to suit your needs */
}

td {
    width: 90%; /* adjust this value to suit your needs */
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

</style>
<script type="text/javascript" src="jquery/jquery.twbsPagination.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css">
<meta charset="UTF-8">
<title>글 수정</title>
</head>
<body>
<main class="container my-4 w-75 m-auto">
<div class="mypage-container-top">뉴스 게시판</div>
    <form action="newsupdateAf.do" method="post">
        <input type="hidden" name="seq" value="<%=dto.getSeq() %>">
        <input type="hidden" name="pageNumber" value="<%=param.getPageNumber() %>">
        <table class="table table-hover text-center">
            <col width="200"><col width="500">
            <tr>
            	<th>아이디</th>
            	<td style="text-align: left"><%=login.getUser_id() %></td><!-- 원본 기사 작성자로 수정해야함 -->
            </tr>
            <tr>
                <th>제목</th>
                <td>
                    <input type="text" class="form-control" name="title" style="text-align: left" value="<%=dto.getTitle() %>">
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <textarea rows="8" class="form-control" name="content" style="text-align: left"><%=dto.getContent() %></textarea>
                </td>
            </tr>
            <tr>
                <th>출처</th>
                <td>
                    <input type="text" name="source" class="form-control" value="<%=dto.getSource() %>">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: left; padding-left: 12px">
                    <input type="submit" class="btn mypage-delete" value="수정완료">
                    <button type="button" class="btn mypage-delete" onclick="cancel()">취소</button>
                </td>
            </tr>
        </table>
    </form>
</div>
<script type="text/javascript">
function cancel( ) {
	location.href = "newslist.do";
}
</script>
</main>
</body>

</html>
