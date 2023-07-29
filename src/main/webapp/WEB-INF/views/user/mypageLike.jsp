<%@page import="ssg.com.a.dto.StocksDto"%>
<<<<<<< HEAD
<%@page import="ssg.com.a.dto.UserDto"%>
<%@page import="ssg.com.a.dto.StockLike"%>
<%@page import="java.util.List"%>
=======
<%@page import="java.util.List"%>
<%@page import="ssg.com.a.dto.UserDto"%>
>>>>>>> 466dfac7fecc27983dd6a11bef06efd9172e5c4e
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
<<<<<<< HEAD

	UserDto user = (UserDto)session.getAttribute("login");
	StocksDto dto = (StocksDto)session.getAttribute("symbol");
	List<StockLike> likeList = (List<StockLike>) request.getAttribute("listList");

=======
	List<StocksDto> mypageLikeList = (List<StocksDto>)request.getAttribute("mypageLikeList");
	System.out.println("mypageLikeList >> " + mypageLikeList.get(0));
>>>>>>> 466dfac7fecc27983dd6a11bef06efd9172e5c4e
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHICKEN STOCK</title>
</head>
<body>
<<<<<<< HEAD
	
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
=======
>>>>>>> 466dfac7fecc27983dd6a11bef06efd9172e5c4e

	<div>
		관심종목
	</div>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>번호</th> <th>종목명</th> <th>현재가</th> 
					<th>전일비</th> <th>등락률</th> <th>거래량</th> 
					<th>거래대금</th> <th>매수호가</th> <th>매도호가</th> 
					<th>시가총액</th> <th>PER</th> <th>ROE</th>
				</tr>
			</thead>
			<tbody>
				<%
					if(mypageLikeList == null || mypageLikeList.size() == 0) {
						%>
						<tr>
							<td colspan="12">
								아직 관심 종목에 항목이 없습니다.
								종목 게시판 바로가기 >>
							</td>
						</tr>
						<%
					}
					else {
						for(int i = 0; i < mypageLikeList.size(); i++){
							StocksDto dto = mypageLikeList.get(i);
							%>
							<tr>
								<td>
									<%=(i + 1) %>
								</td>
								<td>
									<a href="#"><%=dto.getName() %></a>
								</td>
								<td>
									<%=dto.getSector() %>
								</td>
							</tr>
							<%
						}
					}
				%>
			</tbody>
		</table>
	</div>
		
</body>
</html>