<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>


  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>

<style type="text/css">
body{
	width: 100%;
	background: url("pexels-pixabay-258117.jpg") no-repeat center center fixed;
	background-size: cover;
}
.center{
	margin: auto;
	margin-top: 190px;
	height: 400px;
	width: 320px;
	border: 3px solid #ffffff;	
	display: flex;
	justify-content: center;
	flex-direction: column;
	border-radius: 10%;
	background-color: #f2dfd3;
	text-align: center;
}


.bodier{
            margin-top: 10px;
}



.btn{
	background-color: #1BBC9B;
            margin-bottom: 30px;
            color: white;
}

.logtxt{
	text-align: center;
	color: #404040;
}


.center > input:placeholder{
	color: #D2D2D2;
}

</style>

</head>
<body>

<div class="center">
		<h2 >로그인</h2>
	
		<form action="loginAf.do" method="post">
			<div class="bodier">
			<table class="table table-borderless">
				<tr>
					
					<td>
						<input type="text" id="id" name="id" class="id"  
						style="width:270px;height:50px;font-size:22px;border-radius:50px;border:none;
						text-align: center;margin-bottom: 10px;"  placeholder="ID">
						<br><input type="checkbox" id="chk_save_id" >&nbsp;ID저장
					</td>
				</tr>		
				<tr>
					<td>
						<input type="password"  name="pwd" class="pwd" style="width:270px;height:50px;font-size:22px;border-radius:50px;border:none;text-align: center;!important" placeholder="PASSWARD">
					</td>
				</tr>
				</div>
				<tr>
					<td colspan="2">
						<input type="submit" value="로그인" class="btn btn-success" ><br>
						<a href="regi.do">회원가입</a>
						<a href="">아이디찾기</a>
						<a href="">비밀번호찾기</a>
					</td>
				</tr>		
			</table>	
		</form>
</div>

<script type="text/javascript">
/*
 	session : server에 저장. login 정보 저장	Object
 	cookie : client에 저장.  id를 저장. pw 저장 String
 */
 
 let user_id = $.cookie("user_id");
 if(user_id != null){	//저장한 아이디가 있음
	 $("#id").val(user_id);
 	 $("#chk_save_id").prop("checked", true);	//체크박스에 체크가 되게 해준다
 }
 
 $("#chk_save_id").click(function(){
	// alert('click'); 
	
	if($("#chk_save_id").is(":checked") == true){	// id를 저장 -> cookie
		
		if($("#id").val().trim() == ""){	//빈문자열일 경우
			alert('id를 입력해 주십시오');
			$("#chk_save_id").prop("checked", false);
		}else{  // cookie 저장
			$.cookie("user_id", $("#id").val().trim(), { expires:7, path:'./' });
		}

		}else{ // cookie에 저장하지 않음(삭제)

			$.removeCookie("user_id", { path:'./' });
		}

		});

</script>

</body>

</html>