<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>param 객체</title>
</head>
<body>

<form method="post" action="ex05_el.jsp">
	메일 수신 여부: <input type="radio" name="receiveEmail" value="Y" checked>수신
			     <input type="radio" name="receiveEmail" value="N">거부<br><br>
	관심 분야:<br>
	<input type="checkbox" name="interest" value="정치">정치
	<input type="checkbox" name="interest" value="경제">경제	
	<input type="checkbox" name="interest" value="사회">사회	
	<input type="checkbox" name="interest" value="문화">문화<br><br>
	<input type="submit" value="ex05_el.jsp로 전송" >			     
</form>

</body>
</html>