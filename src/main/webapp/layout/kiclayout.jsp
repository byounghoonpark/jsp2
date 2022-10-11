<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>    
<!DOCTYPE html>
<html><head>
<title><sitemesh:write property='title'/></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
#center {
	text-align: center;
}
ul {
width : 100%;

}
.nav-item {
font-weight: 600;
font-size: 1.2em;
padding : 3px;
color: aqua;
}

#half {
	width: 45%;
}
nav {
    box-shadow: 0px 0px 3px 3px #EDEEED;
}

#shade {
  box-shadow: 0px 0px 3px 3px #EDEEED;
}
</style>
<%--원래페이지 head 태그 내용을 설정 :title 태그는 제외  --%>
<sitemesh:write property='head'/>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-light navbar-light">
		<!-- Brand -->
		<a class="navbar-brand" href="<%=path%>/member/main">
		<img src="<%=path%>/image/logo.png"
			  style="margin-right: 20%;"></a>
		<!-- Links -->
		<ul class="navbar-nav   justify-content-end" >
			<li class="nav-item"><a
				href="<%=path%>/board/list?boardid=1"
				class="nav-link">공지사항</a></li>
			<li class="nav-item"><a
				href="<%=path%>/board/list?boardid=2"
				class="nav-link">자유게시판</a></li>
			<li class="nav-item"><a
				href="<%=path%>/board/list?boardid=3"
				class="nav-link">QnA</a></li>
			<c:if test="${sessionScope.login == 'admin' }">	
			<li class="nav-item">
			  <a href="<%=path%>/member/list" class="nav-link">회원리스트</a></li>
			</c:if>	
		</ul>

		<ul class="navbar-nav   justify-content-end text-right" >
		<c:if test="${empty sessionScope.login }">
				<li class="nav-item"><a class="nav-link"
					href="<%=path%>/member/loginForm">로그인</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=path%>/member/memberInput">회원가입</a></li>
	    </c:if>			
		<c:if test="${!empty sessionScope.login }">
			   <li class="nav-item"><a class="nav-link"
					href="<%=path%>/member/info?id=${login}">${login}</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=path%>/member/logout">로그아웃</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=path%>/member/deleteForm?id=${sessionScope.login}">회원탈퇴</a></li>
	    </c:if>
	    </ul>			

		<div class="container  justify-content-end">
			<form class="form-inline" action="#">
				<input class="form-control mr-sm-2" type="text" placeholder="Search">
				<button class="btn btn-success" type="submit">Search</button>
			</form>
		</div>

	</nav><!-- The Modal -->
<sitemesh:write property='body'/>
<!-- Footer -->
<br>
<%-- 시군구 선택 --%> 
<span id="si">
     <select name="si" onchange="getText2('si')">
	     <option value="">시도를 선택하세요</option>
     </select>
 </span>
<span id="gu">
	<select name="gu" onchange="getText2('gu')">
		<option value="">구군을 선택하세요</option>
	</select>
</span>
<span id="dong">
	<select name="dong">
		<option value="">동리를 선택하세요</option>
	</select>
</span>

<script type="text/javascript">
let divid;
let si;
$(function(){
  $.ajax({
	url : "<%=path%>/select",
	success : function(data) {
		console.log(data)
		/*
		[서울특별시, 부산광역시, 대구광역시, 인천광역시, 광주광역시, 대전광역시, 울산광역시, 경기도, 강원도, 충청북도, 충청남도, 전라북도, 전라남도, 경상북도, 경상남도, 제주특별자치도]
		*/
		let arr = data.substring
		          (data.indexOf('[')+1,data.indexOf(']')).split(",");
		$.each(arr,function(i,item){
			$("select[name='si']").append(function(){
				return "<option>" + item + "</option>"
			})
		});
	}
  })
})

function getText(name) {
	let cityval = $("select[name='si']").val(); //시도값
	let guval = $("select[name='gu']").val();   //구군값
	let disname;
	let toptext="구군을 선택하세요";
	let params = "";
	if (name == "si") {
		params = "si=" + cityval.trim();
		disname = "gu";  //결과값이 출력될 영역
	} else if (name == "gu") { 
		// si=서울특별시&gu=강남구
		params = "si=" + cityval.trim()+"&gu="+guval.trim();
		disname = "dong";
		toptext="동리를 선택하세요";
	} else { 
		return ;
	}
	$.ajax({
	  url : "<%=path%>/select",
	  type : "POST",    
	  data : params,  			
	  success : function(data) {
		 let arr = data.substring(data.indexOf('[')+1,data.indexOf(']')).split(",");
		 let selhtml="<select name='"+disname +
		             "' onchange='getText(\""+disname+"\")'>";
		 selhtml += "<option value=''>" + toptext + "</option>"
		 $.each(arr,function(i,item){
				selhtml += "<option>" + item + "</option>"
		 });
		 selhtml+="</select>";
		 $("#"+disname).html(selhtml);
	  }
   })				
}
//append 방식으로 getText함수를 변경하기 
function getText2(name) {
	let cityval = $("select[name='si']").val();
	let guval = $("select[name='gu']").val();
	let disname;
	let toptext="구군을 선택하세요";
	let params = "";
	if (name == "si") {
		params = "si=" + cityval.trim();
		disname = "gu";
	} else if (name == "gu") { 
		params = "si=" + cityval.trim()+"&gu="+guval.trim();
		disname = "dong";
		toptext="동리를 선택하세요";
	} else { 
		return ;
	}
	$.ajax({
	  url : "<%=path%>/select",
	  type : "POST",    
	  data : params,  			
	  success : function(data) {
 		    $("#"+disname).html("")  
 		    $("#"+disname).append("<select name='"+disname +
		             "' onchange='getText2(\""+disname+"\")'>")
		    $("select[name='"+disname+"']").append
		                    ("<option value=''>" + toptext + "</option>")		             
			let arr = data.substring
	          (data.indexOf('[')+1,data.indexOf(']')).split(",");
	     	$.each(arr,function(i,item){
		    	$("select[name='"+disname+"']").append(function(){
				   return "<option>" + item + "</option>"
				})
			});
	  }
   })				
}

</script>	
<div class="jumbotron text-center" style="margin-bottom:0">
  <p>KIC 캠퍼스 : 인공지능을 활용한 고객 맞춤형 웹 플랫폼 구축 양성 과정 </p>
</div>
</body>
</html>