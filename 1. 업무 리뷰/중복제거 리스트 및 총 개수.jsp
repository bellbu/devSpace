if (list.length > 0) {
    //지역구 배열 생성 (중복제거)
    for(var i = 0; i < list.length; i++){addType.push(list[i].sigunNm);}	 
    if(addType){ addTypeList = [...new Set(addType)]; }
}