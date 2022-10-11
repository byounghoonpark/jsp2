<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /jsp2/src/main/webapp/model1/member/join.jsp
  1.파라미터값들을 Member 객체에 저장
  2.Member 객체의 내용을 db에 저장
  3.저장성공 : 화면에 내용출력하기
    저장실패 : joinForm.jsp 페이지 이동 
--%>
<%
    request.setCharacterEncoding("UTF-8");
   //1.파라미터값들을 Member 객체에 저장
    Member mem = new Member(); //Member 객체 생성
    //request.getParameter("id") : id 입력값
    mem.setId(request.getParameter("id"));
    mem.setPass(request.getParameter("pass"));
    mem.setName(request.getParameter("name"));
    mem.setGender(Integer.parseInt(request.getParameter("gender")));
    mem.setTel(request.getParameter("tel"));
    mem.setEmail(request.getParameter("email"));
    mem.setPicture(request.getParameter("picture"));
    //2.Member 객체의 내용을 db에 저장
    MemberDao dao = new MemberDao();
    if(dao.insert(mem)) { //회원가입성공
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
  <tr><td>아이디</td><td><%=mem.getId() %></td></tr>
  <tr><td>이름</td><td><%=mem.getName() %></td></tr>
  <tr><td>성별</td><td><%=(mem.getGender()==1)?"남":"여" %></td></tr>
  <tr><td>전화번호</td><td><%=mem.getTel() %></td></tr>
  <tr><td>이메일</td><td><%=mem.getEmail() %></td></tr>
</table>
<input type="button" value="로그인하기" 
      onclick="location.href='loginForm.jsp'">
</body>
</html>
<% } else { //회원가입실패 %>
<script type="text/javascript">
  alert("회원가입 실패")
  location.href='joinForm.jsp'  //joinForm.jsp로 페이지 이동 
</script>
<% } %>