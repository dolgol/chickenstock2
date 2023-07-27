<%@page import="ssg.com.a.dto.StocksComment"%>
<%@page import="java.util.List"%>
<%@page import="ssg.com.a.dto.StocksDto"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	StocksDto dto = (StocksDto)request.getAttribute("symbol");
	List<String> stock = (List<String>)request.getAttribute("stock");
	List<StocksComment> comment = (List<StocksComment>)request.getAttribute("comment");
	
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
</style>
</head>
<body>

<div align="center" >
	<table border="1" >
		<col width="600"><col width="220">
		<tr>
			<td>
				<%=stock.get(0) %> <hr>			
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
							<%=stock.get(10) %>
						</td>
					</tr>
				</table>
			</td>		
		</tr>
		<tr>
			<td colspan="2">
				<div class="dual">
					<%=stock.get(5) %>				
					<%=stock.get(6) %>
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
		history.back();
	});
});

$(document).ready(function(){
		
	$("#cap").click(function() {	
		$("#capsc").show();
		$("#countsc").hide();
	}); 
	
	 $("#count").click(function() {
		$("#capsc").hide();
		$("#countsc").show();
	});
	 
	 $("#cap1").click(function() {	
			$("#capsc").show();
			$("#countsc").hide();
		}); 
		
		 $("#count1").click(function() {
			$("#capsc").hide();
			$("#countsc").show();
		});			
});
</script>

<div id="app" class="container">
  <form action="commentWriteAf.do" method="post">
  <input type="hidden" name="symbol" value="<%=dto.getSymbol() %>">
  <input type="hidden" name="user_id" value="변경태">
  <input type="hidden" name="write_date" value="2023-07-26">
    <table>
      <col width="1500px">
      <col width="150px">
      <tr>
        <td>comment</td>
      </tr>
      <tr>
        <td>
          <input type="text" name="content">
        </td>
        <td style="padding-left: 30px">
          <button type="submit">댓글</button>
        </td>
      </tr>
    </table>
  </form>
  
  <table class="table tamle-sm">
	<col width="500px"><col width="500px">
	<tbody id="tbody">
	</tbody>

  </table>

<script type="text/javascript">

$.ajax({
	url:"commentList.do",
	type:"get",
	success:function( comment ){
		
		
	$('#tbody').html("");
		
		$.each(comment, function(i, item) {
			let str = "<tr class = 'table-info'>"
				+	"<td>작성자:" + item.user_id + "</td>"
				+ 	"<td>작성일:" + item.write_date + "</td>"
				+	"</tr>"
				+	"<tr>"
				+		"<td colspan='2'>" + item.content + "</td>"
				+	"</tr>";
				$("#tbody").append(str);
		});
	},
	error:function(){
		alert('error');
	}
});
</script>
</div>
</body>
</html>