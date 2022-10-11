<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /jsp2/src/main/webapp/model1/member/imgupload.jsp
  1. 파일 업로드 : 업로드 위치 model1/member/picture로 설정
  2. 이미지파일을 opener 페이지에 출력하기. 현재페이지 닫음. 
--%>    
<%
//1. 파일 업로드 
  //uploadPath : 파일 업로드 되는 폴더이름
 String uploadPath = application.getRealPath("/")+
                     "model1/member/picture/";
 //File : 파일의 정보를 관리하는 클래스. 
 File f = new File(uploadPath);
 //f.exists() : f가 존재?
 //mkdirs() : 폴더 생성
 if(!f.exists()) f.mkdirs(); //이미지파일 업로드되는 폴더 생성
 
 String filename = null;
 try {
	 /*
   (request,uploadPath,10*1024*1024,"utf-8")
	   request : 요청정보. 클라이언트에서 선택된 
	             파라미터정보,파일이름,파일의 내용등이 저장된 요청 객체
       uploadPath : 파일이 업로드되는 폴더. 업로드 위치폴더
       10*1024*1024 : 10M. 업로드 되는 파일의 최대 크기 지정
       "utf-8" : 파라미터 인코딩 코드
       
       MultipartRequest 객체 생성은 반드시 앞페이지에서
                       enctype="multipart/form-data" 여야함
	 */
	 MultipartRequest multi = new MultipartRequest  //파일업로드
			 (request,uploadPath,10*1024*1024,"utf-8");
	 // <input type="file" name="picture"
	 filename = multi.getFilesystemName("picture"); //파일이름
 } catch (IOException e) {
	 e.printStackTrace();
 }
%>
<%--  2. 이미지파일을 opener 페이지에 출력하기. 현재페이지 닫음. --%>
<script>
  //opener 윈도우의 id="pic"인 태그 선택 
  img = opener.document.querySelector("#pic")
  img.src="picture/<%=filename%>"
  //파라미터에 파일이름 설정 => db에 저장
  opener.document.f.picture.value="<%=filename%>" 
  self.close()
</script>