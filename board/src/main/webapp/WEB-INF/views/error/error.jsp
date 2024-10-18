<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러 페이지</title>
</head>
<body>
<h3>에러</h3>
<hr>
<p>
	서비스 중 에러가 발생했습니다.<br>
	아래 에러 정보를 확인해 주세요.<p>
	
	[에러 정보]<br>
	발생 시간: ${time}<br>
	에러 URL: ${url}<br>
	에러 메시지: ${message}<br>
	상세내용:<br>
	${stackTrace}<br>
</p>
<p><a href="${pageContext.request.contextPath}/">홈으로 돌아가기</a></p>
</body>
</html>