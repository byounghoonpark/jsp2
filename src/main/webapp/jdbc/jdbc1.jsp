<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /jsp2/src/main/webapp/jdbc/jdbc1.jsp --%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB 연결</title>
</head>
<body>
<%
   //OracleDriver 클래스 로드 
   Class.forName("oracle.jdbc.driver.OracleDriver");
   // Connection 객체 : 오라클과 접속하는 객체 
   Connection conn = DriverManager.getConnection
		   ("jdbc:oracle:thin:@localhost:1521:xe","kic","1234");
   out.println("오라클 접속 성공");
   //Statement : sql 문장을 데이터베이스에 명령문 전달 객체 
   Statement stmt = conn.createStatement();
   //ResultSet : select 문장의 결과 데이터를 저장하는 객체 
   ResultSet rs = stmt.executeQuery("select * from emp");
%>
<table><tr><td>사원번호</td><td>사원명</td><td>업무</td><td>급여</td></tr>
<%--
   rs.next() : 한개의 행을 조회하고 true 리턴 
               조회할 행이 없으면 false 리턴 
   rs.getString(컬럼명|컬럼순서) : 컬럼값을 문자열로 리턴               
 --%>
<% while(rs.next()) {%>
<tr><td><%=rs.getString("empno") %></td>
    <td><%=rs.getString("ename") %></td>
    <td><%=rs.getString("job") %></td>
    <td><%=rs.getString("sal") %></td>
</tr>
<% } %>
</table></body></html>