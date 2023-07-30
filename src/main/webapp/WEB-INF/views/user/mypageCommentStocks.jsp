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
	
	input[type="checkbox"] {
		accent-color: rgb(239, 98, 16);
	}
	
	.nav-link.active {
		border-color: #EAE8E6 !important;
		border-bottom: none;
	}
	
	.nav-link:hover {
		border-color: #EAE8E6 !important;
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
	
	.mypage-comment-title > a {
		font-size: 14px;
		opacity: 0.5;
	}
	
	.mypage-no-comment {
		padding: 60px 0 !important;
	}
	
	.mypage-no-comment .material-symbols-rounded {
		font-size: 500%;
	}
	
	.mypage-no-comment a {
		font-size: 14px;
		opacity: 0.5;
	}
	
	.mypage-no-comment a:hover {
		opacity: 1;
	}
	
	.mypage-comment-title > a:hover {
		opacity: 1;
	}
	
	.mypage-delete {
		border: solid 1px #EAE8E6;
		transition: 0.2s;
	}
	
	.mypage-delete:hover {
		color: #fff;
		border-color: #ff9406;
		background-color: #ff9406;
	}
	
	.page-item.disabled .page-link {
		border-color: #EAE8E6;
	}
	
	.page-item.active .page-link {
		background-color: #ff9406;
	    border-color: #ff9406;
	}
	
	.page-link  {
		color: #4E4E4E;
	}
	
	.page-link:hover  {
		color: #4E4E4E;
		background-color: #EAE8E6;
	}
 	
</style>

</head>
<body>

	<div>
		<form>
			<div class="nav nav-tabs">
				<a href="mypageComment.do" class="nav-link w-50 text-center">뉴스게시판</a>
				<a href="mypageStocksComment.do" class="nav-link active w-50 text-center">종목게시판</a>
			</div>
			<br/>
			
			<!-- 종목게시판 -->
			<table id="newsTable" class="w-100 text-center table">
				<thead>
					<tr>
						<th style="border-top: none;">
							<input type="checkbox" id="commentAll" name="comment" onclick='commentAllChecked(event)' />
						</th>
						<th style="border-top: none;">번호</th> 
						<th style="border-top: none;">내용</th> 
						<th style="border-top: none;">댓글 작성일</th> 
					</tr>
				</thead>
				<tbody>
					<!-- 댓글 유무 분기 처리, ... 처리, 페이징 처리 -->
						<%
							if(mypageStocksCommentList == null || mypageStocksCommentList.size() == 0) {
								%>
								<tr>
									<td colspan="4" class="mypage-no-comment">
										<br/>
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
									
									int symbolNum = Integer.parseInt(comment.getSymbol());
									String symbol = String.format("%06d", symbolNum);
									
									if(comment.getDel() == 0) {
										%>
										<tr>
											<td class="align-middle">
												<input type="checkbox" name="comment" class="commentOne" value="<%=comment.getScseq() %>">
											</td>
											<td class="align-middle">
												<%=(i + 1) %>
											</td>
											<td class="text-left align-middle">
												<div>
													<a href="stocksdetail.do?symbol=<%=symbol %>">
														<%=BbsUtil.titleDot(comment.getContent()) %>
													</a>
												</div>
												<div class="mypage-comment-title">
													<a href="stocksdetail.do?symbol=<%=symbol %>">
														<%=BbsUtil.titleDot(comment.getSymbol()) %>&nbsp;&nbsp;
														<%=BbsUtil.titleDot(comment.getMarket()) %>&nbsp;&nbsp;
														<%=BbsUtil.titleDot(comment.getName()) %>
													</a>
												</div>
											</td>
											<td class="align-middle">
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
					<input type="button" value="삭제" onclick="commentSelectDelete()" class="btn mypage-delete" /><br/><br/>
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
						console.log("success");
						if(response == "true") {
							console.log("정상 삭제 성공");
							location.href = "mypageStocksComment.do";
						}
						else {
							console.log("정상 삭제 실패");
						}
					},
					error: function() {
						console.log("error");
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