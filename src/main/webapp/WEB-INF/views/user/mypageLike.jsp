<%@page import="ssg.com.a.dto.StocksDto"%>
<%@page import="ssg.com.a.dto.UserDto"%>
<%@page import="ssg.com.a.dto.StockLike"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	UserDto user = (UserDto)session.getAttribute("login");
	StocksDto dto = (StocksDto)session.getAttribute("symbol");
	List<StockLike> likeList = (List<StockLike>) request.getAttribute("listList");

%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHICKEN STOCK</title>
</head>
<body>
	
	<div class="mypage-right">
		<div class="mypage-right-name">
			<span class="material-symbols-outlined">account_circle</span>
			&nbsp;&nbsp;개미개미 님
		</div>
		<div>
			관심종목
		</div>
		<div>
			<table border="1">
				<thead>
					<tr>
						<th>번호</th> <th>종목 이름</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(StockLike sl:likeList) {
					%>
					<tr>
						<td>
							<%=sl.getSeq()%>
						</td>
						<td>
							<%=sl.getCompanyName()%>
						</td>
					</tr>
					<%		
						}
					%>
				</tbody>
			</table>
		</div>
	</div>

</body>
</html>