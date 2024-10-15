<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<ul>
	<c:if test="${not empty bookName}">
		<li>request속성값: ${bookName} </li>
	</c:if>
	<li>파라미터 1 : ${param.category1}</li>
	<li>파라미터 2 : ${param.category2}</li>
</ul>