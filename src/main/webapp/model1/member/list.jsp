<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /jsp2/src/main/webapp/model1/member/list.jsp
  1. 로그아웃상태 : 로그인이 필요합니다. 메세지 출력 loginForm.jsp 페이지 이동
  2. 일반사용자로 로그인 상태 : 관리자만 가능한 거래 입니다. 메세지 출력.
                          main.jsp 로 페이지 이동 
  3. db에서 모든 회원정보를 조회하여 화면에 출력하기
     List<Member> MemberDao.list()                          
--%>
<%
  String login = (String)session.getAttribute("login");
//1. 로그아웃상태 : 로그인이 필요합니다. 메세지 출력 loginForm.jsp 페이지 이동
  if (login == null) { %>
<script type="text/javascript">
  alert("로그인 하세요")
  location.href="loginForm.jsp"
</script>  
<% }  else if (!login.equals("admin")) { //2. 일반사용자로 로그인 상태%>
<script type="text/javascript">
  alert("관리자만 가능한 거래입니다.")
  location.href="main.jsp"
</script>  
<% } else { //3. db에서 모든 회원정보를 조회하여 화면에 출력하기
	//list : db member 테이블의 모든 정보 저장하고 있는 목록
	List<Member> list = new MemberDao().list();
%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록 보기</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
<table><caption>회원 목록</caption>
<tr><th>아이디</th><th>사진</th><th>이름</th><th>성별</th><th>전화</th>
<th>&nbsp;</th></tr>
<% for (Member m : list) {%>
<tr>
<td><a href="info.jsp?id=<%=m.getId() %>"><%=m.getId() %></a></td>
<td><img src="picture/<%=m.getPicture() %>" width="20" height="30"></td>
<td><%=m.getName() %></td><td><%=m.getGender()==1?"남":"여" %></td>
<td><%=m.getTel() %></td>
<td><a href="updateForm.jsp?id=<%=m.getId() %>">[수정]</a>
<a href="deleteForm.jsp?id=<%=m.getId() %>">[강제탈퇴]</a></td>
</tr><% } //for 구문 끝 %>
</table>
</body>
</html>
<% } %>