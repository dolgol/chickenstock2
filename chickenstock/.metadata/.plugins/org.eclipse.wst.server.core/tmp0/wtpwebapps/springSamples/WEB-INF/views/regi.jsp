<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<style type="text/css">
body{
	margin-top: 50px;
}
.log{
	margin: auto;
	height: 400px;
	width: 370px;
	border: 3px solid lightgrey;
	padding: 10px;
	padding-left: 20px;
	justify-content: center;
	flex-direction: column;
	border-radius: 5px;
	
}

#id , .pwd, .name, .email{
	display: flex;
    padding: 5px;
    border: 1px solid lightgray;
    border-radius: 10px;
    margin-left: 5px;
    
}
.pwd, .name, .email{
	margin-bottom: 17px;
	
}


</style>
</head>
<body>

<div class="log">
<form action="regiAf.do" method="post">
<table  >
	<tr>
		<h3 align="center">회원가입</h3>
	</tr>
	<tr class="id" >
		<th>ID</th>
		<td>
			<input type="text" name="id" id="id" size="20">
		</td>
		<td>&nbsp;&nbsp;
			<button type="button" id="id_chk_btn" style="font-size: 15px; margin-top: 15px;" class="btn btn-success">ID확인</button><br>
			<p id="idcheck" style="font-size: 8px"></p>
		</td>
	</tr>
	<tr>
		<th>PW</th>
		<td>
			<input type="text" name="pwd" class="pwd" size="20">
		</td>
	</tr>
	<tr>		
		<th>Name</th>
		<td>
			<input type="text" name="name"  class="name" size="20">
		</td>
	</tr>
	<tr>		
		<th>E-mail</th>
		<td>
			<input type="text" name="email" class="email" size="20">
		</td>
	</tr>
	<tr align="center">
		<td colspan="3">
			<input type="submit" name="join_btn" id="join_btn" value="회원가입" class="btn btn-success">
		</td>
	</tr>

</table>

</form>

</div>

<script type="text/javascript">
$(document).ready(function(){
	
	$("#id_chk_btn").click(function(){
		
		// id의 규칙 : 대소문자 + 특수문자 포함
		
		
		// id 글자의 갯수
		
		// id 사용할수 있는지 없는지 ajax
		$.ajax({
			url:"idcheck.do",
			type:"post",
			data:{"id": $("#id").val() },
			success:function( answer ){
				
				if(answer == "YES"){
					$("#idcheck").css("color", "#00ff00");
					$("#idcheck").text("사용할 수 있는 아이디입니다");
				}else{
					$("#idcheck").css("color", "#ff0000");
					$("#idcheck").text("사용중인 아이디입니다");
					$("#id").val("");
				}
				
			},
			error:function(){
				alert("error");
			}
			
			
		});
	});
	
});

</script>

</body>
</html>