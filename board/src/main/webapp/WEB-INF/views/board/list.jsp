<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글목록</title>
</head>
<body>

    <div id="wrap">
        <div id="search-container">
            <div id="div-total">총게시물수: ${boardList.size()}</div>
            <div id="div-search">
                <form>
                    <select name="searchField">
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                        <option value="writer">작성자</option>
                    </select>
                    <input type="text" name="searchWord" id="searchWord">
                    <input type="submit" id="search_btn" value="검색">
                </form>
            </div>
        </div>

        <table border="1">
            <tr>
                <th>구분</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>

            <c:choose>
                <c:when test="${empty boardList}">
                    <tr>
                        <td colspan="5">등록된 게시물이 없습니다</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="board" items="${boardList}" varStatus="vs">
                        <tr>
                            <td>${vs.count}</td>
                            <td><a href="${pageContext.request.contextPath}/board/view.do?b_idx=${board.b_idx}">
                            		${board.b_title}
                            	</a>
                            </td>
                            <td>${board.b_writer}</td>
                            <td>
                                <fmt:formatDate value="${board.post_date}" type="date"
                                    pattern="yyyy-MM-dd" />
                            </td>
                            <td>${board.read_cnt}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

            <!-- 회원인 경우 글등록할 수 있도록 글등록 버튼 구현 -->
             <c:if test="${not empty member}">
                <tr>
                    <td colspan="5">
                        <a href="${pageContext.request.contextPath}/board/write.do">
                            <button type="button" id="write_btn">글등록</button> 
                        </a>
                    </td>

                </tr>

             </c:if>
            
        </table>

    </div>

</body>
</html>