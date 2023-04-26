<script>
// 선택 그리드 하나 삭제    
function f_ListDel(){
	var rowData = $("#gr_RsList").getRowData(rsRowKey);
	console.log(rowData);
	if(!rowData||rowData['maidNo']==''){
		alert("삭제할 데이터가 없습니다.");
		return false;
	}
	$("#gr_RsList").getGrid().removeRow(rsRowKey);
	
	gridArray = $("#gr_RsList").getGrid().getData();
}

// 템플릿에서 item에서 값 제외
template : getSelectCommonCodeTemplate('CR067',true,null,'001,002,C,M,N')





</script>