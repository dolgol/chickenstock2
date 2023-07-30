<%@page import="ssg.com.a.dto.NewsParam"%>
<%@page import="ssg.com.a.dto.NewsDto"%>
<%@page import="util.BbsUtil"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

    <title>News List</title>

    <!-- Custom styles for this template -->
    <style>
        /* Customize the look and feel here */
        .rounded-card {
            border-radius: 15px;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
        }

        .center {
            margin: auto;
        }

        .center th {
            background: white;
            color: black;
        }
    </style>

    <script src="jquery/jquery.twbsPagination.min.js"></script>
</head>
<body>

    <main class="container my-4">
        <!-- Search Bar -->
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

        <!-- Pagination -->
        <div class="container">
            <nav aria-label="Page navigation">
                <ul class="pagination" id="pagination" style="justify-content:center"></ul>
            </nav>
        </div>

        <br><br>
        <a href="newsnotice.do">글쓰기</a>
    </main>


    <!-- jQuery and Bootstrap Bundle (includes Popper) -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>

    <!-- Additional JS -->
    <script type="text/javascript">
        // Java -> JavaScript
        let search = "<%=search %>";  // 문자열일 경우

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
            first:'<span srid-hidden="true">«</span>',       // 처음 페이지로 이동
            prev:"이전",
            next:"다음",
            last:'<span srid-hidden="true">»</span>',
            initiateStartPageClick:false,                    // 자동 실행이 되지 않도록 설정
            onPageClick:function(event, page){
                let choice = $("#choice").val();
                let search = $("#search").val();

                location.href = "newslist.do?choice=" + choice + "&search=" + search + "&pageNumber=" + (page - 1);
            }
        });
    </script>
</body>
</html>
