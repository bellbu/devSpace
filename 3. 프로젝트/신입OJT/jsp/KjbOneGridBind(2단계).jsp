<%@ page language ="java"  pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="/WEB-INF/include/header.jsp"%>
<title>원그리드 바인드</title>
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

	f_setEvent();
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
 * FUNCTION 명 : 초기화 > 상단 영역(ex:검색 등)
 * FUNCTION 기능설명 :
 *******************************************************************************/
function f_InitTopView() {
	
	$("#sStDate").setCal(0,-6,0);
	$("#sEdDate").setCal(0,0,0);
	
 	$("#sUserId, #sStDate ,#sEdDate").enter('f_Retrieve');
 	$("#userBirth").setCal();
	 
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
		, height: 642
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
				, align: "left"
				, width: "140" 
			}, {
				// 비밀번호
				name: 'userPw'
				, align: "left"
				, width: "150"
				,hidden:true
			}, {
				// 주소
				name: 'userAddr1'
				, align: "left"
				, width: "240"
			},{
				// 상세주소
				name: 'userAddr2'
				, align: "left"
				, width: "200"
			}, {
				// 전화번호
				name: 'userHp'
				, align: "center"
				, width: "200"
			}, {
				// 성별
				name: 'userSex'
				, align: "center"
				, width: "100"
			},{
				// 생년월일
				name: 'userBirth'
				, align: "center"
				, width: "150"
			},{
				// 등록날짜
				name: 'insDate'
				, align: "center"
				, width: "150"
			},{
				// 수정날짜
				name: 'updDate'
				, align: "center"
				, width: "150"
			}
		], 
       		loadComplete: function (data) {
       			if(data.length>0) {
    				$("#gr_List").setSelection(last_select_row);   
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

/*******************************************************************************
 * FUNCTION 명 : 뷰 > 그리드 > 메인 그리드 선택
 * FUNCTION 기능설명 :  그리드 바인드
 *******************************************************************************/
function f_GridBind(rowid) {
		last_select_row = rowid+1;
		$("#gr_List").JSBindData([
			{ id : rowid }
			,{ grid: 'userId'       	 , view : 'userId'          , type: 'text'	}
			,{ grid: 'userPw'       	 , view : 'vUserPw'          , type: 'text'	}
			,{ grid: 'userBirth'       	 , view : 'userBirth'       , type: 'date'	}
			,{ grid: 'userSex'           , view : 'userSex'         , type: 'radio'	}
			,{ grid: 'userAddr1'       	 , view : 'userAddr1'       , type: 'text'	}
			,{ grid: 'userAddr2'       	 , view : 'userAddr2'       , type: 'text'	}
			,{ grid: 'userHp'            , view : 'userHp'        , type: 'text'	}
		]);
		 $('#type').val('edit');
		 $('#userId').prop('readonly', true); 
		 $('#userPw').prop('readonly', true); 

}
 
/*******************************************************************************
 * FUNCTION 명 : 뷰 > 폼 > 신규
 * FUNCTION 기능설명 :
 *******************************************************************************/
function f_Create() {
	 	$('#insertForm select').val("").trigger("change");
		$('#insertForm input[type="text"]').val("");
		$('#insertForm input[type="password"]').val("");
		$('#insertForm input[type="number"]').val("");
		$('input:radio[name=userSexName]:input[value="남"]').prop("checked", true);
		$("#gr_List").getGrid().removeRowClassName(getSelectedRowId("gr_List"), 'tui-selected-row');
		$('#type').val('add');
		 last_select_row=1;
		 
		 $('#userId').prop('readonly', false); 
		 $('#userPw').prop('readonly', false); 
		 
} 
  
/*******************************************************************************
 * FUNCTION 명 : 기능 > 저장
 * FUNCTION 기능설명 :
 *******************************************************************************/
function f_Save(){
	 if($('#userId').val() == '') {
			alert('아이디를 입력해주세요.');
			$('#userId').focus();
			return false;
		}
	 if($('#userPw').val() == '') {
			alert('비밀번호를 입력해주세요.');
			$('#userPw').focus();
			return false;
		}
	 if($('#userAddr1').val() == '') {
			alert('주소를 입력해주세여');
			$('#userAddr1').focus();
			return false;
		}
	 if($('#userAddr2').val() == '') {
			alert('상세주소를 입력해주세여');
			$('#userAddr2').focus();
			return false;
		}
	 if($('#userHp').val() == '') {
			alert('전화번호를 입력해주세요');
			$('#userHp').focus();
			return false;
		}
	 if($('input:radio[name=userSexName]:checked').length < 1) {
			alert('성별을 선택해주세여');
			$('#userSex').focus();
			return false;
		}
	 if($('#userBirth').val() == '') {
			alert('생년월일을 입력해주세요');
			$('#userBirth').focus();
			return false;
		}
	
	 if (!confirm('저장하시겠습니까?'))
			return false;
	 
	 var data = $("#insertForm").serialize();
	 
	 $.ajax({
			async : false,
			type  : "POST", 
			url   : "/kjb/KjbOneGridBind_Control.do",
			data  : data,
			success : function(json) {
				if(json.result == "0"){
					alert(json.msg);
				}else{
					alert("저장 완료!");
					f_Retrieve();
				}

			}
		});
	
	 
} 
 
/*******************************************************************************
 * FUNCTION 명 : f_Delete 
 * FUNCTION 기능설명 : 삭제
 *******************************************************************************/
function f_Delete(){
 var postData = '';
	
	if(!confirm("삭제하시겠습니까?")) {
		return false;
	}
	$("#type").val("del");
	
	postData = $("#insertForm").serialize();
	
	$.ajax({  
        type: "post",  
        data : postData,
        url : '/kjb/KjbOneGridBind_Control.do',  
        success: function (data) {
       	 if(data.result == 1) {
			alert('삭제 완료!');
			f_Retrieve();
   			$("#gr_List").setSelection(1);   
       	 }else 
       		alert(data.msg);
       	 }
    }); 
}
 
 

  
</script>

</head>

<body>
<div class="app-admin-wrap layout-sidebar-compact sidebar-dark-purple sidenav-open clearfix">
	<%@include file="/WEB-INF/include/TopMenu.jsp" %>

	<!-- Main Content Top -->
	<div class="breadcrumb">
		<h1></h1>
		<ul>
			<li></li>
			<li></li>
		</ul>
	</div>
	<div class="separator-breadcrumb border-top"></div>
	<!-- Main Content Top End -->

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
							<label class="col-md-2 radio radio-primary required" style="display:inline;"><input type="radio" name="sSexName" value="남"  id="sexDefault"/><span>남</span><span class="checkmark"></span></label>
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
		
		<div class="col-md-9">
			<div class="card mb-12">
				<div class="card-body">
					<h5><b>학생 정보</b></h5>
					<table id="gr_List"></table>
				</div>
			</div>
		</div>
		
		<div class="col-md-3">
			<div class="card mb-12">
				<div class="card-body" style="height: 718px;">
					<h5><b></b></h5>
					<form id="insertForm">
						<div class="form-row">
							   <input type="hidden" id="type" name="type"/>
						
							   <div class="col-md-6 mb-2">
									<label class="col-form-label" for="userId"><span class="essential_astrisk">*</span>아이디</label>
	                                <input class="form-control required" type="text" id="userId"  name="userId" placeholder="홍길동"/>
								</div>
								
							   <div class="col-md-6 mb-2">
									<label class="col-form-label" for="userPw"><span class="essential_astrisk">*</span>비밀번호</label>
									<input class="form-control" type="password" id="userPw" name="userPw"/>
								</div>
								
								<div class="col-md-6 mb-2">
									<label class="col-form-label" for="userAddr1"><span class="essential_astrisk">*</span>주소</label>
									<input class="form-control" type="text" id="userAddr1" name="userAddr1" maxlength='50'/>
								</div>
								
								<div class="col-md-6 mb-2">
									<label class="col-form-label" for="userAddr2"><span class="essential_astrisk">*</span>상세주소</label>
									<input class="form-control" type="text" id="userAddr2" name="userAddr2" maxlength='50'/>
								</div>
								
								<div class="col-md-6 mb-2">
									<label class="col-form-label" for="userHp"><span class="essential_astrisk">*</span>전화번호</label>
		                            <input class="form-control" type="text" id="userHp"  name="userHp" placeholder="010-000-0000" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="11" />
								</div>
								
					            <div class="col-md-6 mb-2">
	                                <label class="col-form-label"><span class="essential_astrisk">*</span>성별</label>
                                	<label class="col-md-4 radio radio-primary required" style="display:inline;"><input type="radio" name="userSexName" value="남" /><span>남</span><span class="checkmark radio-primary"></span></label>
                                	<label class="col-md-4 radio radio-primary required" style="display:inline;"><input type="radio" name="userSexName" value="여" /><span>여</span><span class="checkmark"></span></label>
	                            </div>
	                            
						       	<div class="col-md-6 mb-2">
	                                <label for="userBirth" class="col-form-label"><span class="essential_astrisk">*</span>생년월일</label>
	                                <input class="form-control required" type="text" id="userBirth"  name="userBirth" placeholder="YYYY-MM-DD"/>
	                            </div>
														
						</div>
					</form>
					<br>
					
					<div class="form-btn-row">
						<button class="btn btn-info ripple m-1 mb-3" onclick="f_Create();">신규</button>
						<button class="btn btn-success ripple m-1 mb-3" onclick="f_Save();">저장</button>
						 <button class="btn btn-danger ripple m-1 mb-3" onclick="f_Delete()">삭제</button>
					</div>
					
				</div>
			</div>
		</div>

	</div>
</div>
</body>
</html>