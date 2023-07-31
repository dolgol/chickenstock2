<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- 제이쿼리 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!-- 쿠키 -->
<script src="http://lab.alexcican.com/set_cookies/cookie.js"
	type="text/javascript"></script>

<!-- 아이디 찾기 모달 기능 -->

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>


<style>

.title {
    margin-top: 100px;
    margin-left: 450px;
  }
   
  
.table {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 100%;
}

.table tr td {
  border: none;
}

.table .centerTr {
	width: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
}


.table .centerTr .idpw {
	width: 611px;
	height: 52px;
	margin-top: 23px;
	background-color: #d9d9d9;
	font-family: "Inter", Helvetica;
	font-size: 20px;
	border: none;
}

.table .centerTr .login {
	width: 300px;
	height: 53px;
	margin-top: 5px;
	background-color: #d9d9d9;
	font-family: "Inter", Helvetica;
	font-size: 20px;
	border: none;
}

.table tr td .chk_save_id {
	width: 18px;
	height: 15px;
	margin-top: 30px;
	margin-right: 8px;
	background-color: #d9d9d9;
}

.table tr td .regi, .table tr td .findIdPw {
	font-family: "Inter", Helvetica;
	font-size: 20px;
	color: #000000;
	margin-right: 5px;
	margin-left: 30px;
}

.table .centerTr .kakao {
	width: 300px;
	height: 50px;
	margin-top: 38px;
	background-color: #FEE500;
	font-family: "Inter", Helvetica;
	font-size: 20px;
    color: black;  /* 텍스트 색상 */
    border: none;  /* 버튼 테두리 제거 */
}


}
</style>

</head>
<body style="margin: 0; background: #ffffff">
	<div class="div">
		<form action="loginAf.do" method="post">
			<input type="hidden" id="anPageName" name="page" value="index" />
			<div class="container-center-horizontal">
				<div class="index screen">
					<h1 class="title">LogIn</h1>
					<table class="table">
						<tr class="centerTr">
							<td><input type="text" id="id" name="user_id"
								placeholder="아이디를 입력하세요." class="idpw"></td>
						</tr>
						<tr class="centerTr">
							<td><input type="password" id="pw" name="password" value=""
								placeholder="비밀번호를 입력하세요." class="idpw"></td>
						</tr>
						<tr>
							<td><input type="checkbox" id="chk_save_id">아이디 저장</td>
						</tr>
						<tr class="centerTr">
							<td><input type="submit" value="로그인" class="login"></td>
						</tr>
						<tr class="centerTr">
							<td>
							<a href="regi.do" class="regi">회원가입</a> 
							<a href="#" id="findId"
								class="findIdPw" data-toggle="modal" data-target="#findIdModal">아이디찾기</a>
							<a href="#" id="findPw" class="findIdPw">비밀번호 찾기</a> 
								
							</td>
						</tr>
						<tr class="centerTr">
							<td><a href="javascript:kakaoLogin();"> <input
									type="button" class="kakao" value="카카오톡 계정으로 로그인"></a></td>
						</tr>
					</table>
				</div>
			</div>
		</form>
	</div>


	<script type="text/javascript">
		let user_id = $.cookie("user_id");

		if (user_id != null) { // 저장한 id가 있을 시
			$("#id").val(user_id);
			$("#chk_save_id").prop("checked", true);
		}

		$("#chk_save_id").click(function() {
			if ($("#chk_save_id").is(":checked") == true) { // id를 cookie에 저장 
				if ($("#id").val().trim() == "") { // 빈문자열이였을 경우 
					alert("id를 입력하세요.");
					$("#chk_save_id").prop("checked", false);
					$("#id").focus();
				} else {
					// cookie에 저장
					$.cookie("user_id", $("#id").val().trim(), {
						expires : 7,
						path : "./"
					});
				}
			} else { // cookie에 저장하지 않음(삭제)
				$.removeCookie("user_id", {
					path : './'
				});
			}
		});
	</script>


	<!-- 카카오 로그인 -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script>
		window.Kakao.init("f574c677ac177912c9b1123d71c995f2");

		function kakaoLogin() {
			window.Kakao.Auth.login({
				scope : 'profile_nickname, account_email',
				success : function(authObj) {
					// 카카오 로그인 성공 시, 액세스 토큰을 서버로 전송
					var accessToken = authObj.access_token;
					$.ajax({
						url : "kakaoLogin.do",
						type : "post",
						data : {
							"access_token" : accessToken
						},
						success : function() {
							// 로그인 성공 후 메인 페이지로 이동
							window.location.href = "main.do";
						},
						error : function() {
							alert("카카오 로그인에 실패했습니다.");
						}
					});
				}
			});
		}
	</script>

	<!-- 아이디 찾기 모달 -->
	<div class="modal fade" id="findIdModal" tabindex="-1" role="dialog"
		aria-labelledby="findIdModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="findIdModalLabel">아이디 찾기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="findIdForm">
						<label for="address">이메일 주소:</label><br> <input type="text"
							id="address" name="address"><br> <label
							for="phone_number">전화번호:</label><br> <input type="text"
							id="phone_number" name="phone_number"><br>
						<br>
						<p id="userId"></p>
						<p id="errorMessage"></p>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" id="findIdSubmit" class="btn btn-primary">아이디 찾기</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
					
				</div>
			</div>
		</div>
	</div>

	<script>
	$(document).ready(function() {
	    $("#findIdSubmit").click(function(e) {
	        e.preventDefault();

	        const address = $("#address").val();
	        const phone_number = $("#phone_number").val();

	        // Require both fields to have a value
	        if (!address || !phone_number) {
	            alert('이메일 주소와 전화번호 모두를 입력해주세요.');
	            return;
	        }

	        $.ajax({
	            type : "POST",
	            url : "findId.do",
	            data : {
	                address : address,
	                phone_number : phone_number
	            },
	            success : function(data, status) {
	                console.log(data);
	                if (data.user_id) {
	                    // 수정된 부분: 모달 내부에 결과를 표시
	                    $("#findIdModal").find("#userId").text("회원정보와 일치하는 아이디 : " + data.user_id);
	                    $("#findIdModal").find("#errorMessage").text(""); // 에러 메시지 초기화
	                } else if (data.errorMessage) {
	                    $("#findIdModal").find("#userId").text(""); // 아이디 결과 초기화
	                    // 수정된 부분: 모달 내부에 에러 메시지를 표시
	                    $("#findIdModal").find("#errorMessage").text(data.errorMessage);
	                }
	            },
	            error : function(jqXHR, textStatus, errorThrown) {
	                console.error("Error:", textStatus, errorThrown);
	            }
	        });
	    });
	});

	</script>

</body>
</html>