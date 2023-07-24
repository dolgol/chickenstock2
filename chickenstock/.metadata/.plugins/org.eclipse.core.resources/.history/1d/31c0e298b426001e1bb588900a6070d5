<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">
.divider:after,
.divider:before {
	content: "";
	flex: 1;
	height: 1px;
	background: #eee;
}
.h-custom {
	height: calc(100% - 73px);
}
@media (max-width: 450px) {
	.h-custom {
		height: 100%;
	}
}
.sec-100{
	height: 500px;
}
</style>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
</head>
<body>
<br><br>
<div class="center">
<section class="sec-100">
  <div class="container-fluid h-custom">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-md-9 col-lg-6 col-xl-5">
        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
          class="img-fluid" alt="Sample image">
      </div>
      <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
      
        <form action="loginAf.do" method="post">
          <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
            <p class="lead fw-normal mb-0 me-3">Sign in with</p>
            <button type="button" class="btn btn-primary btn-floating mx-1e">
			  <i class="fa fa-facebook-f"></i>
			</button>
			
			<button type="button" class="btn btn-primary btn-floating mx-1">
			  <i class="fa fa-twitter"></i>
			</button>
			
			<button type="button" class="btn btn-primary btn-floating mx-1">
			  <i class='fa fa-linkedin'></i>
			</button>
          </div>

          <div class="divider d-flex align-items-center my-4">
            <p class="text-center fw-bold mx-3 mb-0">Or</p>
          </div>

          <!-- ID input -->
          <div class="form-outline mb-4">
            <input type="text" id="id" name="id" class="form-control form-control-lg"
              placeholder="Enter a valid id" />            
          </div>

          <!-- Password input -->
          <div class="form-outline mb-3">
            <input type="password" id="pwd" name="pwd" class="form-control form-control-lg"
              placeholder="Enter password" />            
          </div>

          <div class="d-flex justify-content-between align-items-center">
            <!-- Checkbox -->
            <div class="form-check mb-0">
              <input class="form-check-input me-2" id="chk_save_id" type="checkbox" value="" id="form2Example3" />
              <label class="form-check-label" for="form2Example3">
                Remember me
              </label>
            </div>
            <a href="#!" class="text-body">Forgot password?</a>
          </div>

          <div class="text-center text-lg-start mt-4 pt-2">
            <button type="submit" class="btn btn-primary btn-lg"
              style="padding-left: 2.5rem; padding-right: 2.5rem;">Login</button>
            <p class="small fw-bold mt-2 pt-1 mb-0">Don't have an account? <a href="#!"
                class="link-danger">Register</a></p>
          </div>
          
        </form>
        
      </div>
    </div>
  </div>  
</section>
</div>


<script type="text/javascript">
/*
	session : server에 저장. login 정보.	Object
	cookie : client에 저장. id를 저장. pw 저장	String 
*/

let user_id = $.cookie("user_id");
if(user_id != null){	// 저장한 아이디가 있음
	$("#id").val( user_id );
	$("#chk_save_id").prop("checked", true);	// 첵크박스에 첵크가 되게 해준다
}

$("#chk_save_id").click(function(){
	// alert('click');
	// alert( $("#chk_save_id").is(":checked") );
	
	if( $("#chk_save_id").is(":checked") == true ){	// id를 저장 -> cookie
		
		if( $("#id").val().trim() == "" ){	// 빈문자열이었을 경우
			alert('id를 입력해 주십시오');
			$("#chk_save_id").prop("checked", false);
		}else{	
			// cookie 저장
			$.cookie("user_id", $("#id").val().trim(), { expires:7, path:'./' });
		}		
		
	}else{	// cookie에 저장하지 않음(삭제)
		
		$.removeCookie("user_id", { path:'./' });
	}	
});

</script>

</body>
</html>