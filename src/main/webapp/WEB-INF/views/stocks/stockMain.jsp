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

<style type="text/css">
.thead{
	font-weight: bold;
	height: 55px;
}
body{
	color: #4E4E4E;
}
a{
	font-weight: bold;
	text-decoration: none;
	color: #4E4E4E;
}
a:hover{
	color: #FF9406;
	text-decoration: none;
}
.my-navbar{
	background-color: #FF9406;
	border-radius: 30px;
}

.table > thead > tr:hover {
      background-color: #EAE8E6;
    }


.table > thead > tr{
	transition: 0.2s;
}
.table > thead > tr > th {
    border-color: #EAE8E6;
}
.table > tbody > tr > td {
    border-color: #EAE8E6;
}

.table tbody+tbody {
border-color: #EAE8E6 !important;
}

.table td, .table th {
border-color: #EAE8E6 !important;
}

.nav-link{
	border-radius: 10px;
	border: none;
	height: 100%;
}
.nav-link:focus,
.nav-link:active {
	outline: none;
      box-shadow: none; 
}
	

</style>
</head>
<body>


<div class="container w-75 m-auto">
<nav class="navbar navbar-expand-md navbar-dark container mb-4 mt-5 my-navbar" id="mynavbar">
    <a class="navbar-brand" href="#">CHICKEN STOCK</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <input type="button" id="count" value="거래량 100위" class="nav-link btn-light h-100"><span class="sr-only">(current)</span>
        </li>
        <li class="nav-item">
          <input type="button" id="cap" value="시가총액 100위" class="nav-link btn-light h-100">
        </li>
        <!-- dropdown 메뉴 삭제 -->
        <li class="nav-item">
          <form class="form-inline">
            <!-- Bootstrap 그리드 시스템 활용 -->
            <div class="form-row custom-select-container">
              <div class="col-sm-auto pr-1">
                <select id="choice" name="choice" class="my-select selectpicker h-100 form-control">
                  <option value="name">종목명</option>
                  <option value="symbol">종목번호</option>
                </select>
              </div>
              <div class="col-sm-auto pl-0 custom-search-input">
                <input id="search" name="search" class="form-control" type="search" placeholder="Search" aria-label="Search" />
              </div>
              <div class="col-sm-auto">
                <button class="btn btn-light my-2 my-sm-0" onclick="searchBtn()" id="btn" type="submit">Search</button>
              </div>
            </div>
          </form>
        </li>
      </ul>
    </div>
  </nav>




			



<div id="capsc" style="display: none;" class="table text-center" align="center">
	<table>
		<tr class="thead">
			<th>N</th><th>종목명</th><th>현재가</th><th>전일비</th><th>등락률</th><th>액면가</th><th>시가총액</th><th>상장주식수</th><th>외인비율</th><th>거래량</th><th>PER</th><th>ROE</th>		
		</tr>				
		<tr>
			<%=sslist.get(0)%>
			<%=sslist.get(1)%>
		</tr>
	</table>
</div>

<table class="table text-center" id="countsc" style="display: none;">				
			<tr>
				<%=slist.get(0)%>
			</tr>
</table>

<div align="center" id="searchsc" style="display: none;" class="table text-center">
	<table class="table" style="text-align: center;">
		<col width="5"><col width="180"><col width="80"><col width="120"><col width="250"><col width="120"><col width="120">
		<th>N</th><th>종목명</th><th>종목코드</th><th>종목시장</th><th>부문</th><th>창립일</th><th>대표자</th>
		<tbody>
		<%
			if(list == null || list.size() == 0){					
		%>
			<tr>
				<td colspan="8">
				<script type="text/javascript">
					alert("검색결과가 없습니다.");
				</script>
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
			        <tr onmouseover="mouseOver(this)" onmouseout="mouseOut(this)">
			            <td><%= i + 1 %></td>
			            <td>
			                <a href="stocksdetail.do?symbol=<%=symbol%>">
			                    <%= stock.getName() %>
			                </a>
			            </td>

			            <td><%= stock.getSymbol() %></td>
			            <td><%= stock.getMarket() %></td>
			            <%
			            if (stock.getSector() == null || stock.getListingDate() == null || stock.getRepresentative() == null) {
			                String str = "N";							
			            %>
			                <td>N</td>
			                <td>N</td>
			                <td>N</td>
			            <% 
			            }else{
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
		element.style.backgroundColor = "#EAE8E6";
		
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