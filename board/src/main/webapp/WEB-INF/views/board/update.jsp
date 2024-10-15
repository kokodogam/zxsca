<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
</head>
<body>
<div id="wrap">
    <h2>글수정</h2>
    <div id="container">
        <form name="frmBoardUpdate" action="updateProcess.do" method="post">
            <input type="hidden" name="m_idx" value="${member.m_idx}">
            <input type="hidden" name="b_idx" value="${boardVO.b_idx}">
            작성자: <input type="text" name="b_writer" value="${boardVO.b_writer}" readonly><br>
            제목: <input type="text" name="b_title" value="${boardVO.b_title}"><br>
            내용<br>
            <textarea name="b_content" cols="30" rows="10">${boardVO.b_content}</textarea>
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
