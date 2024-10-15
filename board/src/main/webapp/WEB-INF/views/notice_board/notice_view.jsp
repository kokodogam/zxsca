<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
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
        <h2>상세보기</h2>
        <div id="container">
            <div>작성자: ${noticeVO.nb_writer}</div>
            <div>제목: ${noticeVO.nb_title}</div>
            <div>내용: ${noticeVO.nb_content}</div>
            <div>조회수: ${noticeVO.read_cnt}</div>
            <div>작성일: <fmt:formatDate value="${noticeVO.post_date}" type="date"
                                    pattern="yyyy-MM-dd hh:mm:ss" /></div>
             
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
                    <input type="button" value="수정하기" onclick="location.href='update.do?nb_idx=${noticeVO.nb_idx}'">
                    <input type="button" value="삭제하기" onclick="deletePost()">
                </c:if>
                
                <input type="button" value="목록보기" onclick="location.href='${pageContext.request.contextPath}/index.do'">
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