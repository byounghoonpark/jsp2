<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /src/main/webapp/test20220929/bookForm.jsp
   1. db에 방명록 테이블생성하기. => book
   2. test.Book Bean 클래스 생성하기
   3. test.BookDao 클래스에서 내용을 등록하기
   4. book.jsp 페이지 작성하기
      - 입력된 내용을 db에 등록하기
      - 등록된 내용을 화면에 출력하기=>(결과화면 참조)
--%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록 작성</title>
<link rel="stylesheet" href="../css/main.css" >
</head>
<body>
<form action="book.jsp" method="post">
  <table>
    <tr><td>작성자</td>
       <td><input type="text" name="writer"></td></tr>
    <tr><td>제목</td>
       <td><input type="text" name="title"></td></tr>
    <tr><td>내용</td>
       <td><textarea rows="5" cols="60" name="content"></textarea>
    </td></tr>
    <tr><td colspan="2">
      <input type="submit" value="방명록 등록"></td></tr>
  </table></form></body></html>