<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /jsp2/src/main/webapp/jdbc/jdbc2.jsp
  css 위치: webapp/css/main.css 
--%>
<%--
   JDBC 사용 순서
   1. 드라이버 클래스 로드 : Class.forName("클래스명")
   2. db와 연결하는 객체 : 
   Connection conn = DriverManager.getConnection("url","userid","pw")
   3. db에 sql구문전달 객체 
   Statement stmt = conn.createStatement()
   4. 명령실행 후 db로 부터 결과 수신
     ResultSet rs = stmt.executeQuery(sql문장:select)
          int cnt = stmt.executeUpdate(sql문장:select외)
          cnt : 변경된 레코드의 갯수 리턴
 --%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>emp 테이블의 모든 정보 조회하기</title>
<link rel="stylesheet" href="../css/main.css">
</head>
<body>
<%
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection conn = DriverManager.getConnection
		   ("jdbc:oracle:thin:@localhost:1521:xe","kic","1234"); 
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("select * from emp");
//ResultSetMetaData : 조회된 컬럼의 정보 저장
ResultSetMetaData rsmt = rs.getMetaData();
%>
<table><tr>
<%
/*
  getColumnCount() : 조회된 컬럼의 갯수
  getColumnName(i) : 조회된 컬럼명의 순서대로 조회컬럼 리턴. 1번 인덱스 부터 시작
*/	
  for(int i=1;i<=rsmt.getColumnCount();i++) {
%>
<th><%=rsmt.getColumnName(i) %></th> <%-- 컬럼명 출력 --%>
<% } %></tr>
<%-- 데이터 부분 출력 --%>
<% while(rs.next())  {%>
<tr> <%-- 컬럼값 출력 --%>
<% for(int i=1;i<=rsmt.getColumnCount();i++) {%>
  <td><%=rs.getString(i) %></td> <%-- rs.getString(컬럼순서) --%>
<% } %>  
</tr>
<% } %>
</table>
</body>
</html>