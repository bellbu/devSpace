<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href='../resources/css/reset.css' rel='stylesheet' />
<!-- jqGrid -->
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../resources/css/ui.jqgrid.css" />
<link href='../resources/css/calendar2.css' rel='stylesheet' />
<script src="../resources/js/grid.locale-kr.js"></script>
<script src="../resources/js/jquery.jqGrid.js"></script>
<script src="../resources/js/jQuery.jqGrid.setColWidth.js"></script>
</head>
<script>

			
				$("#list").jqGrid({
					url:'./aaa',
					datatype: "json",
					rowNum: 10,
					height: 500,
					autowidth:true,
					colNames:['IP'],
					 colModel: [	
							{name:'IP',index:'seq_user', align:'left'}
							],
				    pager: '#pager',
				    multiselect: true
				});
				
	
	
window.addEventListener("DOMContentLoaded" , function(){
	$(window).resize(function() {

		$("#list").setGridWidth($(this).width() * .100);

	});
});	

</script>
<body>

<div id="container">
		<div class="header">
			<h3 class="headerName">작업 관리</h3>
		</div>
		
	<div id="content">
		<div class="navBar">
			<ul>
				<li class="pageList"><a href=""><i class="bi bi-person"></i>사용자 관리</a></li>
				<li class="pageList"><a href=""><i class="bi bi-shield-check"></i>서버 관리</a></li>
				<li class="pageList on"><a href=""><i class="bi bi-calendar-check"></i>작업 관리</a></li>
			</ul>
		</div>
		<div id="myjqgridwrapper" style="width:100%">
		<table id="list"></table>
		<div id="pager"></div> 
		</div>
</div>
</div>
		
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>