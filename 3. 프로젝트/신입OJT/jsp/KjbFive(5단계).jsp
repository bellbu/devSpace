<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<%@include file="/WEB-INF/include/header.jsp" %>
<title>5단계</title>
<script type="text/javascript">
var selrowid = 0;
/*******************************************************************************
 * FUNCTION 명 : $( document ).ready(function()
 * FUNCTION 기능설명 : 팝업 최초 실행
 *******************************************************************************/
$( document ).ready(function(){
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
/*******************************************************************************
 * FUNCTION 명 : 초기화 > 상단 영역(ex:검색 등)
 * FUNCTION 기능설명 :
 *******************************************************************************/
function f_InitTopView() {

    $("#sSchoolCode").setSelectDataSet('${cmmnObj.KJB01}','all');
    $("#schoolCode").setSelectDataSet('${cmmnObj.KJB01}','chk');
    $("#userSex").setSelectDataSet('${cmmnObj.RS005}','chk');
	$("#userBirth").setCal();  
	$("#sUserId").enter('f_Retrieve');
	
	// 문자열 유효성 체크
	$("#userId").keyup(function(){
		bytesHandler($(this),20);
	});
	$('#userId').blur(function(){
		bytesHandler($(this),20);
	});
	
	$("#userAddr1").keyup(function(){
		bytesHandler($(this),50);
	});
	$('#userAddr1').blur(function(){
		bytesHandler($(this),50);
	});
	
	$("#userAddr2").keyup(function(){
		bytesHandler($(this),50);
	});
	$('#userAddr2').blur(function(){
		bytesHandler($(this),50);
	});

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
          url: '/kjb/KjbFive_Select.do'	// url
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
            "학교코드","유저ID","주소","성별"
           ]
        , colModel:
            [
                {// 학교코드
                    name: "schoolCode",
                    align: "center",
                    width: "294",
                    template : getSelectCommonCodeTemplate('KJB01',true)
                },
                { // 유저ID
                    name: "userId",
                    align: "left",
                    width: "295", 
                },
                { // 주소
                    name: "userAddr1",
                    align: "left",
                    width: "295",
                },
                {// 성별
                    name: "userSexName",
                    align: "center",
                    width: "295",
                },
            ],
        loadComplete: function () {
        	var grid = $('#gr_List').getGrid();
        	var cnt = grid.getRowCount();
        	if(cnt >= selrowid){
				grid.focus(selrowid,'schoolCode')
        	}else{
        		grid.focus(0,'schoolCode')   
        	}
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
        	sSchoolCode : $("#sSchoolCode").val(),
            sUserId : $("#sUserId").val(),
         }
    }); 

}
/*******************************************************************************
 * FUNCTION 명 : 그리드 바인드 
 * FUNCTION 기능설명 :  
 *******************************************************************************/
function f_GridBind(rowId){
	 selrowid = rowId;
    var rowData = $("#gr_List").getRowData(rowId);
	var orgSchoolCode = rowData['schoolCode']; 
	
    f_Clean(); // 초기화
    $("#type").val("edit");
    
   $("#gr_List").JSBindData([ {
      id : rowId
   }, { grid : 'schoolCode', view : 'schoolCode', type : 'select2' }
   , { grid : 'userId', view : 'userId', type : 'text' }
   , { grid : 'userPw', view : 'userPw', type : 'text' }
   , { grid : 'userHp', view : 'userHp', type : 'text' }
   , { grid : 'userAddr1', view : 'userAddr1', type : 'text' }
   , { grid : 'userAddr2', view : 'userAddr2', type : 'text' }
   , { grid : 'userSex', view : 'userSex', type : 'select2' }  // 코드값을 가져와야 view에 나타남  
   , { grid : 'userBirth', view : 'userBirth', type : 'date' }
   ]);
	
    $("#orgSchoolCode").val(orgSchoolCode);
	$('#userId').prop('readonly', true); 

}
/*******************************************************************************
 * FUNCTION 명 : 초기화
 * FUNCTION 기능설명 : 
 *******************************************************************************/
function f_Clean(){
	$('#insertForm input[type="text"]').val("");
	$('#insertForm input[type="password"]').val("");
	$('#insertForm input[type="hidden"]').val("");
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
	
	$('#userId').prop('readonly', false); 	//  input 타입 : readonly

}
/*******************************************************************************
 * FUNCTION 명 :
 * FUNCTION 기능설명 : 엑셀
 *******************************************************************************/
function f_Excel() {
    $("#gr_List").toExcel('학생정보');
}

/*******************************************************************************
 * FUNCTION 명 :
 * FUNCTION 기능설명 : 금액 저장 수정
 *******************************************************************************/
function f_Save() {
	
// 	var regExp = /\s/g; // 공백 정규식 체크 
	if($("#schoolCode").val()==""||$("#schoolCode").val()==null){ // 유효성 검사 시 select 타입은 null 처리??
		alert("학교코드는 필수 선택 항목입니다.")
		$("#schoolCode").focus();
		return;
	}
	if($("#userId").val().trim() == ""){  // .trim() 사용 
		alert("유저ID는 필수 입력 항목입니다.")
		$("#userId").focus();
		return;
	}
	if($("#userPw").val()==""){ 
		alert("비밀번호는 필수 입력 항목입니다.")
		$("#userPw").focus();
		return;
	}
	if($("#userHp").val()==""){  
		alert("휴대번호는 필수 입력 항목입니다.")
		$("#userHp").focus();
		return;
	}
	if($("#userHp").val().length != 11){  
		alert("휴대번호를 정확히 입력해주세요.")
		$("#userHp").focus();
		return;
	}
	if($("#userSex").val()==""||$("#userSex").val()==null){
		alert("성별은 필수 선택 항목입니다.")
		$("#userSexName").focus();
		return;
	}

	if(confirm('저장 하시겠습니까?')==true){
		$.ajax({
			async : false,
			type : "post",
			url : "/kjb/KjbFive_Control.do",
			data : $("#insertForm").serialize(),
			success : function(json) {
				if(json.result == "1"){
					alert("저장완료!");
					f_Retrieve();
				}else if(json.result == "0"){
					alert(json.msg)
				}
			}
		});
	}
}
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
	if(totalByte>maxlen){
		alert("허용된 문자열의 최대값을 초과했습니다.");  // match를 이용해서 영어로된 name을 한글로 변환해서 출력한다.
		objstr2 = obj.val().substr(0, strlen);
		 obj.val(objstr2);
	}
	
} 

// /*******************************************************************************
// * FUNCTION 명 : 공백 사용 금지
// * FUNCTION 기능설명 : 
// *******************************************************************************/
// function noSpaceForm(obj){             
//     var str_space = /\s/g;               // 공백 체크
//     if(str_space.exec(obj.value)){     // 공백 체크
//         alert("해당 항목에는 공백을 사용할 수 없습니다.\n공백 제거됩니다.");
//         obj.focus();
//         obj.value = obj.value.replace(' ',''); // 공백제거
//         return false;
//     }
// }


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
                            <label for="sSchoolCode" class="col-form-label">학교코드</label>
                            <select id="sSchoolCode" name="sSchoolCode" class="form-control">
                            </select>
                        </div>
     
                        <div class="col-md-1">
                            <label for="sUserId" class="col-form-label">유저ID</label>
                            <input type="text" class="form-control " id="sUserId" name="sUserId"/>
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
                    <h6><b>학생 정보</b></h6>
                    <table  id="gr_List"></table>
                </div>

            </div>
        </div>

        <div class="col-md-4">
            <div class="card mb-12">
                <div class="card-body" style="height: 681px;">
                    <h6><b>학생 상세내역</b></h6>

                    <form id="insertForm">
                        <div class="form-row" >
                            <div class="col-md-12 mb-2">
                                <div class="form-row">
                                	<input type="hidden" id="type" name="type"/>
                                	<input type="hidden" id="orgSchoolCode" name="orgSchoolCode"/>    

                                    <div class="col-md-6 mb-2">
                                        <label class="col-form-label" for="schoolCode"><span class="essential_astrisk">*</span>학교코드</label>
                                        <select class="form-control required " id="schoolCode" name="schoolCode">
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-6 mb-2">
                                        <label class="col-form-label" for="userId"><span class="essential_astrisk">*</span>유저ID</label>
                                        <input type="text" class="form-control required" id="userId" name="userId" placeholder="홍길동" />
                                    </div>
                                    
                                    <div class="col-md-6 mb-2">
                                        <label class="col-form-label" for="userPw"><span class="essential_astrisk">*</span>비밀번호</label>
                                        <input type="password" class="form-control required" id="userPw" name="userPw" />
                                    </div>
                                    
                                    <div class="col-md-6 mb-2">
                                        <label class="col-form-label" for="userHp"><span class="essential_astrisk">*</span>휴대번호</label>
                                        <input type="text" class="form-control required" id="userHp" name="userHp" placeholder="'-'빼고 숫자만 입력" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="11" />
                                    </div>
                                    
                                    <div class="col-md-12 mb-2">
                                        <label class="col-form-label" for="userAddr1">주소</label>
                                        <input type="text" class="form-control required" id="userAddr1" name="userAddr1" />
                                    </div>
                                    
                                    <div class="col-md-12 mb-2">
                                        <label class="col-form-label" for="userAddr2">상세주소</label>
                                        <input type="text" class="form-control required" id="userAddr2" name="userAddr2" />
                                    </div>
                                    
                               		<div class="col-md-6 mb-2">
                                        <label class="col-form-label" for="userSex"><span class="essential_astrisk">*</span>성별</label>
                                        <select class="form-control required " id="userSex" name="userSex">
                                        </select>
                                    </div>
                                    
   		                            <div class="col-md-6 mb-2">
		                                <label for="userBirth" class="col-form-label">생년월일</label>
		                                <input class="form-control required" type="text" id="userBirth"  name="userBirth" placeholder="YYYY-MM-DD"/>
		       						</div>
		       
                                 </div>
                              </div>
                        </div>
                    </form>
                    <div class="form-btn-row">
                        <button class="btn btn-info ripple m-1" onclick="f_Excel()"><!-- Excel --><spring:message code="uh.com.Excel"/></button>
                    	<button class="btn btn-primary ripple m-1"  onclick="f_Create()"><!-- 신규 --><spring:message code="uh.com.New"/></button>
                        <button class="btn btn-success ripple m-1"  onclick="f_Save()"><!-- 저장 --><spring:message code="uh.com.Save"/></button>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
