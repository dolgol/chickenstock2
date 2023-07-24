<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	
	.nonView {
		display: none;
	}
	
	.mypage-warning {
		color: red;
	}

</style>

</head>
<body>
			
	<div class="mypage-right">
		<div class="mypage-right-name">
			<span class="material-symbols-outlined">account_circle</span>
			&nbsp;&nbsp;개미개미 님
		</div>
		<div>
			내 정보 수정
		</div>
		<div>
			<form>
				<div>
					<div>아이디</div>
					<div>
						<input type="text" id="user_id" name="user_id" value="user_id.get" disabled="disabled" />
					</div>
				</div>
				<div>
					<div>이름</div>
					<div>
						<input type="text" id="user_name" name="user_name" value="user_name.get" />
					</div>
					<p id="user_name_warning" class="nonView">이름을 입력해주세요</p>
				</div>
				<div>
					<div>닉네임</div>
					<div>
						<input type="text" id="nick_name" name="nick_name" value="nick_name.get" />
					</div>
					<p id="nick_name_warning" class="nonView">닉네임을 입력해주세요</p>
				</div>
				<div>
					<div>생년월일</div>
					<div>
						<input type="date" id="birthday" name="birthday" />
					</div>
					<p id="birthday_warning" class="nonView">생년월일을 입력해주세요</p>
				</div>
				<div>
					<div>성별</div>
					<div>
						<input type="radio" name="sex" value="male" /> 남자
						<input type="radio" name="sex" value="female" /> 여자
						<input type="radio" name="sex" value="none" /> 선택안함
					</div>
					<p id="sex_warning" class="nonView">성별을 선택해주세요</p>
				</div>
				<div>
					<div>이메일</div>
					<div>
						<input type="text" id="email" name="email" value="email.get" />
					</div>
					<p id="email_warning" class="nonView">이메일을 입력해주세요</p>
				</div>
				<div>
					<div>휴대폰 번호</div>
					<div>
						<input type="text" id="phone_number" name="phone_number" value="phone_number.get" />
					</div>
					<p id="phone_number_warning" class="nonView">휴대폰 번호를 입력해주세요</p>
				</div>
				
				<input type="button" value="수정 완료" onclick="mypageEdit()" />
			</form>
		</div>
	</div>
	
	<script type="text/javascript">
	
		function mypageEdit() {
			
			console.log("mypageEdit");
			
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
				console.log("pass");
			}
		}
	
	</script>

</body>
</html>