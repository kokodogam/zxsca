<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!-- JSTL을 사용하려면 먼저 jstl-1.2.jar파일을 mvnrepository에서 다운받아서
WEB-INF/lib 폴더에 추가하고 이를 톰캣이 잘 인식하지 못할 경우 프로젝트의 build path의
설정부분에 외부 jar파일로 다운받은 jstl-1.2.jar파일을 추가해줌

JSP페이지에서 JSTL을 사용하려면 일반적으로 page지시자 다음에 tablib지시자를 위와 같이 정의해주어야 함
각각의 라이브러리(core, fmt, fn 등)는 별도로 정의해 주어야 함
 --> 
<%@ page import="java.util.Date, el.*, java.util.*" %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL: Core 예제</title>
</head>
<body>

<h3>1. set 태그: 변수 선언 및 초기화</h3>
<c:set var="num1" value="100" />
<c:set var="num2" value="${num1 mod 7}" />
<c:set var="sum" value="${num1 + num2}" />
변수 num1 : ${num1}<br> 
변수 num2 : ${num2}<br>
변수 sum : ${sum}<br>

<!-- 참조 타입 변수 선언 및 초기화 -->
<c:set var="now" value="<%= new Date() %>" />
<c:set var="hero" value='<%= new Person("이순신", 30) %>' scope="request" />
현재 날짜와 시간 : ${now}<br>
영웅의 이름과 나이 : ${hero.name}, ${hero.age}<br>

<!-- List 컬렉션을 변수로 선언하고 초기화 -->
<%
List<Person> personList = new ArrayList<>();
personList.add(new Person("강감찬", 40));
personList.add(new Person("김유신", 20));

//EL을 이용해서 set태그에 값을 세팅하려면 personList를 영역객체에 추가해주면 됨
pageContext.setAttribute("personList", personList);
%>
<c:set var="personList" value="${personList}" />
이름과 나이 : ${personList[1].name}, ${personList[1].age}<br>

<!-- 선언된 변수 삭제: remove -->
<c:remove var="personList" />
이름과 나이 : ${personList[1].name}, ${personList[1].age}<br>
<c:remove var="hero" scope="request" />
영웅의 이름과 나이 : ${hero.name}, ${hero.age}<br>

<hr>

<h3>2. 조건문: if, choose-when-otherwise </h3>
<!-- var 속성에 test 속성(조건식)의 결과값을 저장할 수 있음
     test 속성에 오는 값이 EL이 아닌 경우 false를 반환하고 대소문자 구분없이 true인 경우 true를 반환함
     test 속성에 오는 EL 양쪽에 공백이 있는 경우 false를 반환함 
 -->

<!-- 홀수와 짝수 판단하기 -->
<c:if test="${ 123 mod 2 eq 0 }" var="result">
	123은 짝수이다.<br>
</c:if>
<c:if test="${ not result }" >
   	123은 홀수이다.<br><br>
</c:if>   

<c:if test="홍길동" var="result2" />
<c:if test=" ${ true } " var="result3" />
test 속성에 EL이 아닌 값이 오는 경우 결과값: ${result2}<br>
test 속성에 오는 EL 양쪽에 공백이 있는 경우 결과값: ${result3}<br><br>

<!-- 검색어가 있는 경우와 검색어가 엇는 경우를 구분해서 실행하기 -->
<div>
	<form><!-- form의 action 속성이 없으면 현재 JSP페이지를 호출하여 입력값을 보냄  -->
		<select name="searchField">
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="writer">작성자</option>
		</select>	
		<input type="text" name="searchWord">
		<input type="submit" value="검색">
	</form>
</div>

<c:choose>
	<c:when test="${not empty param.searchWord}"><!-- 검색어가 있는 경우 -->
		검색영역: ${param.searchField}, 검색어: ${param.searchWord}<br>
	</c:when>
	<c:otherwise><!-- 검색어가 없는 경우 -->
		검색어가 없습니다. <br>
	</c:otherwise>
</c:choose>

<hr>

<h3>3. 반복문: forEach, forTokens</h3>
<!-- 
forEach 태그: 일반 for문, 확장 for문(foreach문) 모두 지원
  - varStatus 속성: 제어변수 var의 상태에 대한 값을 여러가지 속성(index,count,current,first,last)으로 반환함
forTokens 태그: for문 + StringTokenizer 클래스 기능
 -->

<!-- 일반 for문: 1부터 100까지의 정수 중 홀수의 합계를 출력하기 -->
<c:forEach var="i" begin="1" end="100" step="2">
	<c:set var="sum" value="${sum+i}" />
</c:forEach>
1부터 100까지의 정수 중 홀수의 합 : ${sum}<br>

<!-- 구구단에서 출력하기
 - 단을 구분하는 내용만 빨간색으로 출력하기 
 - 단을 몇번 출력했는지 마지막에 출력하기
-->
<c:forEach var="i" begin="2" end="9" step="2" varStatus="iStatus">
	
	<c:forEach var="j" begin="1" end="9" varStatus="jStatus">
		<c:if test="${jStatus.first}"> 
			<p style="color:red"> ${i} 단</p>
		</c:if>
		${i} x ${j} = ${i*j}<br>
	</c:forEach>
	
	iStatus의 index : ${iStatus.index}<br>
	iStatus의 current : ${iStatus.current}<br>
	
	<c:if test="${iStatus.last}">
		총 ${iStatus.count} 번 단을 출력함<br>
	</c:if>
</c:forEach>
<!-- 일반 for문에서 varStatus 변수의 index, current 속성값은 변수 i값과 같음 -->
 
<!-- 확장 for문 
 - 문자열 배열에 저장된 이름들을 콤마로 구분해서 출력하되 마지막 값은 콤마를 붙이지 않고 출력하기
-->
<!-- 문자열들을 배열로 정의해주는 메소드를 Conversion 클래스에 정의하기 : stringsToArray -->
<c:set var="names" value='${Conversion.stringsToArray("홍길동","이순신","강감찬")}' />
<c:forEach var="name" items="${names}" varStatus="nameStatus">
	${name}<c:if test="${not nameStatus.last}">,</c:if>
</c:forEach>
<br>
<c:forEach var="name" items="${names}" varStatus="nameStatus">
	nameStatus의 index : ${nameStatus.index}<br>
	nameStatus의 current : ${nameStatus.current}<br>
</c:forEach>
<!-- 확장 for문에서 varStatus변수의 index 속성값은 배열이나 컬렉션의 인텍스 값과 같음 -->

<!-- List객체에 저장된 Person 객체의 이름과 나이 출력하기 -->
<c:set var="personList" value='${Conversion.personsToList()}' />
<c:forEach var="person" items="${personList}">
	이름: ${person.name}, 나이: ${person.age}<br>
</c:forEach>

<!-- 일반 for문을 이용해서 personList에 저장된 Person객체의 이름과 나이 출력하기 -->
<c:forEach var="i" begin="0" end="1">
	이름: ${personList[i].name}, 나이: ${personList[i].age}<br>
</c:forEach>

<!-- forTokens 태그를 이용해서 문자열 토큰으로 출력하기 -->
<c:set var="subjects" value="Java,HTML,CSS,Javascript,React,SQL,Servlet,JSP,Springboot" />
<c:forTokens var="subject" items="${subjects}" delims="," varStatus="subjectStatus">
${subject}<c:if test="${not subjectStatus.last}">#</c:if>
</c:forTokens>

<hr>

<h3>4. 페이지 이동 제어 태그: import, redirect</h3>
<!-- 
import 태그: url속성의 otherPage.jsp의 실행결과를 var속성의 contents 변수에 저장함
redirect 태그: response객체의 sendRedirect()메소드와 같은 기능을 함
              context 속성에 컨텍스트 경로를 지정하면 url속성값은 그 이하의 경로를 지정하면 됨
 -->
<c:set var="bookName" value="JSP 자바 웹프로그래밍" scope="request" />
<c:import var="contents" url="ex01_otherPage.jsp">
	<c:param name="categrory1" value="JSP" />
	<c:param name="category2" value="기본서" />
</c:import>
contents 변수에 저장된 내용 : ${contents}
<p>

<%-- 
<c:redirect url="/jstl/ex01_otherPage.jsp" context="${pageContext.request.contextPath}">
	<c:param name="category1" value="행사상품" />
	<c:param name="category2" value="초특가" />
</c:redirect>
정상 실행되지만 재요청 처리되는 것을 막기 위해 주석처리함 --%>

<hr>

<h3>5. url 태그: url을 변수로 정의해서 사용</h3>
<!-- 
 - value속성: 컨텍스트 패스를 기본적으로 포함하고 있음. 컨텍스트 패스 이하에 붙는 경로를 지정해줌
 -->
<c:url var="otherUrl" value="/jstl/ex01_otherPage.jsp" />
<c:url var="homeUrl" value="/index.jsp" />

<a href = "${otherUrl}?category1=spring&category2=기본서">ex01_otherPage.jsp 바로가기</a><br>
<a href = "${homeUrl}"> 홈 </a>

<hr>

<h3>6. out 태그</h3>
<!-- 
- 표현식이나 EL과 동일한 역할
- 출력내용에 포함된 HTML 태그를 해석해서 적용할 수 있는 escapeXml 속성
  escapeXml속성을 false로 지정하면 HTML 태그를 해석하여 마크업이 적용된 상태로 출력함
- 출력내용이 null일 경우 기본값을 지정해서 출력할 수 있는 default 속성
  빈 문자열도 하나의 값이므로 빈 문자열이 입력된 경우 default에 지정된 값이 출력되지 않음 
 -->
<c:set var="iTag">
	i 태그는 <i style="color:red">기울임</i>을 표현합니다.
</c:set>

표현식이나 EL과 동일한 출력 : <c:out value="${iTag}" /><br>
출력내용에 포함된 HTML태그를 해석해서 출력 : <c:out value="${iTag}" escapeXml="false" /><br>
출력내용이 null일 경우 default 속성값 출력 : <c:out value="${param.name}" default="이름 없음" /><br>
출력내용이 빈 문자열인 경우 빈 문자열로 출력 : <c:out value="" default="값 없음" /><br>

<hr>

<h3>7. catch 태그: 예외 발생 구문에서 예외를 받아서 var 속성에 저장</h3>
<!-- 예외 발생 가능성이 있는 구문을 catch태그에 정의하고 예외처리 구문은 별도로 정의함 -->
<c:catch var="e">
<%
	int result = 100/0;
%>
</c:catch>
<c:if test="${not empty e}">
	예외 내용 : ${e} <br>
</c:if>


</body>
</html>