<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<title>Insert title here</title>
</head>
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
					<h1 style="text-align: center;">자유게시판</h1><br>
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
					<table class="table table-striped table-hover" style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th style="background-color: #eeeeee; text-align: center;">글번호</th>
								<th style="background-color: #eeeeee; text-align: center;">제목</th>
								<th style="background-color: #eeeeee; text-align: center;">작성자</th>
								<th style="background-color: #eeeeee; text-align: center;">작성일</th>
								<th style="background-color: #eeeeee; text-align: center;">조회수</th>
							</tr>  
						</thead>
						<tbody>
						<c:forEach items="${dataList }" var="data">
							<tr>
								<td>${data.boardVo.board_no }</td>		
								<td><a href="./kjbReadContentPage?board_no=${data.boardVo.board_no }">${data.boardVo.board_title }</a></td>		
								<td>${data.memberVo.member_nick }</td>		
								<td><fmt:formatDate value="${data.boardVo.board_writedate }" pattern="yyyy-MM-dd" /></td>		
								<td>${data.boardVo.board_readcount }</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
					<div class="row mt-4">
						<div class="col-3"></div>
						<div class="col">
							<nav aria-label="...">
							  <ul class="pagination mb-0">
							    <li class="page-item disabled">
							      <a class="page-link">Previous</a>
							    </li>
							    <li class="page-item"><a class="page-link" href="#">1</a></li>
							    <li class="page-item active" aria-current="page">
							      <a class="page-link" href="#">2</a>
							    </li>
							    <li class="page-item"><a class="page-link" href="#">3</a></li>
							    <li class="page-item"><a class="page-link" href="#">4</a></li>
							    <li class="page-item"><a class="page-link" href="#">5</a></li>
							    <li class="page-item">
							      <a class="page-link" href="#">Next</a>
							    </li>
							  </ul>
							</nav>							
						</div>
						<div class="col-2 d-grid">
							<c:if test="${!empty sessionUser }">
								<a href="./kjbWriteContentPage" class="btn btn-primary">글쓰기</a>
							</c:if>
						</div>
					</div>
				</div>
				<div class="col"></div>
			</div>
		</div>	
	</div>		
			


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>