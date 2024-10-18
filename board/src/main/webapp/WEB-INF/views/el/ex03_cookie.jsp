<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠키 객체</title>
</head>
<body>
<h3>쿠키를 생성해서 response객체에 추가하기</h3>
<hr>
<%
//제품번호(pid)로 20240923을 값으로 저장하고 2일 동안 사용자 PC에서 쿠키로 저장되도록 생성
Cookie cookie01 = new Cookie("pid", "20240923");//쿠키 생성
cookie01.setPath(request.getContextPath());//경로 설정: 지정된 경로 이하에서 쿠키 사용 가능
cookie01.setMaxAge(60*60*24*2);//유효 기간 설정(초 단위)
response.addCookie(cookie01);//응답 객체에 추가

//회원아이디(mid)로 hong을 값으로 저장하고 1일 동안 사용자 PC에서 쿠키로 저장되도록 생성
Cookie cookie02 = new Cookie("mid", "hong");//쿠키 생성
cookie02.setPath(request.getContextPath());//경로 설정: 지정된 경로 이하에서 쿠키 사용 가능
cookie02.setMaxAge(60*60*24*1);//유효 기간 설정(초 단위)
response.addCookie(cookie02);//응답 객체에 추가
%>
pid, mid 쿠키 생성 완료!

</body>
</html>