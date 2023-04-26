	@Transactional(value = "newTransactionManager")  
	public HashMap<String, Object> RoomReg_Control(MultipartHttpServletRequest request )throws Exception {
		LoginVO loginVO = (LoginVO) request.getSession().getAttribute("loginVO");
		String imagePath = "HouseRepair/" + loginVO.getCorpCode() + "/";
		HashMap<String, Object> param = RequestUtil.getParameter(request);
		boolean SAVE_CHECK = true;
		HashMap<String, Object> resultJSON = new HashMap<String, Object>();
		HashMap<String, Object> result = new HashMap<String, Object>();
		HashMap<String, Object> result2 = new HashMap<String, Object>();
		if(SAVE_CHECK) {
			if(param.containsKey("type")) {
				if(param.get("type").equals("add")){
					result = tabletRoomMapper.RoomReg_Insert(param);
					if(result.get("O_RESULT").equals("0")){
						return result;
					}
				}
			}
			
			if(result.get("O_RESULT").equals("1")) {
				String imgAdd = param.get("imgAdd").toString();

				if (param.get("type").equals("add")) {
					param.put("acceptNo", result.get("O_NO").toString()); 
				}

						try {
							String folderName ="HouseRepair/" + loginVO.getCorpCode();
							Iterator<String> files = request.getFileNames();

						if(imgAdd.equals("Y")) {
							while(files.hasNext()) {
							
							String uploadFile = files.next();
							String fileName = CommonUtil.makeRandomFilename();
		
					   		 List<MultipartFile> uploadFiles1 = request.getFiles(uploadFile);
							 MultipartFile uploadFile1 = uploadFiles1.get(0);
							
							 //base64 업로드
							 BufferedImage Image =  Resize(uploadFile1.getInputStream(), 180, 216);
							 ByteArrayOutputStream baos = new ByteArrayOutputStream();
							 String extension = FilenameUtils.getExtension(uploadFile1.getOriginalFilename()); // 확장자
							 ImageIO.write(Image, extension, baos);
						
							 StringBuilder sb = new StringBuilder();  // 이미지를 문자열로
							 Encoder encoder = Base64.getEncoder();
							 byte[] encodedBytes = encoder.encode(baos.toByteArray());
						 					sb.append(new String(encodedBytes));	
							 					
		 					 param.put("picture", sb.toString());	
							 
							 //ftp 업로드
							 resultJSON = sysCommonService.ftpFileUpload(uploadFile1,param,folderName,fileName);
							 param.put("newUploadFile", resultJSON.get("savePath").toString() + resultJSON.get("fileSaveName").toString());
							 param.put("orgFileName", resultJSON.get("fileSaveName").toString());
							 
							 result = tabletRoomMapper.RoomReg_Img_Insert(param);
							}
						}
							
						}catch (Exception e) {
							e.printStackTrace();
						}
			}
		
		if(result.get("O_RESULT").equals("0")){
			result.put("O_MSG", result.get("O_MSG"));
		}
		
		
		}
		return result;
	}
	
    /**
     * 이미지 리사이징
     * @param inputStream
     * @param width
     * @param height
     * @return
     * @throws IOException
     */
    public static BufferedImage Resize(InputStream inputStream, int width, int height) 
    		throws IOException {
    	
        BufferedImage inputImage = ImageIO.read(inputStream);  // 받은 이미지 읽기
		if(inputImage == null){
			return null;
		}

        BufferedImage outputImage = new BufferedImage(width, height, inputImage.getType());
        // 입력받은 리사이즈 길이와 높이 

        Graphics2D graphics2D = outputImage.createGraphics(); 
        graphics2D.drawImage(inputImage, 0, 0, width, height, null); // 그리기
        graphics2D.dispose(); // 자원해제

        return outputImage;
    }
	