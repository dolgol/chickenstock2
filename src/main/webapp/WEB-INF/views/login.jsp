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
	margin-left: 480px;
	font-family: "Inter", Helvetica;
	font-size: 50px;
	color: #FF9406;
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
	width: 500px;
	height: 52px;
	margin-top: 23px;
	background-color: #d9d9d9;
	font-family: "Inter", Helvetica;
	font-size: 20px;
	border: none;
	padding: 10px; /* 패딩 추가 */
	border-radius: 0.25rem;
}

.table .centerTr .login {
	width: 200px; /* 너비를 줄입니다 */
	height: 53px;
	margin-top: 5px;
	background-color: #FF9406;
	font-size: 20px;
	border: none;
	color: white; /* 글씨 색상 */
	border-radius: 0.25rem; /* 모서리를 둥글게 만듭니다 */
	cursor: pointer;
	transition: 0.3s;
}

.table .centerTr .login:hover {
	background-color: #FF8C00; /* 버튼 호버 시 약간 어두운 주황색 */
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
	color: black;
	border: none;
	border-radius: 0.25rem;
}

.table tr td .regi, .table tr td .findIdPw {
	font-family: "Inter", Helvetica;
	font-size: 20px;
	color: #000000;
	margin-right: 5px;
	margin-left: 30px;
	transition: 0.3s; /* 애니메이션 효과 */
}

.table tr td .regi:hover, .table tr td .findIdPw:hover {
	color: #FF9406; /* 마우스를 올렸을 때의 색상 */
}

/* 아이디 찾기 모달  */

/* Modal content */
.modal-content {
	font-family: Arial, sans-serif; /* 폰트 스타일 */
	background-color: #fefefe; /* 배경색 */
	margin: 15% auto; /* 위치 조정 */
	padding: 20px; /* 패딩 */
	border: 1px solid #888; /* 테두리 */
	width: 80%; /* 너비 */
}

.modal-title {
	background-color: #FF9406; /* 배경색을 주황색으로 설정 */
	color: white; /* 글자 색을 흰색으로 설정 */
	padding: 5px; /* 내부 패딩 설정 */
	display: inline-block; /* 디스플레이 유형을 인라인 블록으로 설정 */
	width: 130px; /* 너비 설정 (원하는 크기로 조정 가능) */
	border-radius: 0.25rem; /* 둥글게 모서리를 설정 (원하는 크기로 조정 가능) */
	text-align: center; /* 가운데 정렬 추가 */
	line-height: 1.5;
}

/* Modal Header */
.modal-header {
	padding: 2px 16px;
	background-color: white; /* 변경된 배경색 */
	color: white;
}

/* Modal Body */
.modal-body {
	padding: 2px 16px;
}

/* Modal Footer */
.modal-footer {
	padding: 2px 16px;
	background-color: white; /* 변경된 배경색 */
	color: white;
}

/* The Close Button */
.close {
	color: white;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

/* Modal Input Field */
#findIdForm input {
	width: 100%; /* 너비 */
	padding: 12px; /* 패딩 */
	margin: 8px 0; /* 마진 */
	display: inline-block;
	border: 1px solid #ccc;
	box-sizing: border-box;
}
/* 이메일 주소 입력 칸 스타일 */
#findIdForm label[for="address"], #findIdForm input[type="text"]#address
	{
	margin-bottom: 5px; /* 아래 간격 조절 (원하는 크기로 조정 가능) */
	border-radius: 0.25rem;
}

/* 전화번호 입력 칸 스타일 */
#findIdForm label[for="phone_number"], #findIdForm input[type="text"]#phone_number
	{
	margin-bottom: 5px; /* 아래 간격 조절 (원하는 크기로 조정 가능) */
	border-radius: 0.25rem;
}

/* Modal Submit Button */
#findIdSubmit {
	background-color: #FF9406; /* 주황색 배경 */
	color: white; /* 텍스트는 흰색 */
	border: none; /* 테두리 제거 */
	border-radius: 0.25rem;
}

#findIdSubmit:hover {
	background-color: #FF8205; /* 마우스 오버 시 배경색 변경 */
}

/* Modal Cancel Button */
.btn.btn-secondary {
	background-color: #f44336; /* 배경색 */
}

/* 모달 배경 색상 흰색으로 설정 */
#findPwModal .modal-content {
	background-color: #FFFFFF; /* 흰색 배경 */
}

/* 비밀번호 찾기 버튼 스타일 */
#findPwSubmit {
	background-color: #FF9406; /* 주황색 배경 */
	color: white; /* 텍스트는 흰색 */
	border: none; /* 테두리 제거 */
	border-radius: 0.25rem;
}

/* 인증번호 받기 버튼 */
#getCertificationNumber, #certificationComplete {
	background-color: #ff9406; /* 기본 배경색 */
	color: white; /* 텍스트 색상 */
	padding: 5px 10px; /* 패딩 */
	margin: 8px 0; /* 마진 */
	border: none;
	cursor: pointer;
	width: 30%; /* 너비 */
	transition: background-color 0.2s; /* 색상 변경 트랜지션 */
	border-radius: 0.25rem;
	font-size: 14px;
}

#findPwSubmit:hover {
	background-color: #FF8205; /* 마우스 오버 시 배경색 변경 */
}

/* 인증번호 받기 버튼에 마우스를 올렸을 때의 스타일 */
#getCertificationNumber:hover {
	background-color: #FF8205; /* 마우스 오버 시 배경색 변경 */
}

/* 인증완료 버튼에 마우스를 올렸을 때의 스타일 */
#certificationComplete:hover {
	background-color: #FF8205; /* 마우스 오버 시 배경색 변경 */
}

/* 인증번호 받기 버튼이 클릭된 상태의 스타일 */
#getCertificationNumber:active {
	background-color: #FF8205; /* 클릭 시 배경색 변경 */
}

/* 인증완료 버튼이 클릭된 상태의 스타일 */
#certificationComplete:active {
	background-color: #FF8205; /* 클릭 시 배경색 변경 */
}

#findPwForm input[type="text"], #findPwForm input[type="password"] {
	border: 1px solid #ccc; /* 테두리를 가늘게 */
	border-radius: 0.25rem; /* 둥근 정도를 조정 */
	padding: 8px; /* 입력 필드에 여백을 줄임 */
	width: 200px; /* 원하는 너비로 조정 */
	margin-bottom: 10px; /* 입력 필드 간의 간격 조정 */
}

/* 취소 버튼 스타일 */
.btn.btn-secondary {
	background-color: #f44336; /* 배경색 */
	color: white; /* 텍스트 색상 */
	margin-right: 5px; /* 우측 간격 */ */
	border: none;
	border-radius: 0.25rem;
}

/* 취소 버튼에 마우스를 올렸을 때의 스타일 */
.btn.btn-secondary:hover {
	background-color: #e53935; /* 마우스 오버 시 배경색 변경 */
}

/* 취소 버튼이 클릭된 상태의 스타일 */
.btn.btn-secondary:active {
	background-color: #c62828; /* 클릭 시 배경색 변경 */
}

#findPwModal hr {
	display: none;
}
/* 모달 푸터의 줄 제거 */
#findPwModal .modal-footer hr {
	display: none;
}

.modal-header, .modal-body, .modal-footer {
	border: none;
}

#id {
	background-color: #eae8e6;
}

#pw {
	background-color: #eae8e6;
}

#findIdModal #address, #findIdModal #phone_number {
	background-color: #eae8e6;
}

#findPwModal #user_name, #findPwModal #user_id, #findPwModal #address2,
	#findPwModal #certification_number, #findPwModal #new_password,
	#findPwModal #new_password_confirm {
	background-color: #eae8e6;
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
							<td><a href="regi.do" class="regi">회원가입</a> <a href="#"
								id="findId" class="findIdPw" data-toggle="modal"
								data-target="#findIdModal">아이디찾기</a> <a href="#" id="findPw"
								class="findIdPw" data-toggle="modal" data-target="#findPwModal">비밀번호
									찾기</a></td>
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
							window.location.href = "home.do";
							alert("카카오 로그인되었습니다.");
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
						<label for="address">이메일</label><br> <input type="text"
							id="address" name="address"><br> <label
							for="phone_number">전화번호</label><br> <input type="text"
							id="phone_number" name="phone_number"><br> <br>
						<p id="userId"></p>
						<p id="errorMessage"></p>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" id="findIdSubmit" class="btn btn-primary">찾기</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>

				</div>
			</div>
		</div>
	</div>



	<!-- 비밀번호 찾기 모달 -->
	<div class="modal fade" id="findPwModal" tabindex="-1" role="dialog"
		aria-labelledby="findPwModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="findPwModalLabel">비밀번호 찾기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="findPwForm">
						<label for="name">이름</label><br> <input type="text"
							id="user_name" name="name"><br> <label for="user_id">아이디</label><br>
						<input type="text" id="user_id" name="user_id"><br> <label
							for="email">이메일</label><br> <input type="text" id="address2"
							name="email">
						<!-- 인증번호 받기 버튼 추가 -->
						<button type="button" id="getCertificationNumber">인증번호 받기</button>
						<br> <label for="certification_number">인증번호</label><br>
						<input type="text" id="certification_number"
							name="certification_number">
						<button type="button" id="certificationComplete">인증완료</button>
						<br> <label for="new_password">새 비밀번호</label><br> <input
							type="password" id="new_password" name="new_password"><br>
						<label for="new_password_confirm">새 비밀번호 확인</label><br> <input
							type="password" id="new_password_confirm"
							name="new_password_confirm"><br>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" id="findPwSubmit" class="btn btn-primary">변경</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>


	<!-- 아이디 찾기  -->
	<script>
		$(document)
				.ready(
						function() {
							$("#findIdSubmit")
									.click(
											function(e) {
												e.preventDefault();

												const address = $("#address")
														.val();
												const phone_number = $(
														"#phone_number").val();

												// Require both fields to have a value
												if (!address || !phone_number) {
													alert('이메일 주소와 전화번호 모두를 입력해주세요.');
													return;
												}

												$
														.ajax({
															type : "POST",
															url : "findId.do",
															data : {
																address : address,
																phone_number : phone_number
															},
															success : function(
																	data,
																	status) {
																console
																		.log(data);
																if (data.user_id) {
																	// 수정된 부분: 모달 내부에 결과를 표시
																	$(
																			"#findIdModal")
																			.find(
																					"#userId")
																			.text(
																					"회원정보와 일치하는 아이디 : "
																							+ data.user_id);
																	$(
																			"#findIdModal")
																			.find(
																					"#errorMessage")
																			.text(
																					""); // 에러 메시지 초기화
																} else if (data.errorMessage) {
																	$(
																			"#findIdModal")
																			.find(
																					"#userId")
																			.text(
																					""); // 아이디 결과 초기화
																	// 수정된 부분: 모달 내부에 에러 메시지를 표시
																	$(
																			"#findIdModal")
																			.find(
																					"#errorMessage")
																			.text(
																					data.errorMessage);
																}
															},
															error : function(
																	jqXHR,
																	textStatus,
																	errorThrown) {
																console
																		.error(
																				"Error:",
																				textStatus,
																				errorThrown);
															}
														});
											});
						});
	</script>

	<!--  비밀번호 찾기 -->
	<script>
		$(document).ready(function() {
			var isCertified = false; // 인증이 완료되었는지 확인하는 변수

			$("#getCertificationNumber").click(function(e) {
				e.preventDefault();

				const user_name = $("#user_name").val();
				const user_id = $("#user_id").val();
				const address = $("#address2").val();

				$.ajax({
					type : "POST",
					url : "findPw.do",
					contentType : "application/json",
					data : JSON.stringify({
						user_name : user_name,
						user_id : user_id,
						address : address
					}),
					success : function(data) {
						if (data.success) {
							alert(data.message);
						} else {
							alert(data.message);
						}
					},
					error : function() {
						alert('Error while sending verification code.');
					}
				});
			});

			$("#certificationComplete").click(function(e) {
				e.preventDefault();

				const certification_number = $("#certification_number").val();

				$.ajax({
					type : "POST",
					url : "verifyCode.do",
					contentType : "application/json",
					data : JSON.stringify({
						verificationCode : certification_number
					}),
					success : function(data) {
						if (data.success) {
							alert(data.message);
							isCertified = true;
						} else {
							alert(data.message);
						}
					},
					error : function() {
						alert('Error during verification.');
					}
				});
			});

			$("#findPwSubmit").click(function(e) {
				e.preventDefault();

				if (!isCertified) {
					alert('이메일 인증을 해주세요.');
					return;
				}

				const new_password = $("#new_password").val();
				const new_password_confirm = $("#new_password_confirm").val();

				if (new_password !== new_password_confirm) {
					alert('비밀번호가 다릅니다.');
					return;
				}

				$.ajax({
					type : "POST",
					url : "resetPassword.do",
					contentType : "application/json",
					data : JSON.stringify({
						newPassword : new_password
					}),
					success : function(data) {
						if (data.success) {
							alert(data.message);
							$("#findPwModal").modal("hide");
						} else {
							alert(data.message);
						}
					},
					error : function() {
						alert('Error while resetting password.');
					}
				});
			});
		});
	</script>


</body>
</html>