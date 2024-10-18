<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 영역(scope)</title>
</head>
<body>
<h3>각 영역별로 동일한 이름의 속성을 추가하고 결과값 확인하기</h3>
<hr>
<%
pageContext.setAttribute("name", "홍길동P");
//request.setAttribute("name", "홍길동R");
session.setAttribute("name", "홍길동S");
//application.setAttribute("name", "홍길동A");

%>

<p>
EL로 확인하기<br>
page 영역에 저장된 name : ${name}<br>
session 영역에 저장된 name : ${sessionScope.name}<br>

</p>

</body>
</html>