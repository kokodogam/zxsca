<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="el.*, java.util.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기타 EL 예제</title>
</head>
<body>
<h3>자바의 메소드 호출</h3>
<hr>
<!-- static 메소드 호출: Conversion클래스의 doubleToInt(double d):int 메소드  -->
100의 제곱근: ${Conversion.doubleToInt(Math.sqrt(100))}<br>

<!-- 인스턴스 메소드 호출: Calculator클래스의 sum(i:int, j:int):int 메소드 -->
<!-- useBean 액션태그를 이용해서 객체 생성하기 -->
<jsp:useBean id="calc" class="el.Calculator" />
1234 + 3456 : ${calc.sum(1234,3456)}<br>

<hr>
<h3>EL 연산식</h3>
<!-- 산술, 비교, 논리, 조건(3항) 연산자 -->
100 + 200 : ${100+200}<br>
100 == 200: ${100 == 200}<br>
(100>200) && (100<200): ${ (100>200) && (100<200) }<br>
(100>200) ? 최대값은 100 : 최대값은 200 : ${ (100>200)? "최대값은 100" : "최대값은 200"} <br>

<!-- 영문 연산자: HTML, JSP와의 혼선을 피하기 위해 사용 -->
<h3>영문 연산자</h3>
100 == 200 : ${100 eq 200}<br>
(100 > 200) && (100 < 200) : ${(100 gt 200) and (100 lt 200)}<br>
(100>200) ? 최대값은 100 : 최대값은 200 : ${ (100 gt 200)? "최대값은 100" : "최대값은 200"} <br>

<!-- empty 연산자: null, 빈 문자열, 길이가 0인 배열, size가 0인 컬렉션이면 true 반환 -->
<h3>empty 연산자</h3>
Calculator객체가 없으면 true : ${empty calc}<br>
Data객체가 있으면 true : ${not empty data}<br>

<h3>문자열 비교</h3>
Hong과 hong이 같으면 true : ${"Hong" == "hong"}<br>

<h3>+ 기호: 덧셈 연산자(연결연산자가 아님)</h3>
<%-- 아이디 : hong : ${"아이디 : " + "hong"}<br> --%>

<h3>null 연산: EL에서 null로 산술연산을 할 경우 0으로 인식됨</h3>
<%-- null + 100 : ${null + 100}<br>  실행은 정상적으로 되지만 에러 표시때문에 주석처리함--%>

<hr>

<h3>param 객체</h3>
메일 수신 여부: ${param.receiveEmail}<br>
관심 분야: ${paramValues.interest[0]}&nbsp;&nbsp;${paramValues.interest[1]}&nbsp;&nbsp;
		 ${paramValues.interest[2]}&nbsp;&nbsp;${paramValues.interest[3]}	

<hr>

<h3>cookie 객체</h3>
쿠키 전체 내용: ${header.cookie}<br>
pid 쿠키 값: ${cookie.pid.value}<br>

<hr>

<h3>Map, List 객체에 접근하기</h3>
<%
//List객체에 Person객체 저장
List<Person> personList = new ArrayList<Person>();
personList.add(new Person("이순신", 30));
personList.add(new Person("김유신", 40));
personList.add(new Person("강감찬", 50));

//page영역에 personList객체를 속성으로 추가
pageContext.setAttribute("personList", personList);

//Map객체에 언어 저장
Map<String, String> langMap = new HashMap<String, String>();
langMap.put("kor", "Korean");
langMap.put("eng", "English");

//page영역에 langMap객체를 속성으로 추가
pageContext.setAttribute("langMap", langMap);

%>

사람 리스트<br>
이름 : ${personList[0].name},  나이 : ${personList[0].age}<br>
이름 : ${personList[1].name},  나이 : ${personList[1].age}<br>
이름 : ${personList[2].name},  나이 : ${personList[2].age}<br>

언어 Map<br>
한국어 : ${langMap.kor}<br>
영어 : ${langMap["eng"]}<br>

<hr>









</body>
</html>