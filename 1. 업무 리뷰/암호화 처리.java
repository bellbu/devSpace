암호화 

// 양방향 : SDBConvert
param.put("resNoShown", CommonUtil.SDBConvert("enc", param.get("resNoShown").toString()));

// 단방향 : SDBConvertSha256	
param.put("userPasswd", CommonUtil.SDBConvertSha256(param.get("userPasswd").toString()));
			