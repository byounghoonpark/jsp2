<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%-- /jsp2/src/main/webapp/error/error.jsp
   isErrorPage="true" 속성 : 현재 페이지가 오류페이지. 
                            exception 객체를 제공
--%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류 페이지</title>
</head>
<body>
<h1>파라미터 name을 입력하세요</h1>
<h1>계속 오류 발생시 전산부로 전화 해 주십시요</h1>
<h1>담당자:홍길동, 전화:1234</h1>
<%= exception.getMessage() %>
</body>
</html>