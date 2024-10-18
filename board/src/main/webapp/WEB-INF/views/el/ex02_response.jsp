<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Collection" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>response 객체를 이용해서 HTTP 응답헤더에 값 추가하기</title>
</head>
<body>
<h3>response 객체를 이용해서 HTTP 응답헤더에 값 추가하기</h3>
<hr>
<%
//날짜 형식의 값 추가하기
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
long dateVal = dateFormat.parse("2024-09-23").getTime();
//1970.1.1.0시0분0초 부터 2024.9.23(KST를 GMT로 환산: 9시간을 뺌)까지를 밀리초로 환산한 값
response.addDateHeader("drawDate", dateVal);

//숫자값 추가하기
response.addIntHeader("luckyNumber", 1004);

//문자열값 추가하기
response.addHeader("prizeWinner", "홍길동");

%>
<hr>
<h3>HTTP 응답헤더에 저장된 값 확인하기</h3>
<hr>
<%
Collection<String> headerNames = response.getHeaderNames();
for(String name : headerNames){
	out.println(name+" : "+response.getHeader(name)+"<br>");
}
%>

<p>
EL로 확인하기<br>
<!--  정상적으로 실행되나 에러 표시 때문에 주석처리함
drawDate : ${pageContext.response.getHeader("drawDate")}<br>
luckyNumber : ${pageContext.response.getHeader("luckyNumber")}<br>
prizeWinner : ${pageContext.response.getHeader("prizeWinner")}<br>
-->
</p>



</body>
</html>