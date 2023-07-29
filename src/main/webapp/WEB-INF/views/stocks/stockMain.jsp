<%@page import="java.util.ArrayList"%>
<%@page import="ssg.com.a.dto.StockParam"%>
<%@page import="ssg.com.a.dto.StocksDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
		List<StocksDto> list = (List<StocksDto>)request.getAttribute("stocklist"); 
		StockParam param = (StockParam)request.getAttribute("param");
		
		
		List<String> slist = (List<String>)request.getAttribute("slist");
		List<String> sslist = (List<String>)request.getAttribute("sslist");
		String choice = param.getChoice();
		String search = param.getSearch();
		int pageNumber = param.getPageNumber();
        	
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>stockmain</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
<div align="center">

<select id="choice" name="param.choice">
	<option value="name">종목명</option>
	<option value="symbol">종목번호</option>
</select>
<input type="text" value="<%=search %>" id="search" name="param.search">
<button type="button"  onclick="searchBtn()" id="btn">검색</button>

<table border="1"   >
	<thead>
		<tr>
			<td colspan="5">
				<input type="button" id="count" value="거래량 100위">
			</td>
			<td colspan="7">
				<input type="button" id="cap" value="시가총액 100위">
			</td>
		</tr>
	</thead>
</table>
<div id="capsc" style="display: none;">
	<table border="1">
		<tr>
			<th>N</th><th>종목명</th><th>현재가</th><th>전일비</th><th>등락률</th><th>액면가</th><th>시가총액</th><th>상장주식수</th><th>외인비율</th><th>거래량</th><th>PER</th><th>ROE</th>		
		</tr>				
		<tr>
			<%=sslist.get(0)%>
			<%=sslist.get(1)%>
		</tr>
	</table>
</div>

<table border="1" id="countsc" style="display: none;">
	<tbody  >			
			<tr>
				<%=slist.get(0)%>
			</tr>
	</tbody>
</table>
</div>
<div align="center" id="searchsc" style="display: none;">
	<table border="1" style="text-align: center;">
		<col width="5"><col width="180"><col width="80"><col width="120"><col width="250"><col width="120"><col width="120">
		<th>NO</th><th>종목명</th><th>종목코드</th><th>종목시장</th><th>부문</th><th>창립일</th><th>대표자</th>
		<tbody>
		<%
			if(list == null || list.size() == 0){					
		%>
			<tr>
				<td colspan="8">
					검색결과가 없습니다.
				</td>
			</tr>
			<%
			} else {
				
			    for (int i = 0; i < list.size(); i++) {
			        StocksDto stock = list.get(i);
			        String symbol;
			        if(stock.getSymbol().length() < 6 ){
			        	int symbolNum = Integer.parseInt(stock.getSymbol());
						symbol = String.format("%06d", symbolNum);
			        }else{
			        	symbol = stock.getSymbol();
			        }
					%>			
			        <tr>
			            <td><%= i + 1 %></td>
			            <td>
			                <a href="stocksdetail.do?symbol=<%= symbol %>&pageNumber=<%= pageNumber%>">
			                    <%= stock.getName() %>
			                </a>
			            </td>

			            <td><%= stock.getSymbol() %></td>
			            <td><%= stock.getMarket() %></td>
			            <%
			            if (stock.getSector() != null || stock.getListingDate() != null || stock.getRepresentative() != null) {
			                String str = "";							
			            %>
			                <td><%= stock.getSector() %></td>
			                <td><%= stock.getListingDate() %></td>
			                <td><%= stock.getRepresentative() %></td>
			            <% 
			            } 
			            %>
			        </tr>
			<%
			    }
			}
			%>
		</tbody>
	</table>
</div>
<!-- 거래량 시가총액 하나씩 보게 하기 위함 -->
<script type="text/javascript">
$(document).ready(function(){
	var searchval = '<%=search%>';
	if(searchval === null || searchval === ''){
		$("#capsc").show();
		$("#searchsc").hide();
	}else{
		$("#searchsc").show();
	}
	
});
	
	$("#count").click(function() {
		$("#capsc").hide();
		$("#countsc").show();		
		$("#searchsc").hide();
	});
	
	$("#cap").click(function(){
		$("#capsc").show();
		$("#countsc").hide();
		$("#searchsc").hide();
	});
	
	$("#btn").click(function() {
		$("#searchsc").show();
		$("#capsc").hide();
		$("#countsc").hide();
	});
	
			 

	function mouseOver(element) {
		element.style.backgroundColor = "#FFFACD";
		
	}
	
	function mouseOut(element) {
		element.style.backgroundColor = "";
	}

	let search = "<%=search %>";	

	if(search != ""){
		let obj = document.getElementById("choice");
		obj.value = "<%=choice %>";
		obj.setAtrribute("selected", "selected");
	}

	function searchBtn() {	
		
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;
	
	location.href = "stockMain.do?choice=" + choice + "&search=" + search;
	
	
	
}

	





</script>

</body>
</html>