<%@page import="model.Member"%>
<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /jsp2/src/main/webapp/model1/member/login.jsp 
  1. 아이디, 비밀번호 파라미터를 변수 저장 
  2. db 정보를 읽기. id에 해당하는 db정보를 읽어서 Member 객체에 저장 
     Member MemberDao.selectOne(id);
  3. 아이디와 비밀번호 검증. 
    - 아이디가 없는 경우      
       아이디가 없습니다. 메세지확인. loginForm.jsp 페이지 이동
    - 아이디 존재. 비밀번호가 틀린경우   
       비밀번호오류 메세지확인. loginForm.jsp 페이지 이동
    - 아이디 존재. 비밀번호가 맞는경우 => 정상적인 로그인.
      session 객체에 로그인 정보 저장.
      main.jsp로 페이지 이동.    
--%>    
<%
  request.setCharacterEncoding("UTF-8");
  //1아이디, 비밀번호 파라미터를 변수 저장
  String id = request.getParameter("id"); //입력한 id값.
  String pass = request.getParameter("pass"); //입력한 비밀번호 값.
  //2. db 정보를 읽기. id에 해당하는 db정보를 읽어서 Member 객체에 저장
  MemberDao dao = new MemberDao();
  //id 존재 : db의 내용 저장, id존재하지 않으면 : null
  Member mem = dao.selectOne(id);
  String msg = null;
  String url = null;
  if(mem == null) { //id 존재하지 않는 경우 
	  msg = "아이디가 틀립니다.";
	  url = "loginForm.jsp";
  } else if(!pass.equals(mem.getPass())) { // id 존재. 비밀번호 오류
	  //pass : 입력된 비밀번호
	  //mem.getPass() : db에 등록된 아이디의 비밀번호
	  msg = "비밀번호가 틀립니다.";
	  url = "loginForm.jsp";
  } else { //id 존재. 비밀번호 일치 => 정상 로그인 상태 
	  session.setAttribute("login", id); //session에 로그인 정보저장
	  msg = "반갑습니다."+mem.getName() + "님";
	  url = "main.jsp";
  }
%>
<script>
  alert("<%=msg %>")
  location.href="<%=url %>"
</script>
