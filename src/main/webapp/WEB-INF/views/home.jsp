<%@page import="ssg.com.a.dto.StocksDto"%>
<%@page import="util.BbsUtil"%>
<%@page import="ssg.com.a.dto.NewsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	List<NewsDto> newsList = (List<NewsDto>)request.getAttribute("newsList");
	System.out.println(newsList);
	
	List<StocksDto> stocksList = (List<StocksDto>)request.getAttribute("stocksList"); 
	List<String> slist = (List<String>)request.getAttribute("slist");
	List<String> sslist = (List<String>)request.getAttribute("sslist");

%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHICKEN STOCK</title>

<style type="text/css">

	.home-banner {
		background-color: #acacac;
		width: 100%;
		height: 400px;
		/* background-image: url("images/banner.jpg");
		background-repeat: no-repeat;
		background-size: cover; */
	}
	
	.home-content-container {
		background-color: #d3d3d3;
		display: flex;
	}
	
	.home-content-left, .home-content-right{
		padding: 16px;
	}
	
	.home-content-left {
		background-color: pink;
	}
	
	.home-content-left table {
		background-color: #fff;
		width: 100%;
	}
	
	.home-content-right {
		background-color: skyblue;
	}
	
	.home-content-right table {
		background-color: #fff;
		width: 100%;
	}
	
	.stocks-active {
		background-color: #ff9406;
	}
	
	.more {
		text-align: right;
	}
	
	.nonView {
		display: none;
	}

</style>

</head>
<body>
	
	<div>
	
		<div class="home-banner">
			메인 배너
		</div>
		
		<div class="home-content-container w-75 m-auto">
		
			<div class="home-content-left w-50">
				
				<input type="button" id="cap" value="시가총액 10위" class="stocks-active">
				<input type="button" id="count" value="거래량 10위">
				
				<table border="1" id="capsc">
					<thead>
						<tr>
							<th>번호</th> <th>종목명</th> <th>현재가</th> <th>전일비</th> 
							<th>등락률</th> <th>액면가</th> <th>시가총액</th> <th>상장주식수</th> 
							<!-- <th>외인비율</th> <th>거래량</th> <th>PER</th> <th>ROE</th> -->	
						</tr>	 
					</thead>
					<tbody id="capscTd">		
						<!--<tr> -->
							<%=sslist.get(0)%>
							<%-- <%=sslist.get(1)%> --%>
						<!-- </tr> -->
					</tbody>
				</table>
				
				<table border="1" id="countsc" style="display: none;">
					<!-- <thead>		
					</thead> -->
					<tbody id="countscTd">
						<!-- <tr> -->
							<%=slist.get(0) %>
						<!-- </tr> -->
					</tbody>
				</table>
				<p class="more">
					<a href="stockMain.do">
						더보기 >>
					</a>
				</p>
			</div>
			
			<div class="home-content-right w-50">
				최신 뉴스
				<table border="1">
					<%
						for(int i = 0; i < newsList.size(); i++) {
							NewsDto news = newsList.get(i);
							%>
							<tr>
								<td>
									<a href="newsdetail.do?seq=<%=news.getSeq() %>">
										<%=BbsUtil.titleDot(news.getTitle()) %>
									</a>
								</td>
								<td>
									<%=news.getPublication_date() %>
								</td>
							</tr>
							<%
						}
					%>
				</table>
				<p class="more">
					<a href="newslist.do">
						더보기 >>
					</a>
				</p>
			</div>
			
		</div>
		
	</div>
	
	<script type="text/javascript">
	
		$(document).ready(function(){
				
			$("#cap").click(function() {	
				$("#cap").addClass("stocks-active");
				$("#count").removeClass("stocks-active");
				$("#capsc").show();
				$("#countsc").hide();
			}); 
			
			$("#count").click(function() {
				$("#cap").removeClass("stocks-active");
				$("#count").addClass("stocks-active");
				$("#capsc").hide();
				$("#countsc").show();
			});
			
			let capscChild = $("#capsc").children().eq(2).children();
			
			for(let i = 14; i < capscChild.length; i++) {
				capscChild.eq(i).addClass("nonView");
			}
			for(let i = 0; i < 20; i++) {
				$("#capsc").children().eq(2).children().eq(i).children().eq(8).addClass("nonView");
				$("#capsc").children().eq(2).children().eq(i).children().eq(9).addClass("nonView");
				$("#capsc").children().eq(2).children().eq(i).children().eq(10).addClass("nonView");
				$("#capsc").children().eq(2).children().eq(i).children().eq(11).addClass("nonView");
			}
			
			let countscChild = $("#countsc").children().eq(1).children();
			
			for(let i = 15; i < countscChild.length; i++) {
				countscChild.eq(i).addClass("nonView");
			}
			for(let i = 0; i < 20; i++) {
				$("#countsc").children().eq(1).children().eq(i).children().eq(7).addClass("nonView");
				$("#countsc").children().eq(1).children().eq(i).children().eq(8).addClass("nonView");
				$("#countsc").children().eq(1).children().eq(i).children().eq(10).addClass("nonView");
				$("#countsc").children().eq(1).children().eq(i).children().eq(11).addClass("nonView");
			}
			
		});
		
		function mouseOver(element) {
			element.style.backgroundColor = "";
		}
		
		function mouseOut(element) {
			element.style.backgroundColor = "";
		}
		
	</script>

</body>
</html>