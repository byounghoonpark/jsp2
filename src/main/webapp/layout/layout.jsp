<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /jsp2/src/main/webapp/layout/layout.jsp
   1.http://localhost:8088/jsp2/model1/member/loginForm.jsp 요청
      /* 에 속한 url 요청임.  
   2.<sitemesh:write property='title'/> : 
             loginForm.jsp 페이지의 title 태그의 내용 적용 
   3.<sitemesh:write property='head'/> :           
             loginForm.jsp 페이지의 head 태그의 내용 적용. title 태그 제외
             <script>,<style>...  
   4. <sitemesh:write property='body'/>
             loginForm.jsp 페이지의 body 태그의 내용 적용.
             
--%>  
<% String path = request.getContextPath(); // /jsp2
   String login = (String)session.getAttribute("login");
%>      
<!DOCTYPE html><html>
<head>
<meta charset="UTF-8">
<title><sitemesh:write property='title'/></title>
<link rel="stylesheet" href="<%=path%>/css/main.css">
<sitemesh:write property='head'/>
</head><body>
<table><tr><td colspan="3" style="text-align:right">
<% if (login == null) {%>
   <a href="<%=path%>/model1/member/loginForm.jsp">로그인</a>
   <a href="<%=path%>/model1/member/joinForm.jsp">회원가입</a>
<% } else {%>
   <%=login %>님. 
   <a href="<%=path%>/model1/member/logout.jsp">로그아웃</a>
<% } %>   
</td></tr>
<tr><td width="15%" valign="top">
  <a href="<%=path%>/model1/member/main.jsp">회원관리</a><br>
</td><td colspan="2" style="text-align: left; vertical-align: top">
<sitemesh:write property='body'/></td></tr>
<tr><td colspan="3">KIC 캠퍼스</td></tr></table></body></html>