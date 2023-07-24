<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<html>
<head>
<style type="text/css">
.home {
	background: #224941 url('./images/back1.png') no-repeat center center/cover;
  	color: #fff;
	font-family: 'Montserrat', sans-serif;	
	overflow: hidden;  
  	height: 800px;
  	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0;
	text-align: right;
}
</style>
</head>
<body>

<div class="home">
	<div class="container">		
		<h1 style="font-size: 300%">Landing Home Page</h1><br>		
		<p>
        Lorem ipsum dolor sit amet, consectetur adipisicing elit. Tenetur, amet!
      	</p><br><br>

      	<button type="button" id="sign" class="btn btn-secondary btn-lg">Sign Up</button>
	</div>
</div>

<script type="text/javascript">
$("#sign").click(function(){
	location.href = "login.do";
});
</script>


</body>
</html>

 

