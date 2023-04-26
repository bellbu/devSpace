<%@ page language ="java"  pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="/WEB-INF/include/header.jsp"%> 
<title>과제6</title>
<style id="ndjTest" type="text/css">

	.image-preview{
		color: black !important;
	}

</style>
<script type="text/javascript">
var selrow = 1;
var schoolCode = '';
/*******************************************************************************
//* FUNCTION 명 : $( document ).ready(function()
* FUNCTION 기능설명 :팝업 최초 실행
*******************************************************************************/
$( document ).ready(function() {
	
	f_InitView();
	
 	// 학교코드 선택시 검색
	$("#sSchoolCode").change(function(){  //.change() : 셀렉터를 정하여 해당 셀렉터의 값이 변할 경우 이벤트 발생
    	f_Retrieve();
	});
	
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
	
	$("#gr_SchoolList").createGridEvent(
		'' 
		, { 
			onClickEvent : 'f_GridBind' // 메인 그리드 선택시 바인드 함수
		},''
 	);
	
	$("#gr_UserList").createGridEvent(
		'' 
		, { 
			onClickEvent : 'f_userGridBind' // 세컨 그리드 선택시 바인드 함수
		},'' 
	);
	
}

/*******************************************************************************
* FUNCTION 명 : 초기화 > 상단 영역(ex:검색 등)
* FUNCTION 기능설명 :  
*******************************************************************************/
function f_InitTopView() {
	
	$("#sUserId").enter('f_SearchSchoolCodePopup'); 
	$("#sSchoolCode").setSelectDataSet('${cmmnObj.KJB01}','all');
	
}
/*******************************************************************************
* FUNCTION 명 : 초기화 > 중간 영역(ex:Grid, 입력 등)
* FUNCTION 기능설명 :  
*******************************************************************************/
function f_InitMiddleView() {	
	
	/* 학교 리스트 */
	$("#gr_SchoolList").tuiGrid({
	  	url : '/kjb/KjbSchoolList_Select.do'	
	  	,postData : {  //학교리스트는 상단 학교코드(sSchoolCode) 조건으로 select
	  		sSchoolCode : $("#sSchoolCode").val()			
	  	}
		,rownumbers: false
		,height : 663					
		,colNames : [
		             '학교코드',
		             '학교명'
		            ]
		,colModel : [ 
				{
					//학교코드
					 name : 'schoolCode'
					,align : "center"
					,width : "140"
				},{
					//학교이름
					name : 'schoolName'
					,align : "center"
					,width : "auto"
				}               
		]
		,loadComplete : function() {		
			if($("#gr_SchoolList").getGrid().getRowCount() > 0){
				$("#gr_SchoolList").setSelection(selrow);  // var selrow = 1; 전역변수 선언
   			}	 
		}
	});
	
	
	/* 학생 리스트 */
	$("#gr_UserList").tuiGrid({  //바인드 된 schoolCode와 상단 유저ID(sUserId) 조건으로 select
		rownumbers: false
		,height : 663												
		,colNames : [
					 '유저ID'
		            ]
		,colModel : [ 
				{
					//유저ID
					name: 'userId'
					,align: "left"
					,width: "auto"
				}
		]
		,loadComplete : function() {
			if($("#gr_UserList").getGrid().getRowCount() > 0) {
				$("#gr_UserList").setSelection(selrow);
			}
		}
	});

	/* 성적 리스트 */
	$("#gr_ScoreList").tuiGrid({
		rownumbers: false
		,height : 663												
		,colNames : [
					 '일자', '학교코드', '유저ID', '국어', '수학', '영어', '예체능', '합계','평균',
		            ]
		,colModel : [ 
				{
					//시험날짜
					name: 'gradeDate'
					,align: "center"
					,width: "auto"
				},{
					//학교코드
					name: 'schoolCode'
					,hidden: true
				},{
					//유저ID
					name: 'userId'
 					,hidden: true  
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
					,align: "right"
					,width: "auto"
				},{
					//합계
					name: 'sumScore'
					,align: "right"
					,width: "auto"
				},{
					//평균
					name: 'avgScore'
					,align: "right"
					,width: "auto"
				}
		]
		,loadComplete : function() {
			if($("#gr_ScoreList").getGrid().getRowCount() > 0) {
				$("#gr_ScoreList").setSelection(selrow);
			}
		},footerData : [ 
            { name : 'gradeDate', setType : 'cnt', addText : '건' },
            { name : 'korean', setType : 'sum', addText : '점' },
            { name : 'math', setType : 'sum',  addText : '점'},
            { name : 'eng', setType : 'sum',  addText : '점'},
            { name : 'etc', setType : 'sum',  addText : '점'},
            { name : 'sumScore', setType : 'sum',  addText : '점'},
            { name : 'avgScore', setType : 'sum',  addText : '점'}
            ]
	});
	
}

/*******************************************************************************
* FUNCTION 명 : 뷰 > 그리드 > 메인 그리드 선택
* FUNCTION 기능설명 :  그리드 바인드
*******************************************************************************/
function f_GridBind(rowid) {
	
	var rowData = $("#gr_SchoolList").getRowData(rowid);
	schoolCode = rowData.schoolCode  //schoolCode 전역변수로 선언

	$("#gr_ScoreList").setGridParam('clear');
	$("#gr_UserList").setGridParam('clear');
	$("#gr_UserList").setGridParam({  //바인드 된 schoolCode와 상단 유저ID(sUserId) 조건으로 select 				
		url : '/kjb/KjbUserList_Select.do',  	
		postData : {
	  		sUserId : $("#sUserId").val(),	
	  		schoolCode : schoolCode
		}
	
	});
	
// 	console.log($("#gr_SchoolList").getRowData(rowid));
	
}

/*******************************************************************************
* FUNCTION 명 : 뷰 > 그리드 > 세컨 그리드 선택
* FUNCTION 기능설명 :  그리드 바인드
*******************************************************************************/

function f_userGridBind(rowid){
	
	var rowData = $("#gr_UserList").getRowData(rowid);
	var userId = rowData.userId

	$("#gr_ScoreList").setGridParam('clear');
	$("#gr_ScoreList").setGridParam({ // 성적리스트는 학교,학생그리드 선택된 조건으로 select 		 				
		url : '/kjb/KjbScoreList_Select.do',  	
		postData : {
			schoolCode : schoolCode,
			userId : userId
		}

	});
	
}

/*******************************************************************************
* FUNCTION 명 : f_SearchUpjangCodePopup
* FUNCTION 기능설명 :  영업장코드 팝업
*******************************************************************************/
function f_SearchSchoolCodePopup(){	
	var popTitleName = '학교코드검색(KJB)';
	var BindData = "";
	
	 BindData =  [ 
	                 	{ EndFocus : 'sUserId'},
						{ grid : 'schoolCode',view : 'sSchoolCode', type :'select2'},
						{ grid : 'userId',view : 'sUserId', type :'text'}
					];
	 f_settingPop({ 
			PopType			: 	"KjbRetrieveSchoolCodeListPop"
		 	,BindData			: 	BindData 
	  		,SearchCodeText : 	$("#sSchoolCode").val()
	  		,SearchNameText	: 	$("#sUserId").val()
	  		,SearchPopupTitle	: 	popTitleName
	 	});
}	

/*******************************************************************************
* FUNCTION 명 : 기능 > 검색 
* FUNCTION 기능설명 :  
*******************************************************************************/
function f_Retrieve() {
	$("#gr_ScoreList").clearGridData();
	$("#gr_UserList").clearGridData();
	$("#gr_SchoolList").clearGridData();
	$("#gr_SchoolList").setGridParam({
		postData : {											// 넘겨줄 파라미터
	  		sSchoolCode : $("#sSchoolCode").val(),				
	  		sUserId : $("#sUserId").val()	
		}
		,datatype : "json" 
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
		                  
                     <div class="col-md-1">
                          <label for="sSchoolCode" class="col-form-label">학교코드</label>
                          <select id="sSchoolCode" name="sSchoolCode" class="form-control"></select>
                      </div>
	                  
	                  <div class="col-md-1" >     
	                      <label for="sUserId" class="col-form-label">유저ID
	                      <img class="Lbtn" id="btnStore" src="<c:url value='/css/images/icon_search.gif'/>" alt="찾기" onclick="f_SearchSchoolCodePopup();"/></label>     
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
      
            <div class="col-md-3">
                  <div class="card mb-12">
                  	<div class="card-body">
                  		<br/><h5><b>학교 리스트</b></h5>
                  		<table id="gr_SchoolList"></table>
                  	</div>
                  </div>
            </div>
            
            <div class="col-md-2">
                  <div class="card mb-12">
                  	<div class="card-body">
                  		<br/><h5><b>학생 리스트</b></h5>
                  		<table id="gr_UserList"></table>
                  	</div>
                  </div>
            </div>
            
			<div class="col-md-7">
                  <div class="card mb-12">
                  	<div class="card-body">
                  		<br/><h5><b>성적 리스트</b></h5>
                  		<table id="gr_ScoreList"></table>
                  	</div>
                  </div>
            </div>

	            
     </div>
              
</div>
          
          
</body>
</html>