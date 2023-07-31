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
/* body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: auto;
    background-color: white;
    margin: 0;
    padding: 10px;
} */

.centerDiv {
    /* display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    max-width: 550px;
    height: auto;
    border: 0;
    background-color: white;
    margin : 0 auto; */
   	width: 25%;
   	padding: 40px 0;
}

.form-group {
    width: 100%;
    border-collapse: collapse;
    display: flex;
    flex-direction: column;
    margin-bottom: 1em;
}

.form-group > div {
    margin-bottom: 0.5em;
}

input[type="text"], input[type="password"], input[type="date"] {
    border-color: #EAE8E6 !important;
    background-color: #f0f0f0;
    width: 100%;
    font-size: 15px;
    border: 0;
    border-radius: 0.25rem;
    padding: 10px;
}

input[type="text"]:disabled {
    background-color: #EAE8E6;
}

input::placeholder {
    opacity: 0.5 !important;
    font-size: 14px;
}

input[type="radio"] {
    margin-right: 10px;
    margin-left: 10px;
    accent-color: rgb(239, 98, 16);
}

/* .form-group > div {
    margin-left: 40px;
    margin-right: 20px;
}
 */
.regi {
    color: #fff;
    border-color: #ff9406 !important;
    background-color: #ff9406;
    transition: 0.2s;
    width: 30%;  /* 이전의 width를 30%에서 80%로 변경하였습니다. */
    font-size: 15px;
    padding: 10px;
    border-radius: 0.25rem;
    margin-top: 30px;
}

.regi_wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
}

.regi:hover {
    color: #fff;
    border-color: #FF8205 !important;
    background-color: #FF8205;
}


#id_chk_btn, #nickname_chk_btn {
    background-color: #ff9406;
    color: #fff;
    border: 0;
   width: 30%;
    height: 36px;
    border-radius: 0.25rem;
    margin-left: 10px;
}

#id_chk_btn:hover, #nickname_chk_btn:hover {
    background-color: #FF8205;
}

.nonView {
    display: none;
}

.mypage-warning {
    color: red;
    font-size: 14px;
}

/* header, footer {
    width: 100%;
    box-sizing: border-box;
} */

/* .input-box {
    margin-left: 40px;
} */

.label-spacing {
    margin-top: 20px;
    display: block;
}

#user_id, #password, #chk_pw, #user_name, #nick_name,#phone_number, #birthday, #address {
	background-color :#EAE8E6;
}

.mypage-container-top {
	font-size: 32px;
	font-weight: 500;
	color: #ff9406;
	margin-bottom: 20px;
	letter-spacing: -2px !important;
}

</style>


</head>
<body>

	<div class="centerDiv m-auto">
	
	<div class="mypage-container-top">회원가입</div>
	<form action="regiAf.do" method="post">
    <div class="form-group">
        <label for="user_id" class="label-spacing">아이디*</label>
         <div style="display: flex;">
	        <input type="text" size="20" id="user_id" name="user_id" class="text" placeholder="아이디를 입력하세요.">
	        <input type="button" id="id_chk_btn" value="중복확인">
         </div>
        <p id="idcheck" style="font-size: 8px"></p>
    </div>
    <div class="form-group">
        <label for="password">비밀번호*</label>
        <div class="input-box">
        <input type="password" size="20" id="password" name="password" class="text" placeholder="비밀번호를 입력하세요.">
        </div>
    </div>
    <div class="form-group">
        <label for="chk_pw">비밀번호 확인*</label>
        <div class="input-box">
        <input type="password" size="20" id="chk_pw" name="chk_pw" class="text" placeholder="비밀번호를 재입력하세요.">
        </div>
        <p id="pwcheck" style="font-size: 10x"></p>
    </div>
    <div class="form-group">
        <label for="user_name">이름</label>
        <div class="input-box">
        <input type="text" size="20" id="user_name" name="user_name" class="text" placeholder="이름을 입력하세요">
        </div>
    </div>
    <div class="form-group">
        <label for="sex">성별</label>
        <div>
        <label><input type="radio" name="sex" value="male">남성</label>
        <label><input type="radio" name="sex" value="female">여성</label>
        </div>
    </div>
    <div class="form-group">
        <label for="nick_name">닉네임*</label>
        <div style="display: flex;">
      	 	 <input type="text" size="20" id="nick_name" name="nick_name" class="text" placeholder="닉네임을 입력하세요.">
       		 <input type="button" id="nickname_chk_btn" value="중복확인">
         </div>
        <p id="nicknamecheck" style="font-size: 10px"></p>
    </div>
    <div class="form-group">
        <label for="birthday">생년월일</label>
        <div class="input-box">
        <input type="text" size="20" id="birthday" name="birthday" placeholder="생년월일을 입력하세요." class="text">
        </div>
    </div>
    <div class="form-group">
        <label for="phone_number">휴대폰 번호</label>
        <div class="input-box">
        <input type="text" size="20" id="phone_number" name="phone_number" class="text" placeholder="휴대폰 번호를 입력하세요">
        </div>
    </div>
    <div class="form-group">
        <label for="address">이메일*</label>
        <div class="input-box">
        <input type="text" size="20" id="address" name="address" class="text" placeholder="예 : chickenstock@gamil.com">
        </div>
        <p id="addresscheck" style="font-size: 10px"></p>
    </div>
    <div class="form-group regi_wrapper">
        <input type="submit" value="가입하기" class="regi btn">
    </div>
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
	    $("#address").on("input", function(event) {
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