<%@ page language ="java"  pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="/WEB-INF/include/header.jsp"%> 
<title>투그리드 바인드</title>
<style id="ndjTest" type="text/css">

	.image-preview{
		color: black !important;
	}

</style>
<script type="text/javascript">
var selrow = 1;
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

function f_setEvent() {
	
	$("#gr_UserList").createGridEvent(
		'' 
		, { 
			onClickEvent : 'f_GridBind' // 메인 그리드 선택시 바인드 함수
		},''
 	);
	
	$("#gr_ScoreList").createGridEvent(
		'' 
		, { 
			onClickEvent : 'f_scoreGridBind' // 세컨 그리드 선택시 바인드 함수
		},'' 
	);
	
}

/*******************************************************************************
* FUNCTION 명 : 초기화 > 상단 영역(ex:검색 등)
* FUNCTION 기능설명 :  
*******************************************************************************/
function f_InitTopView() {
	
	$("#gradeDate").setCal();
	
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
		,height : 663					
		,colNames : [
		             '코드',
		             '아이디'
		            ]
		,colModel : [ 
				{
					//코드
					 name : 'corpCode'
					,align : "center"
					,width : "140"
				},{
					//아이디
					name : 'userId'
					,align : "left"
					,width : "auto"
				}               
		]
		,loadComplete : function() {		
			if($("#gr_UserList").getGrid().getRowCount() > 0){
				$("#gr_UserList").setSelection(selrow);  // var selrow = 1; 전역변수 선언
   			}	 
		}
	});
	
	$("#gr_ScoreList").tuiGrid({
		rownumbers: false
		,height : 663												
		,colNames : [
					 '시험날짜',	
					 '국어',
		             '수학',
		             '영어',
		             '예체능',
		            ]
		,colModel : [ 
				{
					//시험날짜
					name: 'gradeDate'
					,align: "center"
					,width: "auto"
				},{
					//국어
					name: 'korean'
					,align: "right"
					,width: "auto"
				},{
					//수학
					name: 'math'
					,align: "right"
					,width: "auto"
				},{
					//영어
					name: 'eng'
					,align: "right"
					,width: "auto"
				},{
					//예체능
					name: 'etc'
					,align: 'right'
					,width: 'auto'
				}                     
		]
		,loadComplete : function() {
			if($("#gr_ScoreList").getGrid().getRowCount() > 0) {
				$("#gr_ScoreList").setSelection(selrow);
			}
		}
	});
	
}

/*******************************************************************************
* FUNCTION 명 : 뷰 > 그리드 > 메인 그리드 선택
* FUNCTION 기능설명 :  그리드 바인드
*******************************************************************************/
function f_GridBind(rowid) {
	f_Create();  // insertForm 초기화
	var rowData = $("#gr_UserList").getRowData(rowid);
	var sUserId = rowData['userId'];  
	
	f_Clear(); 
	
 	$("#sUserId").val(sUserId);

	$("#gr_ScoreList").setGridParam('clear');
	$("#gr_ScoreList").setGridParam({ 				
		url : '/kjb/KjbTwoGridBind_Select.do',  	
		postData : {
			sUserId : sUserId  						
		}
	
	});
}

/*******************************************************************************
* FUNCTION 명 : 뷰 > 그리드 > 세컨 그리드 선택
* FUNCTION 기능설명 :  그리드 바인드
*******************************************************************************/

function f_scoreGridBind(rowid){
	var rowData = $("#gr_ScoreList").getRowData(rowid);
	var sUserId = rowData['userId']; 
	var sGradeDate = rowData['gradeDate']; 
	
	f_Clear(); 
	
	$("#type").val('edit');
	$("#sUserId").val(sUserId);
	$("#sGradeDate").val(sGradeDate);
	
	// 세컨 그리드 선택시 상세내역 바인드 
	$("#gr_ScoreList").JSBindData([
		{id : rowid},
		{grid : "gradeDate" , view : "gradeDate", type :'date'},
		{grid : "korean" , view : "korean", type :'text'},
		{grid : "math" , view : "math", type :'text'},
		{grid : "eng" , view : "eng", type :'text'},
		{grid : "etc" , view : "etc", type :'text'},
	]);
	
}

/* 신규 */
function f_Create() { 
	
	$('#insertForm input[type="text"]').val("");
	$("#gr_ScoreList").getGrid().removeRowClassName(getSelectedRowId("gr_ScoreList"), 'tui-selected-row');  // removeRowClassName(getSelectedRowId : 선택한 row 해제 , tui-selected-row: 파랑색으로 만들어 줌
	$("#type").val('input');  
	
}


/* 저장 */
function f_Save () {
	
	// 유효성 검사
	if($("#type").val() == "") {
		alert("수정할 데이터가 없습니다.");
		return false;
	}
	if($("#gradeDate").val() == '') {
		alert("시험 날짜를 입력해주세요.");
		$("#gradeDate").focus();
		return false;
	}
	if($("#korean").val() == '') {
		alert("국어 점수를 입력해주세요.");
		$("#korean").focus();
		return false;
	}
	
	if($("#math").val() == '') {
		alert("수학 점수를 입력해주세요.");
		$("#math").focus();
		return false;
	}
	
	if($("#eng").val() == '') {
		alert("영어 점수를 입력해주세요.");
		$("#eng").focus();
		return false;
	}
	
	if($("#etc").val() == '') {
		alert("예체능 점수를 입력해주세요.");
		$("#etc").focus();
		return false;
	}

	  // 그리드 옵션
	var option = {
		success : function(result) { 
			if(result.result == "0"){
				alert(result.msg);				
			}else{
				alert("저장 완료!");
				f_GridBind(getSelectedRowId("gr_UserList"));
			};
		}
	};

	if(confirm('저장하시겠습니까?') != true) {
    	return false;
    }
	
	$("#insertForm").ajaxSubmit(option);   
}


function f_Delete(){
	//유효성 검사
	if($("#type").val() == '') {
		alert("삭제할 데이터가 없습니다.");
		return false;
	}
 	if($("#type").val() == 'input') {
		alert('신규상태에서는 삭제할 수 없습니다');
		return false;
 	}
	
	if(confirm('삭제하시겠습니까?') != true) {
		return false;
	}
	$("#type").val('del');
	
	// 그리드 옵션
	var option = {
		success : function(result) { 
			if(result.result == "0"){
				alert(result.msg);				
			}else{
				alert("삭제 완료!");
				f_GridBind(getSelectedRowId("gr_UserList"));
			};
		}
	};
	
	$("#insertForm").ajaxSubmit(option);   
}


/* 점수 유효성 검사 */
$(document).on("keyup", "input[value^=score]", function() {
    var val= $(this).val();

    if(val.replace(/[0-9]/g, "").length > 0) {
        alert("숫자만 입력해 주십시오.");
        $(this).val('');
    }

    if(val < 0 || val > 100) {
        alert("0~100 범위로 입력해 주십시오.");
        $(this).val('');
    }
});

/* 초기화 */
function f_Clear() {
	$("#insertForm").trigger('reset');  //??의미??
	$('#insertForm input[type="text"]').val("");
	$('#insertForm input[type="hidden"]').val("");
}


</script>  

</head>

<body>
<div class="app-admin-wrap layout-sidebar-compact sidebar-dark-purple sidenav-open clearfix">  
    <%@include file="/WEB-INF/include/TopMenu.jsp"%>

     <div class="row main-row">
      
            <div class="col-md-3">
                  <div class="card mb-12">
                  	<div class="card-body">
                  		<br/><h5><b>학생 리스트</b></h5>
                  		<table id="gr_UserList"></table>
                  	</div>
                  </div>
            </div>
            
            <div class="col-md-6">
                  <div class="card mb-12">
                  	<div class="card-body">
                  		<br/><h5><b>성적 내역</b></h5>
                  		<table id="gr_ScoreList"></table>
                  	</div>
                  </div>
            </div>
            
	        <div class="col-md-3">
	            <div class="card mb-12">
	            	<div class="card-body">
            			<br/><h5><b>성적 관리</b></h5>
            			
	            		<form id="insertForm" method="post" enctype="multipart/form-data" action="/kjb/KjbTwoGridBind_Control.do" >
                			<div class="form-row" >
			  					<input type="hidden" id="type" name="type"/> 
			  					<input type="hidden" id="sUserId" name="sUserId"/>    
			  					<input type="hidden" id="sGradeDate" name="sGradeDate"/>    
			  				
			  					<div class="col-md-6 mb-2">
	                                <label for="gradeDate" class="col-form-label"><span class="essential_astrisk">*</span>시험날짜</label>
	                                <input class="form-control required" type="text" id="gradeDate" name="gradeDate" placeholder="YYYY-MM-DD"/>
	                            </div>
	                            
	                            <div class="col-md-6 mb-2"></div>
	                            
			  					<div class="col-md-6 mb-2">
			  						<label class="col-form-label" for="korean"><span class="essential_astrisk">*</span>국어</label> 
			  						<input type="text" id="korean" name="korean" class="form-control input-Number required" value="score" placeholder="0~100"/>
			  					</div>
			  					
			                    <div class="col-md-6 mb-2">
			  						<label class="col-form-label" for="math"><span class="essential_astrisk">*</span>수학</label> 
			  						<input type="text" id="math" name="math" class="form-control input-Number required" value="score" placeholder="0~100"/>
			  					</div>
			  					
			                    <div class="col-md-6 mb-2">
			  						<label class="col-form-label" for="eng"><span class="essential_astrisk">*</span>영어</label> 
			  						<input type="text" id="eng" name="eng" class="form-control input-Number required" value="score" placeholder="0~100"/>
			  					</div>
			  					
			                    <div class="col-md-6 mb-2">
			  						<label class="col-form-label" for="etc"><span class="essential_astrisk">*</span>예체능</label> 
			  						<input type="text" id="etc" name="etc" class="form-control input-Number required" value="score" placeholder="0~100"/>
			  					</div>
	                  		</div>																
	  					</form>
	  					
	  					<br />		                        
                        <h6 style="color: #0b3987; font-weight: bold;">&nbsp;※ 시험날짜는 동일한 날짜로 등록할 수 없습니다.</h6>
                        <h6 style="color: #0b3987; font-weight: bold;">&nbsp;※ 점수는 0~100 범위로 숫자만 입력할 수 있습니다.</h6>
	  																																															
			  			<div class="form-btn-row">
			  				<button class="btn btn-info ripple m-1 mb-3"  onclick="f_Create();">신규</button>
			  		 		<button class="btn btn-success ripple m-1 mb-3"  onclick="f_Save();">저장</button>
			  		 		<button class="btn btn-danger ripple m-1 mb-3"  onclick="f_Delete();">삭제</button>
			  			</div>
		  			
	  				</div>
				</div>
			</div>
	            
     </div>
              
</div>
          
          
</body>
</html>