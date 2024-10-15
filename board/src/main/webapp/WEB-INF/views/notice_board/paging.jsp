<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="searchField" value="${spVO.searchField}" />
<c:set var="searchWord" value="${spVO.searchWord}" />
<c:choose>
<c:when test="${not empty spVO.searchWord}">
	<!-- 검색어가 있는 경우: 페이징에 필요한 변수는 pagingVO에 저장되어 있고 이것은 Model객체에 저장되어 있음 -->
	

	<!-- 3. 현재 페이지블록이 1이 아닌 경우 '이전'과 맨처음페이지 기호(<<) 출력 -->
		<c:if test="${pagingVO.blockNum gt 1}">
			<a href="index.do?pageNum=1&blockNum=1&searchField=${searchField}&searchWord=${searchWord}">
				&lt;&lt;
			</a>&nbsp;
			<a href="index.do?pageNum=${(pagingVO.blockNum -2)*pagingVO.blockPages+1}&blockNum=${pagingVO.blockNum-1 }&searchField=${searchField}&searchWord=${searchWord}">
				이전
			</a>&nbsp;
	
		</c:if>
			<!-- 1. 총 페이지번호와 페이지블록을 연계하여 페이지번호 출력 -->
		<c:forEach var="i" begin="${(pagingVO.blockNum -1)*pagingVO.blockPages+1}"
				   end="${pagingVO.blockNum*pagingVO.blockPages}">
				   
			<c:if test="${i le pagingVO.totalPages}"><!-- 페이지 번호가 총/마지막 페이지번호보다 작거나 같은 경우  -->
				<a href="index.do?pageNum=${i}&blockNum=${pagingVO.blockNum}&searchField=${searchField}&searchWord=${searchWord}"><!--  파라미터: 현재 페이지번호, 현재 블록번호 -->
					<c:if test="${i eq pagingVO.pageNum}" var="result"><!-- 페이지번호가 현재 페이지번호인 경우 -->
						<span style="color:red;">${i}&nbsp;</span>
					</c:if>
					<c:if test="${not result}">
					${i} &nbsp;
					</c:if>
				</a>
			</c:if>
			
		</c:forEach>
		
		<!--  2. 총 페이지번호가 페이지블록을 초과하는 경우 '다음'과 맨마지막 페이지 기호(>>) 출력 -->
		<c:if test="${pagingVO.totalPages > (pagingVO.blockNum*pagingVO.blockPages)}">
		
			<a href="index.do?pageNum=${(pagingVO.blockNum*pagingVO.blockPages)+1}&blockNum=${pagingVO.blockNum+1}&searchField=${searchField}&searchWord=${searchWord}">
				다음
			</a>&nbsp;
			<a href="index.do?pageNum=${pagingVO.totalPages}&blockNum=${pagingVO.lastBlock}&searchField=${searchField}&searchWord=${searchWord}">
				&gt;&gt;
			</a>
		
		</c:if>
		
	</c:when>
		
	<c:otherwise>
		
		<!-- 검색어가 없는 경우: 페이징에 필요한 변수는 pagingVO에 저장되어 있고 이것은 Model객체에 저장되어 있음 -->

		<!-- 3. 현재 페이지블록이 1이 아닌 경우 '이전'과 맨처음페이지 기호(<<) 출력 -->
		<c:if test="${pagingVO.blockNum gt 1}">
			<a href="index.do?pageNum=1&blockNum=1">
				&lt;&lt;
			</a>&nbsp;
			<a href="index.do?pageNum=${(pagingVO.blockNum -2)*pagingVO.blockPages+1}&blockNum=${pagingVO.blockNum-1 }">
				이전
			</a>&nbsp;
		
		</c:if>
		
		
		<!-- 1. 총 페이지번호와 페이지블록을 연계하여 페이지번호 출력 -->
		<c:forEach var="i" begin="${(pagingVO.blockNum - 1)*pagingVO.blockPages+1}"
				   end="${pagingVO.blockNum*pagingVO.blockPages}">
				   
			<c:if test="${i le pagingVO.totalPages}"><!-- 페이지 번호가 총/마지막 페이지번호보다 작거나 같은 경우  -->
				<a href="index.do?pageNum=${i}&blockNum=${pagingVO.blockNum}"><!--  파라미터: 현재 페이지번호, 현재 블록번호 -->
					<c:if test="${i eq pagingVO.pageNum}" var="result"><!-- 페이지번호가 현재 페이지번호인 경우 -->
						<span style="color:red;">${i}&nbsp;</span>
					</c:if>
					<c:if test="${not result}">
					${i} &nbsp;
					</c:if>
				</a>
			</c:if>
			
		</c:forEach>
		
		<!--  2. 총 페이지번호가 페이지블록을 초과하는 경우 '다음'과 맨마지막 페이지 기호(>>) 출력 -->
		<c:if test="${pagingVO.totalPages > (pagingVO.blockNum*pagingVO.blockPages)}">
		
			<a href="index.do?pageNum=${(pagingVO.blockNum*pagingVO.blockPages)+1}&blockNum=${pagingVO.blockNum+1}">
				다음
			</a>&nbsp;
			<a href="index.do?pageNum=${pagingVO.totalPages}&blockNum=${pagingVO.lastBlock}">
				&gt;&gt;
			</a>
		</c:if>
		
		
	</c:otherwise>

</c:choose>


















