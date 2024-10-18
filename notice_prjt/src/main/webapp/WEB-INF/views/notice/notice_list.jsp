<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice_list.css">
</head>
<body>

    <div id="wrap">
        <div id="search-container">
            <div id="div-total"></div>
            <div id="div-search">
                <form>
                    <select name="searchField">
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                        <option value="writer">제목+내용</option>
                    </select>
                    <input type="text" name="searchWord" id="searchWord">
                    <input type="submit" id="search_btn" value="검색">
                </form>
            </div>
        </div>

        <table>
            <tr>
                <th>번호</th>
                <th>구분</th>
                <th>제목</th>
                <th>작성일</th>
            </tr>

            <c:choose>
                <c:when test="${empty noticeList}">
                    <tr>
                        <td colspan="4">등록된 게시물이 없습니다</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="notice" items="${noticeList}" varStatus="vs">
                        <tr>
                            <td>${notice.n_idx}</td>
                            <td>${notice.n_category}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/notice/view.do?n_idx=${notice.n_idx}">
                                    ${notice.n_title}
                                </a>
                            </td>
                            <td>
                                <fmt:formatDate value="${notice.n_regdate}" type="date" pattern="yyyy-MM-dd" />
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </table>
	<div class="notice_write_btn">
        <a href="${pageContext.request.contextPath}/write.do">
            <button type="button" id="write_btn">공지사항 등록</button> 
        </a>
        </div>
    </div>

</body>
</html>
