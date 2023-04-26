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


