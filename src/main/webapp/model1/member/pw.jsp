<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /jsp2/src/main/webapp/model1/member/pw.jsp
  1. 파라미터저장
  2. db에서 비밀번호 읽기
      id,email,tel에 맞는 비밀번호를 읽기. 
--%>    
<%
  String id = request.getParameter("id");
  String email = request.getParameter("email");
  String tel = request.getParameter("tel");
  String pass = new MemberDao().pwSearch(id,email,tel);
  if (pass != null) {  
%>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>비밀번호 찾기</title></head>
<body>
  <table><tr><th>비밀번호</th><td><%= pass %></td></tr>
     <tr><td colspan="2"><input type="button" value="닫기"
        onclick="self.close()"></td></tr>
  </table></body></html>
<% }  else {%>
<script type="text/javascript">
  alert("정보에 맞는 비밀번호를 찾을 수 없습니다.")
  location.href="pwForm.jsp";
</script>
<% } %>