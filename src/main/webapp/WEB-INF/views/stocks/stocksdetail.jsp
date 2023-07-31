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

	StocksDto dto = (StocksDto)request.getAttribute("symbol");
	List<String> stock = (List<String>)request.getAttribute("stock");
	List<StocksComment> comment = (List<StocksComment>)request.getAttribute("comment");
	List<StockLike> like = (List<StockLike>)request.getAttribute("list");
	String currentSymbol = dto.getSymbol();
	UserDto login = (UserDto)session.getAttribute("login");
	
/* 	int pageBbs = (Integer)request.getAttribute("pagecomment");
	StockParam param = (StockParam)request.getAttribute("param"); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans&display=swap" rel="stylesheet">
  
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  
  <script type="text/javascript" src="jquery/jquery.twbsPagination.min.js"></script>
  
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
	
<style type="text/css">
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
}
i{
font-size: 36px;
margin-left: 8px;
}
.wrap_company h2 a{
	font-size: 48px;
}

#tab_con1, #tab_con1 * {
    font-size: 13px !important;
  }
.gray table {
    width: 100%;
  }
.gray th, .gray td {
    width: 50%;
  }
 
 .first table{
 	width: 100%;
 } 
  
 .first > table > tbody > tr > td{
 	width: 50%;
 }
 .first > table > tbody > tr > th{
 	width: 50%;
 }
.link_site{
	color: #4E4E4E;
	cursor: default;
	pointer-events: none;
	text-decoration: none;
}
h2 a{
	color: #4E4E4E;
	cursor: default;
	pointer-events: none;
	text-decoration: none;
}
#img_chart_area {
    height: 400px;
}
.no_today > .no_down > *{
	font-size: 36px;
	font-family: 'Noto Sans', sans-serif;
}
.no_today > .no_up > *{
	font-size: 36px;
	font-family: 'Noto Sans', sans-serif;
}
.dom{
 	vertical-align: top;
}

 .comment-container {
    display: flex;
    align-items: center;
    border: 1px solid #ccc;
    height: 50px;
    border-radius: 20px;
    display: flex;
    align-items: center;
    transition: 0.2s;
  }

  .comment-container textarea {
    flex: 1;
    resize: none;
    border: none;
    outline: none;
    height: 100%;
  }

  .comment-container label {
    margin-right: 10px;
    width: 10%;
    background-color: #FF9406;
    display: inline-block;
    line-height: 50px; 
    height: 100%;
    text-align: center;
    border-radius: 20px;
    margin: 0;
    padding: 0;
  }

  .comment-container button {
    margin-left: 5px;
    width: 12%;
    height: 100%;
    border-radius: 20px;
    
  }
  .comment-container button:hover{
  	background-color: #FF9406;
  }
  .container{
  	text-align: center;
  }
  .content-table{
  	margin-top: 50px;
  	 border-collapse: separate;
    border-spacing: 0;
    border: 1px solid #ccc;
    border-radius: 30px;
    padding-left: 20px;
    padding-bottom: 15px;
    padding-top: 15px;
  }
  
  
  .chart-table{
  	 border-collapse: separate;
    border-spacing: 0;
    border: 1px solid #ccc;
    border-radius: 30px;
    padding: 20px;
    margin-top: 20px;
    padding-right: 47px;
  }
  .data-table{
  	margin-top: 20px;
  	 border-collapse: separate;
    border-spacing: 0;
    border: 1px solid #ccc;
    border-radius: 30px;
  }  
  .data-table td + td {
    border-left: 1px solid #ccc;    
  }
  
  .state-table{
   border-collapse: separate;
    border-spacing: 0;
    border: 1px solid #ccc;
    border-radius: 30px;
    margin-left: 20px;
    margin-right: 20px;
    padding-top: 20px;
  }
  .state-table td + td{
  	 border-left: 1px solid #ccc;
  }
  .trade-table{
  border-collapse: separate;
    border-spacing: 0;
    border: 1px solid #ccc;
    border-radius: 30px;
    padding: 30px;
    margin-top: 20px;
    padding-right: 68px;
  }
  #back{
   background-color: #ff9406;
   color: #ffffff;
  }
  

</style>
</head>
<body>
<div align="center">
	<table class="content-table">
		<tbody>
				<tr>
					<td colspan="3"><%=stock.get(0) %> </td>
				</tr>
					<tr>
						<td colspan="2">
							<table class="data-table" style="height: 100px; width: 770px;text-align: center;">
								<col width="200"><col width="190"><col width="190"><col width="190">
								<tr>
									<td rowspan="4">
										<%=stock.get(1) %>
									</td>
								</tr>
								<tr>
									<%=stock.get(2) %>
									<%=stock.get(3) %>
								</tr>
							</table>
							<table class="chart-table">	
								<tr>
									<td colspan="4">
										<%=stock.get(4) %>
									</td>
								</tr>
							</table>
						</td>
						
						<td rowspan="2">
							<table class="state-table">
								<tr>
									<td>
										<%=stock.get(5) %>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				<tr>
					<td>
						<table class="trade-table">
							<tr>
								<td>
									<%=stock.get(6) %>
								</td>
								<td>
									<%=stock.get(7) %>
								</td>
							</tr>
						</table>
					</td>
				</tr>
		</tbody>
	</table>
	<br>
		<input type="button" value="돌아가기" class="btn btn-warning" id="back">
</div>


<script type="text/javascript">
// 뒤로가기
$(document).ready(function(){
	
	$("#back").click(function() {
		location.href = "stockMain.do";
	});
	
});

</script>
<br><br>
<div id="app" class="container m-auto w-75">
  <form action="commentWriteAf.do" method="post">
  <input type="hidden" name="symbol" value="<%=dto.getSymbol() %>">
  <input type="hidden" name="user_id" value="<%=login.getUser_id()%>">
    <table class="w-100 m-auto text-center">
      <col width="1000px">
      <col width="200px">
      <tr>
        <td>
        	<div class="comment-container">
        	  <label for="commentInput" style="color:#ffffff;">댓글</label>
	          <textarea rows="4" cols="15"  class="form-control"  name="content"> </textarea>       
	          <button type="submit" class="btn btn-light">작성</button>
	        </div>
        </td>
      </tr>
    </table>
    
  </form>
  
  <table class="table w-75 text-left m-auto">
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
    	$("#icon").children().css('color', '#FF9406');
    }else{
    	$("#icon").children().css('color', '#d8c0c0');
    }
    
    $('.no_up').children().css('color', 'red');
    $('.no_down').children().css('color', 'blue');
    $('.f_up').css('color', 'red');
    $('.f_up.up').css('color', 'red');
    $('.f_down').css('color', 'blue');
    $('.f_down.down').css('color', 'blue');
    
    var blindValue = parseInt($('.no_down .blind:first').text().replace(',', ''));
    var emValue = parseInt($('.first em .blind:first').text().replace(',', ''));
    
    if (blindValue < emValue) {
        $('.no_today .no_down:first').children().css('color', 'blue');
        $('.no_exday .no_down:first').children().css('color', 'blue');
      } else if (blindValue > emValue) {
        $('.no_today .no_down:first').children().css('color', 'red');
        $('.no_exday .no_down:first').children().css('color', 'red');
      }else{
    	  $('.no_today .no_down').children().css('color', '#4E4E4E');
      }

	  if (checkLikedSymbols(currentSymbol)) {
        $("#icon").children().css('color', 'red');
    }
});

$(document).ready(function() {

    $("#icon").on("click", function() {
        $.ajax({
            url: "like.do",
            type: "GET",
            data: { 'symbol': '<%=dto.getSymbol()%>', 'user_id': '<%=login.getUser_id()%>' },
            success: function(data) {            	        	    	
            	console.log("데이타:" + data);
            	if (data=="inserted") {
            		var likedSymbolsArray = <%= new Gson().toJson(like) %>;
            		var currentSymbol = '<%=dto.getSymbol()%>';           		
            		    $("#icon i").css('color', '#FF9406');
            		          		
	 				if (confirm('찜목록으로 이동하시겠습니까?')) {
	 					location.href='mypageLike.do';
	 					
	 	 			}	
            	} else {
            		$("#icon i").css('color', '#d8c0c0');           		
            	}
            },
            error: function(error) {
                alert('error');
            }
        });
    });
});

<%-- $("#paginationComment").twbsPagination({
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
}); --%>

</script>
</body>
</html>