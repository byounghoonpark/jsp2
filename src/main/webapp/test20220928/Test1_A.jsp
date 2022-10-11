<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>간단한 select 구문 실행 결과 확인</title>
<link rel="stylesheet" href="../css/main.css">
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String sql = request.getParameter("sql"); //null
%>
<form method="post">
<textarea cols="60" rows="5" name="sql"><%=(sql==null)?"":sql %></textarea>
   <input type="submit" value="실행" >
</form>
<% 
Connection conn = null; 
if(sql != null && !sql.trim().equals("")) { //sql 구문이 입력된 경우
 try {	
   Class.forName("oracle.jdbc.driver.OracleDriver");
   conn = DriverManager.getConnection
   ("jdbc:oracle:thin:@localhost:1521:xe","kic","1234");
   Statement stmt = conn.createStatement();
   ResultSet rs = stmt.executeQuery(sql); //입력한 sql문장 실행
   ResultSetMetaData rsmt = rs.getMetaData();
   //sql : select * from emp
   // select count(*) from (select * from emp) a
   Statement stmt2 = conn.createStatement();
   // sql 구문을 실행한경우 조회되는 레코드 건수
   ResultSet rs2 = stmt2.executeQuery
       ("select count(*) from (" + sql + ") a");  
   rs2.next();  //조회 건수
   int cnt = rs2.getInt(1); //첫번째 컬럼(count(*))의 값
   %>
 <table>
 <tr><td colspan="<%=rsmt.getColumnCount()%>" 
     style="text-align: right;">
     조회된 레코드 갯수:<%=cnt %></td></tr>
<tr>
<% //조회된 컬럼명 출력 
  for(int i=1;i<=rsmt.getColumnCount();i++) {%>
   <th><%=rsmt.getColumnName(i)%></th>
<% } %>
</tr>
<% //데이터 출력
   while(rs.next()) { %><tr>
 <% for(int i=1;i<=rsmt.getColumnCount();i++) {%>
	   <td><%=rs.getString(i) %></td><% } %>	   
<% }%></tr>
</table>  
<% } catch (Exception e) { %>
    <h1>sql 구문 오류 입니다.<br>
        <%=e.getMessage() %><br>
        sql 구문 :<%=sql%> </h1>
<% } finally {
    conn.close();
   } 
}%>
</body></html>