<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>

<style>
/* 파일 input 태그를 다른 모양 바꾸기 */
input[type=file]{
	display: none;
	border-color: white;
}

/* 첨부파일 span */
#span-file-btn{
	display: inline-block;
    width:80px; 
    height:20px;
    line-height:20px;
    padding-top:5px;
    text-align:center;
    background-color:orange; 
    border-radius:20px;
    font:12px Arial,sans-serif;
    color:white;
    cursor: pointer;
}

#div-fileNames{
	font:bold 13px Arial,sans-serif;
}

/* 첨부파일 삭제 아이콘 */
.delete-file-icon{
	width: 20px;
	height: 20px;
}	

</style>

<script>
	$(function(){
		
		//파일창에서 선택한 파일명 출력하기
		$("input:file").on("change", function(){
			let fileNames = "";
			for(let i=0; i<this.files.length; i++){
				fileNames += this.files[i].name+"("+Math.round(this.files[i].size/1000000)+" MB)<br>";
			}
			$("#div-fileNames").css("margin-top", "10px").html(fileNames);
			
		});
		
		//삭제아이콘을 클릭했을 때 이미지 삭제하기
		$(".delete-file-icon").on("click", function(){
			
			const na_idx = this.dataset.na_idx;
			
			$.ajax({
				type: "post",
				url: "deleteAttached.do",
				data: {na_idx: na_idx},
				success: function(response){
					if(response === "OK"){
						//현재 페이지 다시 요청(새로고침)
						window.location.reload();
					}else{
						console.log("첨부파일 삭제 실패");
					}
				},
				error: function(error){
					console.log("첨부파일 삭제중 에러발생: "+error);
				}
				
			});//end of ajax
			
		});
		
	});

</script>

</head>
<body>
<div id="wrap">
    <h2>공지사항 수정</h2>
    <div id="container">
        <form name="frmNoticeUpdate" action="updateProcess.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="m_idx" value="${member.m_idx}">
            <input type="hidden" name="nb_idx" value="${noticeVO.nb_idx}">
            작성자: <input type="text" name="nb_writer" value="${noticeVO.nb_writer}" readonly><br>
            제목: <input type="text" name="nb_title" value="${noticeVO.nb_title}"><br>
            내용<br>
            <textarea name="nb_content" cols="30" rows="10">${noticeVO.nb_content}</textarea><br>
            
            <!-- 파일업로드 관련 추가 -->
            첨부파일(1개 파일 크기: 최대 5MB, 첨부 가능 파일 수 : 최대 4개)<br>
            <c:if test="${not empty noticeVO.attachedList}">
            	
            	<div>
            		<c:forEach var="attached" items="${noticeVO.attachedList}">
            	<div class="div-attached">
            	<img src="${pageContext.request.contextPath}/resources/uploads/thumbnail-${attached.save_filename}" 
                 alt="이미지파일">
            				<div>
            					${attached.origin_filename}&nbsp;&nbsp;
            	<img src="${pageContext.request.contextPath}/resources/css/icon/delete.png" 
            	     class="delete-file-icon" alt="삭제아이콘" data-na_idx="${attached.na_idx}">
            				
            				</div>
            			</div>
            		</c:forEach>
            	</div>
            </c:if>
            <label>
            	<input type="file" name="uploadFiles" multiple>
                <span id="span-file-btn">파일첨부</span>
            </label>
            <div id="div-fileNames"></div>
            
            
            
            <div>
                <input type="submit" value="수정하기">
                <input type="reset" value="다시입력">
                <input type="button" value="목록보기" onclick="location.href='../index.do'">
            </div>
        </form>

    </div>

</div>
</body>
</html>