<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /jsp2/src/main/webapp/model1/member/update.jsp

 1. 모든 파라미터 정보를 Member 객체에 저장
 2. 입력된 비밀번호와, db에 저장된 비밀번호 비교 => db에서 읽기
    관리자인경우 관리자비밀번호로 비교하기.
    본인인 경우 본인의 비밀번호로 비교하기
    - 비밀번호가 틀린 경우 : "비밀번호 오류" 메세지 출력 
                         updateForm.jsp 페이지 이동
 3. 비밀번호가 맞는 경우
    입력된 내용을 저장하고 있는 Member 객체를 이용하여 db 정보 수정.
    boolean MemberDao.update(Member)
    결과가 true 면 수정성공 info.jsp 페이지 이동
    결과가 false면 수정실패 메세지 출력후 , updateForm.jsp 페이지 이동
--%>    
<%
   request.setCharacterEncoding("UTF-8");

//1. 모든 파라미터 정보를 Member 객체에 저장
   Member mem = new Member();
   mem.setId(request.getParameter("id"));
   mem.setPass(request.getParameter("pass"));
   mem.setName(request.getParameter("name"));
   mem.setGender(Integer.parseInt(request.getParameter("gender")));
   mem.setTel(request.getParameter("tel"));
   mem.setEmail(request.getParameter("email"));
   mem.setPicture(request.getParameter("picture"));
// 2. 입력된 비밀번호와, db에 저장된 비밀번호 비교 => db에서 읽기
   // 관리자가 회원수정시 관리자 비밀번호로 검증
   // 본인이 회원수정시 본인 비밀번호로 검증
   String login = (String)session.getAttribute("login");
   MemberDao dao = new MemberDao();
   Member dbMem = dao.selectOne(login); //비밀번호 검증용
   String msg = "비밀번호가 틀렸습니다.";
   String url = "updateForm.jsp?id="+mem.getId();
   //mem.getPass() : 입력된 비밀번호
   //dbMem.getPass() : db 등록된 비밀번호 
   if(mem.getPass().equals(dbMem.getPass())) {
	   //mem : 입력된 파라미터 정보를 저장
	  if(dao.update(mem)) {
		  msg = "회원 정보 수정이 완료되었습니다.";
		  url = "info.jsp?id="+mem.getId();
	  } else {
		  msg = "회원 정보 수정시 오류발생.";
	  }
   }
%>
<script type="text/javascript">
   alert("<%=msg%>")
   location.href="<%=url %>"
</script>