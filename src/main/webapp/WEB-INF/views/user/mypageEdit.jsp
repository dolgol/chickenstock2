<%@page import="ssg.com.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	UserDto user = (UserDto)request.getAttribute("userDto");
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHICKEN STOCK</title>

<style>
	
	.nonView {
		display: none;
	}
	
	.mypage-warning {
		color: red;
		font-size: 14px;
	}
	
	input {
		border-color: #EAE8E6 !important;
	}
	
	input[type="text"]:disabled {
	  	background-color: #EAE8E6;
	}
	
	input::placeholder {
	    opacity: 0.5 !important;
	    font-size: 14px;
	}
	
	.mypage-gender input {
		accent-color: rgb(239, 98, 16);
	}
	
	.mypage-gender > div {
		margin-left: 40px;
		margin-right: 20px;
	}
	
	.mypage-edit-btn {
		color: #fff;
		border-color: #ff9406 !important;
		background-color: #ff9406;
		transition: 0.2s;
	}
	
	.mypage-edit-btn:hover {
		color: #fff;
		border-color: #FF8205 !important;
		background-color: #FF8205;
	}

</style>

</head>
<body>

	<div>
		<form id="frm" method="post" class="w-50 m-auto">
			<div class="mb-4">
				<div class="mb-2">아이디</div>
				<div>
					<input type="text" id="user_id" name="user_id" value="<%=user.getUser_id() %>" disabled="disabled" class="form-control" />
					<input type="hidden" name="user_id" value="<%=user.getUser_id() %>" />
				</div>
			</div>
			<div class="mb-4">
				<div class="mb-2">닉네임</div>
				<div>
					<input type="text" id="nick_name" name="nick_name" 
							value="<%=user.getNick_name() == null ? "" : user.getNick_name() %>" 
							class="form-control" disabled="disabled" />
				</div>
				<p id="nick_name_warning" class="nonView">&nbsp;&nbsp;닉네임을 입력해주세요</p>
			</div>
			<div class="mb-4">
				<div class="mb-2">이름</div>
				<div>
					<input type="text" id="user_name" name="user_name" 
							value="<%=user.getUser_name() == null ? "" : user.getUser_name() %>" 
							class="form-control" />
				</div>
				<p id="user_name_warning" class="nonView">&nbsp;&nbsp;이름을 입력해주세요</p>
			</div>
			<div class="mb-4">
				<div class="mb-2">생년월일</div>
				<div>
					<input type="date" id="birthday" name="birthday" value="<%=user.getBirthday() %>" class="form-control" />
				</div>
				<p id="birthday_warning" class="nonView">&nbsp;&nbsp;생년월일을 입력해주세요</p>
			</div>
			<div class="mb-4">
				<div class="mb-2">성별</div>
				<div class="m-auto d-flex mypage-gender">
					<div>
						<input type="radio" id="male" name="sex" value="male" /> 남성
					</div>
					<div>
						<input type="radio" id="female" name="sex" value="female" /> 여성
					</div>
				</div>
				<p id="sex_warning" class="nonView">&nbsp;&nbsp;성별을 선택해주세요</p>
			</div>
			<div class="mb-4">
				<div class="mb-2">이메일</div>
				<div>
					<input type="text" id="email" name="address" value="<%=user.getAddress() %>" class="form-control" placeholder="예) chickenstock@kdt.com" />
				</div>
				<p id="email_warning" class="nonView">&nbsp;&nbsp;이메일을 입력해주세요</p>
			</div>
			<div class="mb-4">
				<div class="mb-2">휴대폰 번호</div>
				<div>
					<%-- <input type="text" id="phone_number" name="phone_number" value="<%=user.getPhone_number() %>" class="form-control" placeholder="010-2023-0801" /> --%>
					<input type="text" id="phone_number" name="phone_number" 
							value="<%=(user.getPhone_number() == null || user.getPhone_number().equals("")) ? "" : user.getPhone_number() %>" class="form-control" 
							placeholder="예) 010-2023-0801" />
				</div>
				<p id="phone_number_warning" class="nonView">&nbsp;&nbsp;휴대폰 번호를 입력해주세요</p>
			</div>
			
			<div class="text-center">
				<br/>
				<input type="button" value="수정 완료" onclick="mypageEdit()" class="btn mypage-edit-btn" />
			</div>
		</form>
	</div>
	
	<script type="text/javascript">
	
		$(document).ready(function() {
			
			if("<%=user.getSex() %>" == "male") {
				$("#male").prop("checked", true);
			}
			else if("<%=user.getSex() %>" == "female") {
				$("#female").prop("checked", true);
			}
		});
	
		function mypageEdit() {
			
			let sexList = $('input[name="sex"]');
			let sex = "";
			for(let i = 0; i < sexList.length; i++) {
				if(sexList[i].checked) {
					sex = sexList[i].value;
				}
			}
			
			let isAllPass = true;
			
			if($("#user_name").val().trim() == "") {
				$("#user_name_warning").removeClass("nonView");
				$("#user_name_warning").addClass("mypage-warning");
				isAllPass = false;
			} else {
				$("#user_name_warning").removeClass("mypage-warning");
				$("#user_name_warning").addClass("nonView");
			}
			
			if($("#nick_name").val().trim() == "") {
				$("#nick_name_warning").removeClass("nonView");
				$("#nick_name_warning").addClass("mypage-warning");
				isAllPass = false;
			} else {
				$("#nick_name_warning").removeClass("mypage-warning");
				$("#nick_name_warning").addClass("nonView");
			}
			
			if($("#birthday").val().trim() == "") {
				$("#birthday_warning").removeClass("nonView");
				$("#birthday_warning").addClass("mypage-warning");
				isAllPass = false;
			} else {
				$("#birthday_warning").removeClass("mypage-warning");
				$("#birthday_warning").addClass("nonView");
			}
			
			if(sex == "") {
				$("#sex_warning").removeClass("nonView");
				$("#sex_warning").addClass("mypage-warning");
				isAllPass = false;
			} else {
				$("#sex_warning").removeClass("mypage-warning");
				$("#sex_warning").addClass("nonView");
			}
			
			if($("#email").val().trim() == "") {
				$("#email_warning").removeClass("nonView");
				$("#email_warning").addClass("mypage-warning");
				isAllPass = false;
			} else {
				$("#email_warning").removeClass("mypage-warning");
				$("#email_warning").addClass("nonView");
			}
			
			if($("#phone_number").val().trim() == "") {
				$("#phone_number_warning").removeClass("nonView");
				$("#phone_number_warning").addClass("mypage-warning");
				isAllPass = false;
			} else {
				$("#phone_number_warning").removeClass("mypage-warning");
				$("#phone_number_warning").addClass("nonView");
			}
			
			if(isAllPass) {
				/* alert("pass"); */
				console.log("pass");
				
				// confirm
				
				$("#frm").attr("action", "mypageEditAf.do").submit();
			}
		}
	
	</script>

</body>
</html>