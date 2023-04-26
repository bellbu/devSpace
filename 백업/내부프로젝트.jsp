<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/include/mobile/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<!-- <link rel="stylesheet" type="text/css" href="../css/mobile/pop.css"/> -->
<%-- <script type="text/javascript" src="<c:url value='../js/tablet/pop.js'/>"></script> --%>
<link rel="stylesheet" type="text/css" href="../css/mobile/orderPop.css"/>
</head>
<body ondragstart="return false">
	<div class="pop_default">
	
		<header>
			<div class="userve_logo svg_default "></div>
		</header>
		
		<main class="Main scroll_y">
			<section class="menuImg"></section>
			
			<section class="mainSection">
				<article>
					<div class="menuName font_c2">참치 스페셜222222</div>
					<div class="menuDescription font_c5 Gray500 flex_left_row">부드러운 참치</div>
				</article>
				
				<article>
					<div class="option_box">
						<div class="option">
							<div class="font_c2 Gray700 flex_left_row">옵션1</div>
						</div>
			           	<div class = "detail_option">
	                        <div class="option_button">
	                            <div class="radioDef icon30 svg_default option_select flex_left_row"></div>
	                            <div class="detailOption font_C4 Gray700 flex_left_row" >옵션 세부1</div>
	                        </div>
	                        <div class="option_button">
	                            <div class="radioSel icon30 svg_default option_select flex_left_row"></div>
	                            <div class="detailOption font_C4 Gray700 flex_left_row" >옵션 세부2</div>
	                        </div>
						</div>
					</div>
					<div class="option_box">
						<div class="option">
							<div class="font_c2 Gray700 flex_left_row">옵션2</div>
						</div>
			           	<div class = "detail_option">
	                        <div class="option_button">
	                            <div class="radioDef icon30 svg_default option_select flex_left_row"></div>
	                            <div class="detailOption font_C4 Gray700 flex_left_row" >옵션 세부1</div>
	                        </div>
	                        <div class="option_button">
	                            <div class="radioSel icon30 svg_default option_select flex_left_row"></div>
	                            <div class="detailOption font_C4 Gray700 flex_left_row" >옵션 세부2</div>
	                        </div>
						</div>
					</div>
				</article>
				
			</section>	
		</main>
		
<!-- 		<main class="amountMain"> -->
<!-- 			<section class="amountSection flex_between_row"> -->
			
<!-- 				<article class="amountTitle"> -->
<!-- 					<div class="font_c2 Gray700 flex_left_row">수 량</div> -->
<!-- 				</article> -->
<!-- 				<article class="amountNumber"> -->
<!-- 			 		<div class="btnMinus icon25 svg_default amount_select"></div> -->
<!-- 				    <div class="btnNumber font_c2 Gray500">2</div> -->
<!-- 				    <div class="btnPlus icon25 svg_default amount_select"></div> -->
<!-- 				</article> -->
				
<!-- 			</section> -->
<!-- 		</main> -->
                
		<footer>
			<section class="amountMain">
				<section class="amountSection flex_between_row">
				
					<article class="amountTitle">
						<div class="font_c2 Gray700 flex_left_row">수 량</div>
					</article>
					<article class="amountNumber">
				 		<div class="btnMinus icon25 svg_default amount_select"></div>
					    <div class="btnNumber font_c2 Gray500">2</div>
					    <div class="btnPlus icon25 svg_default amount_select"></div>
					</article>
					
				</section>
			</section>
			<section>
				<article class="btn_gray w4">
					<div class="font_c2">취&nbsp;&nbsp;&nbsp;소</div>
				</article>
				<article class="btn_main w6">
					<div class="price font_c2">38,000<br>담&nbsp;&nbsp;&nbsp;기</div>
				</article>
			</section>
		</footer>
		
	</div>
	
<script type="text/javascript">
$(document).ready(() => {
});
</script>

</body>
</html>


