<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="mypage-right">
		<div class="mypage-right-name">
			<span class="material-symbols-outlined">account_circle</span>
			&nbsp;&nbsp;개미개미 님
		</div>
		<div>
			내가 쓴 댓글
		</div>
		<div>
			<form>
				<input type="button" value="삭제" onclick="commentSelectDelete()" />
				<table border="1">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="commentAll" name="comment" onclick='commentAllChecked(event)' />
							</th>
							<th>번호</th> 
							<th>내용</th> 
							<th>댓글 작성일</th> 
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<!-- 분기 처리 -->
						<tr>
							<td>
								<input type="checkbox" name="comment" class="commentOne" value="seq1">
							</td>
							<td>
								1
							</td>
							<td>
								<div>
									<a href="#">
										댓글내용
									</a>
								</div>
								<div>
									<a href="#">
										뉴스 제목 or 종목 이름
									</a>
								</div>
							</td>
							<td>
								2023.07.20
							</td>
							<td>
								<input type="button" value="하나삭제" />
							</td>
						</tr>
						<tr>
							<td>
								<input type="checkbox" name="comment" class="commentOne" value="seq2">
							</td>
							<td>
								2
							</td>
							<td>
								<div>
									<a href="#">
										그냥 일들이나 하고 있거라따라다니면서 보채지 말고.
									</a>
								</div>
								<div>
									<a href="#">
										뉴스 제목 or 종목 이름
									</a>
								</div>
							</td>
							<td>
								2023.07.20
							</td>
							<td>
								<input type="button" value="하나삭제" />
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			
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
			console.log(deleteList);
			
			let deleteConfirm = confirm("선택한 댓글을 삭제하시겠습니까?");
			
			if(deleteConfirm) {
				console.log("확인 클릭");
			}
			else {
				console.log("취소 클릭");
			}
			
		}
			
	</script>

</body>
</html>