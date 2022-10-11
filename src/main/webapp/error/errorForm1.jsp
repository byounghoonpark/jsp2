<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>    
<%-- /jsp2/src/main/webapp/error/errorForm1.jsp
   page 지시어의 errorPage 속성 : 현재페이지에서 오류 발생하면 error.jsp 호출 
--%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예외 발생 페이지</title>
</head>
<body>
<%= request.getParameter("name").trim() %>
</body>
</html>