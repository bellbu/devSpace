HashMap<String, Object> param = RequestUtil.getParameter(request);
=> {checkArray=[{"chk":"Y","empName":"박준서","empNo":"0601","cdept":null,"hpNo":"01062327744","authGroupCode":"유서브","groupNo":"30","rowKey":0,"sortKey":0,"uniqueKey":"@dataKey1675755756993-0","_attributes":{"rowNum":1,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":["tui-selected-row"],"column":{"hpNo":["secretCell"]}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}},
{"chk":"Y","empName":"박준서테스트","empNo":"3132","cdept":null,"hpNo":"01062327744","authGroupCode":null,"groupNo":"30","rowKey":1,"sortKey":1,"uniqueKey":"@dataKey1675755756993-1","_attributes":{"rowNum":2,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":[],"column":{"hpNo":["secretCell"]}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}},
{"chk":"Y","empName":"김종부","empNo":"3119","cdept":null,"hpNo":"01066613076","authGroupCode":"유서브","groupNo":"30","rowKey":2,"sortKey":2,"uniqueKey":"@dataKey1675755756993-2","_attributes":{"rowNum":3,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":[],"column":{"hpNo":["secretCell"]}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}}], 
data={"type":"add","kind":"S","RsvSendTypeName":"1","rsvSendDate":"2023-02-07","rsvSendTime":"2100","title":"테스트","remarks":"테스트","template":"001","callBack":"064-793-5041"}}


String griddata = (String) param.get("data");
=> {"type":"add","kind":"S","RsvSendTypeName":"1","rsvSendDate":"2023-02-07","rsvSendTime":"2=> 100","title":"테스트","remarks":"테스트","template":"001","callBack":"064-793-5041"}


HashMap<String, Object> sendInfut = CommonUtil.jsonToMap(JSONObject.fromObject(griddata));
=> {template=001, RsvSendTypeName=1, rsvSendDate=2023-02-07, kind=S, callBack=064-793-5041, type=add, title=테스트, remarks=테스트, rsvSendTime=2100}


JSONArray memberGrid = CommonUtil.parseGridToJArr(request,"checkArray") ;
=> [{"chk":"Y","empName":"박준서","empNo":"0601","cdept":null,"hpNo":"01062327744","authGroupCode":"유서브","groupNo":"30","rowKey":0,"sortKey":0,"uniqueKey":"@dataKey1675755756993-0","_attributes":{"rowNum":1,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":["tui-selected-row"],"column":{"hpNo":["secretCell"]}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}},
{"chk":"Y","empName":"박준서테스트","empNo":"3132","cdept":null,"hpNo":"01062327744","authGroupCode":null,"groupNo":"30","rowKey":1,"sortKey":1,"uniqueKey":"@dataKey1675755756993-1","_attributes":{"rowNum":2,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":[],"column":{"hpNo":["secretCell"]}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}},
{"chk":"Y","empName":"김종부","empNo":"3119","cdept":null,"hpNo":"01066613076","authGroupCode":"유서브","groupNo":"30","rowKey":2,"sortKey":2,"uniqueKey":"@dataKey1675755756993-2","_attributes":{"rowNum":3,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":[],"column":{"hpNo":["secretCell"]}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}}]


for (int i = 0; i < memberGrid.size(); i++) {


JSONArray grids = CommonUtil.parseGridToJArr(request);
=> [{"workDate":"2023-02-08","roomNo":"104","roomType":"","roomStat":"","maidNo":"000006","maidName":"김정호","stTime":"","edTime":"","cleanStat":"02","remarks":"","type":"add","makeYn":"","mtcNo":"","upjangCode":"2101","rowKey":1,"rowSpanMap":{}}]


// addData는 array
JSONObject addData = JSONObject.fromObject(request.getParameter("addData"));
=> {"checkArray":"[{\"chk\":\"Y\",\"roomNo\":\"103\",\"roomType\":\"DKT\",\"roomStat\":\"06\",\"cleanStat\":\"02\",\"gscName\":\"김부\",\"upjangCode\":\"2101\",\"gscTelNo\":\"01012341234\",\"rowKey\":1,\"sortKey\":1,\"uniqueKey\":\"@dataKey1675819299641-1\",\"_attributes\":{\"rowNum\":2,\"checked\":false,\"disabled\":false,\"checkDisabled\":false,\"className\":{\"row\":[],\"column\":{}}},\"_disabledPriority\":{},\"rowSpanMap\":{},\"_relationListItemMap\":{}},{\"chk\":\"Y\",\"roomNo\":\"105\",\"roomType\":\"DWD\",\"roomStat\":\"02\",\"cleanStat\":\"08\",\"gscName\":\"이재근\",\"upjangCode\":\"2101\",\"gscTelNo\":\"01035760484\",\"rowKey\":3,\"sortKey\":3,\"uniqueKey\":\"@dataKey1675819299641-3\",\"_attributes\":{\"rowNum\":4,\"checked\":false,\"disabled\":false,\"checkDisabled\":false,\"className\":{\"row\":[],\"column\":{}}},\"_disabledPriority\":{},\"rowSpanMap\":{},\"_relationListItemMap\":{}},{\"chk\":\"Y\",\"roomNo\":\"107\",\"roomType\":\"DWT\",\"roomStat\":\"04\",\"cleanStat\":\"02\",\"gscName\":null,\"upjangCode\":\"2101\",\"gscTelNo\":null,\"rowKey\":5,\"sortKey\":5,\"uniqueKey\":\"@dataKey1675819299641-5\",\"_attributes\":{\"rowNum\":6,\"checked\":false,\"disabled\":false,\"checkDisabled\":false,\"className\":{\"row\":[],\"column\":{}}},\"_disabledPriority\":{},\"rowSpanMap\":{},\"_relationListItemMap\":{}},{\"chk\":\"Y\",\"roomNo\":\"109\",\"roomType\":\"DWT\",\"roomStat\":\"02\",\"cleanStat\":\"03\",\"gscName\":null,\"upjangCode\":\"2101\",\"gscTelNo\":null,\"rowKey\":7,\"sortKey\":7,\"uniqueKey\":\"@dataKey1675819299641-7\",\"_attributes\":{\"rowNum\":8,\"checked\":false,\"disabled\":false,\"checkDisabled\":false,\"className\":{\"row\":[\"tui-selected-row\"],\"column\":{}}},\"_disabledPriority\":{},\"rowSpanMap\":{},\"_relationListItemMap\":{}}]"}


JSONArray addData = CommonUtil.parseGridToJArr(request,"addData") ;
=> [{"checkArray":[{"chk":"Y","roomNo":"107","roomType":"DWT","roomStat":"04","cleanStat":"02","gscName":null,"upjangCode":"2101","gscTelNo":null,"rowKey":5,"sortKey":5,"uniqueKey":"@dataKey1675819989431-5","_attributes":{"rowNum":6,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":[],"column":{}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}},
{"chk":"Y","roomNo":"110","roomType":"DKT","roomStat":"04","cleanStat":"03","gscName":null,"upjangCode":"2101","gscTelNo":null,"rowKey":8,"sortKey":8,"uniqueKey":"@dataKey1675819989431-8","_attributes":{"rowNum":9,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":[],"column":{}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}},
{"chk":"Y","roomNo":"111","roomType":"DWT","roomStat":"01","cleanStat":"03","gscName":"하이하이","upjangCode":"2101","gscTelNo":"34242342342","rowKey":9,"sortKey":9,"uniqueKey":"@dataKey1675819989431-9","_attributes":{"rowNum":10,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":["tui-selected-row"],"column":{}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}}]}]

======================================================================================================

JSONArray maidGrid = CommonUtil.parseGridToJArr(request);
[{"workDate":"2023-02-08","roomNo":"105","roomType":"","roomStat":"","maidNo":"000020","maidName":"김동섭","stTime":"","edTime":"",
"cleanStat":"02","remarks":"","type":"add","makeYn":"","mtcNo":"","upjangCode":"2101","rowKey":0,"rowSpanMap":{}}]

[{"workDate":"2023-02-08","roomNo":"104","roomType":"DKT","roomStat":"04","maidNo":"000021","maidName":"김상태","stTime":" ","edTime":" ",
"cleanStat":"02","remarks":"","type":"edit","makeYn":"Y","mtcNo":23,"upjangCode":"2101","rowKey":1,"rowSpanMap":{}}]



JSONArray roomGrid = CommonUtil.parseGridToJArr(request,"addData");
[{"chk":"Y","roomNo":"106","roomType":"DKD","roomStat":"01","cleanStat":"03","gscName":"김종부짱짱맨맨","upjangCode":"2101","gscTelNo":"0101111111","rowKey":4,"sortKey":4,"uniqueKey":"@dataKey1675823589707-4","_attributes":{"rowNum":5,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":[],"column":{}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}},
{"chk":"Y","roomNo":"107","roomType":"DWT","roomStat":"04","cleanStat":"02","gscName":null,"upjangCode":"2101","gscTelNo":null,"rowKey":5,"sortKey":5,"uniqueKey":"@dataKey1675823589707-5","_attributes":{"rowNum":6,"checked":false,"disabled":false,"checkDisabled":false,"className":{"row":["tui-selected-row"],"column":{}}},"_disabledPriority":{},"rowSpanMap":{},"_relationListItemMap":{}}]



@Transactional
public HashMap<String, Object> RoomMakeupStatMngm_Control(HttpServletRequest request) throws Exception {
    HashMap<String, Object> result = new HashMap<String, Object>();

    JSONArray maidGrid = CommonUtil.parseGridToJArr(request);
    JSONArray roomGrid = CommonUtil.parseGridToJArr(request,"addData");

    for (int i = 0; i < maidGrid.size(); i++) {

        JSONObject maidData = maidGrid.getJSONObject(i);
        HashMap<String, Object> param = CommonUtil.jsonToMap(maidData);

        System.out.println(i + "번째 : " + param);

        if (param.containsKey("makeYn")) {

            param.put("workDate", param.get("workDate").toString().replaceAll("-", ""));
            param.put("stTime", param.get("stTime").toString().replaceAll(":", ""));
            param.put("edTime", param.get("edTime").toString().replaceAll(":", ""));

            if (param.get("makeYn").equals("Y")) {
                result = rslCheckinMapper.RoomMakeupStatMngm_Update(param);
            } else {
                  for (int j = 0; j < roomGrid.size(); j++) {
                    
                    JSONObject roomData = roomGrid.getJSONObject(i);
                    HashMap<String, Object> roomParam = CommonUtil.jsonToMap(roomData);
                    param.put("roomNo", roomParam.get("roomNo").toString());

                    result = rslCheckinMapper.RoomMakeupStatMngm_Insert(param);
                  
                  }
            }
        }

        if (!result.get("O_RESULT").toString().equals("1")) {
            break;
        }
    }
    return result;
}








