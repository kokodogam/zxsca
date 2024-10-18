<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사내 공지</title>
</head>
<body>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/notice_list.css">
 <h2> 사내 공지 </h2>
    <div id="wrap">
        <table id="board-table"
        	class="board-table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                    <th>첨부</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty noticeList}">
                        <tr>
                            <td colspan="6">등록된 게시물이 없습니다</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="notice" items="${noticeList}" varStatus="vs">
                            <tr>
                                <td>${noticeList[vs.count-1].nb_idx}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/notice_board/view.do?nb_idx=${notice.nb_idx}">
                                        ${notice.nb_title}
                                    </a>
                                </td>
                                <td>${notice.nb_writer}</td>
                                <td>
                                    <fmt:formatDate value="${notice.post_date}" type="date" pattern="yyyy-MM-dd" />
                                </td>
                                <td>${notice.read_cnt}</td>
                                <td>
                                    <c:if test="${not empty notice.attachedList}">
                                        <img src="${pageContext.request.contextPath}/resources/css/icon/download.png"
                                            alt="첨부파일" class="attachment-icon">
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        
        <!-- 검색기능 -->
<div class="search-container"> 
<!-- 페이징 추가 -->
		<div class="paging">
             <c:if test="${not empty noticeList}">
             	<tr>
             		<td id="td_paging" colspan="6">
             			<%@ include file="paging.jsp" %>
             		
             		</td>
             	</tr>
             </c:if> 
             </div>        
            <div class="search-box">
                <form>
                
                    <select name="searchField" class="search-field">
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                        <option value="writer">작성자</option>
                    </select>
                    <input type="text" name="searchWord" class="search-word" >
                    <input type="submit" id="search_btn" value="검색">
      
            
              <a class="button-box" href="${pageContext.request.contextPath}/notice_board/write.do">
                    <button type="button" id="write_btn">글 쓰기</button> 
                </a>
           
            
      
	</form>
	</div>
	</div>
    </div>

</body>
</html>