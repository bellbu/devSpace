<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<%@include file="/WEB-INF/include/header.jsp" %>
<title>온천락카판매등록</title>
<style>
#lockerBackDiv{
	background-color: #aa9ff1;
	width:732px;
	padding: 14px;
}

#lockerTable {
	margin-top: -6px;
}


.man{
	background-color:#afffdc;
}

.woman{
	background-color: #e3fbff;
}

.man,.woman{
	border: 3px solid;
	cursor: pointer;
	border-color: white;
}

.click{
    background-color: #5a5a5a;
}

.emptybox{
 
}

#lockerTable td{
	width: 52px;
	height: 42px; 
	color: #ff1f9b;
	font-weight: bold;
	min-width: 50px;
	max-width: 52px;
	max-height: 42px;
	
	overflow:hidden;
	white-space : pre;
	text-overflow: ellipsis;

}

</style>
<script type="text/javascript">
var codeRoomType ;
var selrow = 1;
var keyNo ="";
var keyObj = new Object();

$(function () {


	$('#upjangCode').val('2308');  //업장코드초기화
	/*hotkeys.unbind('F2');

	hotkeys('F2', function() {
		f_Save();
		return false;
	});*/

	$(document).off().on('click',".man,.woman", function(){
  		//input , selectbox 초기화
  		
  		keyNo = this.dataset.val; //선택된 락커 번호

  		var sexClass = $(this).attr('class'); // 클래스 이름 성별

	    // 락카선택 초기화
  		$(".man").removeClass("click");
  		$(".woman").removeClass("click");

  		$(this).addClass("click"); // 해당락카 선택시 클릭 클래스 추가

  		var data = keyObj[keyNo]; // 선택라카 이용자 정보??
  		console.log("sexClass",sexClass);

  		if(data==null){ // 데이터 없는 경우

  		 	if($('#stat').val()!='comp'){ // 빈 락카에 동반객 로우 추가가 없는 경우 모두 클리어
  		 		if($("#gr_Partner").getGrid()){
					$("#gr_Partner").setGridParam("clear");
				}

				if($("#gr_RentItemList").getGrid()) {
					$("#gr_RentItemList").setGridParam("clear");
				}

				if($("#gr_PartnerSubList").getGrid()) {
					$("#gr_PartnerSubList").setGridParam("clear");
				}

  	  			f_Create(); // 초기화		
  		 	}
  		 		$('#type').val('add');  // 등록된 락카아닌 경우 add타입 추가
  		 		$('#keyAddress').val(); // 키값 초기화
  			
  		 	// 이용자 성별 자동 셀렉트 
  	 		if(sexClass=='man' || sexClass=="man click"){
  	 	 		$('#sex').val('M').trigger('change',true);
  	 		}else if(sexClass=='woman' || sexClass=="woman click"){
  	 	 		$('#sex').val('F').trigger('change',true);
  	 		}
  		 	// 키 자동 인풋
  	 		$('#keyNo').val(keyNo);
  		 	// 로우추가 없는 경우 지불락카 번호 인풋
  	 		if($('#copy').val()=='N'){
	  	 		$("#payLockNo").val(keyNo);
  	 		}

  			return false;
  		}else{ // 등록된 락카인 경우
  	 		$('#keyNo').val(keyNo);
  	 		$('#guestName').val(data.guestName); // 이용자
  	 		console.log("data.guestName",data.guestName);
  	 		$('#guestNo').val(data.guestNo);
  	 	
  	 		$('#relativeType').val(data.relativeType).trigger('change',true); //관계사
  	 		$('#gymYn').val(data.gymYn).trigger('change',true); //헬스장
  	 		$('#spaYn').val(data.spaYn).trigger('change',true); //수영장
	 	 	$('#sex').val(data.sex).trigger('change',true);
		
  	  		$('#entDiv').val(data.entDiv).trigger('change',true); // 입장객 구분(입주자,입주동반자 등)
  	  		$('#roomNo').val(data.roomNo); 
  	  		$('#payLockNo').val(data.payLockNo); // 지불락카
  	  		
  	  		$('#keyAddress').val(data.keyAddress); //
  	  		$('#upjangCode').val(data.upjangCode);
  	  		$('#saleDate').val(data.saleDate);
  	  		$("#menuCode").val(data.menuCode).trigger('change',true); // 온천요금
  	  		$('#memType').val(data.memType);
  			$('#spaFareType').val(data.spaFareType);  // 존재x
  			$('#saleAmt').val(data.saleAmt); // 입장금액
  			$('#possible').val(data.possible); // 존재x
  			$('#all').val(data.all);
  			$('#remarks').val(data.remarks);
  			$('#payLockNo').val(data.payKeyNo);
  			$('#enterTime').val(data.enterTime);
  			$('#exitTime').val(data.exitTime);
  			
  			f_GridLoad(data); // 동반자 그리드 바인드
  			$('#stat').val('');
  		}
  		
  		if($('#stat').val()=='comp'){ // 동반자 로우 추가한 경우
  	  		$('#type').val('add');
  		}else{
  	  		$('#type').val('edit');
  		}	
 		//ajax success 안에 입력

		
	/* 	
		//서브인풋
		$('#bGuestName').val('data.bGuestName');
		$('#bGuestNo').val('data.bGuestNo');
		$('#bMemType').val('data.bMemType').trigger('change',true);
		$('#bRoomNo').val('data.bRoomNo');
		$('#bOfficeName').val('data.bOfficeName');
		
		$('#bHpNo').val('data.bHpNo');
		$('#bBirthDay').val('data.bBirthDay');
		$('#bMarrDate').val('data.bMarrDate');
		$('#bMainGuestName').val('data.bMainGuestName');
				
		 */

		
  	});
  	

	$("#sBookDate").on("change",function (){
		f_Retrieve();
		f_Create();
	});

  	$("#menuCode").on("change", function(){ // 온천요금 셀렉트 변경시 입장금액 인풋
  		 $.ajax({
 		 	type : "POST",
 		 	url : "/btm/SpaLockerSalesRegistration_SaunaAmt_Select.do",
 		 	data : {
 		 		sMenuCode : $("#menuCode").val()
 		 	},
 		 	datatype : "json",
 		 	success : function(json) {
 			 	if(json[0]){
 					$("#saleAmt").val(json[0].salePrice);	

 				}
 	 		}
 	 });
  	});
	$("#guestName").keydown(function (key) {
    	if(key.keyCode != 13 || $("#guestName").val() == ""){
    		if(f_CheckFunctionKey(key.keyCode)){
				f_GuestClear();
    		 }
    	 }
	});


/*
	$("#guestName").blur(function (e){
		f_SearchMemName()
	});*/


});
/*******************************************************************************
 * FUNCTION 명 : $( document ).ready(function()
 * FUNCTION 기능설명 : 팝업 최초 실행
 *******************************************************************************/
$( document ).ready(function(){

	f_InitView();

	f_Retrieve();

   
	
	
});
 
 
 function f_GridLoad(data) {

	 	//동반자내역
	 	console.log(data);
		$("#type").val("edit");
	    $('#keyNo').attr('disabled',true);
		//$("#keyNo").attr("disa")


	 	if($("#gr_Partner").getGrid()){
			$("#gr_Partner").setGridParam("clear");
			$("#gr_Partner").setGridParam({
				url : '/btm/SpaLockerSalesRegistration_Companion.do',
				postData : {											// 넘겨줄 파라미터
					saleDate : data.saleDate
					,upjangCode : data.upjangCode
					,keyAddress : data.keyAddress
					,sex :data.sex
				}
			});
		}

			
}
 
 
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
 * FUNCTION 명 : 초기화 > 상단 영역(ex:검색 등)
 * FUNCTION 기능설명 :
 *******************************************************************************/
function f_InitTopView() {
	 
	// 마감일자 가져오기
	 $.ajax({ 
			type:"POST",
			url : "/btm/SpaLockerSalesRegistration_SaleDate_Select.do",
			data : {
				pUpjangCode : '2308'
			},
			async : false,
			datatype : "json",
			success : function(json){
				if(json){
				$.each(json, function(i,item){
					$("#sBookDate").setCal(item.saleDate);
				});
				}
			}
		});

	$("#menuCode").empty(); // 온천요금 초기화
	
	 // 온천요금 가져오기
	 $.ajax({
		 	type : "POST",
		 	url : "/btm/SpaLockerSalesRegistration_Sauna_Select.do",
		 	data : {
				pUpjangCode : '2308'
		 	},
		 	datatype : "json",
		 	success : function(json) {
			 	if(json){
					$("#menuCode").append('<option value="" selected>-- 선택 --</option>');
					
					$.each(json, function(i, item) {
						$('<option>').val(item.menuCode).text(item['menuName']).appendTo("#menuCode");
					});

					$("#menuCode").select2();

				}
	 		}
	 });


	 //entDiv 임시
     $("#entDiv").setSelectDataSet('${cmmnObj.BT009}', "chk"); // 입장객 구분
     $("#relativeType").setSelectDataSet('${cmmnObj.BT001}', "chk"); // 멤버사
     $("#memType").setSelectDataSet('${cmmnObj.CR034}', "chk"); // 고객구분
	 $("#vMemType").setSelectDataSet('${cmmnObj.CR034}','chk'); // 고객구분 
     $("#spaFareType").setSelectDataSet('${cmmnObj.SP002}', "chk"); // 존재x
     $("#sex").setSelectDataSet('${cmmnObj.RS005}', "chk");
     $("#gymYn").setSelectDataSet('${cmmnObj.CO010}', "chk");
     $("#spaYn").setSelectDataSet('${cmmnObj.CO010}', "chk");
 	 $("#guestName").enter('f_PopupsGuestName','"guestName"');
 	 $("#roomNo").enter('','"roomNo"');



}
 
	
 function f_setEvent() {

	    $("#gr_Partner").createGridEvent(
	          ''   // create
	          ,{   // read
	             onClickEvent:'f_PartnerBind' // 동반자 상세정보 바인드
	          } 
	          ,''   // update
	          );
	    /*	
	    $("#gr_PartnerSubList").createGridEvent(
		          ''   // create
		          ,{   // read
		             onClickEvent:'f_PartnerSubBind'
		          } 
		          ,''   // update
		          );   
	    */
}
/*******************************************************************************
 * FUNCTION 명 :
 * FUNCTION 기능설명 : 초기화 > 중간 영역(ex:Grid 등)
 *******************************************************************************/
function f_InitMiddleView() { 

		$("#gr_Partner").tuiGrid({
			 url : '/btm/SpaLockerSalesRegistration_Companion.do'
			, postData: {

			}
			, rownumbers: true
			, height: 150
			, colNames: [
				'락카번호','이용자명','고객구분','멤버사','주택번호'
				,'성별'	,'지불락카','요금구분','입장금액','비고사항'
				,'휘트니스','수영장','입장시간','퇴장시간','정산유무','keyAddress','menuCode','upjangCode','saleDate'
			]
			, colModel: [
				{
					//락카번호
					name: 'keyNo'
					, align: "center"
					, width: "60"
				},{
					//이용자명
					name: 'guestName'
					,align: "center"
					,width: "80"
				}, {
					//고객구분
					name: 'memType'
					, align: "center"
					, width: "100"
					, template : getSelectCommonCodeTemplate('CR034',true)
				}, {
					//관계사
					name: 'relativeType'
					, align: "center"
					, width: "100"
                    , template : getSelectCommonCodeTemplate('BT001',false)
				}, {
					//주택번호
					name: 'roomNo'
					, align: "center"
					, width: "60"
				},{
					//성별
					name: 'sex'
					,align: "center"
					,width: "50"
				},
				
				{  
					//지불라카
					name: 'payKeyNo'
					,align: "center"
					,width: "60"
				},  {
					//요금구분
					name: 'menuName'
					,align: "center"
					,width: "100"
				}, {
					//입장금액
					name: 'saleAmt'
					,align: "right"
					,width: "100"
					,template : getNumberTemplate(20,true)
				}, {
					//비고사항
					name: 'remarks'
					,align: "center"
					,width: "80"
					,hidden : true
				}, {
					//휘트니스
					name: 'spaYn'
					, align: "center"
					, width: "60"
				},{
					//수영장
					name: 'gymYn'
					, align: "center"
					, width: "60"
				}, {
					//입장시간
					name: 'enterTime'
					, align: "center"
					, width: "80"
				}, {
					//퇴장시간
					name: 'exitTime'
					, align: "center"
					, width: "80"
				}, {
					//정산유무
					name: 'paidYn'
					, align: "center"
					, width: "80"
				}, {
					//정산유무
					name: 'keyAddress'
					, hidden:  true
				}, {
					//정산유무
					name: 'menuCode'
					, hidden:  true
				}, {
					//정산유무
					name: 'upjangCode'
					, hidden:  true
				}, {
					//정산유무
					name: 'saleDate'
					, hidden:  true
				}
				
			],ondblClickRow: function (rowid, iRow, iCol, e) {
			},loadComplete: function (data) {
				var rowSize = $('#gr_Partner').getGrid().getRowCount();
				if(rowSize>0){
					$('#gr_Partner').getGrid().focus(0,'keyNo',true);
				}
			}	
		});	 

		$("#gr_RentItemList").tuiGrid({
			  url: "" 
			, postData: {

			}
			, rownumbers: true
			, height: 170
			, colNames: [
				'코드','입장/대여내역','수량','금액'
			]
			, colModel: [
				{
					//코드
					name: 'menuCode'
					, align: "center"
					, width: "80"
				},{
					//입장/대여내역
					name: 'menuName'
					,align: "left"
					,width: "150"
				}, {
					//수량
					name: 'saleQty'
					, align: "right"
					, width: "60"
				}, {
					//금액
					name: 'saleAmt'
					, align: "right"
					, width: "80"
					, template : getNumberTemplate(10,false)
				}
				
			],ondblClickRow: function (rowid, iRow, iCol, e) {
			},loadComplete: function (data) {
			  	var rentAmt = 0;
			  	var entAmt = 0;

				$.each(data,function(rowId,rowData){
					console.log(rowData);
					if(rowData["menuType"] == "001"){ // 고객구분 : 일반골프 회원 
						entAmt += rowData["saleAmt"];
						//grid.addCellClassName(rowId,"taxOrgan","Red");
					}else if(rowData["menuType"] == "002"){ // 고객구분 : 명예특별 회원
						rentAmt += rowData["saleAmt"];
						//grid.addCellClassName(rowId,"taxOrgan","Blue");
					}
				});

				$("#rentJoinAmt").val(f_SetComma(entAmt));
				$("#rentAmt").val(f_SetComma(rentAmt));
				$("#allRentAmt").val(f_SetComma(entAmt + rentAmt));
			}
		});

	$("#gr_record").tuiGrid({
		rownumbers: false
		,height : 100
		,colNames : [
			'성명'
			,'고객번호'
			,'연번'
			,'관계'
		]
		,colModel : [
			{
				name : 'memName'
				,align : "center"
				,width : "80"
			},{
				name : 'guestNo'
				,align : "center"
				,width : "80"
			},{
				name : 'idx'
				,align : "center"
				,width : "80"
			},{
				name : 'relation'
				,align : "center"
				,width : "100"
				,template : getSelectCommonCodeTemplate('CR008',false)
			}
		]
	});
		


}
/*******************************************************************************
 * FUNCTION 명 :
 * FUNCTION 기능설명 : 조회
 *******************************************************************************/
function f_Retrieve() {
	f_LokerView();

	f_LockcerUse();
}

/*******************************************************************************
 * FUNCTION 명 :
 * FUNCTION 기능설명 : 신규
 *******************************************************************************/

function f_BytesHandler(obj) {
	var objId = $(obj).attr('id');
	var maxlength = $(obj).attr('maxlength');
	var text = $(obj).val();
	var totalByte = 0;
	for (var i = 0; i < text.length; i++) {
		var currentByte = text.charCodeAt(i);
		if (currentByte > 128)
			totalByte += 3;
		else
			totalByte++;
	}
	$('#' + objId + "Length").text(totalByte + "/" + maxlength + "byte");
}

// 훔친 함수 사용X
function f_FormClear(formId) {

	$("#" + formId + " :input").each(function() {
		$(this).val($(this).prop("defaultValue"));
	});
	$("#" + formId + " textarea").each(function() {
		$(this).val('').text('').change();
		f_BytesHandler(this);
	});

	$("#" + formId + " textarea").off('keyup');
	$("#" + formId + " textarea").keyup(function() {
		f_BytesHandler(this);
	});

	$("#" + formId + " select").each(function() {
		$(this).select2();
		try {
			$(this).prop('selectedIndex', 0).change();
		} catch (e) {
			console.log(e);
		}
	});

	$("#" + formId + " :checkbox").each(function() {
		$(this).data('oldData', null);
		$(this).prop('checked', false);
	});

	$("#" + formId + " :radio").each(function() {
		$(this).prop('checked', false);
		$(this).trigger('change');
	});

}

function f_LockcerUse(){
     // 남녀 이용락커 cnt 
	 $.ajax({
		type : "POST",
		url : "/btm/SpaLockerSalesRegistration_Use_Select.do",
		async : false,
		data : {
			sBookDate : $('#sBookDate').getCal().replaceAll(),
			sUpjangCode : '2308'
		},
		datatype : "json",
		success : function(json) {
			//	console.log(json);
			console.log(json);

			$.each(json,function(idx,item){
				$("#manLock").val(item.manCnt);
				$("#womanLock").val(item.womanCnt);
				$("#totalCnt").val(item.manCnt + item.womanCnt);
			});
		}
	});
}

function f_PopupsGuestName() {

	if($("#guestName").val() == ""){
		alert("이용자 성명을 입력해주세요.");
		return ;
	}

	var houseCk = false;

	$.ajax({
		async : false,
		type : "post",
		url : "/btmPopup/RetrieveHouseMemberListPop_Select.do",
		data : {
			sMemName : $("#guestName").val()
		},
		datatype : "json",
		success : function(json) {
			console.log(json.data.contents.length);
			if(json.data.contents.length > 0) {
				houseCk = true;
			}

		},beforeSend : function () {
			pageBlock();
		},
		complete : function () {
			pageUnBlock();

		}
	});

	var BindData;
	var PopType;
	
	if(houseCk) 
	{
		PopType = "RetrieveHouseMemberListPop"; // 존재하지 않는 팝업
		BindData = [
			{ grid : 'memName',			view : 'guestName',			type :'text'},
			{ grid : 'guestNo',			view : 'guestNo',			type :'text'},
			{ grid : 'roomNo',			view : 'roomNo',			type :'text'},
			{ grid : 'relativeType',	view : 'relativeType',		type :'select2'},
			{ grid : 'memType',			view : 'memType',			type :'select2'},
		];
	} else {
		PopType = "RetrieveMemberCodeListPop";
		BindData = [
			 { grid : 'memName',		view : 'guestName',			type :'text'}
			,{ grid : 'guestNo',		view : 'guestNo',			type :'text'}
			,{ grid : 'memType',		view : 'memType',			type :'select2'}
		];
	}


	f_settingPop({
		PopType : PopType,
		BindData : BindData,
		SearchNameText : $("#guestName").val(),
		CloseEvent : function() {
/*
			hotkeys.unbind('F2');

			hotkeys('F2', function() {
				f_Save();
				return false;
			});*/


			if(houseCk){
				$("#entDiv").val("01").trigger("change");
			}
			f_GetGuestInfo($("#guestNo").val())
		}
	});


   /* var BindData = [
        { grid : 'memName',			view : 'guestName',			type :'text'}
        ,{ grid : 'guestNo',		view : 'guestNo',			type :'text'}
        ,{ grid : 'memType',		view : 'memType',			type :'select2'}
        ,{ grid : 'sex',			view : 'sex',				type :'select2'}
        ,{ grid : 'remarks',		view : 'remarks',			type :'textarea'}
 		,{ grid: 'roomNo', 			view : 'roomNo', 			type : 'text'	}
		,{ grid: 'guestName', 		view : 'bGuestName', 		type : 'text'	}
		,{ grid: 'guestNo', 		view : 'bGuestNo', 			type : 'text'	}
		,{ grid: 'memType', 		view : 'bMemType', 			type : 'select2'	}
		,{ grid: 'roomNo' , 		view : 'bRoomNo', 			type : 'text'	}
		,{ grid: 'officeName', 		view : 'bOfficeName', 		type : 'text'	}
		,{ grid: 'hpNo', 			view : 'bHpNo', 			type : 'text'	}
		,{ grid: 'birthDay', 		view : 'bBirthDay', 		type : 'text'	}
		,{ grid: 'marrDate', 		view : 'bMarrDate', 		type : 'text'	}
		,{ grid: 'masterGuestName', view : 'bMainGuestName', 	type : 'text'	}
		,{ grid : 'imagePath',		view : 'prev_previewId',	type : 'guestImage'}
		,{ grid : 'imgPath',		view : 'imgPath',			type : 'text'	}
    ];
    f_settingPop({
        PopType : "RetrieveMemberCodeListPop",
        BindData : BindData,
        SearchNameText : $("#guestName").val(),
        SearchCodeText : $("#guestNo").val(),
        CloseEvent : function() {
//         	f_GridLoad();
		}
    });*/
}

function f_LokerView() { // 해당일자에 등록된 락카정보 select
	f_reset();
	var man=0;
	var woman=0;
		$.ajax({
			type : "POST",
			url : "/btm/SpaLockerSalesRegistration_Select.do",
			async : false,
			data : {
				sBookDate : $('#sBookDate').getCal().replaceAll(),
				sUpjangCode : '2308'
			},
			datatype : "json",
			success : function(json) {
			//	console.log(json);
				console.log(json);

				$.each(json,function(idx,item){
					var keyNo = item.keyNo;
					//$('#lockerTable td')[70].append('\n 기타사항') 
					$('[data-val='+keyNo+']').css('backgroundColor','blue');
					$('[data-val='+keyNo+']').css('font-size','6px');
					$('[data-val='+keyNo+']').css('color','white');
// 					$('[data-val='+keyNo+']').css('word-break','keep-all');
// 					$('[data-val='+keyNo+']').css('word-wrap','break-word');
					$('[data-val='+keyNo+']').text(keyNo+'\n'+item.guestName);
					if(item.sex=='M'){
						man++;
					}else if(item.sex=='F'){
						woman++;
					}
					//$("#manLock").val(man);
					//$("#womanLock").val(woman);
					//$("#totalCnt").val(man+woman);
					keyObj[keyNo] = item;

				});
			}
		});
}

function f_PartnerBind(rowId){ // 동반자 상세정보
	selrow1 = rowId;
	var grid = $('#gr_Partner').getGrid();
	var data = $('#gr_Partner').getGrid().getData()[rowId];

	var rowData = $("#gr_Partner").getRowData(rowId);
	$("#gr_Partner").JSBindData([ {
		id : rowId
	}, { grid : 'keyNo', 		 	 view : 'keyNo', 		 type : 'text' }
	, { grid : 'guestName', 		 view : 'guestName', 	 type : 'text' }
		, { grid : 'memType',		 view : 'memType', 		 type : 'select2' }
		, { grid : 'relativeType', 	 view : 'relativeType',  type : 'select2' }
		, { grid : 'roomNo', 		 view : 'roomNo', 		 type : 'text' }
		, { grid : 'sex', 		 	 view : 'sex', 		 	 type : 'select2' }
/*		, { grid : 'menuName', 	 	 view : 'menuName', 	 type : 'text' }*/
		, { grid : 'saleAmt', 	 	 view : 'saleAmt', 	 	 type : 'text' }
		, { grid : 'remarks', 	 	 view : 'remarks', 	 	 type : 'text' }
		, { grid : 'spaYn',      	 view : 'spaYn', 	 	 type : 'select2' }
		, { grid : 'gymYn', 	 	 view : 'gymYn',         type : 'select2' }
		, { grid : 'enterTime',  	 view : 'enterTime',     type : 'text' }
		, { grid : 'exitTime', 	 	 view : 'exitTime',      type : 'text' }
		, { grid : 'paidYn', 	 	 view : 'paidYn',        type : 'select2' }
		, { grid : 'keyAddress', 	 view : 'keyAddress',    type : 'text' }
		, { grid : 'upjangCode', 	 view : 'upjangCode',    type : 'text' }
		, { grid : 'saleDate', 	 	 view : 'saleDate',      type : 'text' }
		, { grid : 'guestNo', 	 	 view : 'guestNo',      type : 'text' }
		, { grid : 'menuCode', 	 	 view : 'menuCode',    	 type : 'select2' }

	]);

	//console.log(rowData);

	//대여내역
	$("#gr_RentItemList").setGridParam("clear"); 
	$("#gr_RentItemList").setGridParam({
		url : '/btm/SpaLockerSalesRegistration_Rent.do',
		postData : {											// 넘겨줄 파라미터
			upjangCode :  rowData["upjangCode"]
			,keyAddress : rowData["keyAddress"]
			,keyNo : 	  rowData["keyNo"]
			,sex :		  rowData["sex"]
		 }
	}); 

	if(rowData["type"] == "add"){
		$("#type").val("add");
	} else {
		$("#type").val("edit");
	}

  	/*//고객목록
 	$("#gr_PartnerSubList").setGridParam("clear");
	$("#gr_PartnerSubList").setGridParam({
		url : "/btm/SpaLockerSalesRegistration_MemGroup.do",
		postData : {											// 넘겨줄 파라미터
			guestNo : data.guestNo
		 }
	}); */
}

function f_reset(){
//	f_Create();

	for(var i=0; i<1000;i++){
		keyObj[i] = null;
	}

	$("#lockerTable").empty();
	var htmlAppend ='<tr>'+ 
        '<td class="emptybox" data-val="blank"></td>'+
       	'<td class="emptybox" data-val="blank"></td>'+
       	'<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="woman" data-val="570">570</td>'+
        '<td class="woman" data-val="546">546</td>'+
        '<td class="woman" data-val="545">545</td>'+
        '<td class="woman" data-val="516">516</td>'+
        '<td class="woman" data-val="515">515</td>'+
    '</tr>'+
    '<tr>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="woman" data-val="569">569</td>'+
        '<td class="woman" data-val="547">547</td>'+
        '<td class="woman" data-val="544">544</td>'+
        '<td class="woman" data-val="517">517</td>'+
        '<td class="woman" data-val="514">514</td>'+
    '</tr>'+
    '<tr>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="woman" data-val="571">571</td>'+
        '<td class="woman" data-val="568">568</td>'+
        '<td class="woman" data-val="548">548</td>'+
        '<td class="woman" data-val="543">543</td>'+
        '<td class="woman" data-val="518">518</td>'+
        '<td class="woman" data-val="513">513</td>'+
    '</tr>'+
    '<tr>'+
        '<td class="man" data-val="112">112</td>'+
        '<td class="man" data-val="113">113</td>'+
        '<td class="man" data-val="136">136</td>'+
        '<td class="man" data-val="137">137</td>'+
        '<td class="man" data-val="160">160</td>'+
        '<td class="man" data-val="161">161</td>'+
        '<td class="man" data-val="184">184</td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="woman" data-val="572">572</td>'+
        '<td class="woman" data-val="567">567</td>'+
        '<td class="woman" data-val="549">549</td>'+
        '<td class="woman" data-val="542">542</td>'+
        '<td class="woman" data-val="519">519</td>'+
        '<td class="woman" data-val="512">512</td>'+
    '</tr>'+
    '<tr>'+
        '<td class="man" data-val="111">111</td>'+
        '<td class="man" data-val="114">114</td>'+
        '<td class="man" data-val="135">135</td>'+
        '<td class="man" data-val="138">138</td>'+
        '<td class="man" data-val="159">159</td>'+
        '<td class="man" data-val="162">162</td>'+
        '<td class="man" data-val="183">183</td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="woman" data-val="573">573</td>'+
        '<td class="woman" data-val="566">566</td>'+
        '<td class="woman" data-val="550">550</td>'+
        '<td class="woman" data-val="541">541</td>'+
        '<td class="woman" data-val="520">520</td>'+
        '<td class="woman" data-val="511">511</td>'+
    '</tr>'+
    '<tr>'+
        '<td class="man" data-val="110">110</td>'+
        '<td class="man" data-val="115">115</td>'+
        '<td class="man" data-val="134">134</td>'+
        '<td class="man" data-val="139">139</td>'+
        '<td class="man" data-val="158">158</td>'+
        '<td class="man" data-val="163">163</td>'+
        '<td class="man" data-val="182">182</td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="woman" data-val="574">574</td>'+
        '<td class="woman" data-val="565">565</td>'+
        '<td class="woman" data-val="551">551</td>'+
        '<td class="woman" data-val="540">540</td>'+
        '<td class="woman" data-val="521">521</td>'+
        '<td class="woman" data-val="510">510</td>'+
    '</tr>'+
    '<tr>'+
        '<td class="man" data-val="109">109</td>'+
        '<td class="man" data-val="116">116</td>'+
        '<td class="man" data-val="133">133</td>'+
        '<td class="man" data-val="140">140</td>'+
        '<td class="man" data-val="157">157</td>'+
        '<td class="man" data-val="164">164</td>'+
        '<td class="man" data-val="181">181</td>'+
        '<td class="man" data-val="185">185</td>'+
        '<td class="woman" data-val="575">575</td>'+
        '<td class="woman" data-val="564">564</td>'+
        '<td class="woman" data-val="552">552</td>'+
        '<td class="woman" data-val="539">539</td>'+
        '<td class="woman" data-val="522">522</td>'+
        '<td class="woman" data-val="509">509</td>'+
    '</tr>'+
    '<tr>'+
        '<td class="man" data-val="108">108</td>'+
        '<td class="man" data-val="117">117</td>'+
        '<td class="man" data-val="132">132</td>'+
        '<td class="man" data-val="141">141</td>'+
        '<td class="man" data-val="156">156</td>'+
        '<td class="man" data-val="165">165</td>'+
        '<td class="man" data-val="180">180</td>'+
        '<td class="man" data-val="186">186</td>'+
        '<td class="woman" data-val="576">576</td>'+
        '<td class="woman" data-val="563">563</td>'+
        '<td class="woman" data-val="553">553</td>'+
        '<td class="woman" data-val="538">538</td>'+
        '<td class="woman" data-val="523">523</td>'+
        '<td class="woman" data-val="508">508</td>'+
    '</tr>'+
    '<tr>'+
        '<td class="man" data-val="107">107</td>'+
        '<td class="man" data-val="118">118</td>'+
        '<td class="man" data-val="131">131</td>'+
        '<td class="man" data-val="142">142</td>'+
        '<td class="man" data-val="155">155</td>'+
        '<td class="man" data-val="166">166</td>'+
        '<td class="man" data-val="179">179</td>'+
        '<td class="man" data-val="187">187</td>'+
        '<td class="woman" data-val="577">577</td>'+
        '<td class="woman" data-val="562">562</td>'+
        '<td class="woman" data-val="554">554</td>'+
        '<td class="woman" data-val="537">537</td>'+
        '<td class="woman" data-val="524">524</td>'+
        '<td class="woman" data-val="507">507</td>'+
    '</tr>'+
    '<tr>'+
        '<td class="man" data-val="106">106</td>'+
        '<td class="man" data-val="119">119</td>'+
        '<td class="man" data-val="130">130</td>'+
        '<td class="man" data-val="143">143</td>'+
        '<td class="man" data-val="154">154</td>'+
        '<td class="man" data-val="167">167</td>'+
        '<td class="man" data-val="178">178</td>'+
        '<td class="man" data-val="188">188</td>'+
        '<td class="woman" data-val="578">578</td>'+
        '<td class="woman" data-val="561">561</td>'+
        '<td class="woman" data-val="555">555</td>'+
        '<td class="woman" data-val="536">536</td>'+
        '<td class="woman" data-val="525">525</td>'+
        '<td class="woman" data-val="506">506</td>'+
    '</tr>'+
    '<tr>'+
        '<td class="man" data-val="105">105</td>'+
        '<td class="man" data-val="120">120</td>'+
        '<td class="man" data-val="129">129</td>'+
        '<td class="man" data-val="144">144</td>'+
        '<td class="man" data-val="153">153</td>'+
        '<td class="man" data-val="168">168</td>'+
        '<td class="man" data-val="177">177</td>'+
        '<td class="man" data-val="189">189</td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="woman" data-val="556">556</td>'+
        '<td class="woman" data-val="535">535</td>'+
        '<td class="woman" data-val="526">526</td>'+
        '<td class="woman" data-val="505">505</td>'+
    '</tr>'+
    '<tr>'+
        '<td class="man" data-val="104">104</td>'+
        '<td class="man" data-val="121">121</td>'+
        '<td class="man" data-val="128">128</td>'+
        '<td class="man" data-val="145">145</td>'+
        '<td class="man" data-val="152">152</td>'+
        '<td class="man" data-val="169">169</td>'+
        '<td class="man" data-val="176">176</td>'+
        '<td class="man" data-val="190">190</td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="woman" data-val="557">557</td>'+
        '<td class="woman" data-val="534">534</td>'+
        '<td class="woman" data-val="527">527</td>'+
        '<td class="woman" data-val="504">504</td>'+
    '</tr>'+
    '<tr>'+
        '<td class="man" data-val="103">103</td>'+
        '<td class="man" data-val="122">122</td>'+
        '<td class="man" data-val="127">127</td>'+
        '<td class="man" data-val="146">146</td>'+
        '<td class="man" data-val="151">151</td>'+
        '<td class="man" data-val="170">170</td>'+
        '<td class="man" data-val="175">175</td>'+
        '<td class="man" data-val="191">191</td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="woman" data-val="558">558</td>'+
        '<td class="woman" data-val="533">533</td>'+
        '<td class="woman" data-val="528">528</td>'+
        '<td class="woman" data-val="503">503</td>'+
    '</tr>'+
    '<tr>'+
        '<td class="man" data-val="102"><span>102</span></td>'+
        '<td class="man" data-val="123">123</td>'+
        '<td class="man" data-val="126">126</td>'+
        '<td class="man" data-val="147">147</td>'+
        '<td class="man" data-val="150">150</td>'+
        '<td class="man" data-val="171">171</td>'+
        '<td class="man" data-val="174">174</td>'+
        '<td class="man" data-val="192">192</td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="woman" data-val="559">559</td>'+
        '<td class="woman" data-val="532">532</td>'+
        '<td class="woman" data-val="529">529</td>'+
        '<td class="woman" data-val="502">502</td>'+
    '</tr>'+
    '<tr>'+
        '<td class="man" data-val="101">101</td>'+
        '<td class="man" data-val="124">124</td>'+
        '<td class="man" data-val="125">125</td>'+
        '<td class="man" data-val="148">148</td>'+
        '<td class="man" data-val="149">149</td>'+
        '<td class="man" data-val="172">172</td>'+
        '<td class="man" data-val="173">173</td>'+
        '<td class="man" data-val="193">193</td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="emptybox" data-val="blank"></td>'+
        '<td class="woman" data-val="560">560</td>'+
        '<td class="woman" data-val="531">531</td>'+
        '<td class="woman" data-val="530">530</td>'+
        '<td class="woman" data-val="501">501</td>'+
    '</tr>';
    $("#lockerTable").append(htmlAppend);
}


function f_Create() { // 신규/초기화
		$('textarea').val('');
		$('#insertForm input[type=text]').val('');
		$('#subView input[type=text]').val('');
		$('#copy').val('N');
		$('textarea').val('');
  		var selectId = $('#insertForm select');
  		$.each(selectId,function(idx,item){
  			id = item.id;
  	  		$('#'+id+' option:eq(0)').prop('selected',true).trigger('change',true);
  		})
  		$('#bMemType option:eq(0)').prop('selected',true).trigger('change',true);
  		$('#type').val('add');
  		$('#saleDate').val('');
  		$('#keyAddress').val('');  
  		$('#stat').val('');

  		$("#gymYn").val('N').trigger("change");
  		$("#spaYn").val('N').trigger("change");
  		$("#entDiv").val('99').trigger("change");
  		$("#keyNo").attr("disabled",false);

  		if($("#gr_Partner").getGrid()){
			$("#gr_Partner").setGridParam("clear");
		}

		if($("#gr_RentItemList").getGrid()){
			$("#gr_RentItemList").setGridParam("clear");
		}

		if($("#gr_PartnerSubList").getGrid()){
			$("#gr_PartnerSubList").setGridParam("clear");
		}

  	 	$("#menuCode").val("6610100013").trigger("change");

  	 	$("#guestName").focus();

	$("#vGuestName").val("");
	$("#vGuestNo").val("");
	$("#vMemType").val("").trigger("change");
	$("#vGuestHpNo").val("");
	$("#vGuestType").val("").trigger("change");
	$("#vOfficeName").val("");
	$("#vMasterGuestName").val("");
	$("#vOfficePosition").val("").trigger("change");
	$("#prev_previewId").getGuestImage("");

	//f_GuestClear();
}

function f_Companion() { // 현재 사용X
	if($('#keyAddress').val()==''){
		alert('동반자를 추가할 락카를 선택해주세요');
		return false;
	}
	$('textarea').val('');
	$('#insertForm input[type=text]').val('');
	$('#subView input[type=text]').val('');
	var selectId = $('#insertForm select');
	$.each(selectId,function(idx,item){
  		id = item.id;
  	  	$('#'+id+' option:eq(0)').prop('selected',true).trigger('change',true);
  	})
	$('#bMemType option:eq(0)').prop('selected',true).trigger('change',true);	
	$('#stat').val('comp');
}
function f_Copy() {
	/*if($('#keyAddress').val()==''){
		alert('동반자를 추가할 락카를 선택해주세요');
		return false;
	}*/

	/*var selRow = $("#gr_Partner").getGridParam( "selrow" );
	//var selRow = $("#gr_Partner").tuiGrid('getGridParam', 'selrow');
	if (selRow == null) {
		alert("복사할 동반자를 선택 해주세요.");
		return false;
	}*/

/*	alert(selrow1);*/

	if($('#keyAddress').val()==''){
		alert('동반자를 추가할 락카를 선택해주세요');
		return false;
	}

	var rsvListRowData = $("#gr_Partner").getRowData(selrow1);

	$("#type").val('add');
	$("#keyNo").attr("disabled",false);
	$('#keyNo,#guestName,#guestNo').val('');
	$('#subView input[type=text]').val('');
	$('#bMemType option:eq(0)').prop('selected',true).trigger('change',true);
	$('#stat').val('comp');
	$('#copy').val('Y');
	//subView

	// 동반자 로우 추가/복사(선택한 로우값과 동일)
	var addObject = new Object();
	addObject.keyNo = "";
	addObject.guestName = rsvListRowData["guestName"];
	addObject.memType = rsvListRowData["memType"];
	addObject.relativeType = rsvListRowData["relativeType"];
	addObject.roomNo = rsvListRowData["roomNo"];
	addObject.sex = rsvListRowData["sex"];
	addObject.payKeyNo = rsvListRowData["payKeyNo"];
	addObject.menuName = rsvListRowData["menuName"];
	addObject.saleAmt = rsvListRowData["saleAmt"];
	addObject.remarks = rsvListRowData["remarks"];
	addObject.spaYn = rsvListRowData["spaYn"];
	addObject.gymYn = rsvListRowData["gymYn"];
	addObject.enterTime = rsvListRowData["enterTime"];
	addObject.exitTime = rsvListRowData["exitTime"];
	addObject.paidYn = rsvListRowData["paidYn"];
	addObject.keyAddress = rsvListRowData["keyAddress"];
	addObject.upjangCode = rsvListRowData["upjangCode"];
	addObject.saleDate = rsvListRowData["saleDate"];
	addObject.menuCode = rsvListRowData["menuCode"];
	addObject.type = "add"
	$("#gr_Partner").GridAdd(addObject);

	$("#keyNo").focus();

}

function f_Save() {

	if (!f_isValidate("insertForm")) {
		return;
	}

	if ($("#keyNo").val().trim() == "") {
		alert("락카번호를 선택해 주세요.");
		$("#keyNo").focus();
		return false;
	}	
	if ($("#guestName").val().trim() == "" || $("#guestName").val() == null) {
		alert("고객명을 입력해주세요");
		$("#guestName").focus();
		return false;
	}	
/* 	if ($("#guestNo").val() == "" || $("#guestNo").val() == null) {
		alert("고객번호를 입력해주세요.");
		$("#guestNo").focus();
		return false;
	} */
	if ($("#entDiv").val() == "" || $("#guestNo").val() == null) {
		alert("입장객구분을 입력해주세요.");
		$("#entDiv").focus();
		return false;
	}
	
	$('#saleDate').val($('#sBookDate').val().replaceAll('-',''));

	if($("#type").val() == ""){
		$("#type").val("add");
	}

	var type = $("#type").val();
	$('#sex,#keyNo').attr('disabled',false);
	var option = {
		beforeSubmit : function() {

		},
		success : function(result) {

			var saveOk = result.result;
			if (saveOk == '1') {
				f_Retrieve();
				//alert("저장 완료!");
				f_LokerView();

				console.log(keyNo);
				if(keyNo == null){
					f_GridLoad(keyObj[$("#keyNo").val()]);
				} else {

					if(keyNo != $("#keyNo").val()){
						f_GridLoad(keyObj[$("#keyNo").val()]);
					} else {
						f_GridLoad(keyObj[keyNo]);
					}
				}


			} else if (saveOk == '0') {
				alert(result.msg);
			}
		},
		error : function() {
			//alert("업로드 실패! 업로드 형식을 확인해주세요.");
		},
		beforeSend : function() {
			pageBlock();
		},
		complete : function() {
			pageUnBlock();
		}
	};

	if (confirm('저장하시겠습니까?') != true) {
		return false;
	}

	$('#insertForm').ajaxSubmit(option);
	$('#sex').attr('disabled',true);

}

function f_GuestClear()
{
    $("#guestNo").val("");
    $("#memType").val("").trigger("change");
	$("#roomNo").val("");
    $("#relativeType").val("").trigger("change");
}

function f_Del(){
    

	$("#gr_Partner").GridDelete({
		url : "/btm/SpaLockerSalesRegistration_Delete.do",
		success : function(json) {
			if(json.result == "1"){
				delete keyObj[keyNo];
				alert('삭제 완료!');
				f_LokerView();
				f_Create();
			}else if(json.result == "0"){
				alert(json.msg)
			}
		}
	});	 
}

function f_RentPop(){
	if($('#keyAddress').val()==''){
		alert('대여품 추가할 락카를 선택해주세요');
		return false;
	}

	var rsvListRowData = $("#gr_Partner").getRowData(selrow1);

	var popObj = new Object();
	popObj.upjangCode = "2308" ;
	popObj.saleDate = $("#sBookDate").val().replaceAll(",","");
	popObj.keyAddress = rsvListRowData["keyAddress"];
	popObj.keyNo = rsvListRowData["keyNo"];
	popObj.sex = rsvListRowData["sex"];
	popObj.guestName = rsvListRowData["guestName"];


	/*var addObject = new Object();
	addObject.keyAddress = rsvListRowData["keyAddress"];
	addObject.upjangCode = rsvListRowData["upjangCode"];
	addObject.saleDate = rsvListRowData["saleDate"];
	addObject.menuCode = rsvListRowData["menuCode"];*/

	//popObj.keyAddress = rowData['keyAddress'];
// 	popObj.keyNo = ;
// 	popObj.sex = ;
	f_settingPop({
		PopType : "RetrieveLockerRentListPop",
		Parameter : popObj,
// //         SearchNameText : $("#guestName").val(),
//         SearchCodeText : $("#guestNo").val(),
		CloseEvent : function() {
			$("#gr_RentItemList").setGridParam("clear");
			$("#gr_RentItemList").setGridParam({
				url : '/btm/SpaLockerSalesRegistration_Rent.do',
				postData : {											// 넘겨줄 파라미터
					upjangCode :  rsvListRowData["upjangCode"]
					,keyAddress : rsvListRowData["keyAddress"]
					,keyNo : 	  rsvListRowData["keyNo"]
					,sex :		  rsvListRowData["sex"]
				}
			});

			/*hotkeys.unbind('F2');

			hotkeys('F2', function() {
				f_Save();
				return false;
			});
*/
		}

	});

}


function f_LokerCal(){ //락카 정산
// 	var BindData = [
//         { grid : 'memName',	view : 'guestName',	type :'text'}


//     ];
	var count = $("#gr_Partner").getGridParam("reccount");
	if(count==0){
		alert('정산할락카를 선택해주세요.');
		return false;
	}
	var rowKey = $("#gr_Partner").getGrid().getFocusedCell().rowKey;
	var rowData = $("#gr_Partner").getRowData(rowKey);
	var popObj = new Object();
	popObj.upjangCode = "2308" ;
	popObj.saleDate = $("#sBookDate").val().replaceAll(",","");
	popObj.keyAddress = rowData['keyAddress'];
// 	popObj.keyNo = ;
// 	popObj.sex = ;
    f_settingPop({
        PopType : "LokerCalculatePop",
        Parameter : popObj,
// //         SearchNameText : $("#guestName").val(),
//         SearchCodeText : $("#guestNo").val(),
        CloseEvent : function() {
/*
			hotkeys.unbind('F2');

			hotkeys('F2', function() {
				f_Save();
				return false;
			});*/


			f_InitView();
			f_LokerView();
//         	f_GridLoad();
		}
    });
}

function f_LokerSearchPop(){ // 이용내역조회
/*
	if($("#keyNo").val()==''){
		alert('조회할 락카를 선택해주세요.');
		return false;
		
	}*/
	var popObj = new Object();
	popObj.keyNo = $("#keyNo").val(),
	popObj.saleDate = $("#sBookDate").val()
	  f_settingPop({
	        PopType : "LokerUsingDetailPop",
	        Parameter : popObj,
	        CloseEvent : function() {
				f_InitView();
				f_LokerView();
				/*hotkeys.unbind('F2');

				hotkeys('F2', function() {
					f_Save();
					return false;
				});*/


//	         	f_GridLoad();
			}
	    });
}

function f_GetGuestInfo(guestNo) // 이름검색시 오른쪽 아래 등록됨
{
	if(guestNo != "null" && guestNo != "" && guestNo != null) {
		console.log(guestNo);
		$.ajax({
			async: false,
			type: "post",
			url: "/crmPopup/RetrieveMemberCodeListPop_Select.do",
			data: {
				sGuestNo: guestNo
			},
			datatype: "json",
			success: function (json) {
				console.log(json)
				if (json.data.contents.length > 0) {
					var rData = json.data.contents[0];
					console.log(rData);
					$("#vGuestName").val(rData.memName);
					$("#vGuestNo").val(rData.guestNo);
					$("#vMemType").val(rData.checkMemType).trigger("change");
					$("#vGuestHpNo").val(rData.hpNo);
					$("#vGuestType").val(rData.checkGuestType).trigger("change");
					$("#vOfficeName").val(rData.officeName);
					$("#vMasterGuestName").val(rData.masterGuestName);
					$("#vOfficePosition").val(rData.officePosition).trigger("change");
					$("#prev_previewId").getGuestImage(rData.guestNo);

				}

			}
			, beforeSend: function () {
				pageBlock();
			},
			complete: function () {
				pageUnBlock();

			}
		});

		$("#gr_record").setGridParam({
			url: "/crmPopup/GuestFamilyPop_Select.do",
			postData: { // 넘겨줄 파라미터
				memberNo: $("#vMemNo").val()
			}
		});
	}



}


</script>

</head>
<body class="text-left fix-body">
    <div class="app-admin-wrap layout-sidebar-compact sidebar-dark-purple sidenav-open clearfix">
        <%@include file="/WEB-INF/include/TopMenu.jsp"%>
  	     
    <div class="row">
        <div class="col-md-12">
            <div class="card mb-12">
                <div class="card-body">

                    <div class="form-row">
                        <div class="col-md-1">
						   <label for="sBookDate" class="col-form-label">영업일자</label>
						   <input type="text" class="form-control" name = "sBookDate" id="sBookDate"  placeholder="YYYY-MM-DD"<%-- readonly="readonly" disabled="disabled"--%>/>
						</div>


                        <div class="col-md-1 search-btn">
                            <!-- 조회 버튼 -->
                            <button class="btn btn-primary" hotkey="F3" onclick="f_Retrieve();">
                                <i class="fa fa-search"></i> 검색[F3]
                            </button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    
    <div class="row main-row">
        <div class="col-md-5">
            <div class="card mb-12">
                <div class="card-body">
                    <h4 style="background-color: #d56fff;text-align: center;color: #fff;">Hot Spring</h4>
                    <div id="lockerBackDiv">
						<table id="lockerTable" style="word-wrap:break-word;word-break:break-all;table-layout:fixed;" >
						</table>
						                    
                    </div>

                </div>
            </div>
            
            <div class="card mb-12">
                <div class="card-body">
                	<div class="form-row" >
                		<div class="col-md-3">
                             <label class="col-form-label" for="manLock">온천(남)</label>
                             <input type="text" class="form-control input-Number" id="manLock" name="manLock" placeholder="0" maxlength="5" readonly="readonly"/>
                         </div>
                         
                         <div class="col-md-3">
                             <label class="col-form-label" for="womanLock">온천(여)</label>
                             <input type="text" class="form-control input-Number" id="womanLock" name="womanLock" placeholder="0" maxlength="5" readonly="readonly"/>
                         </div>
                         
                         <div class="col-md-3">
                             <label class="col-form-label" for="totalCnt">이용인원</label>
                             <input type="text" class="form-control input-Number" id="totalCnt" name="totalCnt" placeholder="0" maxlength="5" readonly="readonly"/>
                         </div>
                	</div>
                    
                </div>
            </div>
        </div>

        <div class="col-md-7">
        	 <div class="col-md-12">
		            <div class="card mb-12">
		                <div class="card-body">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <h4 style="background-color: #b95c5c;text-align: center;color: #efff00; width: 100%;">온천락카입장등록</h4>

                                    <%--								<button style="width: 113px; height: 23px"  id="rentInsertBtn" class="btn-dark" onclick="f_Companion();">동반자추가</button>--%>
                                </div>
                            </div>

		                    <input type="hidden" id="stat"name="type" value="" />
							<form id="insertForm" method="post" onsubmit="return false;"  method="post" action="/btm/SpaLockerSalesRegistration_Control.do">
							<input type="hidden" id="imgPath"name="imgPath" value="" />
							<input type="hidden" id="type"name="type" value="" />
							<input type="hidden" id="copy"name="copy" value="N" />
							<input type="hidden" id="keyAddress"name="keyAddress" value="" />
		                	<input type="hidden" id="upjangCode"name="upjangCode" value="" />
		                    <input type="hidden" id="saleDate"name="saleDate" value="" />
							
		                    <div class="form-row">
		                        <div class="col-md-1">
								   <label for="keyNo" class="col-form-label"><span class="essential_astrisk">*</span>락카번호</label>
								   <input type="text" class="form-control input-Number" name ="keyNo" id="keyNo"  placeholder="1011" maxlength="4"/>
								</div>
								
								<div class="col-md-2">
								   
								    <label for="guestName" class="col-form-label"><span class="essential_astrisk">*</span>이용자
                              	    <img class="Lbtn" id="sGuestNoImg" src="<c:url value='/css/images/icon_search.gif'/>"
                                                 alt="찾기" onclick="f_PopupsGuestName();" /></label>
								   <input type="text" class="form-control" name ="guestName" id="guestName"  placeholder="홍길동"/>
								</div>
								
								<div class="col-md-1">
								   <label for="guestNo" class="col-form-label">고객번호</label>
								   <input type="text" class="form-control" name ="guestNo" id="guestNo" readonly  placeholder="00000000" maxlength="8"/>
								</div>
		                        
		                        <div class="col-md-2">
		                        	<label for="noMemBtn" class="col-form-label"></label>
		                        	<button style="width: 163px;" id="noMemBtn" class="btn-dark" onclick="f_GuestClear()">비회원처리</button>
								</div>
								
								<div class="col-md-2">
		                            <label for="relativeType" class="col-form-label">멤버사</label>
		                            <select id="relativeType" name="relativeType" class="form-control">
		                            </select>
		                        </div>

                                <div class="col-md-2">
                                    <label for="memType" class="col-form-label">고객구분</label>
                                    <select id="memType" name="memType" class="form-control" disabled readonly="">
                                    </select>
                                </div>

                                <div class="col-md-2">
                                    <label for="roomNo" class="col-form-label">주택번호</label>
                                    <input type="text" class="form-control" id="roomNo" name="roomNo"/>
                                </div>
		                        
		                        <%--    --%>
		                    </div>
		                    
		                    <div class="form-row">
                                <div class="col-md-2">
                                    <label for="entDiv" class="col-form-label"><span class="essential_astrisk">*</span>입장객구분</label>
                                    <select id="entDiv" name="entDiv" class="form-control">
                                    </select>
                                </div>

                                <div class="col-md-1">
                                    <label for="sex" class="col-form-label" >성별</label>
                                    <select id="sex" name="sex" disabled class="form-control">
                                    </select>
                                </div>

                                <div class="col-md-1">
                                    <label for="payLockNo" class="col-form-label">지불락카</label>
                                    <input type="text" class="form-control input-Number" id="payLockNo" name="payLockNo" placeholder="1011" maxlength="4"/>
                                </div>


                                <div class="col-md-2">
                                    <label for="menuCode" class="col-form-label">온천요금</label>
                                    <select id="menuCode" name="menuCode" class="form-control">
                                    </select>
                                </div>

                                <div class="col-md-2">
                                    <label for="saleAmt" class="col-form-label">입장금액</label>
                                    <input type="text" class="form-control input-Price" id="saleAmt" name="saleAmt" readonly/>
                                </div>
                                 <%--<div class="col-md-1">
                                    <label for="enterTime" class="col-form-label">입장시간</label>
                                    <input type="text" class="form-control" id="enterTime" name="enterTime" placeholder="00:00"/>
                                </div>
                                 <div class="col-md-1">
                                    <label for="exitTime" class="col-form-label">퇴장시간</label>
                                    <input type="text" class="form-control" id="exitTime" name="exitTime" placeholder="00:00"/>
                                </div>--%>

                                <div class="col-md-1">
                                    <label for="gymYn" class="col-form-label">헬스장</label>
                                    <select id="gymYn" name="gymYn" class="form-control">
                                    </select>
                                </div>

                                <div class="col-md-1">
                                    <label for="spaYn" class="col-form-label">수영장</label>
                                    <select id="spaYn" name="spaYn" class="form-control">
                                    </select>
                                </div>



								<div class="col-md-10">
									<label for="remarks" class="col-form-label">비고</label>
									<textarea class="form-control" id="remarks" name="remarks" rows="1"></textarea>
								</div>

								<div class="col-md-2">
									<button type="button"  class="btn-success" style="width: 100%; height: 46px;" id=""  onclick="f_Save();" hotkey="F7"><!-- 저장 --><spring:message code="uh.com.Save"/>[F7]</button>
								</div>
		                    </div>
                            <%--<div class="form-row">
                                <div class="col-md-10">
                                    <label for="remarks" class="col-form-label">비고</label>
                                    <textarea class="form-control" id="remarks" name="remarks" rows="1"></textarea>
                                </div>
                            </div>--%>

		                    <%--<span class ="mt-1" style="COLOR: red; font-weight: bold;">이용자를 반드시 입력합니다.</span>--%>
		                    
		               		<%--<div class="form-btn-row">
			               		<button type="button" class="btn btn-info m-1 ui-button" onclick="f_Create();" >신규</button>
						
								<button type="button" class="btn btn-success m-1 ui-button" onclick="f_Save();" hotkey="F2">
									<!-- 저장 --><spring:message code="uh.com.Save"/>[F2]</button>
								<button type="button" class="btn btn-dark m-1 ui-button" onclick="f_LokerCal();" >락카정산</button>
								<button type="button" class="btn btn-dark m-1 ui-button" onclick="f_LokerSearchPop();" >이용내역조회</button>
								
							</div>--%>
							</form>
		                </div>
		            </div>
		        </div>
        
            <div id='subView' class="card md-12">
                <div class="card-body">
					<div class="col-md-12">
						<div class="form-row">
							<h4 style="background-color: #b95c5c;text-align: center;color: #efff00; width: 800px;">동반자 내역</h4>
		<%--								<button style="width: 113px; height: 23px"  id="rentInsertBtn" class="btn-dark" onclick="f_Companion();">동반자추가</button>--%>
							<button style="width: 113px; height: 23px;" id="rentInsertBtn" class="btn-dark" hotkey="F8"  onclick="f_Copy();">복사[F8]</button>
							<button style="width: 113px; height: 23px;" id="rentInsertBtn" class="btn-danger" onclick="f_Del();">삭제</button>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-row">
							<div class="col-md-12">
								<table id="gr_Partner"></table>
							</div>
						 </div>
					</div>
				</div>
			</div>
			<br/>
			<div class="card md-12">
				<div class="card-body">
					<div class="col-md-12">
						<div class="form-row">
<%--					<div class="col-md-12">
						<div class="form-row">
&lt;%&ndash;							<h4 style="background-color: #b95c5c;text-align: center;color: #efff00; width: 800px;">동반자 내역</h4>&ndash;%&gt;
							&lt;%&ndash;								<button style="width: 113px; height: 23px"  id="rentInsertBtn" class="btn-dark" onclick="f_Companion();">동반자추가</button>&ndash;%&gt;
							<button style="width: 113px; height: 23px;" id="rentInsertBtn" class="btn-dark" onclick="f_Copy();">복사</button>
							<button style="width: 113px; height: 23px;" id="rentInsertBtn" class="btn-dark" onclick="f_Del();">삭제</button>
						</div>
					</div>--%>
					<div class="col-md-5">
						<div class="form-row">
							<div class="col-md-12">
								<table id="gr_RentItemList"></table>

								<div class="form-row">
									<div class="col-md-4">
										<label for="rentJoinAmt" class="col-form-label">입장금액</label>
										<input type="text" class="form-control input-Number" id="rentJoinAmt" name="rentJoinAmt" placeholder="0" defaultValue="0" readonly="readonly"/>
									</div>

									<div class="col-md-4">
										<label for="rentAmt" class="col-form-label">대여금액</label>
										<input type="text" class="form-control input-Number" id="rentAmt" name="rentAmt" placeholder="0" defaultValue="0" readonly="readonly"/>
									</div>

									<div class="col-md-4">
										<label for="allRentAmt" class="col-form-label">합계금액</label>
										<input type="text" class="form-control input-Number" id="allRentAmt" name="allRentAmt" placeholder="0" defaultValue="0" readonly="readonly"/>
									</div>

									<%--<div class="col-md-2">
										<label for="rentInsertBtn" class="col-form-label"></label>
										<button style="width: 140px;" id="rentInsertBtn" class="btn-dark" onclick="">대여등록</button>
									</div>--%>
								</div>
							</div>
						</div>
					</div>

					<div class="col-md-7">
						<div class="row">
							<div class="col-md-3">
								<img id="prev_previewId" name="prev_previewId" src="/images/no_image.jpg" style="width: 140px; height: 132px;margin-left: 10px; margin-bottom: 5px;" />
							</div>

							<div class="col-md-8">
								<div class="form-row">
									<div class="col-md-4">
										<label for="bGuestName" class="col-form-label">고객성명</label>
										<input type="text" class="form-control" id="vGuestName" name="vGuestName"  readonly="readonly"/>
									</div>

									<div class="col-md-4">
										<label for="bGuestNo" class="col-form-label">고객번호</label>
										<input type="text" class="form-control" id="vGuestNo" name="vGuestNo"  readonly="readonly"/>
									</div>

									<div class="col-md-4">
										<label for="bMemType" class="col-form-label">고객구분</label>
										<select type="text" class="form-control" id="vMemType" name="vMemType"  disabled></select>
									</div>

									<%--<div class="col-md-4">
										<label for="bRoomNo" class="col-form-label">주택번호</label>
										<input type="text" class="form-control" id="bRoomNo" name="bRoomNo"  readonly="readonly"/>
									</div>--%>

									<div class="col-md-4">
										<label for="bOfficeName" class="col-form-label">직장</label>
										<input type="text" class="form-control" id="vOfficeName" name="vOfficeName"  readonly="readonly"/>
									</div>

									<div class="col-md-4">
										<label for="bHpNo" class="col-form-label">연락처</label>
										<input type="text" class="form-control" id="vGuestHpNo" name="vGuestHpNo"  readonly="readonly"/>
									</div>

									<%--<div class="col-md-4">
										<label for="bBirthDay" class="col-form-label">생년월일</label>
										<input type="text" class="form-control" id="bBirthDay" name="bBirthDay"  readonly="readonly"/>
									</div>

									<div class="col-md-4">
										<label for="bMarrDate" class="col-form-label">결혼기념일</label>
										<input type="text" class="form-control" id="bMarrDate" name="bMarrDate"  readonly="readonly"/>
									</div>
--%>
									<div class="col-md-4">
										<label for="bMainGuestName" class="col-form-label">대표고객명</label>
										<input type="text" class="form-control" id="vMasterGuestName" name="vMasterGuestName"  readonly="readonly"/>
									</div>
								</div>
							</div>
						</div>
						<table id="gr_record"></table>
					</div>

						</div>
					</div>
				</div>
			</div>

			<div class="form-btn-row">
				<button type="button" class="btn btn-info m-1 ui-button" onclick="f_Create();" >신규[동반자추가]</button>
				<button type="button" class="btn btn-info m-1 ui-button" onclick="f_RentPop();" >대여품등록</button>
				<button type="button" class="btn btn-info m-1 ui-button" onclick="f_LokerSearchPop();" >이용내역조회</button>

<%--				<button type="button" class="btn btn-success m-1 ui-button" onclick="f_Save();" hotkey="F2">
					<!-- 저장 --><spring:message code="uh.com.Save"/>[F2]</button>--%>
				<button type="button" class="btn btn-dark m-1 ui-button" onclick="f_LokerCal();" >락카정산</button>

			</div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
