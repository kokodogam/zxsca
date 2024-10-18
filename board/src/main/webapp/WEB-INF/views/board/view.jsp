<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분실물 게시판</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/board_view.css">
</head>
<body>
	<div class="wrap">
		<h2>분실물 게시판</h2>
		<div class="board-container">
		<div class="detail-header">
		<h2 class="detail-title">${boardVO.b_title}</h2>
		<div class="detail-meta">
			<span>작성자: ${boardVO.b_writer}</span> | 
					<span>조회수: ${boardVO.read_cnt}</span> | 
					<span>작성일: <fmt:formatDate value="${boardVO.post_date}" type="date" pattern="yyyy-MM-dd hh:mm:ss" /></span>
				</div>
			</div>
			<div class="detail-content">
				<p>${boardVO.b_content}</p>
			</div>
			<div class="detail-btn-group">
				<!-- 조건: 회원 + 자신이 쓴 게시글-->
				<c:if test="${(not empty member) and (member.m_idx eq boardVO.m_idx)}">
					<button class="btn btn-edit" onclick="location.href='update.do?b_idx=${boardVO.b_idx}'">수정하기</button>
					<button class="btn btn-delete" onclick="deletePost()">삭제하기</button>
				</c:if>
				<button class="btn btn-back" onclick="location.href='${pageContext.request.contextPath}/index.do'">목록으로</button>
			</div>
		</div>
	</div>

	<script>
		function deletePost() {
			const ans = confirm("정말 삭제하겠습니까?");
			if (ans) {
				location.href = "deleteProcess.do?b_idx=${boardVO.b_idx}";
			}
		}
	</script>
</body>
</html>
