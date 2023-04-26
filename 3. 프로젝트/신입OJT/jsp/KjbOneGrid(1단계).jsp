<%@ page language ="java"  pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="/WEB-INF/include/header.jsp"%>
<title>원그리드</title>
<script type="text/javascript">
var last_select_row = 1;
var lastSearchParam = {};

/*******************************************************************************
 //* FUNCTION 명 : $( document ).ready(function()
 * FUNCTION 기능설명 :팝업 최초 실행
 *******************************************************************************/
$( document ).ready(function() {
	f_InitView();
});

/*******************************************************************************
 * FUNCTION 명 : 초기화 > view 초기화
 * FUNCTION 기능설명 :
 *******************************************************************************/
function f_InitView() {
	f_InitTopView();

	f_InitMiddleView();

}

/*******************************************************************************
 * FUNCTION 명 : 초기화 > 상단 영역(ex:검색 등)
 * FUNCTION 기능설명 :
 *******************************************************************************/
function f_InitTopView() {
	
	$("#sStDate").setCal(0,-6,0);
	$("#sEdDate").setCal(0,0,0);
	
 	$("#sUserId, #sStDate ,#sEdDate").enter('f_Retrieve');	
	
	 
}

/*******************************************************************************
 * FUNCTION 명 : 초기화 > 중간 영역(ex:Grid, 입력 등)
 * FUNCTION 기능설명 :
 *******************************************************************************/
function f_InitMiddleView() {
	
	  $("#gr_List").tuiGrid({
 		  url: "/kjb/KjbOneGrid_Select.do"
 		, postData: f_SetParam()
		, rownumbers: false
		, height: 595
		, colNames: [
			'아이디',
			'비밀번호',
			'주소',
			'상세주소',
			'전화번호',
			'성별', 
			'생년월일',      	
			'등록날짜',
			'수정날짜'
		]
		,  colModel: [
			 {
				// 아이디
				name: 'userId'
				,align: "left"
				,width: "180" 
			}, {
				// 비밀번호
				name: 'userPw'
				,align: "left"
				,width: "300"
				,hidden:true
			}, {
				// 주소
				name: 'userAddr1'
				,align: "left"
				,width: "300"
			},{
				// 상세주소
				name: 'userAddr2'
				,align: "left"
				,width: "250"
			}, {
				// 전화번호
				name: 'userHp'
				,align: "center"
				,width: "200"
			}, {
				// 성별
				name: 'userSex'
				,align: "center"
				,width: "170"
			},{
				// 생년월일
				name: 'userBirth'
				,align: "center"
				,width: "230"
			},{
				// 등록날짜
				name: 'insDate'
				,align: "center"
				,width: "230"
			},{
				// 수정날짜
				name: 'updDate'
				,align: "center"
				,width: "230"
			}
		], 
       		loadComplete: function (data) {
       			if(data.length>0) {
    				$("#gr_List").setSelection(last_select_row); // last_select_row=1 전역변수 선언  
    			}
       			
       			
       		}
	});
	  

}

/*******************************************************************************
 * FUNCTION 명 : 기능 > 검색
 * FUNCTION 기능설명 :
 *******************************************************************************/
 function f_Retrieve() {
	$("#gr_List").setGridParam("clear");
	$("#gr_List").setGridParam({
		url: "/kjb/KjbOneGrid_Select.do",
		postData : f_SetParam()
	});
	
} 

/*******************************************************************************
* FUNCTION 명 :  
* FUNCTION 기능설명 :    
*******************************************************************************/
function f_SetParam() {
	lastSearchParam = {
		"sUserId" : $("#sUserId").val(),
		"sStDate" : $('#sStDate').getCal(),
		"sEdDate" : $('#sEdDate').getCal(),
		"sSexName" : $('input:radio[name="sSexName"]:checked').val()
	}
	return lastSearchParam;
}

  
</script>

</head>

<body>
<div class="app-admin-wrap layout-sidebar-compact sidebar-dark-purple sidenav-open clearfix">
    <%@include file="/WEB-INF/include/TopMenu.jsp" %>

	<!-- Search Box Start -->
	<div class="row">
		<div class="col-md-12">
			<div class="card mb-12">
				<div class="card-body">
					<div class="form-row">
						<div class="col-md-1">
							<label for="sUserId" class="col-form-label">아이디</label>
							<input class="form-control" type="text" id="sUserId" name="sUserId" maxlength="150"/>
						</div>

						<!-- 조회기간 -->
						<div class="col-md-2">
							<label for="sStDate" class="col-form-label"><span class="essential_astrisk">*</span>출생기간</label>
							<input class="form-control required" type="text" id="sStDate" name="sStDate" placeholder="YYYY-MM-DD"/>
							<div class="day-mid">~</div>
							<input class="form-control required" type="text" id="sEdDate" name="sEdDate" placeholder="YYYY-MM-DD"/>
						</div>
						
						<!-- 성별 -->
						<div class="col-md-2">
							<label class="col-form-label">성별</label>
							<label class="col-md-2 radio radio-primary required" style="display:inline;"><input type="radio" name="sSexName" value="남" /><span>남</span><span class="checkmark"></span></label>
							<label class="col-md-2 radio radio-primary required" style="display:inline;"><input type="radio" name="sSexName" value="여" /><span>여</span><span class="checkmark"></span></label>
						</div>

						<!-- 조회 버튼 -->
						<div class="col-md-1 search-btn">
							<button class="btn btn-info" onclick="f_Retrieve();" hotkey="F3">
								<i class="fa fa-search"></i>&nbsp;검색[F3]
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Search Box End -->

	<div class="row main-row">
		<div class="col-md-12">
			<div class="card mb-12">
				<div class="card-body">
					<h5><b>학생 정보</b></h5>
					<table id="gr_List"></table>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>