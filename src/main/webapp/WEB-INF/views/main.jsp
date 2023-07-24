<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    
<%
	
	String content = (String)request.getAttribute("content");

	if(content == null) {
		content = "home";
	}

%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHICKEN STOCK</title>

<!-- bootstrap -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<!-- google fonts -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<style>

	.main-table {
		width: 100%;
	}
	
	.btn-primary {
		background-color: #ff9406;
		border-color: #ff9406;
	}
	
	.btn-primary:hover {
		background-color: #ef7d00;
		border-color: #ef7d00;
	}
	
	.btn-outline-primary {
		color: #ff9406;
		border-color: #ff9406;
	}
	
	.btn-outline-primary:hover {
		color: #fff;
		background-color: #ff9406;
		border-color: #ff9406;
	}

</style>

</head>
<body>

	<div>
		<table class="main-table">
			<tr>
				<td>
					<jsp:include page="menu.jsp" flush="false" />
				</td>
			</tr>
			<tr>
				<td>
					<jsp:include page='<%=content + ".jsp"%>' flush="false" />
				</td>
			</tr>
			<tr>
				<td>
					<jsp:include page="footer.jsp" flush="false" />
				</td>
			</tr>
		</table>
	</div>

</body>
</html>