<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>글쓰기</h1>
	
	<form action="./writeContentProcess" method="post">
		작성자 : ${sessionUser.member_nick }<br>
		제목 : <input type="text" name="board_title"><br>
		내용 : <br> 
		<textarea rows="10" cols="40" name="board_content"></textarea><br>
		<input type="submit" value="작성완료">
	</form>
	


</body>
</html>