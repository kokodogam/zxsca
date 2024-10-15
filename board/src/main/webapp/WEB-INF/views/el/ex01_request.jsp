<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %> 
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>request 객체</title>
</head>
<body>
<h3>request객체에 저장된 HTTP 헤더정보들</h3>
<hr>
<%
//HTTP요청 헤더에 저장된 모든 헤더 이름을 열거형(Enumeration) 객체로 가져오기
Enumeration<String> headerNames = request.getHeaderNames();

while(headerNames.hasMoreElements()){
	String headerName = headerNames.nextElement();
	out.println(headerName+" : "+ request.getHeader(headerName)+"<br>");
}
%>

<p>
EL로 요청 헤더에 저장된 정보 확인하기<br>
host: ${header.host}<br>
user-agent: ${header["user-agent"]}<br>

</p>
<hr>
<h3>request객체에 저장된 쿠키 정보들</h3>
<hr>
<%
//request객체에 저장된 쿠키들 가져오기
Cookie[] cookies = request.getCookies();

for(Cookie cookie : cookies){
	out.println(cookie.getName()+" : "+cookie.getValue()+" : "+cookie.getMaxAge()+" : "+cookie.getPath()+"<br>");
}
//쿠키에 대한 설정내용은 JSP/서블릿에서는 name과 value만 확인 가능하고 유효기간은 -1로, 경로는 null로 출력됨
//개발자 도구(F12)에서 애플리케이션의 왼쪽 저장용량의 쿠키 부분에서 확인하면 쿠키에 대한 모든 설정내용을 확인할 수 있음
%>
<p>
EL로 쿠키에 대한 정보 확인하기<br>
쿠키 name: ${cookie.JSESSIONID.name}<br>
쿠키 value: ${cookie.JSESSIONID.value}<br>
</p>

<hr>
<h3>request객체에 저장된 URL/URI, 요청방식 정보들</h3>
<hr>
<%
out.println("서버의 도메인명:"+request.getServerName()+"<br>");
out.println("서버의 포트번호:"+request.getServerPort()+"<br>");
out.println("요청 URL:"+request.getRequestURL()+"<br>");
out.println("요청 URI:"+request.getRequestURI()+"<br>");
out.println("쿼리 스트링:"+request.getQueryString()+"<br>");
out.println("클라이언트 호스트명:"+request.getRemoteHost()+"<br>");
out.println("클라이언트 IP주소:"+request.getRemoteAddr()+"<br>");
out.println("요청에 사용된 프로토콜:"+request.getProtocol()+"<br>");
out.println("요청방식:"+request.getMethod()+"<br>");
out.println("컨텍스트 패스:"+request.getContextPath()+"<br>");
out.println("el 폴더의 실제 경로:"+request.getRealPath("/el")+"<br>");

%>
<p>
EL로 확인하기<br>
서버 도메인명: ${pageContext.request.serverName}<br>
서버 포트번호: ${pageContext.request.serverPort}<br>
요청 프로토콜: ${pageContext.request.protocol}<br>
</p>


</body>
</html>