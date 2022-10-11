<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /jsp2/src/main/webapp/model1/member/info.jsp
   1. id 파라미터값을 변수 저장하기
   2. login 상태 검증.
      로그아웃상태 : 로그인하세요 메세지출력 후 loginForm.jsp 페이지 이동   
   3. login 상태 검증 2.
      로그상태 : 관리자가 아닌 경우 id 파라미터값과 login 정보가 다르면
              본인정보만 조회가능합니다. 메세지 출력 후 main.jsp로 페이지 이동
   4. id에 해당하는 정보를 읽어서 화면 출력하기               
--%>   
<%
   String id = request.getParameter("id"); //id 파라미터 저장
   String login = (String)session.getAttribute("login"); //로그인정보 저장
   if(login == null) {  //로그아웃 상태 %>
<script type="text/javascript">
  alert("로그인 하세요")
  location.href="loginForm.jsp"
</script>
<%-- 로그인 상태. 관리자가 아니고 내정보가 아닌 경우   --%>   
<% } else if (!login.equals("admin") && !id.equals(login)) {%>
<script type="text/javascript">
  alert("본인 정보 조회만 가능합니다.")
  location.href="main.jsp"
</script>   
<%-- 관리자이거나, 본인정보인 경우 --%>
<% } else {   //회원 정보 조회 부분
	//mem : db에서 id에 해당하는 정보를 읽어서 Member 객체로 저장
	Member mem = new MemberDao().selectOne(id);
%>    
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>회원 정보 보기</title>
<link rel="stylesheet" href="../../css/main.css">
</head><body>
<table><caption>회원 정보 보기</caption>
<tr><td rowspan="6" width="30%">
<img src="picture/<%=mem.getPicture() %>" width="200" height="210">
</td>
    <th width="20%">아이디</th><td><%=mem.getId() %></td></tr>
<tr><th>이름</th><td><%=mem.getName() %></td></tr>
<tr><th>성별</th><td><%=(mem.getGender()==1)?"남":"여" %></td></tr>
<tr><th>전화</th><td><%=mem.getTel() %></td></tr>
<tr><th>이메일</th><td><%=mem.getEmail() %></td></tr>
<tr><td colspan="2">
  <a href="updateForm.jsp?id=<%=mem.getId() %>">[수정]</a>
  <a href="deleteForm.jsp?id=<%=mem.getId() %>">[탈퇴]</a>
</td></tr></table></body></html>
<% } %>