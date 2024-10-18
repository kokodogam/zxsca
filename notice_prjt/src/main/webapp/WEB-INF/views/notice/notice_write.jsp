<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice_write.css">
</head>
<body>
<div id="wrap">
    <h2>글등록</h2>
    <div id="container">
        <form name="frmBoardWrite" action="writeProcess.do" method="post">
            <label for="category">카테고리</label>
            <select name="n_category" id="category">
                <option value="일반" selected>일반</option>
                <option value="서비스">서비스</option>
                <option value="당첨자발표">당첨자발표</option>
            </select>

            <label for="n_writer">작성자:</label>
            <input type="text" name="n_writer" id="n_writer" required><br>

            <label for="n_title">제목:</label>
            <input type="text" name="n_title" id="n_title" required><br>

            <label for="n_content">내용:</label>
            <textarea name="n_content" id="n_content" cols="30" rows="10" required></textarea><br>

            <div class="form-actions">
                <input type="submit" value="작성완료">
                <input type="reset" value="다시입력">
                <input type="button" value="목록보기" onclick="location.href='/'">
            </div>
        </form>
    </div>
</div>
</body>
</html>
