<%@page import="ssg.com.a.dto.UserDto"%>
<%@page import="ssg.com.a.dto.StocksDto"%>
<%@page import="util.BbsUtil"%>
<%@page import="ssg.com.a.dto.NewsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	UserDto login = (UserDto)session.getAttribute("login");

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
	
	.nonView {
		display: none;
	}

	.home-banner {
		background-color: #acacac;
		width: 100%;
		height: 360px;
		background-image: url("images/banner.jpg");
		opacity: 0.8;
		background-repeat: no-repeat;
		background-size: cover;
		position: relative;
	}
	
	.home-banner-text {
		font-weight: 700;
		font-size: 300%;
		color: #fff;
		position: absolute;
		top: 20%;
		left: 13%;
	}
	
	.home-banner-text p {
		margin-top: 14px;
		color: #fff;
		font-weight: 400;
		font-size: 14px;
	}
	
	.home-content-container {
		display: flex;
	}
	
	.home-content-container a {
		color: #4E4E4E;
		transition: 0.2s;
	}
	
	.home-content-container a:hover {
		color: #ff9406;
	}
	
	.home-content-left, .home-content-right{
		padding: 16px;
	}
	
	.home-content-left table {
		background-color: #fff;
		width: 100%;
	}
	
	.home-content-right table {
		background-color: #fff;
		width: 100%;
	}
	
	.home-content-right .table tr:first-child td {
		border-top: none;
	}
	
	.nav-link {
		cursor: pointer;
	}
	
	.nav-link.active {
		border-color: #EAE8E6 !important;
		border-bottom: none;
		font-weight: 500;
		color: #ff9406 !important;
	}
	
	.nav-link.active > span {
		color: #ff9406;
	}
	
	.charticon {
		display: flex;
		align-items: center;
	}
	
	.home-title {
		margin-top: 16px;
		margin-bottom: 16px;
	}
	
	.home-title.hot-news {
		font-weight: 500;
		display: flex;
		align-items: center;
		color: #ff9406;
	}
	
	.hot-news span {
		color: #ff9406;
	}
	
	.home-news-date {
		font-size: 14px;
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
	
	.home-content-left .table td, .table th {
		padding: 8px 2px;
	}
	
	.home-content-left .table td, .table th {
		text-align: center;
	}
	
	.home-table-top > th {
		border-top: none !important;
	}
	
	.home-content-left .table th {
		border-top: none;
	}
	
	#countsc.table tbody+tbody {
		border-top: none !important;
	}
	
	.more {
		text-align: right;
		transition: 0.2s;
	}
	
	.more a {
		font-size: 14px;
		opacity: 0.5;
	}
	
	.more a:hover {
		opacity: 1;
	}
	
	.table-hover tr {
		transition: 0.2s;
	}
	
	.table-hover tr:hover td {
		background-color: #EAE8E6;
	}
	
	#countsc.table.table-hover tr:first-child {
		pointer-events: none;
	}

</style>

</head>
<body>
	
	<div>
	
		<div class="home-banner">
			<div class="home-banner-text">
				당신의 주식을<br/>
				맛있게! 만들어드립니다
				<p>
					CHICKEN STOCK 은 주식 투자를 맛있게 즐기고, 지식과 의견을 공유하는 토론 커뮤니티 사이트입니다. <br/>
					우리의 목표는 주식 투자를 간편하고 즐거운 경험으로 만들어 드리는 것입니다.
				</p>
			</div>
		</div>
		
		<div class="home-content-container w-75 m-auto">
		
			<!-- 종목 -->
			<div class="home-content-left w-50">
				
				<div class="home-title nav nav-tabs">
					<div id="cap" class="nav-link active w-50 text-center charticon">
						<span id="cap-charticon" class="material-symbols-rounded">leaderboard</span>
						&nbsp;&nbsp;시가총액 10위
					</div>
					<div id="count" class="nav-link w-50 text-center charticon">
						<span id="count-charticon" class="material-symbols-rounded nonView">leaderboard</span>
						&nbsp;&nbsp;거래량 10위
					</div>
				</div>
				
				<table id="capsc" class="table table-hover">
					<thead>
						<tr class="home-table-top">
							<th>N</th> <th>종목명</th> <th>현재가</th> <th>전일비</th> 
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
				
				<table id="countsc" class="table table-hover" style="display: none;">
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
			
			<!-- 뉴스 -->
			<div class="home-content-right w-50">
				<div class="home-title hot-news">
					&nbsp;&nbsp;<span class="material-symbols-rounded">breaking_news_alt_1</span>
					&nbsp;&nbsp;최신 뉴스
				</div>
				<hr/>
				
				<table class="table table-hover">
					<%
						for(int i = 0; i < newsList.size(); i++) {
							NewsDto news = newsList.get(i);
							
							if(login == null || login.getUser_id().equals("")){
								%>
								<tr>
									<td>
										<a href="login.do">
											<%=BbsUtil.titleDot(news.getTitle()) %>
										</a>
									</td>
									<td class="text-right home-news-date">
										<%=news.getPublication_date() %>
									</td>
								</tr>
								<%
							}
							else {
								%>
								<tr>
									<td>
										<a href="newsdetail.do?seq=<%=news.getSeq() %>&pageNumber=0">
											<%=BbsUtil.titleDot(news.getTitle()) %>
										</a>
									</td>
									<td class="text-right home-news-date">
										<%=news.getPublication_date() %>
									</td>
								</tr>
								<%
							}
							
						}
					%>
				</table>
				<div class="more">
					<a href="newslist.do">
						더보기 >>
					</a>
				</div>
			</div>
			
		</div>
		
	</div>
	
	<script type="text/javascript">
	
		$(document).ready(function(){
				
			$("#cap").click(function() {	
				$("#cap").addClass("active");
				$("#cap-charticon").removeClass("nonView");
				$("#count").removeClass("active");
				$("#count-charticon").addClass("nonView");
				$("#capsc").show();
				$("#countsc").hide();
			}); 
			
			$("#count").click(function() {
				$("#cap").removeClass("active");
				$("#cap-charticon").addClass("nonView");
				$("#count").addClass("active");
				$("#count-charticon").removeClass("nonView");
				$("#capsc").hide();
				$("#countsc").show();
			});
			
			let capscChild = $("#capsc").children().eq(2).children();
			
			for(let i = 14; i < capscChild.length; i++) {
				capscChild.eq(i).addClass("nonView");
			}
			
			capscChild.eq(8).addClass("nonView");
			capscChild.eq(7).addClass("nonView");
			capscChild.eq(6).addClass("nonView");
			capscChild.eq(0).addClass("nonView");
			
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
			
			countscChild.eq(9).addClass("nonView");
			countscChild.eq(8).addClass("nonView");
			countscChild.eq(7).addClass("nonView");
			countscChild.eq(1).addClass("nonView");
			
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