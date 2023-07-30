<%@page import="ssg.com.a.dto.MypageStocksComment"%>
<%@page import="ssg.com.a.dto.MypageParam"%>
<%@page import="util.BbsUtil"%>
<%@page import="ssg.com.a.dto.MypageNewsComment"%>
<%@page import="ssg.com.a.dto.NewsComment"%>
<%@page import="java.util.List"%>
<%@page import="ssg.com.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	List<MypageStocksComment> mypageStocksCommentList = (List<MypageStocksComment>)request.getAttribute("mypageStocksCommentList");
	
	int pageBbs = (Integer)request.getAttribute("pageBbs");
	
	MypageParam param = (MypageParam)request.getAttribute("param");
	int pageNumber = param.getPageNumber();
	
	System.out.println(pageNumber);
	
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHICKEN STOCK</title>

<script type="text/javascript" src="jquery/jquery.twbsPagination.min.js"></script>

<style>
	
	.nonView {
		display: none;
	}

</style>

</head>
<body>

	<div>
		내가 쓴 댓글
	</div>
	<div>
		<form>
			<!-- <input type="button" value="뉴스게시판" /> <input type="button" value="종목게시판" /> -->
			<a href="mypageComment.do">뉴스게시판</a>
			<a href="mypageStocksComment.do">종목게시판</a>
			
			<!-- 뉴스게시판 -->
			<table border="1" id="newsTable">
				<thead>
					<tr>
						<th>
							<input type="checkbox" id="commentAll" name="comment" onclick='commentAllChecked(event)' />
						</th>
						<th>번호</th> 
						<th>내용</th> 
						<th>댓글 작성일</th> 
					</tr>
				</thead>
				<tbody>
					<!-- 댓글 유무 분기 처리, ... 처리, 페이징 처리 -->
						<%
							if(mypageStocksCommentList == null || mypageStocksCommentList.size() == 0) {
								%>
								<tr>
									<td colspan="4">
										<span class="material-symbols-rounded">rate_review</span><br/>
										아직 작성한 댓글이 없습니다<br/>
										<a href="stockMain.do">종목게시판 바로가기 >></a>
									</td>
								</tr>
								<%
							}
							else {
								for(int i = 0; i < mypageStocksCommentList.size(); i++) {
									MypageStocksComment comment = mypageStocksCommentList.get(i);
									
									if(comment.getDel() == 0) {
										%>
										<tr>
											<td>
												<input type="checkbox" name="comment" class="commentOne" value="<%=comment.getScseq() %>">
											</td>
											<td>
												<%=(i + 1) %>
											</td>
											<td>
												<div>
													<a href="stocksdetail.do?symbol=<%=comment.getSymbol() %>">
														<%=BbsUtil.titleDot(comment.getContent()) %>
													</a>
												</div>
												<div>
													<a href="stocksdetail.do?symbol=<%=comment.getSymbol() %>">
														<%=BbsUtil.titleDot(comment.getSymbol()) %>&nbsp;&nbsp;
														<%=BbsUtil.titleDot(comment.getMarket()) %>&nbsp;&nbsp;
														<%=BbsUtil.titleDot(comment.getName()) %>
													</a>
												</div>
											</td>
											<td>
												<%=comment.getWrite_date().substring(0, 10) %>
											</td>
										</tr>
										<%
									}
								}
							}
						%>
				</tbody>
			</table>
			
			<%
				if(mypageStocksCommentList.size() != 0) {
					%>
					<input type="button" value="삭제" onclick="commentSelectDelete()" />
					<%
				}
			%>
		</form>
		
		<div class="container">
			<nav aria-label="Page navigation">
				<ul class="pagination" id="pagination" style="justify-content: center;"></ul>
			</nav>
		</div>
		
	</div>
	
	<script type="text/javascript">
	
		$(document).ready(function() {
			
			let commentList = $(".commentOne");
			
			$(".commentOne").change(function() {
				
				let isAllChecked = true;
				
				for(let i = 0; i < commentList.length; i++) {
					if(commentList[i].checked == false) {
						isAllChecked = false;
						break;
					}
				}
				
				if(isAllChecked) {
					$("#commentAll").prop("checked", true);
				}
				else {
					$("#commentAll").prop("checked", false);
				}
				
			});
			
		});

		function commentAllChecked(event) {
			
			if(event.target.checked) {
				$('input[name="comment"]').prop("checked", true);
			}
			else {
				$('input[name="comment"]').prop("checked", false);
			}
		}
		
		function commentSelectDelete() {
			
			let commentOneList = $(".commentOne");
			let deleteList = [];
			
			for(let i = 0; i < commentOneList.length; i++) {
				if(commentOneList[i].checked) {
					deleteList.push(commentOneList[i].value);
				}
			}
			console.log("deleteList >> ", deleteList);
			
			if(deleteList.length == 0) {
				return;
			}
			
			let deleteConfirm = confirm("선택한 댓글을 삭제하시겠습니까?");
			
			if(deleteConfirm) {
				console.log("확인 클릭");
				$.ajax({
					url: "mypageStocksCommentDel.do",
					type: "get",
					data: { "deleteList": deleteList },
					success: function(response) {
						alert("success");
						if(response == "true") {
							alert("정상 삭제 성공");
							location.href = "mypageStocksComment.do";
						}
						else {
							alert("정상 삭제 실패");
						}
					},
					error: function() {
						alert("error");
					}
				});
			}
			else {
				console.log("취소 클릭");
			}
		}
		
		<!-- pagination -->
		$("#pagination").twbsPagination({
			startPage : <%=pageNumber + 1 %>,
			totalPages : <%=pageBbs %>,
			visiblePages : 10,
			first : '<span srid-hidden="true">«</span>',
			prev : "이전",
			next : "다음",
			last : '<span srid-hidden="true">»</span>',
			initiateStartPageClick: false,
			onPageClick: function(event, page) {
				location.href = "mypageStocksComment.do?pageNumber=" + (page - 1);
			}
		});
			
	</script>

</body>
</html>