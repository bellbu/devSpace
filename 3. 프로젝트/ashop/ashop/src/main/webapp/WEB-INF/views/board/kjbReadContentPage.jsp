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
					<table class="table" style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th style="background-color: #eeeeee; text-align: left; padding-left: 40px;">${data.boardVo.board_title }</th>
								<th style="background-color: #eeeeee; text-align: right; padding-right: 40px;">${data.memberVo.member_nick } | 조회 : ${data.boardVo.board_readcount } | <fmt:formatDate value="${data.boardVo.board_writedate }" pattern="yyyy-MM-dd (hh:mm)" /></th>
							</tr>  
						</thead>
						<tbody>
							<tr>
								<td colspan="2" style="padding: 15px 40px 12px; text-align: left;">${data.boardVo.board_content }</td>
							</tr>		
						</tbody>
					</table>
					<div class="row mt-1">
						<div class="col" style="float: left; padding-right: 0px;">
							<a href="./kjbMainPage" class="btn btn-success">목록</a>
						</div>
						<div class="col-2" style="float: left; padding-right: 0px;padding-left: 0px">
							<c:if test="${!empty sessionUser }">
								<a href="./kjbWriteContentPage" class="btn btn-primary">글쓰기</a>
							</c:if>
						</div>
						<div class="col-7"></div>
						<div class="col" style="float: right; padding-right: 0px;padding-left: 0px">
							<c:if test="${!empty sessionUser && sessionUser.member_no == data.boardVo.member_no }">
								<a href="./kjbDeleteContentProcess?board_no=${data.boardVo.board_no }" class="btn btn-danger">삭제</a>
							</c:if>
						</div>  
						<div class="col" style="float: right; padding-right: 0px;padding-left: 0px">
							<c:if test="${!empty sessionUser && sessionUser.member_no == data.boardVo.member_no }">
								<a href="./kjbUpdateContentPage?board_no=${data.boardVo.board_no }" class="btn btn-warning">수정</a>
							</c:if>        
						</div>
						
						<div class="row mt-5" style="margin-right:0px; padding-right:0px">
							<div class="col" style="padding-right: 0px;">
								<div class="card">
									<div class="card-header">댓글리스트</div>
									 <ul class="list-group">
										<c:forEach items="${commentList }" var="comment">
										 	<li class="list-group-item d-flex justify-content-between">
										 		<div>${comment.commentVo.comment_content }</div>
										 		<div class="d-flex">
													<div>작성자 : ${comment.memberVo.member_nick}&nbsp;(<fmt:formatDate value="${comment.commentVo.comment_writedate }" pattern="yyyy-MM-dd hh:mm" />)&nbsp;</div>
													<c:if test="${!empty sessionUser && sessionUser.member_no == comment.commentVo.member_no }">
														<a href="./deleteCommentProcess?comment_no=${comment.commentVo.comment_no }&board_no=${data.boardVo.board_no }" class="btn btn-danger btn-sm">삭제</a>
													</c:if>
												</div>	
											</li>
										 </c:forEach>
									 </ul>
								</div>		
							<c:if test="${!empty sessionUser }">
								<form action="./kjbWriteCommentProcess" method="post">
									<div class="row my-4">
										<div class="col-11">
											<textarea class="form-control" rows="3" name="comment_content"></textarea>
											<input type="hidden" name="member_no" value="${sessionUser.member_no }">
											<input type="hidden" name="board_no" value="${data.boardVo.board_no }">
										</div>	
										<div class="col d-grid" style="float: center; padding-left: 2px; padding-right: 10px;">
											<input type="submit" value="등록" class="btn btn-primary">
										</div>
									</div>
								</form>
							</c:if>	
							</div>
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