<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글등록</title>
</head>
<body>
<div id="wrap">
    <h2>글목록</h2>
    <div id="container">
        <form name="frmBoardWrite" action="writeProcess.do" method="post">
            <!-- 회원번호 입력을 직접 받도록 변경 -->
           사원번호: <input type="text" name="m_idx" placeholder="시번을 입력하세요."><br>
            작성자: <input type="text" name="b_writer" placeholder="작성자를 입력하세요"><br>
            제목: <input type="text" name="b_title" ><br>
            내용<br>
            <textarea name="b_content" cols="30" rows="10"></textarea>
            <div>
                <input type="submit" value="작성완료">
                <input type="reset" value="다시입력">
                <input type="button" value="목록보기" onclick="location.href='../index.do'">
            </div>
        </form>
    </div>
</div>
</body>
</html>
