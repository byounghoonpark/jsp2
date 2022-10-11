<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="test.BookDao"%>
<%@page import="test.Book"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /jsp2/src/main/webapp/test20220929/book.jsp
   bookForm.jsp 에서 전달해준 파라미터값 들을 db의 book 테이블에 저장기능  
   1. 파라미터값을 읽어서 Book 객체에 저장
   2. Book 객체를 db의 book 테이블에 저장
   3. 방명록 등록 성공 : 화면 내용 출력
      방명록 등록 실패 : bookForm.jsp 페이지 이동
--%>
<%
// 1. 파라미터값을 읽어서 Book 객체에 저장
   request.setCharacterEncoding("UTF-8");
   Book book = new Book();
   book.setWriter(request.getParameter("writer"));
   book.setTitle(request.getParameter("title"));
   book.setContent(request.getParameter("content"));
   BookDao dao = new BookDao();
   SimpleDateFormat sf =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   if(dao.insert(book)) {
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록 결과 보기</title>
</head>
<body>
<table><caption>방명록 조회</caption>
<tr><td>작성자</td><td><%=book.getWriter() %></td>
<tr><td>제목</td><td><%=book.getTitle() %></td>
<tr><td>내용</td><td><%=book.getContent() %></td>
<tr><td>등록일</td><td><%=sf.format(new Date()) %></td>
</table>
</body>
</html>
<% } else { %>
<script type="text/javascript">
  alert("방명록 등록 실패")
  location.href='bookForm.jsp'
</script>
<% } %>