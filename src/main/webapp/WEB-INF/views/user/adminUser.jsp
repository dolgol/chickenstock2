<%@page import="ssg.com.a.dto.UserDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	
	List<UserDto> userList = (List<UserDto>)request.getAttribute("userList");
	
	int pageBbs = (Integer)request.getAttribute("pageBbs");
	int pageNumber = (Integer)request.getAttribute("pageNumber");
	
	System.out.println(pageNumber);
	
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHICKEN STOCK</title>

<script type="text/javascript" src="jquery/jquery.twbsPagination.min.js"></script>

</head>
<body>
	
	<div>회원 관리</div>
	
	<div>
		<form>
			<table border="1" id="newsTable">
				<thead>
					<tr>
						<!-- <th>
							<input type="checkbox" id="userAll" name="user" onclick='userAllChecked(event)' />
						</th> -->
						<th>번호</th> 
						<th>아이디</th> 
						<th>이름</th> 
						<th>닉네임</th>
						<th>성별</th>
						<th>생년월일</th>
						<th>휴대폰 번호</th>
						<th>이메일</th>
					</tr>
				</thead>
				<tbody>
						<%
							if(userList == null || userList.size() == 0) {
								%>
								<tr>
									<td colspan="4">
										유저 없음
									</td>
								</tr>
								<%
							}
							else {
								for(int i = 0; i < userList.size(); i++) {
									
									UserDto user = userList.get(i);
									%>
									<tr>
										<%-- <td>
											<input type="checkbox" name="user" class="userOne" value="<%=user.getUser_id() %>">
										</td> --%>
										<td>
											<%=(i + 1) %>
										</td>
										<td>
											<%=user.getUser_id() %>
										</td>
										<td>
											<%=user.getUser_name() %>
										</td>
										<td>
											<%=user.getNick_name() %>
										</td>
										<% 
										if(user.getSex().equals("female")) {
											%>
											<td>여</td>
											<%
										}
										else {
											%>
											<td>남</td>
											<%
										}
										%>
										<td>
											<%=user.getBirthday() %>
										</td>
										<td>
											<%=user.getPhone_number() %>
										</td>
										<td>
											<%=user.getAddress() %>
										</td>
									</tr>
									<%
								}
							}
						%>
				</tbody>
			</table>
			
			<!-- <input type="button" value="삭제" onclick="userSelectDelete()" /> -->
		</form>
		
		<div class="container">
			<nav aria-label="Page navigation">
				<ul class="pagination" id="pagination" style="justify-content: center;"></ul>
			</nav>
		</div>
		
	</div>
	
	
	<script type="text/javascript">
	
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
				location.href = "adminuser.do?pageNumber=" + (page - 1);
			}
		});
	
	<%--
		$(document).ready(function() {
			
			let userList = $(".userOne");
			
			$(".userOne").change(function() {
				
				let isAllChecked = true;
				
				for(let i = 0; i < userList.length; i++) {
					if(userList[i].checked == false) {
						isAllChecked = false;
						break;
					}
				}
				
				if(isAllChecked) {
					$("#userAll").prop("checked", true);
				}
				else {
					$("#userAll").prop("checked", false);
				}
				
			});
			
		});

		function userAllChecked(event) {
			
			if(event.target.checked) {
				$('input[name="user"]').prop("checked", true);
			}
			else {
				$('input[name="user"]').prop("checked", false);
			}
		}
		
		function userSelectDelete() {
			
			let userOneList = $(".userOne");
			let deleteList = [];
			
			for(let i = 0; i < userOneList.length; i++) {
				if(userOneList[i].checked) {
					deleteList.push(userOneList[i].value);
				}
			}
			console.log("deleteList >> ", deleteList);
			
			if(deleteList.length == 0) {
				return;
			}
			
			let deleteConfirm = confirm("선택한 회원을 삭제하시겠습니까?");
			
			if(deleteConfirm) {
				console.log("확인 클릭");
				$.ajax({
					url: "adminuserDel.do",
					type: "get",
					data: { "deleteList": deleteList },
					success: function(response) {
						alert("success");
						if(response == "true") {
							alert("정상 삭제 성공");
							location.href = "adminuser.do";
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
		--%>
			
	</script>

</body>
</html>