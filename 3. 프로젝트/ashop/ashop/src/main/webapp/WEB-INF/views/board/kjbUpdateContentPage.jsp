<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>          
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
</head>
<style>
	td{
	border: 1px solid #bbbbbb;
	vertical-align : middle;
	}
</style>
<body>
	<div style="width:1200px; margin:0 auto">
		<div class="container-fluid">
			<div class="row">
				<div class="col">
					<jsp:include page="../commons/global_nav.jsp"></jsp:include>
				</div>
			</div>
			<div class="row mt-5">
				<div class="col">
					<h1 style="text-align: center;">게시글 수정</h1><br>
				</div>
			</div>
			<div class="row mt-2">
				<div class="col" style="padding-right: 20px;">
					<div class="list-group">
					  <a href="./mainPage" class="list-group-item list-group-item-action">Home</a>
					  <a href="./kjbMainPage" class="list-group-item list-group-item-action active" aria-current="true">자유게시판</a>
					  <a class="list-group-item list-group-item-action disabled">게시판1</a>
					  <a class="list-group-item list-group-item-action disabled">게시판2</a>
					  <a class="list-group-item list-group-item-action disabled">게시판3</a>
					</div>
				</div>
				<div class="col-9">
				<form action="./kjbUpdateContentProcess" method="post">
					<table class="table" style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th style="background-color: #eeeeee; text-align: center;" colspan="2"><font size="5">글쓰기</font></th>
							</tr>  
						</thead>
						<tbody>
							<tr>
								<td class="col-3" id="name">작성자</td>
								<td class="col-9" id="name" style="text-align: left; padding-left: 20px;">${sessionUser.member_nick }</td>
							</tr>
							<tr>
								<td>제목</td>
								<td><input type="text" value="${data.boardVo.board_title }" name="board_title" class="form-control"></td>
							</tr>
							<tr>
								<td>내용</td>
								<td><textarea id="summernote" name="board_content">${data.boardVo.board_content }</textarea></td>
							</tr>		
						</tbody>
					</table>
					<input type="hidden" name="board_no" value="${data.boardVo.board_no }">
					<div class="row mt-4">
						<div class="col d-grid" style="float: left;">
							<a href="./kjbMainPage" class="btn btn-success">목록</a>
						</div>
						<div class="col-9"></div>
						<div class="col d-grid" style="float: right;">
							<input type="submit" value="완료" class="btn btn-primary">
						</div>
					</div>
					<script>
						$('#summernote').summernote({
						  tabsize: 1,
						  height: 350,
						  toolbar: [
						    ['style', ['style']],
						    ['font', ['bold', 'underline', 'clear']],
						    ['color', ['color']],
						    ['para', ['ul', 'ol', 'paragraph']],
						    ['table', ['table']],
						    ['insert', ['link', 'picture', 'video']],
						  ]
						});
					</script>
				</form>	
				</div>
				<div class="col"></div>
			</div>
		</div>
	</div>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>