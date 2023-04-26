package skPinxPms.kjb.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.sf.json.JSONObject;
import skPinxPms.CommonUtil;
import skPinxPms.RequestUtil;
import skPinxPms.kjb.service.kjbOjtPopupService;
import skPinxPms.sys.service.sysCommonService;


/**
  * @FileName : skPinxPms.spt.controller
                  |_ sptCommonController.java
  * 
  * @Project : skPinxPms
  * @Date : 2020. 4. 9. 
  * @작성자 : jhkim
  * @변경이력 :
  * @프로그램 설명 :
  */
@Controller
public class kjbOjtPopupController {
	protected final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
    private kjbOjtPopupService kjbOjtPopupService;
	
	@Autowired
    private sysCommonService sCommonService;
		
	/**
	 * 학교코드 -조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjbOjtPopup/KjbRetrieveSchoolCodeListPop.do")
	public String RetrieveSchoolCodeListPop(HttpServletRequest request, ModelMap model) throws Exception {
		JSONObject cmmnObj = sCommonService.getComboData(new String[] { "KJB01" });
		model.addAttribute("cmmnObj", cmmnObj);
		return "kjb/kjbOjtPopup/KjbRetrieveSchoolCodeListPop";                  
	}
	
	/**
	 * 영업장메뉴관리 - 영업장리스트 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjbOjtPopup/KjbRetrieveSchoolCodeListPop_Select.do", method = RequestMethod.POST)
	public void KjbRetrieveSchoolCodeListPop_Select(HttpServletRequest request,  HttpServletResponse response) throws Exception {	
		HashMap<String, Object> param = RequestUtil.getParameter(request);
		List<?> list = kjbOjtPopupService.KjbRetrieveSchoolCodeListPop_Select(param);
		
		CommonUtil.printTuiGridSet(param, list, response);
	}
	
	
	
	
}