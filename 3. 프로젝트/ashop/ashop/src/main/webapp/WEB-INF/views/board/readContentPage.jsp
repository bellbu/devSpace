<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h1>${data.boardVo.board_title }</h1>
	
	작성자 : ${data.memberVo.member_nick }<br>
	작성일 : ${data.boardVo.board_writedate }<br>
	조회수 : ${data.boardVo.board_readcount }<br>
	내용 : <br>
	${data.boardVo.board_content }<br>
	
	<a href="./mainPage">목록으로</a>
	
	<c:if test="${!empty sessionUser && sessionUser.member_no == data.boardVo.member_no }">
		<a href="./deleteContentProcess?board_no=${data.boardVo.board_no }">삭제</a>	
		<a href="./updateContentPage?board_no=${data.boardVo.board_no }">수정</a> 
	</c:if>

</body>
</html>










