<%@ page language ="java"  pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="/WEB-INF/include/header.jsp"%>
<title>고정락카 사용등록</title>
<style type="text/css">
body{
	overflow-y:hidden;
}
.col-md-12 .tuiDatePicker{
width: 132px!important;

}

</style> 
<script type="text/javascript">
var selrowPop1 = 0;    
var selrowPop2 = 0;    
var Parameter = new Object();
/*******************************************************************************
* FUNCTION 기능설명 : 화면 키 이벤트 설정  
*******************************************************************************/
$(function () {
	$("#remark").keyup(function(){ //비고에서 키보드 손을 뗄 때 바이트 계산
		bytesHandler($(this),100);
	});
	$('#remark').blur(function(){ //비고에서 포커스 해제될 때 바이트 계산
		bytesHandler($(this),100);
	});

	$("#pMemName").keyup(function (key) { // 엔터이외의 키를 누르거나 빈값은 경우 고객번호 삭제
   	 if(key.keyCode != 13 || $("#pMemName").val() == ""){
   		$("#pGuestNo").val("");
   	 }
			
	});
   $("#pMemName").change(function(e){ // 이름 변경시 고객번호 삭제
       if($(this).val() == ""){
           $("#pGuestNo").val("");
       }
   });
	
});
/*******************************************************************************
 * FUNCTION 명 : $( document ).ready(function()
 * FUNCTION 기능설명 : 팝업 최초 실행
 *******************************************************************************/ 
$( document ).ready(function() {
	
	$("#psLockerType").setSelectDataSet('${cmmnObj.GB105}','all'); // 검색 상단 락카종류 공통코드
	$("#pLockerType").setSelectDataSet('${cmmnObj.GB105}','chk');  // 폼 락카종류 공통코드
	$("#pLockerStat").setSelectDataSet('${cmmnObj.GF009}','chk');  // 폼 락카상태 공통코드 
	$("#pStDate").setCal();  // 폼 고정락카 사용시작일자
	$("#pEdDate").setCal();  // 폼 고정락카 사용종료일자 
	$("#pUseDate").setCal(); // 검색 고정락카 사용일자
	
	Parameter = parent.PopupSearchParameter; // 데이터 없음
	
	calFromTo('pStDate', 'pEdDate');

	$('body').keydown(function(e) {  // 화살표 위, 아래 키 누르고 있는 동안 페이지를 이동 등의 동작을 중단시킴 
		if (e.keyCode == 38 || e.keyCode == 40)      
			e.preventDefault();
	});
	
    if(parent.PopupSearchCodeText){ // 부모페이지의 락카번호 파라미터 존재하는 경우 검색상단에 값 넣어줌
        $("#psLockerKey").val(parent.PopupSearchCodeText).focus();
    } else {
        $("#psLockerKey").focus();
    }
    console.log(Parameter);
    
    $("#type").val("add");

    if(Parameter.guestName){ // 파라미터 존재X
    	$("#pMemName").val(Parameter.guestName);
    }
    
    if(Parameter.guestNo){ // 파라미터 존재X
    	$("#pGuestNo").val(Parameter.guestNo);
    }
    
    $("#psLockerKey").enter("f_RetrievePop"); // 엔터 시 검색
    gridload(); // 메인, 세컨 그리드 그려줌


	$("#pMemName").popEnter(['pGuestNo'],'f_guestCodePopup', '');
	f_setEventPop(); // 바인드 이벤트
});


 /*******************************************************************************
  * FUNCTION 명 : bytesHandler
  * FUNCTION 기능설명 : Textarea Byte 계산
  *******************************************************************************/
  function bytesHandler(obj,maxlen) {
  	var text = obj.val();
  	var i = 0; // for문에 사용
  	var totalByte = 0;
  	var strlen = 0;
  	var objstr2 = ""; // 허용된 글자수까지만 포함한 최종문자열
  	for (i = 0; i < text.length; i++) {
  		var currentByte = text.charCodeAt(i);
  		if (currentByte > 128){totalByte += 3;}
  		else{totalByte++;}
  			
  	if (totalByte <= maxlen) { // 전체 크기가 maxlen를 넘지않으면
  	    strlen = i + 1; // 1씩 증가
      }
  	}
  	if(obj.attr("id")=="remark"){
  		if(totalByte>maxlen){
  			alert("허용된 문자열의 최대값(100)을 초과했습니다. \n초과된 내용은 자동으로 삭제 됩니다.");  // match를 이용해서 영어로된 name을 한글로 변환해서 출력한다.
  			objstr2 = obj.val().substr(0, strlen);
  			 obj.val(objstr2);
  			 $('#'+obj.attr("id")+"size").text((totalByte-1) + "/100byte");
  		}else{
  			$('#'+obj.attr("id")+"size").text(totalByte + "/100byte");
  		}
  	}
  }
  
 function f_setEventPop() {
	   // 20170929 chabh 이벤트 선언 
	    $("#gr_LockerInfoListPop").createGridEvent(
	          ''   // create
	          ,{   // read
	             onClickEvent:'f_GridBindPop1'
	          } 
	          ,''   // update
	          );
	    $("#gr_LockerFixInfoListPop").createGridEvent(
		          ''   // create
		          ,{   // read
		             onClickEvent:'f_GridBindPop2'
		          } 
		          ,''   // update
		          );        
	}

 /*******************************************************************************
 * FUNCTION 명 : f_guestCodePopup()
 * FUNCTION 기능설명 : 고객정보를 조회한다
 *******************************************************************************/
 function f_guestCodePopup(){  // 고객명 팝업 검색
 	var BindData = [
 		{ grid : 'memNo',	 view : 'memNo',    type :'text'},
 		{ grid : 'memName',	 view : 'pMemName',  type :'text'},
 		{ grid : 'guestNo',	 view : 'pGuestNo',  type :'text'}
     ];
 	
 	f_settingPop({
 		SearchPopupTitle : "고객검색",
 		PopType : "RetrieveGuestCodeListPop", // 팝업아이디
 		SearchNameText : $("#pMemName").val(),
 		SearchCodeText : $("#pGuestNo").val(),
 		BindData : BindData
     });
 } 
/*******************************************************************************
* FUNCTION 명 : 그리드
* FUNCTION 기능설명 : 그리드 로딩 
*******************************************************************************/
function gridload(){
	$("#gr_LockerInfoListPop").tuiGrid( 
			{
				url : '/gslpopup/LockerFixPop_Select.do' // PKG_LockerFixPop.SP_SELECT
					,
					postData : {
						lockerKey : $('#psLockerKey').val(),
						lockerType : $('#psLockerType').val(),
						UseDate : $('#pUseDate').val()
							},
				mtype : 'POST',
				datatype : "json",
				loadtext : '로딩중..',
				rowNum : 9999999
				,gridview:true   
				,loadonce:true  
				,cmTemplate: {sortable:true}
				,navOptions: { reloadGridOptions: { fromServer: true } }
				,scrollOffset : 0
				,rownumbers: false  
			    ,shrinkToFit:false
			    ,forceFit:true,
				autowidth : true,
				height : 573// 높이
				,
						colNames : [ '락카번호','락카종류' , '사용상태', '사용자', '시작일자','종료일자'],
						colModel : [ {
							//락카번호
							name : 'lockerKey',
							align : "center",
							width : "70"
						}, {
							//락카종류
							name : 'lockerType',
							align : "center",
							width : "70"
			      				,template : getSelectCommonCodeTemplate('GB105',true)
						}, {
							//상태
							name : 'useYn',
							align : "center",
							width : "70"
						}, {
							//고정사용자
							name : 'guestName',
							align : "left",
							width : "auto"
						}, {
							//시작일자
							name : 'stDate',
							align : "center",
							width : "80"
								, template: getDatePickerTemplate(false)  
						}, {
							//종료일자
							name : 'edDate',
							align : "center",
							width : "80"
								, template: getDatePickerTemplate(false)  
						}
						],
						beforeRequest : function() {

						},
						beforeSelectRow : function(id) {
						},
						afterEditCell : function(rowid, cellname, value,
								iRow, iCol) {
						},
						afterSaveCell : function(rowid, name, val, iRow,
								iCol) {
						},
						beforeSaveCell : function(rowid, cellname, value,
								iRow, iCol) {
						},
						ondblClickRow: function(ev){
						},
						editurl : 'clientArray',
						cellsubmit : 'clientArray',
						loadComplete : function() {
							if($("#gr_LockerInfoListPop").getGrid().getRowCount() >= (selrowPop1+1)){
								$("#gr_LockerInfoListPop").setSelection(selrowPop1+1);
				   			}else{
				   				$("#gr_LockerInfoListPop").setSelection(1);
				   			}
						},
						gridComplete: function(){
							
						},
						loadError : function() {

						},
						jsonReader : {
							root : "root",
							id : "no",
							repeatitems : false,
							page : "page",
							total : "total",
							records : "records"

						}

					});
	$("#gr_LockerFixInfoListPop").tuiGrid(  // PKG_LockerFixPop.SP_SELECT_H
			{
				mtype : 'POST',
				datatype : "json",
				loadtext : '로딩중..',
				rowNum : 9999999
				,gridview:true   
				,loadonce:true  
				,cmTemplate: {sortable:true}
				,navOptions: { reloadGridOptions: { fromServer: true } }
				,scrollOffset : 0
				,rownumbers: false  
			    ,shrinkToFit:false
			    ,forceFit:true,
				autowidth : true,
				height : 212// 높이
				,
						colNames : [ '시작일자', '종료일자', '사용자', '사용','락카번호','락카상태','비고','seqNo','고객번호'],
						colModel : [ {
							//시작일자
							name : 'stDate',
							align : "center",
							width : "80"
								, template: getDatePickerTemplate(false)  
						}, {
							//종료일자
							name : 'edDate',
							align : "center",
							width : "80"
								, template: getDatePickerTemplate(false)  
								  
						}, {
							//사용자
							name : 'guestName',
							align : "left",
							width : "auto"
						}, {
							//사용
							name : 'useYn',
							align : "center",
							width : "60"
								, template: getSelectYnTemplate(false)
						}
						,{name:'lockerKey',hidden:true}
						,{name:'lockerType',hidden:true}
						,{name:'remark',hidden:true}
						,{name:'seqNo',hidden:true}						
						,{name:'guestNo',hidden:true}						
						],
						beforeRequest : function() {

						},
						beforeSelectRow : function(id) {
						},
						afterEditCell : function(rowid, cellname, value,
								iRow, iCol) {
						},
						afterSaveCell : function(rowid, name, val, iRow,
								iCol) {
						},
						beforeSaveCell : function(rowid, cellname, value,
								iRow, iCol) {
						},
						ondblClickRow: function(ev){
						},
						editurl : 'clientArray',
						cellsubmit : 'clientArray',
						loadComplete : function() {
							
						},
						gridComplete: function(){
							
						},
						loadError : function() {

						},
						jsonReader : {
							root : "root",
							id : "no",
							repeatitems : false,
							page : "page",
							total : "total",
							records : "records"

						}
					});
	
}

/*******************************************************************************
* FUNCTION 명 : 뷰 > 그리드 > 메인 그리드 선택
* FUNCTION 기능설명 :  그리드 바인드
*******************************************************************************/
function f_GridBindPop1(id) {
	//f_Create();
	selrowPop1 = id;
   	var rowData = $("#gr_LockerInfoListPop").getRowData(id);
   	
   	$("#gr_LockerInfoListPop").JSBindData([ 
		 { id   : id },
		{ grid : 'lockerKey',      view : 'pLockerKey',      type : 'text' }, 
       { grid : 'lockerType',     view : 'pLockerType',     type : 'select2' }, 
       { grid : 'lockerStat',     view : 'pLockerStat',     type : 'select2'}, 
       { grid : 'remark',         view : 'remark',          type : 'textarea'}, 
   	], false);
   	
	$("#gr_LockerFixInfoListPop").setGridParam('clear');
   	$("#gr_LockerFixInfoListPop").setGridParam({
			url : '/gslpopup/LockerFixPop_Select_H.do' // url
				,
				postData : {                                 // 넘겨줄 파라미터
					lockerKey : rowData.lockerKey,
              }, 
   });

    $("#pStDate").setCal();
    $("#pEdDate").setCal();
    calFromTo('pStDate', 'pEdDate');
    $("#pSeqNo").val(""); // 첫 번째 그리드 바인드 될 때 히스토리 시퀀스 초기화
}

/*******************************************************************************
* FUNCTION 명 : 뷰 > 그리드 > 메인 그리드 선택
* FUNCTION 기능설명 :  그리드 바인드
*******************************************************************************/
function f_GridBindPop2(id) {
	console.log("id",id);

   	$("#gr_LockerFixInfoListPop").JSBindData([ 
		 { id   : id },
        { grid : 'guestName',      view : 'pMemName',       type : 'text' }, 
        { grid : 'stDate',         view : 'pStDate',         type : 'date' }, 
        { grid : 'edDate',         view : 'pEdDate',         type : 'date' },
        { grid : 'seqNo',          view : 'pSeqNo',          type : 'text' },
        { grid : 'guestNo',        view : 'pGuestNo',          type : 'text' },
    	], false);
}


/*******************************************************************************
* FUNCTION 명 : 기능 > 검색
* FUNCTION 기능설명 :  
*******************************************************************************/
function f_RetrievePop() {

	if(($("#pUseDate").val() == '')||($("#pUseDate").val() == null)){
		alert("고정락카 사용일자는 필수입력사항 입니다");
		$("#pUseDate").focus();
		return false;
	}	

	$("#gr_LockerInfoListPop").setGridParam('clear');
	$("#gr_LockerFixInfoListPop").setGridParam('clear');
	$("#gr_LockerInfoListPop").setGridParam({
		postData : {
			lockerKey : $('#psLockerKey').val(),
			lockerType : $('#psLockerType').val(),
			UseDate : $("#pUseDate").val(),
				}
				,datatype: 'json'
			});
}



/*******************************************************************************
* FUNCTION 명 : 기능 > 신규 
* FUNCTION 기능설명 :  
*******************************************************************************/

function f_Create() {
	$("#pGuestNo").val("");
	$("#pMemName").val("");
	$("#remark").val("");	
    $("#pStDate").setCal();
    $("#pEdDate").setCal();

    $("#type").val("add");
    
}

	
/*******************************************************************************
* FUNCTION 명 : 기능 > 저장 
* FUNCTION 기능설명 :  
*******************************************************************************/
function f_SavePop() { // PKG_LockerFixPop.SP_INSERT or SP_UPDATE
	var lockerKey = $("#pLockerKey").val()
	var guestName = $("#pMemName").getCal()
	var guestNo = $("#pGuestNo").getCal()
	var stDate = $("#pStDate").getCal()
	var edDate = $("#pEdDate").getCal()
	var seqNo = $("#pSeqNo").val()
	var remark = $("#remark").val()
	
	if(lockerKey==""||lockerKey==null){
		alert("락카를 선택해주세요.");
		return false;
	}

    if (stDate.length != 8) {
       alert('올바른 날짜를 입력해 주세요');
       $("#pStDate").focus();
       return false;
    }
    if (edDate.length != 8) {
       alert('올바른 날짜를 입력해 주세요');
       $("#pEdDate").focus();
       return false;
    }

    if (stDate > edDate) {
       alert("고정락카 사용시작일자는 종료일자보다 클 수 없습니다.");
       $("#pStDate").focus();
       return false;
    }

	if (!confirm('저장하시겠습니까?')){
		return false;
	}
	var type = "";
		type = $("#type").val();;	
 	$.ajax({
		async : false,
		type : "post",
		data : {
			'lockerKey' : lockerKey,
			'guestName' : guestName,
			'guestNo' : guestNo,
			'stDate' : stDate,
			'edDate' : edDate,
			'seqNo' : seqNo,
			'type' : type,
			'remark' : remark,
			
		},
		url : "/gslpopup/LockerFixPop_Control.do",
		success : function(data) {
			if(data.result=="1"){
				alert("저장완료!");
				f_RetrievePop();
			}else{
				alert(data.msg);
			}
		}
	});
}

/*******************************************************************************
* FUNCTION 명 : 기능 > 저장 
* FUNCTION 기능설명 :  
*******************************************************************************/
function f_FixStop() {  // call PKG_LockerFixPop.SP_DELETE
	var lockerKey = $("#pLockerKey").val()
	var seqNo = $("#pSeqNo").val()
	if(lockerKey==""||lockerKey==null){
		alert("락카를 선택해주세요.");
		return false;
	}
	if(seqNo==""||seqNo==null){
		alert("고정락카 사용자가 없습니다.");
		return false;
	}

	if (!confirm('사용중지 하시겠습니까?')){
		return false;
	}
	var type = "del";
 	$.ajax({
		async : false,
		type : "post",
		data : {
			'lockerKey' : lockerKey,
			'seqNo' : seqNo,
			'type' : type,
		},
		url : "/gslpopup/LockerFixPop_Control.do", 
		success : function(data) {
			if(data.result=="1"){
				alert("저장완료!");
				f_RetrievePop();
			}else{
				alert(data.msg);
			}
		}
	});
}
</script>
</head>
<body id="LblockBodyPop" class="popup-body">
 	
	   <div class="row">
         
           <!-- Search Box Start -->
           <div class="col-md-12">
               <div class="card mb-12">
                   <div class="card-body">
                       <div class="form-row">
                      	  <div class="col-md-3">
								<label class="col-form-label" for="psLockerKey">락카번호</label> 
								<input class="form-control input-Number" type="text" id="psLockerKey" name="psLockerKey" placeholder="000" maxlength="3" />
							</div>
                           <div class="col-md-3">
								<label class="col-form-label" for="psLockerType">락카종류</label>
								<select id="psLockerType" name="psLockerType" class="form-control">
								</select> 
							</div>
							
                           <div class="col-md-3">
								<label class="col-form-label" for="psLockerType">고정락카 사용일자</label>
	                            <input type="text" id="pUseDate" name="pStDate" class="form-control" placeholder="YYYY-MM-DD"/>
							</div>	
							
	                      <!-- 조회 버튼 -->
		                    <div class="col-md-2 search-btn">
		                        <button class="btn btn-primary" onclick="f_RetrievePop();" hotkey="F3"><i class="fa fa-search"></i>&nbsp;검색[F3]</button>
		                    </div>
                       </div>
                   </div>
               </div>
           </div>
           <!-- Search Box End -->
       </div>
    <div class="row">
       <div class="col-md-7">
          	<div class="card mb-12">
            	<div class="card-body">
					<table id="gr_LockerInfoListPop"></table>
				</div>
  			</div>
  		</div>
  		<div class="col-md-5">
          	<div class="card mb-12">
          		<div class="card-body">
	              	<div class="card-body">
	          	    <h5>고정락카 사용이력</h5>
						<table id="gr_LockerFixInfoListPop"></table>
					</div>
	  			</div>
  			</div>
          	<div class="card mb-12">
          	<div class="card-body">
          	    <h5>기본정보</h5>
					<div class="form-row">
					<input type="" id="pSeqNo" name="pSeqNo"/>
                    <input type="" id="type" name="type"/>
                       	<div class="col-md-4">
							<label class="col-form-label" for="pLockerKey">락카번호</label> 
							<input class="form-control required" type="text" id="pLockerKey" name="pLockerKey" placeholder="000" maxlength="3" readonly="readonly"/>
						</div>
                       	<div class="col-md-4">
							<label class="col-form-label" for="pLockerType">락카종류</label> 
							<select id="pLockerType" name="pLockerType" class="form-control" disabled="disabled">
							</select> 
						</div>
                       	<div class="col-md-4">
							<label class="col-form-label" for="pLockerStat">락카상태</label>
							<select id="pLockerStat" name="pLockerStat" class="form-control" disabled="disabled">
							</select> 
						</div>
                       	<div class="col-md-12">
							<label class="col-form-label" for="remark">비고사항</label>
							<textarea class="form-control" id="remark" name="remark" ></textarea>
							<label class="col-form-label" id="remarksize">0/100byte</label>
						</div>
                       	<div class="col-md-4">
							<label class="col-form-label" for="pMemName">고객명<img class="Lbtn searchIcon" src="<c:url value='/css/images/icon_search.gif'/>" alt="찾기" onclick="f_guestCodePopup();" style="display: inline-block;"/></label>
							<input class="form-control" type="text" id="pMemName" name="pMemName"/>
						</div>
                       	<div class="col-md-4">
							<label class="col-form-label" for="pGuestNo">고객번호</label>
							<input class="form-control" type="text" id="pGuestNo" name="pGuestNo" readonly="readonly"/>  
						</div>
						<div class="col-md-12">
                            <label for="stDate" class="col-form-label">고정락카 사용시간</label>
                            <input type="text" id="pStDate" name="pStDate" class="form-control" placeholder="YYYY-MM-DD"/>
                            <div class="day-mid">~</div>
                            <input type="text" id="pEdDate" name="pEdDate" class="form-control" placeholder="YYYY-MM-DD"/>
                        </div>
               		</div>
                    <div class="form-btn-row">
					    <button class="btn btn-info ripple m-1 mb-1"   onclick="f_Create();" >신규</button>
          				<button class="btn btn-success ripple m-1" onclick="f_SavePop();">저장</button>
          				<button class="btn btn-danger ripple m-1" onclick="f_FixStop();">사용중지</button>
      				</div>
            	</div>
  			</div>
      </div>
    </div>
          
</body>
</html>