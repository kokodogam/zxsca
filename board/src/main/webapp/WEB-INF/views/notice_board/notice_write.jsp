<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글등록</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/write.css">
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
		
		
	});

</script>

</head>
<body>
<div id="wrap">
    <h2>공지사항등록</h2>
    <div id="container">
    	<!-- 파일업로드를 하는 form태그: method는 post방식으로, enctype="multipart/form-data"속성 정의 -->
        <form name="frmNoticeWrite" action="writeProcess.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="m_idx" value="${member.m_idx}">
            작성자: <input type="text" name="nb_writer" value="${member.member_name}" readonly><br>
            제목: <input type="text" name="nb_title"><br>
            내용<br>
            <textarea name="nb_content" cols="30" rows="10"></textarea><br>
            
            <!-- 파일업로드 관련 추가 -->
            첨부파일(1개 파일크기: 최대 5MB, 첨부가능 파일 수: 최대 4개)<br>
            <label>
            	<input type="file" name="uploadFiles" multiple>
                <span id="span-file-btn">파일첨부</span>
            </label>
            <div id="div-fileNames"></div>
            
            <div id="div-bundle-btn">
                <input type="submit" value="작성완료">
                <input type="reset" value="다시입력">
                <input type="button" value="목록보기" onclick="location.href='../index.do'">
            </div>
        </form>

    </div>

</div>
</body>
</html>