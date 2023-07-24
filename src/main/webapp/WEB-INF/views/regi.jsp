<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>


<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	background-color: white;
	margin: 0;
}

.div {
	width: 550px;
	height: 700px;
	border: 0;
	background-color: white;
}

.centerTr {
	display: flex;
	justify-content: center;
}

#idTr {
	margin-left: 70px;
}

/* 추가 */
th, td {
	text-align: left; /* 텍스트를 왼쪽으로 정렬 */
}

th { //
	display: flex; //
	align-items: center;
	float: left;
	background-color: white;
	width: 120px;
	height: 48px;
	font-size: 15px;
	padding-left: 5px;
	margin-bottom: 10px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

.text {
	width: 250px;
	height: 47px;
	background-color: #f0f0f0;
	font-size: 15px;
	border: 0;
}

.logo {
	display: block;
	margin: 0 auto;
	width: 540px;
	height: 180px;
	margin-bottom: 30px;
}

#id_chk_btn {
	background-color: white;
	width: 65px;
	height: 50px;
	border: 0;
}

#nickname_chk_btn {
	background-color: white;
	width: 65px;
	height: 50px;
	border: 0;
}

.regi {
	width: 385px;
	height: 45px;
	background-color: black;
	color: white;
	margin-top: 30px;
	font-size: 24px;
}

.table-container {
	margin-top: 100px;
} /* 필요에 따라 값을 조정하세요 */

/* 성별 입력 필드에 대한 스타일 */
input[type="radio"] {
	margin-right: 10px;
}

</style>

</head>
<body>
	<div class="table-container">
		<table>
			<!-- 테이블 내용은 여기에 들어갑니다 -->
		</table>
	</div>
	<div class="div">
		<form action="regiAf.do" method="post">
			<table>

				<tr id="idTr" class="centerTr">
					<th>아이디*</th>
					<td><input type="text" size="20" id="user_id" name="user_id"
						class="text" placeholder="아이디를 입력하세요."> <input
						type="button" id="id_chk_btn" value="중복확인"> <br>
						<p id="idcheck" style="font-size: 8px"></p></td>

				</tr>
				<tr class="centerTr">
					<th>비밀번호*</th>
					<td><input type="password" size="20" id="password" name="password"
						class="text" placeholder="비밀번호를 입력하세요."></td>
				</tr>
				<tr class="centerTr">
					<th>비밀번호 확인*</th>
					<td><input type="password" size="20" id="chk_pw" name="chk_pw"
						class="text" placeholder="비밀번호를 재입력하세요."> <br>
						<p id="pwcheck" style="font-size: 8px"></p></td>
				</tr>
				<tr class="centerTr">
					<th>이름</th>
					<td><input type="text" size="20" id="user_name" name="user_name"
						class="text" placeholder="이름을 입력하세요"></td>
				</tr>

				<tr class="centerTr">
					<th>성별</th>
					<td><label><input type="radio" name="sex" value="male">남성</label>
						<label><input type="radio" name="sex" value="female">여성</label></td>
				</tr>

				<tr class="centerTr">
					<th>닉네임*</th>
					<td><input type="text" size="20" id="nick_name"
						name="nick_name" class="text" placeholder="닉네임을 입력하세요."> <input
						type="button" id="nickname_chk_btn" value="중복확인"> <br>
						<p id="nicknamecheck" style="font-size: 8px"></p></td>
				</tr>

				<tr class="centerTr">
					<th>생년월일*</th>
					<td><input type="text" size="20" id="birthday" name="birthday"
						placeholder="생년월일을 입력하세요." class="text"></td>
				</tr>


				<tr class="centerTr">
					<th>휴대폰 번호</th>
					<td><input type="text" size="20" id="phone_number"
						name="phone_number" class="text" placeholder="휴대폰 번호를 입력하세요"></td>
				</tr>

				<tr class="centerTr">
					<th>이메일</th>
					<td><input type="text" size="20" id="address" name="address"
						class="text" placeholder="예 : chickenstock@gamil.com"> <br>
						<p id="addresscheck" style="font-size: 8px"></p></td>
				</tr>
				<tr class="centerTr">
					<td colspan="2"><input type="submit" value="가입하기" class="regi">
					</td>
				</tr>
			</table>
		</form>
	</div>

	<script>
	$(document).ready(function() { // 중복확인
	    $("#id_chk_btn").click(function() {
	        $.ajax({
	            url : "idcheck.do",
	            type : "post",
	            data : { "user_id" : $("#user_id").val() },
	            success : function(answer) {
	// 빈칸일때 중복확인 눌리는 경우 
	/* 안해도 나옴
	if( $("#id").val().trim()=="" ){
	$("#idcheck").css("color", "#ff0000")
	;$("#idcheck").text("사용할 수 없는 아이디입니다!!!!!")
	;$("#id").focus();}*/
	                if (answer == "YES") {
	                    $("#idcheck").css("color", "#0000ff");
	                    $("#idcheck").text("사용할 수 있는 아이디입니다.");
	                } else {
	                    $("#idcheck").css("color", "#ff0000");
	                    $("#idcheck").text("사용할 수 없는 아이디입니다.");
	                    $("#user_id").val("");
	                }
	            },
	            error : function() {
	                alert("error");
	            }
	        });
	    });
	});

	// 비밀번호 확인
	$("form").submit(function(event) {
	    var pw = $("#password").val().trim();
	    var chkPw = $("#chk_pw").val().trim();

	    if (pw !== chkPw) {
	        event.preventDefault(); // 폼 제출을 막음
	        $("#pwcheck").css("color", "#ff0000");
	        $("#pwcheck").text("비밀번호가 일치하지 않습니다.");
	        $("#password").focus();
	    }
	});

	$(document).ready(function() {
	    // 닉네임 중복확인
	    $("#nickname_chk_btn").click(function() {
	    	// 입력값 확인을 위한 콘솔 출력
	        console.log($("#nick_name").val());
	        $.ajax({
	            url : "nicknamecheck.do",
	            type : "post",
	            data : { "nick_name" : $("#nick_name").val() },
	            success : function(answer) {
	                if (answer == "YES") {
	                    $("#nicknamecheck").css("color", "#0000ff");
	                    $("#nicknamecheck").text("사용할 수 있는 닉네임입니다.");
	                } else {
	                    $("#nicknamecheck").css("color", "#ff0000");
	                    $("#nicknamecheck").text("사용할 수 없는 닉네임입니다.");
	                    $("#nick_name").val("");
	                }
	            },
	            error : function() {
	                alert("error");
	            }
	        });
	    });

	    // 이메일 형식 확인
	    $("#address").on("input", function() {
	        var address = $("#address").val().trim();
	        var addressPattern = /^[a-zA-Z0-9]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

	        if (!addressPattern.test(address)) {
	            event.preventDefault(); // 폼 제출을 막음
	            $("#addresscheck").css("color", "#ff0000");
	            $("#addresscheck").text("유효하지 않은 이메일 형식입니다.");
	        } else {
	            $("#addresscheck").css("color", "#0000ff");
	            $("#addresscheck").text("올바른 이메일 형식입니다.");
	        }
	    });
	});

	</script>
</body>
</html>