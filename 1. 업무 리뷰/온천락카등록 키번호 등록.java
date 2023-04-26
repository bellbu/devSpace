	@Transactional 
	public HashMap<String, Object> SpaLockerSalesRegistration_Control(HttpServletRequest request) throws Exception {
		boolean SAVE_CHECK = true;
		HashMap<String, Object> result = null; // 있어
		JSONObject jsonObj = new JSONObject();
		JSONArray grids = CommonUtil.parseGridToJArr(request) ; // 있어
		
	    String keyAddress = "";
	    
		for(int i = 0 ; i < grids.size() ; i++) {
			JSONObject data = grids.getJSONObject(i);
			HashMap<String, Object> param = CommonUtil.jsonToMap(data);
		
			if(param.containsKey("type")) {
				
				if(param.get("type").equals("add")){
					
					if(keyAddress != "") {
						param.put("keyAddress", keyAddress);
					}
					
					result = btmSpaMapper.SpaLockerSalesRegistration_Insert(param);
					
				} else if(param.get("type").equals("edit")){
					
					result = btmSpaMapper.SpaLockerSalesRegistration_Update(param);
					
				}
			}
			
			if(!result.get("O_RESULT").toString().equals("1")) {
				break;
	    	} else {
	    		keyAddress = result.get("O_KEYADDRESS").toString();
	    	}
			
		}
		
		return result;
	}



