<%@page import="java.util.ArrayList"%>
<%@page import="ssg.com.a.dto.stockParam"%>
<%@page import="ssg.com.a.dto.stocksDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   List<stocksDto> list = (List)request.getAttribute("stocklist"); 
   stockParam param = (stockParam)request.getAttribute("param");
   List<ArrayList> slist = (List)request.getAttribute("slist");
   List<ArrayList> sslist = (List)request.getAttribute("sslist");
   List<ArrayList> ssslist = (List)request.getAttribute("ssslist");
   String choice = param.getChoice();
   String search = param.getSearch();
   
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
<select id="choice">
	<option value="Name">종목명</option>
	<option value="Symbol">종목번호</option>
	<input type="text" value=""  id="search" >
	<button type="button"  onclick="searchBtn()">검색</button>
</select>
<table border="1"  id="capsc">
	<thead>
		<tr>
			<td colspan="5">
				<input type="button" id="count" value="거래량 100위">
			</td>
			<td colspan="7">
				<input type="button" id="cap" value="시가총액 100위">
			</td>
		</tr>
		<th>NO.</th><th>종목명</th><th>현재가</th><th>전일비</th><th>등락률</th><th>거래량</th><th>거래대금</th><th>매수호가</th><th>매도호가</th><th>시가총액</th><th>PER</th><th>ROE</th>		
	</thead>
	<tbody>		
			<tr>
				<%=sslist.get(0)%>
				<%=ssslist.get(0) %>
			</tr>

	</tbody>
</table>

<table border="1" id="countsc" style="display: none;">
	<thead>		
	</thead>
	<tbody>		
		<tr>
			<td colspan="5">
				<input type="button" id="count1" value="거래량 100위">
			</td>
			<td colspan="7">
				<input type="button" id="cap1" value="시가총액 100위">
			</td>
		</tr>
	
			<tr>
				<%=slist.get(0) %>
			</tr>
	</tbody>
</table>
</div>

<!-- 거래량 시가총액 하나씩 보게 하기 위함 -->
<script type="text/javascript">
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



</body>
</html>