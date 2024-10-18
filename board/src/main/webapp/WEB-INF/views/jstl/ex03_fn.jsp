<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL fn 예제</title>
</head>
<body>

<h3>문자열 변수 정의 및 EL에서 JSTL 함수 사용</h3>
<c:set var="str" value="   Java based Web Programming   " />
본래의 문자열 : ${str}<br>
앞뒤 공백 제거 : ${fn:trim(str)}<br>
모두 대문자로 : ${fn:toUpperCase(str)}<br>
모두 소문자로 : ${fn:toLowerCase(str)}<br>
Web의 위치 : ${fn:indexOf(str, "Web")}<br>
Web 포함여부 : ${fn:contains(str, "Web")}<br>
Web 포함여부(대소문자 구분없음) : ${fn:containsIgnoreCase(str, "Web")}<br>
Web을 App로 바꿈 : ${fn:replace(str,"Web","App")}<br>
문자열의 길이 : ${fn:length(str)}<br>

<c:set var="web_idx" value='${fn:indexOf(str, "Web")}' />
Web 추출하기 : ${fn:substring(str, web_idx, (web_idx+3))}<br>

<h3>문자열 배열을 생성해서 forEach문으로 요소값 가져오기</h3>
<c:set var="words" value="${fn:split(str, ' ')}" />

<c:forEach var="word" items="${words}" >
${word}<br>
</c:forEach>

배열의 각 항목을 콤마로 구분해서 하나의 문자열로 표시 : ${fn:join(words, ", ")}<br>



</body>
</html>