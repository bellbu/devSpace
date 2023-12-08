※ rowKey
 - .setSelection(), .getRowCount()는 1로 시작
 - 나머진 0으로 시작

※ .getGrid()없이 사용가능 함수
 - .setSelection()
 - .getRowData()


1. 그리드 전체 속성 가져오기 
$('#그리드아이디값').getGrid()
 
 1) 속성 선택
  $('#그리드아이디값').getGrid().dataProvider


2. 그리드의 모든행의 데이터 가져오기 
$('#그리드아이디값').getGrid().getData()   



3-1. 하나의 행(rowkey)의 데이터(전체컬럼) 가져오기1
$("#그리드아이디값").getRowData(rowKey);  // rowKey(인덱스 번호 0으로 시작)

 1) 데이터 접근
  ex) $("#그리드아이디값").getRowData(rowKey).upjangCode

 2) 활용 
  function f_GridBind(rowid) {
 	  var rowData = $("#gr_UserList").getRowData(rowid);
	  var sUserId = rowData['userId']; 
  }


3-2. 하나의 행(rowkey)의 데이터(전체컬럼) 가져오기2 // 선택된 그리드 로우키로 데이터를 가져옴 
$("#gr_List").getRowData(getSelectedRowId("gr_List")); // getSelectedRowId("gr_List") 함수는 선택된 그리드의 rowKey 생성


4. 선택된 셀의 값 가져오기
$("#그리드아이디값").getGrid().getFocusedCell() // rowKey, 컬럼이름, 컬럼값 가져옴


5. 그리드 전체의 해당칼럼 값 가져오기
var grid = $('#그리드아이디값').getGrid();
grid.getColumnValues("컬럼명");


6. rowId(0으로 시작)의 해당 칼럼 값 가져오기
var grid = $('#그리드아이디값').getGrid();
grid.getValue(rowId,'컬럼명')


7. rowId(0으로 시작)의 해당 칼럼 값 넣기
var grid = $('#그리드아이디값').getGrid();
grid.setValue(rowId,'컬럼명', '넣을 값');


8. 그리드 행의 갯수 구하기(1부터 시작)
$('#그리드아이디값').getGrid().getRowCount();


// 그리드 포커스 
$('#그리드아이디값').getGrid().focus(rowKey,'컬럼명(생략가능)') // rowKey 0부터 시작
$("#그리드아이디값").setSelection(rowKey) // rowKey 1부터 시작

// 로그인 정보 가져오기
console.log("${loginVO}")

//JSON 데이터 가져오기
console.log(JSON.stringify(ReqDlvy));

9. 등록/수정/삭제 시 setSelection() 기본 설정
  1) 초기 전역변수 0으로 설정: var last_select_row = 0;

  2) 그리드 loadComplete 설정
    if($("#gr_List").getGrid().getRowCount() > last_select_row){ // 추가시: 생성로우 / 업데이트,삭제시: 제자리(setSelection은 첫줄이 1로 시작)
      $("#gr_List").setSelection(last_select_row+1); 
    }else{ // 마지막 로우 삭제 시: 첫줄 셀렉트
      if($("#gr_List").getGrid().getRowCount() != 0){   
        $("#gr_List").setSelection(1);
      }
    }

  3) 바인드 설정 
    function f_GridBind(rowid) {
        last_select_row = rowid;
    }

  4)f_Create() 설정: last_select_row = $("#gr_List").getGrid().getRowCount();



10. 신규 로우 
	 	var createRow = $("#gr_List").getRowData(rowid)._attributes.className.column._number
	 	console.log("createRow",createRow);
	 	if(createRow){
	 		$("#gr_List").setSelection(rowid)
	 		alert('변경된 내용이 있습니다.');
	 		return false;
	 	}

11. 페이지 이동
$("#gr_List").getGrid().getPagination().movePageTo(targetRowsPageNum);


$("#gr_List").movePageTo($("#gr_List").getGrid().getPagination()._currentPage);

12. 선택된 데이터 값 가져오기
$("#gr_List").getGridParam("selrow");