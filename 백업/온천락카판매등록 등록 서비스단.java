	/**
	 * 온천락카판매등록 - 라카 등록
	 * @param request
	 * @return HashMap<String, Object> result
	 * @throws Exception
	 */
	
	@Transactional 
	public HashMap<String, Object> SpaLockerSalesRegistration_Control(HttpServletRequest request) throws Exception {
		boolean SAVE_CHECK = true;
		HashMap<String, Object> result = null; // 있어
		JSONObject jsonObj = new JSONObject();
//		HashMap<String, Object> param = RequestUtil.getParameter(request);
		JSONArray grids = CommonUtil.parseGridToJArr(request) ; // 있어
			
//			if(param.containsKey("type")) {
//				if(param.get("type").equals("add")){
//					result = btmSpaMapper.SpaLockerSalesRegistration_Insert(param);
//				}else if(param.get("type").equals("edit")){
//					 result = btmSpaMapper.SpaLockerSalesRegistration_Update(param);
//				}
//				
//			}
			
		    String keyaddress = "";
		
			for(int i = 0 ; i < grids.size() ; i++) {
				JSONObject data = grids.getJSONObject(i);
				HashMap<String, Object> param = CommonUtil.jsonToMap(data);
			
				if(param.containsKey("type")) {
					if(param.get("type").equals("add")){
						if(keyaddress != "") {
							param.put("keyaddress", keyaddress);
						}
						
						result = btmSpaMapper.SpaLockerSalesRegistration_Insert(param);
					} else if(param.get("type").equals("edit")){
						result = btmSpaMapper.SpaLockerSalesRegistration_Update(param);
					}
				}
				
				if(!result.get("O_RESULT").toString().equals("1")) {
		    		break;
		    	} else {
		    		keyaddress = result.get("O_KEYSSSS").toString();
		    	}
			}
		
		return result;
	}