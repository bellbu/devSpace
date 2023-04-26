<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<title>Insert title here</title>
<style>
	.text_center{
		text-align: center;
	}
</style>
</head>
<body>
	<div style="width: 1200px; margin:0 auto">
		<div class="container-fluid">
			<div class="row">
				<div class="col"><!-- 글로벌 nav -->
					<jsp:include page="../commons/global_nav.jsp"></jsp:include>
				</div>
			</div>
			<div class="row">
				<div class="col"></div>
				<div class="col-4">
					<form action="./joinMemberProcess" method="post">
					<div class="row" style="padding-top: 70px;">
						<div class="col text-center fs-2 fw-bold">회원가입</div>
					</div>	
					<div class="row mt-3">
						<div class="col">
							아이디<font color="red"><sup>&#149;</sup></font> 
						</div>
						<div class="row mt-1">
							<div class="col">
								<input type="text" name="member_id" class="form-control" placeholder="아이디를 입력"><br>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							비밀번호<font color="red"><sup>&#149;</sup></font> 
						</div>
						<div class="row mt-1">
							<div class="col">
								<input type="password" name="member_pw" class="form-control" placeholder="비밀번호 입력"><br>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							닉네임<font color="red"><sup>&#149;</sup></font> 
						</div>
						<div class="row mt-1">
							<div class="col">
								<input type="text" name="member_nick" class="form-control" placeholder="닉네임 입력"><br>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							성별<font color="red"><sup>&#149;</sup></font> 
						</div>
						<div class="row mt-1">
							<div class="col">
								<input type="radio" name="member_gender" value="M" class="form-check-input">남&nbsp;
								<input type="radio" name="member_gender" value="F" class="form-check-input">여
							</div>
						</div>
					</div>
					<div class="row mt-4">
						<div class="col">
							생년월일<font color="red"><sup>&#149;</sup></font>
						</div>	
						<div class="row mt-1">
							<div class="col">
								<input type="date" name="member_birth">
							</div>
						</div>
					</div>	
					<div class="row mt-4">
						<div class="col">
							전화번호<font color="red"><sup>&#149;</sup></font> 
						</div>
						<div class="row mt-1">
							<div class="col">
								<input type="text" name="member_phone" class="form-control" placeholder="전화번호 입력">
							</div>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col">
							이메일 
						</div>
						<div class="row mt-1">
							<div class="col">
								<input type="text" name="member_email" class="form-control" placeholder="이메일 입력">
							</div>
						</div>
					</div>
					<div class="row my-5">
						<div class="col d-grid">
							<input type="submit" value="회원가입" class="btn btn-success btn-lg">
						</div>
					</div>
					</form>
				</div>
				<div class="col"></div>
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>	
</body>
</html>