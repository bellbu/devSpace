* 서비스단에서 배열 받아오는 법(배열 파라미터 다중으로 보내는 경우 ex) data : {checkArray : 배열, data : 고정데이터})
HashMap<String, Object> param = RequestUtil.getParameter(request);
{checkArray=[{"chk":"Y","empName":"박준서테스트","empNo":"3132","cdept":null,"hpNo":"01062327744","authGroupCode":null,"groupNo":"30","rowKey":1,"sortKey":1,"uniqueKey":"@dataKey1676004155815-1","_attributes":{"rowNum":2,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":[],"column":{"hpNo":["secretCell"]}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}},{"chk":"Y","empName":"김종부","empNo":"3119","cdept":null,"hpNo":"01066613076","authGroupCode":"유서브","groupNo":"30","rowKey":2,"sortKey":2,"uniqueKey":"@dataKey1676004155815-2","_attributes":{"rowNum":3,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":[],"column":{"hpNo":["secretCell"]}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}}], 
data={"type":"add","kind":"S","RsvSendTypeName":"1","rsvSendDate":"2023-02-10","rsvSendTime":"2000","title":"택배 알림","remarks":"회원님 비오토피아 프런트에서 택배 보관중입니다.","template":"001","callBack":"064-793-5041"}}

String griddata = (String) param.get("data");
{"type":"add","kind":"S","RsvSendTypeName":"1","rsvSendDate":"2023-02-10","rsvSendTime":"2000","title":"택배 알림","remarks":"회원님 비오토피아 프런트에서 택배 보관중입니다.","template":"001","callBack":"064-793-5041"}

HashMap<String, Object> sendInfut = CommonUtil.jsonToMap(JSONObject.fromObject(griddata));
{template=001, RsvSendTypeName=1, rsvSendDate=2023-02-10, kind=S, callBack=064-793-5041, type=add, title=택배 알림, remarks=회원님 비오토피아 프런트에서 택배 보관중입니다., rsvSendTime=2000}

JSONArray memberGrid = CommonUtil.parseGridToJArr(request,"checkArray") ;
[{"chk":"Y","empName":"박준서테스트","empNo":"3132","cdept":null,"hpNo":"01062327744","authGroupCode":null,"groupNo":"30","rowKey":1,"sortKey":1,"uniqueKey":"@dataKey1676004155815-1","_attributes":{"rowNum":2,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":[],"column":{"hpNo":["secretCell"]}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}},
{"chk":"Y","empName":"김종부","empNo":"3119","cdept":null,"hpNo":"01066613076","authGroupCode":"유서브","groupNo":"30","rowKey":2,"sortKey":2,"uniqueKey":"@dataKey1676004155815-2","_attributes":{"rowNum":3,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":[],"column":{"hpNo":["secretCell"]}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}}]

//고정 데이터
rsvSendParam.put("callback", sendInfut.get("callBack").toString());

//배열 데이터
memberGrid.size();
rsvSendParam.put("hpNo", memberGrid.getJSONObject(i).getString("hpNo"));


======================================================================================


* 서비스단에서 배열 받아오는 법(그리드 세이브인 경우)
// 배열(data)
JSONArray maidGrid = CommonUtil.parseGridToJArr(request);
[{"workDate":"2023-02-10","roomNo":"104","roomType":"","roomStat":"","maidNo":"000002","maidName":"홍길동","stTime":"","edTime":"","cleanStat":"02","remarks":"","type":"add","makeYn":"","mtcNo":"","upjangCode":"2101","rowKey":0,"rowSpanMap":{}},
{"workDate":"2023-02-10","roomNo":"104","roomType":"","roomStat":"","maidNo":"000020","maidName":"김동섭","stTime":"","edTime":"","cleanStat":"02","remarks":"","type":"add","makeYn":"","mtcNo":"","upjangCode":"2101","rowKey":1,"rowSpanMap":{}}]

//i=0(첫번째 배열 객체)
JSONObject maidData = maidGrid.getJSONObject(i);
{"workDate":"2023-02-10","roomNo":"104","roomType":"","roomStat":"","maidNo":"000002","maidName":"홍길동","stTime":"","edTime":"","cleanStat":"02","remarks":"","type":"add","makeYn":"","mtcNo":"","upjangCode":"2101","rowKey":0,"rowSpanMap":{}}

// 파람1(첫번째 배열 객체 해시맵)
HashMap<String, Object> param = CommonUtil.jsonToMap(maidData);
{upjangCode=2101, rowSpanMap={}, roomNo=104, roomStat=, stTime=, makeYn=, mtcNo=, type=add, edTime=, workDate=2023-02-10, maidName=홍길동, maidNo=000002, cleanStat=02, roomType=, remarks=, rowKey=0}


// 배열2(addData)
JSONArray roomGrid = CommonUtil.parseGridToJArr(request,"addData");
[{"chk":"Y","roomNo":"104","roomType":"DKT","roomStat":"04","cleanStat":"02","gscName":null,"maidName":" ","upjangCode":"2101","gscTelNo":null,"rowKey":2,"sortKey":2,"uniqueKey":"@dataKey1676003649799-2","_attributes":{"rowNum":3,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":["tui-selected-row"],"column":{}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}},
{"chk":"Y","roomNo":"105","roomType":"DWD","roomStat":"02","cleanStat":"02","gscName":"이재근","maidName":" ","upjangCode":"2101","gscTelNo":"01035760484","rowKey":3,"sortKey":3,"uniqueKey":"@dataKey1676003649799-3","_attributes":{"rowNum":4,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":[],"column":{}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}}]

// j=0(첫번째 배열 객체)
JSONObject roomData = roomGrid.getJSONObject(j);
{"chk":"Y","roomNo":"104","roomType":"DKT","roomStat":"04","cleanStat":"02","gscName":null,"maidName":" ","upjangCode":"2101","gscTelNo":null,"rowKey":2,"sortKey":2,"uniqueKey":"@dataKey1676003649799-2","_attributes":{"rowNum":3,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":["tui-selected-row"],"column":{}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}}

// 파람2 (첫번째 배열 객체 해시맵)
HashMap<String, Object> roomParam = CommonUtil.jsonToMap(roomData);
{gscTelNo=null, _disabledPriority={}, upjangCode=2101, rowSpanMap={}, roomNo=104, roomStat=04, chk=Y, uniqueKey=@dataKey1676003649799-2, _relationListItemMap={}, sortKey=2, gscName=null, maidName= , cleanStat=02, _attributes={checkDisabled=false, rowNum=3, checked=false, disabled=false, className={column={}, row=[tui-selected-row]}}, roomType=DKT, rowKey=2}

// 파람 키값 넣기
param.put("roomNo", roomParam.get("roomNo").toString());

// 인서트
result = rslCheckinMapper.RoomMakeupStatMngm_Insert(param);

* 그리드 세이브 파라미터 보내는 법
- jsp : addData : {reasonRemark : reasonRemark},
- service : JSONObject addData = JSONObject.fromObject(request.getParameter("addData"));
			param.put("reasonRemark", addData.get("reasonRemark"));

======================================================================================

* hasNext, next 함수
- Iterator: 배열이나 그와 유사한 자료구조의 내부요소를 순회하는 객체
.hasNext(): boolean 타입으로 반환("True or False"로 반환) 
.next(): iterator의 다음 요소 값 반환(타입은 요소의 타입으로 반환, 즉 Iterator에 입력된 값들이 String이면 String 값으로 반환) 


hasNext() : 읽어올 요소가 남아있는지 확인하는 메서드, 요소가 있으면 true, 없으면 false
next() : 다음 데이터를 반환
remove() : next()로 읽어온 요소를 삭제

