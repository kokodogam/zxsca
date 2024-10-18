<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL 포맷팅 라이브러리: fmt</title>
</head>
<body>

<h3>숫자에 대한 포맷팅</h3>
<!-- formatNumber 태그: 숫자에 대한 포맷 -->
<hr>
<c:set var="num1" value="123456789" />
세 자리마다 콤마 출력 : <fmt:formatNumber value="${num1}" /><br>
세 자리마다 콤마 출력하지 않음 : <fmt:formatNumber value="${num1}" groupingUsed="false"/><br>
통화기호를 붙여서 출력 : <fmt:formatNumber value="${num1}" type="currency" /><br>
<fmt:formatNumber var="num2" value="${num1}" type="currency" />
통화기호를 붙여서 출력2 : ${num2}<br>

<hr>

<h3>문자열을 숫자로 변경하기</h3>
<!-- parseNumber 태그: 문자열을 숫자로 변경 -->
<c:set var="number1" value="123,456.789" />
<fmt:parseNumber var="number2" value="${number1}" pattern="000,000.00" />
소수점까지 출력 : ${number2}<br>
콤마를 표시해서 출력 : <fmt:formatNumber value="${number2}" /><br> 

<fmt:parseNumber var="number3" value="${number1}" integerOnly="true" />
정수 부분만 출력 : ${number3}<br> 

<hr>

<h3>날짜와 시간 포맷, 타임존 설정</h3>

<c:set var="today" value="<%= new Date() %>" />

<!-- formatDate 태그: 날짜와 시간 포맷 -->
<h4>날짜 포맷하여 출력하기</h4>
전체 : <fmt:formatDate value="${today}" type="date" dateStyle="full" /><br>
짧게 : <fmt:formatDate value="${today}" type="date" dateStyle="short" /><br>
길게 : <fmt:formatDate value="${today}" type="date" dateStyle="long" /><br>
기본 : <fmt:formatDate value="${today}" type="date" dateStyle="default" /><br>

<h4>시간 포맷하여 출력하기</h4>
전체 : <fmt:formatDate value="${today}" type="time" timeStyle="full" /><br>
짧게 : <fmt:formatDate value="${today}" type="time" timeStyle="short" /><br>
길게 : <fmt:formatDate value="${today}" type="time" timeStyle="long" /><br>
기본 : <fmt:formatDate value="${today}" type="time" timeStyle="default" /><br>

<h4>날짜와 시간 모두 포맷하여 출력하기</h4>
전체 : <fmt:formatDate value="${today}" type="both" dateStyle="full" timeStyle="full" /><br>
패턴 : <fmt:formatDate value="${today}" type="both" pattern="yyyy-MM-dd hh:mm:ss" /><br>

<!-- timeZone 태그: 타임존(시간대) 설정 -->
<h4>타임존에 대한 날짜와 시간 출력하기</h4>
<fmt:timeZone value="GMT">
	전체 : <fmt:formatDate value="${today}" type="both" dateStyle="full" timeStyle="full" /><br>
</fmt:timeZone>
<fmt:timeZone value="America/Chicago">
	전체 : <fmt:formatDate value="${today}" type="both" dateStyle="full" timeStyle="full" /><br>
</fmt:timeZone>

<hr>

<h3>언어와 국가코드로 지역을 설정하여 통화와 날짜 출력하기</h3>
<!-- setLocale 태그 : 언어와 국가코드로 지역 설정 -->
<c:set var="today" value="<%= new Date() %>" />

한글로 설정 : <fmt:setLocale value="ko_kr" />
<fmt:formatNumber value="10000000" type="currency" /> /
<fmt:formatDate value="${today}" /><br>

영어로 설정 : <fmt:setLocale value="en_US" />
<fmt:formatNumber value="10000000" type="currency" /> /
<fmt:formatDate value="${today}" /><br>

일어로 설정 : <fmt:setLocale value="ja_JP" />
<fmt:formatNumber value="10000000" type="currency" /> /
<fmt:formatDate value="${today}" /><br>

중국어로 설정 : <fmt:setLocale value="zh-chs_cn" />
<fmt:formatNumber value="10000000" type="currency" currencySymbol="元"/> /
<fmt:formatDate value="${today}" /><br>

<hr>

<h3>하나의 JSP페이지로 다른 언어로 작성된 둘 이상의 웹 페이지 생성하기</h3>
<!-- 
이클립스의 Project Explorer의 프로젝트 폴더에서 build/classes 폴더 아래에 properties 폴더를
생성하고 아래 2개의 properties 파일을 추가함

intro_ko.properties
TITLE=회사 소개
GREETING=이 사이트를 방문해 주셔서 감사합니다.
CONTENT=당사는 소프트웨어 개발을 주업무로 하는 회사입니다.
COMPANY_NAME=(주) 휴먼 소프트웨어

intro_en.properties
TITLE=About Us
GREETING=Thank you for visiting this site.
CONTENT=We are a dedicated software development company.
COMPANY_NAME=Human Software Inc.

 -->
<fmt:bundle basename="properties/intro_en">
	<h3><fmt:message key="TITLE" /></h3>
	<fmt:message key="GREETING" /><br>
	<fmt:message key="CONTENT" /><br>
	<fmt:message key="COMPANY_NAME" />
</fmt:bundle>











</body>
</html>