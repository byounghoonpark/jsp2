<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /jsp2/src/main/webapp/model1/member/logout.jsp
  1. session에 등록된 로그인 정보제거
  2. loginForm.jsp로페이지 이동. 
--%>    
<%
  //1. session에 등록된 로그인 정보제거
  session.removeAttribute("login"); //login 속성만 제거. session 유지
  //1. session에 등록된 로그인 정보제거
  session.invalidate(); //기존 session 제거. session 새로 할당
  //2. loginForm.jsp로페이지 이동. 
  response.sendRedirect("loginForm.jsp");
%>