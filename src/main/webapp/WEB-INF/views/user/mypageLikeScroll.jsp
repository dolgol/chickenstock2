<%@page import="ssg.com.a.dto.StocksDto"%>
<%@page import="java.util.List"%>
<%@page import="ssg.com.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	List<StocksDto> mypageLikeList = (List<StocksDto>)request.getAttribute("mypageLikeList");
	
	UserDto login = (UserDto)session.getAttribute("login");
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHICKEN STOCK</title>

<style type="text/css">

	body {
	  min-height: 104vh;
	}
	
	.loader-container {
		display: flex;
		justify-content: center;
	}

	.loader {
	  opacity: 0;
	  display: flex;
	  position: fixed;
	  bottom: 50px;
	  transition: opacity 0.3s ease-in;
	}
	
	.loader.show {
	  opacity: 1;
	}
	
	.circle {
	  background-color: #ff9406;
	  width: 10px;
	  height: 10px;
	  border-radius: 50%;
	  margin: 5px;
	  animation: bounce 0.5s ease-in infinite;
	}
	
	.circle:nth-of-type(2) {
	  animation-delay: 0.1s;
	}
	
	.circle:nth-of-type(3) {
	  animation-delay: 0.2s;
	}
	
	@keyframes bounce {
	  0%,
	  100% {
	    transform: translateY(0);
	  }
	
	  50% {
	    transform: translateY(-10px);
	  }
	}

</style>

</head>
<body>

	<div>
		관심종목 scroll
	</div>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>종목코드</th> <th>마켓</th> <th>종목명</th>
				</tr>
			</thead>
			<tbody id="posts-container">
				<%
				if(mypageLikeList.size() == 0) {
					%>
					<tr>
						<td colspan="12">
							<span class="material-symbols-rounded">favorite</span><br/>
							아직 관심종목이 없습니다<br/>
							종목 게시판 바로가기 >>
						</td>
					</tr>
					<%
				}
				%>
			</tbody>
		</table>
		
		<div class="loader-container">
			<div class="loader">
		      <div class="circle"></div>
		      <div class="circle"></div>
		      <div class="circle"></div>
		    </div>
	    </div>

	</div>
	
	<script type="text/javascript">
	
		const postsContainer = document.getElementById('posts-container');
		const loading = document.querySelector('.loader');

		let pageNumber = 0;
		let hasMorePosts = true;
	
		function getPosts() {
		  
		  $.ajax({
			url: "mypageScroll.do",
			type: "get",
			data: { 
				"user_id": "<%=login.getUser_id() %>",
				"pageNumber": pageNumber
			},
			success: function(response) {
				console.log("success + " + response);
				console.log(JSON.stringify(response));
				
				if(response.length == 0) {
					hasMorePosts = false;
					return;
				}
				
				$.each(response, function(i, item) {
					let str = "";
					str += "<tr>";
					str += "	<td>" + item.symbol + "</td>";
					str += "	<td>" + item.market + "</td>";
					str += "	<td>" + item.name + "</td>";
					str += "</tr>";
					
					$("#posts-container").append(str);
				});
			},
			error: function(response) {
				console.log("error + " + response);
			}
		  });
		}
	
		// Show loader & fetch more posts
		function showLoading() {
		  loading.classList.add('show');
	
		  setTimeout(() => {
		    loading.classList.remove('show');
	
		    setTimeout(() => {
		      pageNumber++;
		      getPosts();
		    }, 300);
		  }, 1000);
		}
	
		// Show initial posts
		getPosts();
	
		window.addEventListener('scroll', () => {
		  if (!hasMorePosts) return;
		  
		  const { scrollTop, scrollHeight, clientHeight } = document.documentElement;
	
		  if (scrollTop + clientHeight >= scrollHeight - 5) {
		    showLoading();
		  }
		});
	
	</script>
		
</body>
</html>