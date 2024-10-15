<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/notice_view.css">
<!-- jQuery API 추가  -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>

<script>
	$(function(){
		//첨부파일을 클릭했을 때 다운로드 요청하기
		$(".div-attached").on("click", function(){
			location.href = this.dataset.href;
		});
	});
</script>

</head>
<body>
    <div id="wrap">
        <h2>사내 공지</h2>
        <div class="board-container">
        <div class="detail-header">
		<h2 class="detail-title">${noticeVO.nb_title}</h2>
		<div class="detail-meta">
            <span>작성자: ${noticeVO.nb_writer}</span> | 
					<span>조회수: ${noticeVO.read_cnt}</span> | 
					<span>작성일: <fmt:formatDate value="${noticeVO.post_date}" type="date" pattern="yyyy-MM-dd hh:mm:ss" /></span>
				</div>
			</div>
			<div class="detail-content">
				<p>${boardVO.b_content}</p>
			</div>
            <div>첨부파일:
            <c:if test="${not empty noticeVO.attachedList}">
            	<div>
            		<c:forEach var="attached" items="${noticeVO.attachedList}">
            <div class="div-attached" 
            	 data-href="download.do?origin_filename=${attached.origin_filename}&save_filename=${attached.save_filename}">
            <img src="${pageContext.request.contextPath}/resources/uploads/thumbnail-${attached.save_filename}" 
                 alt="이미지파일"><br>
            				${attached.origin_filename}
            			
            			</div>
            		</c:forEach>
            	</div>
            </c:if>
            
            </div>                        
                                   
            <div id="div-bundle-btn">
                <!-- 조건: 회원 + 자신이 쓴 게시글 -->
                <c:if test="${(not empty member) and (member.m_idx eq noticeVO.m_idx)}">
                    <button class="btn btn-edit" onclick="location.href='update.do?b_idx=${noticeVO.nb_idx}'">수정하기</button>
					<button class="btn btn-delete" onclick="deletePost()">삭제하기</button>
                </c:if>
                
                <button class="btn btn-back" onclick="location.href='${pageContext.request.contextPath}/index.do'">목록으로</button>
            </div>
        </div>

    </div>
    
<script>
	function deletePost(){
		const ans = confirm("정말 삭제하겠습니까?");
		
		if(ans){
			location.href="deleteProcess.do?nb_idx=${noticeVO.nb_idx}";
		}
	}


</script>    
    
    
    
</body>
</html>