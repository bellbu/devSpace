<%@ page language ="java"  pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="/WEB-INF/include/header.jsp"%> 
<title>그리드 CRUD</title>

<script type="text/javascript">
var selrow1 = 1;
var selrow = 0;
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
	
	f_setEvent();
}

/*******************************************************************************
* FUNCTION 명 : 초기화 > 그리드 클릭 이벤트
* FUNCTION 기능설명 :  
*******************************************************************************/
function f_setEvent() {     
	$("#gr_UserList").createGridEvent(
			'f_Create',
			{	// read
	            onClickEvent:'f_scoreLength'
			 }
			,{	// update
			 }
			);
	
}
/*******************************************************************************
* FUNCTION 명 : 초기화 > 상단 영역(ex:검색 등)
* FUNCTION 기능설명 :  
*******************************************************************************/
function f_InitTopView() {
    
    $("#sUserId").enter('f_Retrieve');	
    
}
/*******************************************************************************
* FUNCTION 명 : 초기화 > 중간 영역(ex:Grid, 입력 등)
* FUNCTION 기능설명 :  
*******************************************************************************/
function f_InitMiddleView() {
	$("#gr_UserList").tuiGrid({
 	   url : '/kjb/KjbOneGrid_Select.do'	
	  	,postData : {											
	  	}
		,rownumbers: false  
		,height : 600												
		,colNames : [
		             '코드',
		             '아이디',
		            ]
		,colModel : [ 
				{	//코드
					 name : 'corpCode'
					,align : "center"
					,width : "200"
				},{
					//아이디
					name : 'userIdAdd'
					,align : "left"
					,width : "368"
				}
		]
		,loadComplete : function() {
			if($("#gr_UserList").getGrid().getRowCount() > (selrow)){  // var selrow = 0; 전역변수 선언
				$("#gr_UserList").setSelection(selrow+1); // rowCount 0이상 인 경우 첫번째(1) 그리드 선택 / setSelection(): 1이 첫번째 그리드
   			}else{
   				$("#gr_UserList").setSelection(1);  	  // rowCount 0이하 인 경우 첫번째(1) 그리드 선택
   			}
            
		}
	});
	
	$("#gr_ScoreList").tuiGrid({
		 rownumbers: false
		, height: 483
		, colNames: [
			'아이디',
			'시크릿 날짜',
			'시험날짜',
			'국어', 	
			'수학', 	
			'영어',
			'예체능'
		]
		,  colModel: [
			{name : 'userIdAdd', hidden:true},
			{name : 'sGradeDate', hidden:true}
			,{
				name : 'gradeDate'
				,align : "center"
				,width : "auto"
				,editable : true
				,template : getDatePickerTemplate(true)
			},{
				name : 'korean'
				,align : "right"
				,width : "auto"
				,editable : true
				,template : getNumberTemplate(3, true)
			},{
				name : 'math'
				,align : "right"
				,width : "auto"
				,editable : true
				,template : getNumberTemplate(3, true)
			},{
				name : 'eng'
				,align : "right"
				,width : "auto"
				,editable : true
				,template : getNumberTemplate(3, true)
			},{
				name : 'etc'
					,align : "right"
					,width : "auto"
					,editable : true
					,template : getNumberTemplate(3, true)
			}
		], 
       		loadComplete: function (data) {
       			var grid = $('#gr_ScoreList').getGrid();
       			if(grid.getRowCount()>0){
       				grid.focus(0,'gradeDate',true) // rowCount 0이상인 경우 첫번째(0) 그리드의 컬럼명 선택 / .focus(): 0이 첫번째 그리드??
       			}	
		}
	});
	
	
}

/*******************************************************************************
 * FUNCTION 명 : 뷰 > 폼 > 신규
 * FUNCTION 기능설명 : 
 *******************************************************************************/
function f_Create() {
	
	 var rowData = $("#gr_UserList").getRowData(selrow);  //var selrow = 0; 전역변수 선언
	 	if(rowData == null){
	 		alert("학생을 선택해 주세요.");
	 		return;
	 	}
	
	var AddRow = new Object();
	AddRow.type = 'add';
	AddRow.userId = rowData['userIdAdd'];
	$("#gr_ScoreList").GridAdd(AddRow);
	var getRowCount = $("#gr_ScoreList").getGridParam('reccount')-1;
	$("#gr_ScoreList").setGridRowEnabled(true,getRowCount);
	
}
 
/*******************************************************************************
* FUNCTION 명 : 기능 > 검색 
* FUNCTION 기능설명 :  
*******************************************************************************/
function f_Retrieve() {
	$("#gr_UserList").clearGridData();
	$("#gr_ScoreList").clearGridData();
	$("#gr_UserList").setGridParam({
 		postData : {											
				sUserId : $("#sUserId").val()
		}, datatype : "json" 
	});
}
/*******************************************************************************
* FUNCTION 명 : 기능 > 저장 
* FUNCTION 기능설명 :  
*******************************************************************************/
function f_Save(){
	
	var grid = $('#gr_ScoreList').getGrid();
	grid.finishEditing();
	
	var regExp = /^[0-9]*$/;
	var checkDate = grid.getColumnValues("gradeDate"); 
	var checkKorean = grid.getColumnValues("korean"); 
	var checkMath = grid.getColumnValues("math"); 
	var checkEng = grid.getColumnValues("eng"); 
	var checkEtc = grid.getColumnValues("etc"); 
	
	
	/* 날짜 중복 검사 */
	for(var i = 0; i < checkDate.length; i++){
		for(var j = i+1; j < checkDate.length ; j++){
			if(checkDate[i]==checkDate[j]){
	    		alert("시험날짜가 중복 되었습니다.");
	    		return false;
		   		}
			}
	}
	
	/* 국어 점수 유효성 검사 */
	for(var i = 0; i < checkKorean.length; i++){
		if(checkKorean[i] === ''){
    		alert("국어점수를 입력해 주세요.");
    		return false;
   		}else if(checkKorean[i] < 0 || checkKorean[i] > 100){
   			alert("0~100 범위로 입력해 주십시오.");
    		return false;
   		}else if(!regExp.test(checkKorean[i])){
   			alert("숫자만 입력해 주십시오.");
   			return false;
   		}
	}
	
	/* 수학 점수 유효성 검사 */
	for(var i = 0; i < checkMath.length; i++){
		if(checkMath[i] === ''){
    		alert("수학점수를 입력해 주세요.");
    		return false;
   		}else if(checkMath[i] < 0 || checkMath[i] > 100){
   			alert("0~100 범위로 입력해 주십시오.");
    		return false;
   		}else if(!regExp.test(checkMath[i])){
   			alert("숫자만 입력해 주십시오.");
   			return false;
   		}
	}
	
	/* 영어 점수 유효성 검사 */
	for(var i = 0; i < checkEng.length; i++){
		if(checkEng[i] === ''){
    		alert("영어점수를 입력해 주세요.");
    		return false;
   		}else if(checkEng[i] < 0 || checkEng[i] > 100){
   			alert("0~100 범위로 입력해 주십시오.");
    		return false;
   		}else if(!regExp.test(checkEng[i])){
   			alert("숫자만 입력해 주십시오.");
   			return false;
   		}
	}
	
	/* 예체능 점수 유효성 검사 */
	for(var i = 0; i < checkEtc.length; i++){
		if(checkEtc[i] === ''){
    		alert("예체능점수를 입력해 주세요.");
    		return false;
   		}else if(checkEtc[i] < 0 || checkEtc[i] > 100){
   			alert("0~100 범위로 입력해 주십시오.");
    		return false;
   		}else if(!regExp.test(checkEtc[i])){
   			alert("숫자만 입력해 주십시오.");
   			return false;
   		}
	}
	
	
	$("#gr_ScoreList").GridSave({
		url : "/kjb/KjbGridCrud_Control.do",
		success: function (json) {
			if(json.result == "1"){
				alert("저장완료")
				f_Retrieve();					
			}else if(json.result == "0"){
				alert(json.msg)
			}
        }
	});		
}

/*******************************************************************************
 * FUNCTION 명 : 기능 > 삭제 
 * FUNCTION 기능설명 :  
 *******************************************************************************/
function f_Delete() {
	$("#gr_ScoreList").GridDelete({
		url : "/kjb/KjbGridCrud_Control.do"	
		,success : function(json) {
			if(json.result == "1"){
				alert("삭제완료");
				f_Retrieve();			
			}else if(json.result == "0"){
				alert(json.msg)
			}
		}
	});	 	 
} 

function f_scoreLength(rowid) { //학생 그리드 선택시 f_scoreLength 함수 실행
		
	selrow = rowid;
	var rowData = $("#gr_UserList").getRowData(rowid);
	$("#gr_ScoreList").setGridParam("clear");
	$("#gr_ScoreList").setGridParam({
		url: "/kjb/KjbTwoGridBind_Select.do",  // 점수 리스트 url
		postData: {
			sUserId : rowData.userIdAdd
			
			}
	});

}



</script> 

</head>

<body>
<div class="app-admin-wrap layout-sidebar-compact sidebar-dark-purple sidenav-open clearfix">  
  <%@include file="/WEB-INF/include/TopMenu.jsp"%>
		
        <!-- Search Box Start -->
		<div class="row">
            <div class="col-md-12">
                <div class="card mb-12">
                    <div class="card-body">
                        <div class="form-row">
                          <div class="col-md-1" >     
                              <label for="sUserId" class="col-form-label">아이디</label>     
                              <input type="text" class="form-control" name = "sUserId" id="sUserId"/>  
                          </div>
		                  <!-- 조회 버튼 -->
		                  <div class=" col-md-1 search-btn">
		                  	   <button class="btn btn-info" onclick="f_Retrieve();" hotkey="F3"><i class="fa fa-search"></i>&nbsp;검색[F3]</button>
		                  </div>
                        </div>
                    </div>
                </div>
            </div>
		</div>
        <!-- Search Box End -->
        
    	<div class="row main-row">
			<div class="col-md-4">
			      <div class="card mb-12">
			          <div class="card-body">
			              <br/><h5><b>학생 리스트</b></h5>
			              <table id="gr_UserList"></table>
			          </div>
			      </div>
			</div>
			<div class="col-md-8">
				<div class="card mb-12">
					<div class="card-body">
						<br/><h5><b>성적 내역</b></h5>
						<table id="gr_ScoreList"></table>
						
						<br />		                        
                        <h6 style="color: #0b3987; font-weight: bold;">&nbsp;※ 시험날짜는 동일한 날짜로 등록할 수 없습니다.</h6>
                        <h6 style="color: #0b3987; font-weight: bold;">&nbsp;※ 점수는 0~100 범위로 숫자만 입력할 수 있습니다.</h6>
						
						<div class="row btn-row" >
				            <button class="btn btn-info ripple m-1 mb-3"   onclick="f_Create();" >신규</button>
							<button class="btn btn-success ripple m-1 mb-3"  onclick="f_Save();">저장</button>
						 	<button class="btn btn-danger ripple m-1 mb-3"   onclick="f_Delete();">삭제</button>
				       </div>    
					</div>	
				</div>
			</div>
         </div>
         
         
</div>
</body>
</html>