<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<%@include file="/WEB-INF/include/header.jsp" %>
<style>

.tui-grid-cell.fffeea{background-color: #fffeea !important;}
.tui-grid-cell.ffeaea{background-color: #ffeaea !important;}

</style>
<title>입,퇴실관리</title>
<script type="text/javascript">
var selrowid = 0;
/*******************************************************************************
 * FUNCTION 명 : $( document ).ready(function()
 * FUNCTION 기능설명 : 팝업 최초 실행
 *******************************************************************************/
$( document ).ready(function(){
    f_InitView();
    
	 // 선택시 검색
	$("#sUpjangCode, #sCcoStatus").change(function(){ 
    	f_Retrieve();
	});
	 
	 // 숙박일수 자동계산
	$("#cciDate, #ccoDate").change(function(){
		f_StayinDayCnt()
	}); 
	 
	// 객실번호 글자 변경시 빈값 처리
	$("#roomNo").keyup(function (key) {
	     if(key.keyCode != 13 || $('#'+id).val() == ""){
	         if(key.keyCode != 114){
	            $('#roomNo').val('');
	            $('#roomType').val('').trigger("change");
	          }
	      }
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
/*******************************************************************************
 * FUNCTION 명 : 초기화 > 상단 영역(ex:검색 등)
 * FUNCTION 기능설명 :
 *******************************************************************************/
function f_InitTopView() {

    $("#sUpjangCode").setSelectDataSetItem('${cmmnObj.RS002}','chk','2301'); //비오토피아(2301) 셀렉트에서 제거됨 
    $("#sUpjangCode").val("2101").trigger("change");
    
	$("#sStDate").setCal();
	$("#sEdDate").setCal(0,2,0); 
	calFromTo("sStDate","sEdDate");
	$("#sCcoStatus").setSelectDataSetItem('${cmmnObj.RB009}','chk','H');
	
    $("#roomType").setSelectDataSet('${cmmnObj.RB003}','chk');
	$("#cciDate").setCal();
	$("#ccoDate").setCal();
	calFromTo("cciDate","ccoDate");
    $("#reservNo, #reservSeq, #stayinDayCnt").attr('readonly',true);
    $("#roomType, #cciDate").attr('disabled',true);
    
	$("#sUpjangCode, #sStDate, #sEdDate, #gscName, #roomNo, #sCcoStatus").enter('f_Retrieve');
	
}

function f_setEvent() {
    $("#gr_List").createGridEvent(
          ''   
          ,{   
             onClickEvent:'f_GridBind'
          } 
          ,''  
	);
}
/*******************************************************************************
 * FUNCTION 명 :
 * FUNCTION 기능설명 : 초기화 > 중간 영역(ex:Grid 등)
 *******************************************************************************/
function f_InitMiddleView() {
    $("#gr_List").tuiGrid({
          url: '/kjb/KjbSeven_Select.do'	// url
        , mtype: 'POST'
        , datatype: "json"
        , loadtext: '로딩중..'
        , rowNum: -1
        , gridview: true
        , cmTemplate: {sortable: false}
        , scrollOffset: 0
        , rownumbers: false
        , shrinkToFit: false
        , forceFit: true
        , autowidth: true
        , height: 610
        , colNames:[
            "예약번호","순번","투숙객명","입실일자","퇴실일자","재실상태","객실타입","객실번호","실제퇴실일자"
           ]
        , colModel:
            [
                {//예약번호
                    name: "reservNo",
                    align: "center",
                    width: "auto",
                },{ //순번
                    name: "reservSeq",
                    align: "right",
                    width: "auto", 
                },{ //투숙객명
                    name: "gscName",
                    align: "left",
                    width: "auto",
                },{//입실일자
                    name: "cciDate",
                    align: "center",
                    width: "auto",
                    template : getDatePickerTemplate(true)
                },{//퇴실일자
                    name: "ccoDate",
                    align: "center",
                    width: "auto",
                    template : getDatePickerTemplate(true)
                },{ //재실상태
                    name: "ccoStatus",
                    align: "center",
                    width: "auto",
                    template : getSelectCommonCodeTemplate('RB009',true)
                },{ //객실타입
                    name: "roomType",
                    align: "left",
                    width: "auto",
                    template : getSelectCommonCodeTemplate('RB003',true)
                },{//객실번호
                    name: "roomNo",
                    align: "center",
                    width: "auto",
                },{//실제퇴실일자
                    name: "checkoutYmd",
                    align: "center",
                    width: "auto",
                    template : getDatePickerTemplate(true)
                }
            ],
        loadComplete: function () {
        	var grid = $('#gr_List').getGrid();
        	var cnt = grid.getRowCount();
        	if(cnt >= selrowid){
				grid.focus(selrowid,'reservNo')
        	}else{
        		grid.focus(0,'reservNo')   
        	}
        	
			var ids = $("#gr_List").getGrid().getData();
			$.each(ids,function(rowId, rowData){

				if(rowData.ccoStatus == "N") {
					$("#gr_List").getGrid().addRowClassName(rowId, "fffeea");
				}

				if(rowData.ccoStatus == "Y") {
					$("#gr_List").getGrid().addRowClassName(rowId, "ffeaea");
				}

			});
        }
    });

    f_Retrieve();

}
/*******************************************************************************
 * FUNCTION 명 :
 * FUNCTION 기능설명 : 조회
 *******************************************************************************/
function f_Retrieve() {
	 f_Clean();
    $("#gr_List").clearGridData();
    $("#gr_List").setGridParam({
        datatype: 'json'
        ,postData : {
        	sUpjangCode : $("#sUpjangCode").val(),
        	sStDate : $("#sStDate").val(),
        	sEdDate : $("#sEdDate").val(),
        	sGscName : $("#sGscName").val(),
        	sRoomNo : $("#sRoomNo").val(),
        	sCcoStatus : $("#sCcoStatus").val(),
         }
    }); 
    
    $("#upjangCode").val($("#sUpjangCode").val());

}
/*******************************************************************************
 * FUNCTION 명 : 그리드 바인드 
 * FUNCTION 기능설명 :  
 *******************************************************************************/
function f_GridBind(rowId){
	selrowid = rowId;
    var rowData = $("#gr_List").getRowData(rowId);
// 	var upjangCode = rowData['upjangCode']; 
	var cciDate = rowData['cciDate']; 
	var ccoDate = rowData['ccoDate'];
	var ccoStatus = rowData['ccoStatus'];
	
    f_Clean(); // 초기화
    $("#type").val("edit");
    
   $("#gr_List").JSBindData([ {
      id : rowId
   }, { grid : 'reservNo', view : 'reservNo', type : 'text' }
   , { grid : 'reservSeq', view : 'reservSeq', type : 'text' }
   , { grid : 'gscName', view : 'gscName', type : 'text' }
   , { grid : 'gscTelNo', view : 'gscTelNo', type : 'text' }
   , { grid : 'roomType', view : 'roomType', type : 'select2' }
   , { grid : 'roomNo', view : 'roomNo', type : 'text' }
   , { grid : 'cciDate', view : 'cciDate', type : 'date' }  
   , { grid : 'stayinDayCnt', view : 'stayinDayCnt', type : 'text' }  
   , { grid : 'ccoDate', view : 'ccoDate', type : 'date' }  
   , { grid : 'ccoStatus', view : 'ccoStatus', type : 'text' }
   ]);
	
   $("#orgCciDate").val(cciDate);
   $("#orgCcoDate").val(ccoDate);
   
   if(ccoStatus == 'Y') {
	   $("#gscName, #gscTelNo, #roomNo").attr('readonly',true);
	   $(".Lbtn").attr("onclick",  null);
	   $("#roomType, #cciDate, #ccoDate").attr('disabled',true);
   } else {
	   $("#gscName, #gscTelNo, #roomNo").attr('readonly',false);
	   $(".Lbtn").attr("onclick", 'f_RoomNoPopup()');
	   $("#cciDate").attr('disabled',true);
	   $("#ccoDate").attr('disabled',false);
   }
  
}
/*******************************************************************************
 * FUNCTION 명 : 초기화
 * FUNCTION 기능설명 : 
 *******************************************************************************/
function f_Clean(){
	$('#insertForm input[type="text"]').val("");
	$('#insertForm select').val("").trigger("change");
}
/*******************************************************************************
 * FUNCTION 명 :
 * FUNCTION 기능설명 : 신규
 *******************************************************************************/
function f_Create(){
	$("#gr_List").getGrid().removeRowClassName(getSelectedRowId("gr_List"), 'tui-selected-row'); // 선택 그리드 지우기 
	f_Clean();
	$("#type").val("add");
    $("#cciDate, #ccoDate").attr('disabled',false);
    $("#gscName, #gscTelNo, #roomNo").attr('readonly',false);
    $(".Lbtn").attr("onclick", 'f_RoomNoPopup()');
}

/*******************************************************************************
 * FUNCTION 명 :
 * FUNCTION 기능설명 : 금액 저장 수정
 *******************************************************************************/
function f_Save() {
	
	if($("#gscName").val().trim() == ""){ 
		alert("투숙객명은 필수 입력 항목입니다.")
		$("#gscName").focus();
		return;
	}
	if($("#gscTelNo").val()==""){  
		alert("휴대번호는 필수 입력 항목입니다.")
		$("#gscTelNo").focus();
		return;
	}
	if($("#gscTelNo").val().length != 11){  
		alert("휴대번호를 정확히 입력해주세요.")
		$("#gscTelNo").focus();
		return;
	}
	if($("#roomType").val()==""||$("#roomType").val()==null){
		alert("객실타입은 필수 선택 항목입니다.")
		$("#roomType").focus();
		return;
	}
	if($("#roomNo").val()==""){  
		alert("객실번호는 필수 입력 항목입니다.")
		$("#roomNo").focus();
		return;
	}
	if($("#cciDate").val()=="" || $("#stayinDayCnt").val()=="" || $("#ccoDate").val()==""){  
		alert("투숙기간은 필수 입력 항목입니다.")
		$("#cciDate").focus();
		return;
	}
	
	if($("#cciDate").val() == $("#ccoDate").val()) {
		alert("입실일과 퇴실일은 동일한 날짜를 선택할 수 없습니다.");
		$("#ccoDate").focus();
		return;
	}
	
	if($("#ccoStatus").val() == 'Y') {
		alert("퇴실처리 된 객실은 수정할 수 없습니다.");
		return;
	} 
	
	
	// 이전날짜 선택시 예외처리
	if($("#type").val() == 'add') {
		var today = getToday();
		
		if($("#cciDate").val().replace(/-/g,'') < today) {
			alert("오늘 이전 날짜를 선택할 수 없습니다.");
			$("#cciDate").focus();
			return;
		}
		
		if($("#ccoDate").val().replace(/-/g,'') < today) {
			alert("오늘 이전 날짜를 선택할 수 없습니다.");
			$("#ccoDate").focus();
			return;
		}
	}
	
    $("#roomType, #cciDate").attr('disabled',false);

	if(confirm('저장 하시겠습니까?')==true){
		$.ajax({
			async : false,
			type : "post",
			url : "/kjb/KjbSeven_Control.do",
			data : $("#insertForm").serialize(),
			success : function(json) {
				if(json.result == "1"){
					alert("저장완료!");
					f_Retrieve();
					$("#roomType, #cciDate").attr('disabled',true);
				}else if(json.result == "0"){
					alert(json.msg)
					$("#roomType").attr('disabled',true);
				}
			}
		});
	}
	
}

/*******************************************************************************
 * FUNCTION 명 : CheckOut
 * FUNCTION 기능설명 : 체크아웃 처리
 * Param   :
 *******************************************************************************/
function f_CheckOut() {
	var rowData = $("#gr_List").getRowData(getSelectedRowId("gr_List"));	//getSelectedRowId("gr_List") : 선택 된 셀의 그리드 rowkey를 가져오는 함수
    var ccoStatus = rowData['ccoStatus'];
    
    if(ccoStatus == "Y") {
        alert("이미 퇴실처리 된 객실입니다..");
        return;
    }
    
   	if(confirm('체크아웃 하시겠습니까?') != true) {
   		return false;
   	}
   
   	$("#type").val('checkOut');
    	
	$.ajax({
		async : false,
		type : "post",
		url : "/kjb/KjbSeven_Control.do",
		data : $("#insertForm").serialize(),
		success : function(json) {
			if(json.result == "1"){
				alert("체크아웃이 완료 되었습니다.");
				f_Retrieve();
			}else if(json.result == "0"){
				alert(json.msg)
			}
		}
	});

}


/*******************************************************************************
* FUNCTION 명 : 객실 팝업
* FUNCTION 기능설명 : 
*******************************************************************************/
function f_RoomNoPopup(){

	var BindData = "";

	BindData = [
		{ grid : 'roomNo',					view : 'roomNo',         				type :'text'},
		{ grid : 'roomType',				view : 'roomType',         				type :'select2'},
	];

	f_settingPop({
 		SearchPopupTitle : "재실가능 객실검색(김종부)",
		PopType : "KjbRetrieveRoomListPop",
		SearchText : $("#roomNo").val(),
		SearchNameText	: $("#roomType").val(),
		SearchCodeText	: $("#sUpjangCode").val(),
		BindData : BindData,
		CloseEvent : function () {
			var rData = PopupReturnData;
			PopupReturnData = "";
		}
	});

}
/*******************************************************************************
* FUNCTION 명 : 숙박일수 자동 계산
* FUNCTION 기능설명 : 
*******************************************************************************/
function f_StayinDayCnt(){
	var cciDate = new Date($("#cciDate").val());
	var ccoDate = new Date($("#ccoDate").val());
	
	const diffDate = ccoDate.getTime() - cciDate.getTime();
	
	var stayinDayCnt = diffDate / (1000 * 60 * 60 * 24); // 밀리세컨 * 초 * 분 * 시 = 일
	
	if(isNaN(stayinDayCnt)){
		$("#stayinDayCnt").val(0);
    }
    else{
    	$("#stayinDayCnt").val(stayinDayCnt)
    }
	
}

/*******************************************************************************
* FUNCTION 명 : 오늘 날짜 가져오기(시간제외)
* FUNCTION 기능설명 : 
*******************************************************************************/
function getToday(){
	var date = new Date();
    
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);
    
    return year+month+day; 
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
                            <label for="sUpjangCode" class="col-form-label"><span class="essential_astrisk">*</span>객실구분</label>
                            <select id="sUpjangCode" name="sUpjangCode" class="form-control">
                            </select>
                        </div>
                        
                        <!-- 조회기간 -->
						<div class="col-md-2">
							<label for="sStDate" class="col-form-label">입실일자</label>
							<input class="form-control required" type="text" id="sStDate" name="sStDate" placeholder="YYYY-MM-DD"/>
							<div class="day-mid">~</div>
							<input class="form-control required" type="text" id="sEdDate" name="sEdDate" placeholder="YYYY-MM-DD"/>
						</div>
     
                        <div class="col-md-1">
                            <label for="sGscName" class="col-form-label">투숙객명</label>
                            <input type="text" class="form-control " id="sGscName" name="sGscName"/>
                        </div>
                        
                        <div class="col-md-1">
                            <label for="sRoomNo" class="col-form-label">객실번호</label>
                            <input type="text" class="form-control " id="sRoomNo" name="sRoomNo"/>
                        </div>
                        
                        <div class="col-md-1">
                            <label for="sCcoStatus" class="col-form-label">재실상태</label>
                            <select id="sCcoStatus" name="sCcoStatus" class="form-control">
                            </select>
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

        <div class="col-md-8">
            <div class="card mb-12">
                <div class="card-body">
	                
	                <div class="form-row">
	                	
	                	<div class="col-md-6">
	                    	<h6><b>조회내역</b></h6>
	                    </div>
		                
		                <div class="col-md-6">
							<table style="float: right;position: relative;">
								<tr>
									<td style="padding: 0px 5px;"><div style="display:inline; background-color: #fffeea; border: 1px solid; padding: 1px 10px;"></div><span style="font-weight: bold; color: #454545; padding-left: 1px;">재실</span></td>
									<td style="padding: 0px 5px;"><div style="display:inline; background-color: #ffeaea; border: 1px solid; padding: 1px 10px;"></div><span style="font-weight: bold; color: #454545; padding-left: 1px;">퇴실</span></td>
								</tr>
							</table>
						</div>
						
					</div>	
                    
                    <table  id="gr_List"></table>
                
                </div>
                

            </div>
        </div>

        <div class="col-md-4">
            <div class="card mb-12">
                <div class="card-body" style="height: 681px;">
                    <h6><b>상세내역</b></h6>

                    <form id="insertForm">
                        <div class="form-row" >
                            <div class="col-md-12 mb-2">
                                <div class="form-row">
                                	<input type="hidden" id="type" name="type"/>
                                	<input type="hidden" id="upjangCode" name="upjangCode"/>    
                                	<input type="hidden" id="orgCciDate" name="orgCciDate"/>    
                                	<input type="hidden" id="orgCcoDate" name="orgCcoDate"/>    
                                	<input type="hidden" id="ccoStatus" name="ccoStatus"/>    

                                    <div class="col-md-3 mb-2">
                                        <label class="col-form-label" for="reservNo"><span class="essential_astrisk">*</span>예약번호</label>
                                        <input type="text" class="form-control required" id="reservNo" name="reservNo" />
                                    </div>
                                    
                                    <div class="col-md-3 mb-2">
                                        <label class="col-form-label" for="reservSeq">순번</label>
                                        <input type="text" class="form-control required" id="reservSeq" name="reservSeq" />
                                    </div>
                                    
                                	<div class="col-md-3 mb-2">
                                        <label class="col-form-label" for="gscName"><span class="essential_astrisk">*</span>투숙객명</label>
                                        <input type="text" class="form-control required" id="gscName" name="gscName" placeholder="홍길동"/>
                                    
                                    </div>
                                    
                                    <div class="col-md-3 mb-2">
                                        <label class="col-form-label" for="gscTelNo"><span class="essential_astrisk">*</span>투숙객연락처</label>
                                        <input type="text" class="form-control required" id="gscTelNo" name="gscTelNo" placeholder="'-'빼고 숫자만 입력" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="11"/>
                                    </div>
                                    
                                    <div class="col-md-3 mb-2">
										<label class="col-form-label" for="roomType"><span class="essential_astrisk">*</span>객실타입</label>
										<select class="form-control required" id="roomType" name="roomType"></select>
									</div>

									<div class="col-md-3 mb-2">
										<label class="col-form-label" for="roomNo"><span class="essential_astrisk">*</span>객실번호
											<img class="Lbtn" src="<c:url value='/css/images/icon_search.gif'/>"alt="찾기" onclick="f_RoomNoPopup();" />
										</label>
										<input type="text" class="form-control required" id="roomNo" name="roomNo" />
									</div>
									
                                    <div class="col-md-6 mb-2"></div>
                                    
                                    <div class="col-md-8 mb-2">
										<label class="col-form-label" for="cciDate"><span class="essential_astrisk">*</span>투숙기간</label>
										<div class="form-row"> 
										   <div class="col-md-4 mb-2">
										      <input type="text" class="form-control required" id="cciDate" name="cciDate" placeholder="YYYY-MM-DD"/>
										   </div>
										   <div class="col-md-4 mb-2">
										      <input type="text" class="form-control required" id="ccoDate" name="ccoDate" placeholder="YYYY-MM-DD"/>
										   </div>
										   <div class="col-md-2 mb-2">
										      <input type="text" class="form-control input-Number required" id="stayinDayCnt" name="stayinDayCnt"/>
										   </div><span class="col-md-1 mb-2">박</span>
										</div>
									</div>
									
                                 </div>
                              </div>
                        </div>
                    </form>
                    <div class="form-btn-row">
                    	<button class="btn btn-primary ripple m-1"  onclick="f_Create()"><!-- 신규 --><spring:message code="uh.com.New"/></button>
                        <button class="btn btn-success ripple m-1"  onclick="f_Save()"><!-- 저장 --><spring:message code="uh.com.Save"/></button>
                        <button class="btn btn-danger ripple m-1" onclick="f_CheckOut()">체크아웃</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
