<%@page import="ssg.com.a.dto.StockParam"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="ssg.com.a.dto.StockLike"%>
<%@page import="ssg.com.a.dto.UserDto"%>
<%@page import="ssg.com.a.dto.StocksComment"%>
<%@page import="java.util.List"%>
<%@page import="ssg.com.a.dto.StocksDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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

	StocksDto dto = (StocksDto)request.getAttribute("symbol");
	List<String> stock = (List<String>)request.getAttribute("stock");
	List<StocksComment> comment = (List<StocksComment>)request.getAttribute("comment");
	List<StockLike> like = (List<StockLike>)request.getAttribute("list");
	String currentSymbol = dto.getSymbol();
	
	int pageBbs = (Integer)request.getAttribute("pagecomment");
	StockParam param = (StockParam)request.getAttribute("param");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  
  <script type="text/javascript" src="jquery/jquery.twbsPagination.min.js"></script>
  
  <script src="https://kit.fontawesome.com/23e6d6a2a2.js" crossorigin="anonymous"></script>

<style type="text/css">
body{
	margin: 40px;
}
.blind{
	display: none;
}
.dual{
	display: flex;
	justify-content: space-between;
	width: 100%%;
	padding-left: 60px;
	padding-right: 60px;
}
#icon{	
	overflow: hidden;
	color: #d8c0c0;
}
.wrap_company:first-child{
	display:inline-block;
  	margin-right: 5px;
}
</style>
</head>
<body>
<div align="center" >
	<table border="1" >
		<col width="600"><col width="220">
		<tr>
			<td>
				<%=stock.get(0) %> 
						
			<div>
				<table border="1" style="height: 100px; width: 600px;">
					<col width="150"><col width="150"><col width="150"><col width="150">
					<tr>
						<td rowspan="4">
							<%=stock.get(1) %>
						</td>
					</tr>
					<tr>						
						<%=stock.get(2) %>					
						<%=stock.get(3) %>
					</tr>
					<tr>
						<td colspan="4">
							<%=stock.get(4) %>
						</td>
					</tr>
				</table>
			</div>
			</td>
			<td>
				<table>
					<tr>
						<td>
							
						</td>
						
					</tr>
					<tr>					
						<td style="font-size: 12px;">
							<%=stock.get(5) %>
						</td>
					</tr>
				</table>
			</td>		
		</tr>
		<tr>
			<td colspan="2">
				<div class="dual">
					<%=stock.get(6) %>				
					<%=stock.get(7) %>
				</div>	
			</td>
		</tr>
		<tr>
			<td>
				
			</td>
		</tr>			
			
	</table>
	<br>
		<input type="button" value="돌아가기" id="back">
</div>

<script type="text/javascript">
// 뒤로가기
$(document).ready(function(){
	
	$("#back").click(function() {
		location.href = "stockMain.do";
	});
});

</script>

<div id="app" class="container">
  <form action="commentWriteAf.do" method="post">
  <input type="hidden" name="symbol" value="<%=dto.getSymbol() %>">
  <input type="hidden" name="user_id" value=<%=login.getUser_id() %>>
    <table>
      <col width="1500px">
      <col width="150px">
      <tr>
        <td>comment</td>
      </tr>
      <tr>
        <td>
          <input type="text" class="form-control"  name="content">
        </td>
        <td style="padding-left: 30px">
          <button type="submit">댓글</button>
        </td>
      </tr>
    </table>
    
  </form>
  
  <table class="table tamle-sm">
	<col width="100px"><col width="700px">	
	<tbody id="tbody">
		
		<%
		if(comment == null || comment.size() == 0){
			%>
			<tr>
				<td colspan="2">작성된 댓글이 없습니다</td>
			</tr>
			<%
		}else{
			for(int i = 0; i < comment.size(); i++){ 				
			%>
		<tr>
			<td>
				<%=comment.get(i).getUser_id() %>
			</td>
			<td>
				<%=comment.get(i).getContent() %>
			</td>
		</tr>	
		<%} 
		}
		%>
	</tbody>	
  </table>
</div>

<script type="text/javascript">
$(document).ready(function() {
	
	var likedSymbolsArray = <%= new Gson().toJson(like) %>;
    var currentSymbol = '<%= currentSymbol %>';
	
    function checkLikedSymbols(symbol) {
        return likedSymbolsArray.some(function(item) {
            return item.symbol === symbol;
        });
    }

    if (checkLikedSymbols(currentSymbol)) {
        $("#icon").css('color', 'red');
    }
	
    $("#icon").on("click", function() {
        $.ajax({
            url: "like.do",
            type: "GET",
            data: { 'symbol': '<%=dto.getSymbol()%>', 'user_id': '<%=login.getUser_id()%>' },
            success: function(data) {            	        	    	
            	console.log("데이타:" + data);
            	if (data=="inserted") {
            		$("#icon").css('color', '#ff0000');
            		alert("관심종목에 추가되었습니다.");
            		var likedSymbolsArray = <%= new Gson().toJson(like) %>;
            		var currentSymbol = '<%=dto.getSymbol()%>';

            		if (likedSymbolsArray.includes(currentSymbol)) {
            		    $("#icon").css('color', 'red');
            		}	
            		          		
	 				if (confirm('찜목록으로 이동하시겠습니까?')) {
	 					location.href='mypageLike.do';
	 					
	 	 			}	
            	} else {
            		$("#icon").css('color', '#d8c0c0');
            		alert("관심종목에서 제외하셨습니다.");            		
            	}
            },
            error: function(error) {
                alert('error');
            }
        });
    });
});

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

		location.href = "stocksdetail.do?seq=" + <%=dto.getSymbol()%> + "&pageNumber=" + (page - 1);
	}
});

</script>
</body>
</html>