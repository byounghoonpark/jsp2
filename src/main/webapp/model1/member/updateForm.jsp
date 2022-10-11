<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /jsp2/src/main/webapp/model1/member/updateForm.jsp
  수정 전 기존의 회원정보를 화면에 출력하기
  1. id 파라미터 조회.
  2. login 정보 조회. 
     로그아웃상태 : 로그인하세요. 메세지 출력. loginForm.jsp 페이지 이동
  3. login 정보 조회2
     관리자가 아니면서 다른사람 정보 수정 하는 경우 
     내정보만 수정이 가능합니다. main.jsp 페이지 이동
  4. id 정보를 db에서 읽어서 화면에 출력하기      
--%>  
<%
  //1. id 파라미터 조회.
  String id = request.getParameter("id");
  //2. login 정보 조회.
  String login = (String)session.getAttribute("login");
  if (login == null) {  %>
<script type="text/javascript">
  alert("로그인 하세요")
  location.href='loginForm.jsp'
</script>  
<% } else if (!login.equals("admin") && !id.equals(login)) { %>
<script type="text/javascript">
  alert("내정보만 수정이 가능합니다.")
  location.href='main.jsp'
</script>  
<% } else {
	Member mem = new MemberDao().selectOne(id); %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
  function win_passchg() {
	  let op = "width=500,height=250,left=50,top=150"
	  open("passwordForm.jsp","",op)
  }
  function win_upload() {
	   let op = "width=300,height=300,left=50,top=150"
	   open("memberimg.jsp","",op)
  }
</script>
</head>
<body>
<form action="update.jsp" name="f" method="post" 
       onsubmit="return inputcheck(this)">
<input type="hidden" name="picture" value="<%=mem.getPicture()%>">
<table><caption>회원 정보 수정</caption>
<tr><td rowspan="4" valign="bottom">
  <img src="picture/<%=mem.getPicture() %>" 
                         width="100" height="120" id="pic"><br>
  <font size="1"><a href="javascript:win_upload()">사진수정</a></font>
</td><th>아이디</th>
 <td><input type="text" name="id" readonly value="<%=mem.getId()%>">
 </td></tr>
<tr><th>비밀번호</th><td><input type="password" name="pass" ></td></tr>
<tr><th>이름</th>
<td><input type="text" name="name" value="<%=mem.getName()%>"></td></tr>
<tr><th>성별</th>
   <td><input type="radio" name="gender" value="1" 
     <%=mem.getGender()==1?"checked":""%>>남
      <input type="radio" name="gender" value="2"
     <%=mem.getGender()==2?"checked":""%>>여</td></tr>
<tr><th>전화번호</th>
<td colspan="2"><input type="text" name="tel"  
    value="<%=mem.getTel()%>"></td></tr>
<tr><th>이메일</th><td colspan="2">
<input type="text" name="email"  value="<%=mem.getEmail()%>"></td></tr>
<tr><td colspan="3"><input type="submit" value="회원수정">
<%--!login.equals("admin") : 관리자가 아닌 경우  
    id.equals("admin") : 관리자 관리자 정보 수정 --%>
<% if(login.equals(id))  {%>
<input type="button" value="비밀번호수정" onclick="win_passchg()">
<% } %></td></tr>
</table></form></body></html>
<% } %>