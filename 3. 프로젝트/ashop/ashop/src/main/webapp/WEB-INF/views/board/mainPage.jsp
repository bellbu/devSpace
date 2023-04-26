<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<title>Insert title here</title>
</head>
<body>
	<div style="width:1200px; margin: 0 auto">
		<div class="container-fluid">
			<div class="row">
				<div class="col"><!-- 글로벌 nav -->
					<jsp:include page="../commons/global_nav.jsp"></jsp:include>
				</div>
			</div>
			<div class="row" style="padding-top: 24px; padding-bottom: 48px;"><!-- 배너.. -->
				<div class="col" style="text-align : center;">
					<img src="../resources/img/logo.png" height="180">
				</div>
			</div>
			<div class="row" style="padding-bottom:80px;"><!-- carousel -->
				<div class="col" style="text-align : center;">
					<div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
					  <div class="carousel-inner">
					    <div class="carousel-item active">
					      <img src="../resources/img/apparel1.jpg" height="600">
					      <div class="carousel-caption">
								<h2>OPEN SALE</h2>
								<h1>50%</h1>
					      	</div>
					    </div>
					    <div class="carousel-item">
					      <img src="../resources/img/apparel2.jpg" height="700">
					      <div class="carousel-caption">
								<h2>OPEN SALE</h2>
								<h1>50%</h1>
					      	</div>
					    </div>
					    <div class="carousel-item">
					      <img src="../resources/img/apparel3.jpg" height="700">
					    	<div class="carousel-caption">
								<h2>OPEN SALE</h2>
								<h1>50%</h1>
					      	</div>
					    </div>
					  </div>
					  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
					    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					    <span class="visually-hidden">Previous</span>
					  </button>
					  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true"></span>
					    <span class="visually-hidden">Next</span>
					  </button>
					</div>
				</div>
			</div>
		</div>
	</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>