package skPinxPms.kjb.controller;

import java.io.PrintWriter;
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
import skPinxPms.LogUtil;
import skPinxPms.RequestUtil;
import skPinxPms.kjb.service.kjbOjtService;
import skPinxPms.sys.service.sysCommonService;

@Controller
public class kjbOjtController extends LogUtil {
	final static Logger LOGGER = LoggerFactory.getLogger(kjbOjtController.class);
	
	@Autowired
	private sysCommonService sCommonService;

	@Autowired
    private kjbOjtService kjbOjtService;
	
	kjbOjtController(){
		super(LOGGER);
	}
	
	/**
	 * 1단계 원그리드 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbOneGrid.do")
	public String KjbOneGrid(HttpServletRequest request, ModelMap model) throws Exception { 
		return "kjb/kjbOjt/KjbOneGrid";
	}
	
	/**
	 * 1단계 원그리드 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbOneGrid_Select.do", method = RequestMethod.POST)							 // request : org.springframework.web.servlet.resource.ResourceUrlEncodingFilter$ResourceUrlEncodingRequestWrapper@e0cb9c
    public void KjbOneGrid_Select(HttpServletRequest request,  HttpServletResponse response) throws Exception {  // response : org.springframework.web.servlet.resource.ResourceUrlEncodingFilter$ResourceUrlEncodingResponseWrapper@272130
		HashMap<String, Object> param = RequestUtil.getParameter(request);   // param(HashMap) : {perPage=, sStDate=20220525, sUserId=, sSexName=, page=1, sEdDate=20221125}
        List<?> list = kjbOjtService.KjbOneGrid_Select(param);   /* list(ArrayList) : [{userSex=F, insDate=2022-10-25, userAddr2=1111, userHp=11111111111, userPw=1111, userAddr1=11111, userBirth=20221006, corpCode=01, userId=1111, updDate=null}, 
																	        		   {userSex=M, insDate=null, userAddr2=null, userHp=11111111111, userPw=77, userAddr1=null, userBirth=20221025, corpCode=01, userId=123, updDate=null}, 
																		     	   ... {userSex=M, insDate=2022-10-24, userAddr2=1234, userHp=11113123123, userPw=1111, userAddr1=유서브, userBirth=20221002, corpCode=01, userId=테스트4, updDate=2022-10-24}] */
        CommonUtil.printTuiGridSet(param, list, response);        
	}
	
	
	/**
	 * 2단계 원그리드 바인드 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbOneGridBind.do")
	public String KjbOneGridBind(HttpServletRequest request, ModelMap model) throws Exception { 
		return "kjb/kjbOjt/KjbOneGridBind";
	}
	
	/**
	 * 2단계 원그리드 바인드 - C U D (생성, 수정, 삭제)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbOneGridBind_Control.do", method = RequestMethod.POST)
    public void KjbOneGridBind_Control(HttpServletRequest request,  HttpServletResponse response) throws Exception {
        JSONObject jsonObj = new JSONObject();
        HashMap<String, Object> result = kjbOjtService.KjbOneGridBind_Control(request);	
		
        jsonObj.put("result", result.get("O_RESULT"));
		jsonObj.put("msg", result.get("O_MSG"));
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObj);
		out.flush();
		out.close();
    }
	
	
	/**
	 * 3단계 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbTwoGridBind.do")
	public String KjbTwoGridBind(HttpServletRequest request, ModelMap model) throws Exception { 
		JSONObject cmmnObj = sCommonService.getComboData(new String[] { "RS005", "KJB01" });
		model.addAttribute("cmmnObj", cmmnObj);
		return "kjb/kjbOjt/KjbTwoGridBind";
	}
	
	
	/**
	 * 3단계 성적 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbTwoGridBind_Select.do", method = RequestMethod.POST)
    public void KjbTwoGridBind_Select(HttpServletRequest request,  HttpServletResponse response) throws Exception {
		HashMap<String, Object> param = RequestUtil.getParameter(request);
        List<?> list = kjbOjtService.KjbTwoGridBind_Select(param);
        CommonUtil.printTuiGridSet(param, list, response);
	}
	
	

	/**
	* 3단계 CUD (생성, 수정, 삭제)
	* @param request
	* @param response
	* @throws Exception
	*/
	@RequestMapping(value = "/kjb/KjbTwoGridBind_Control.do", method = RequestMethod.POST)
	public void KjbTwoGridBind_Control(HttpServletRequest request,  HttpServletResponse response) throws Exception {
	   JSONObject jsonObj = new JSONObject();
	   HashMap<String, Object> result = kjbOjtService.KjbTwoGridBind_Control(request);	
	   
	   jsonObj.put("result", result.get("O_RESULT"));
	   jsonObj.put("msg", result.get("O_MSG"));
	  
	   response.setContentType("application/json; charset=UTF-8");
	   PrintWriter out = response.getWriter();
	   out.print(jsonObj);
	   out.flush();
	   out.close();
	}
	
	
	/**
	 * 4단계 그리드 CRUD 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbGridCrud.do")
	public String SaveUpjangPOSForm(HttpServletRequest request, ModelMap model) throws Exception {
		return "kjb/kjbOjt/KjbGridCrud"; 
	}
	
	/**
	 * 4단계 그리드 CRUD - C U D (생성, 수정, 삭제)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbGridCrud_Control.do", method = RequestMethod.POST)
    public void KjbGridCrud_Control(HttpServletRequest request,  HttpServletResponse response) throws Exception {
        JSONObject jsonObj = new JSONObject();
        HashMap<String, Object> result = kjbOjtService.KjbGridCrud_Control(request);	
		
        jsonObj.put("result", result.get("O_RESULT"));
		jsonObj.put("msg", result.get("O_MSG"));
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObj);
		out.flush();
		out.close();
    }	
	
	/**
	 * 5단계 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbFive.do")
	public String KjbFive(HttpServletRequest request, ModelMap model) throws Exception { 
		JSONObject cmmnObj = sCommonService.getComboData(new String[] { "RS005", "KJB01" });
		model.addAttribute("cmmnObj", cmmnObj);
		return "kjb/kjbOjt/KjbFive";
	}
	
	/**
	 * 5단계 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbFive_Select.do", method = RequestMethod.POST)
    public void KjbFive_Select(HttpServletRequest request,  HttpServletResponse response) throws Exception {
		HashMap<String, Object> param = RequestUtil.getParameter(request);
        List<?> list = kjbOjtService.KjbFive_Select(param);
        CommonUtil.printTuiGridSet(param, list, response);
	}
	
	/**
	 * 5단계 - C U (생성, 수정)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbFive_Control.do", method = RequestMethod.POST)
    public void KjbFive_Control(HttpServletRequest request,  HttpServletResponse response) throws Exception {
        JSONObject jsonObj = new JSONObject();
        HashMap<String, Object> result = kjbOjtService.KjbFive_Control(request);	
		
        jsonObj.put("result", result.get("O_RESULT"));
		jsonObj.put("msg", result.get("O_MSG"));
		
		System.out.println(jsonObj);
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObj);
		out.flush();
		out.close();
    }
	
	
	/**
	 * 6단계 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbSix.do")
	public String KjbSix(HttpServletRequest request, ModelMap model) throws Exception { 
		JSONObject cmmnObj = sCommonService.getComboData(new String[] { "RS005", "KJB01" });
		model.addAttribute("cmmnObj", cmmnObj);
		return "kjb/kjbOjt/KjbSix";
	}
	
	/**
	 * 6단계 학교리스트 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbSchoolList_Select.do", method = RequestMethod.POST)
    public void KjbSchoolList_Select(HttpServletRequest request,  HttpServletResponse response) throws Exception {
		HashMap<String, Object> param = RequestUtil.getParameter(request);
        List<?> list = kjbOjtService.KjbSchoolList_Select(param);
        CommonUtil.printTuiGridSet(param, list, response);
	}
	
	/**
	 * 6단계 유저리스트 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbUserList_Select.do", method = RequestMethod.POST)
    public void KjbUserList_Select(HttpServletRequest request,  HttpServletResponse response) throws Exception {
		HashMap<String, Object> param = RequestUtil.getParameter(request);
        List<?> list = kjbOjtService.KjbUserList_Select(param);
        CommonUtil.printTuiGridSet(param, list, response);
	}
	
	/**
	 * 6단계 성적리스트 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbScoreList_Select.do", method = RequestMethod.POST)
    public void KjbScoreList_Select(HttpServletRequest request,  HttpServletResponse response) throws Exception {
		HashMap<String, Object> param = RequestUtil.getParameter(request);
        List<?> list = kjbOjtService.KjbScoreList_Select(param);
        CommonUtil.printTuiGridSet(param, list, response);
	}
	
	/**
	 * 7단계 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbSeven.do")
	public String KjbSeven(HttpServletRequest request, ModelMap model) throws Exception { 
		JSONObject cmmnObj = sCommonService.getComboData(new String[] { "RS002", "RB009", "RB003"});
		model.addAttribute("cmmnObj", cmmnObj);
		return "kjb/kjbOjt/KjbSeven";
	}
	
	/**
	 * 7단계 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/kjb/KjbSeven_Select.do", method = RequestMethod.POST)
    public void KjbSeven_Select(HttpServletRequest request,  HttpServletResponse response) throws Exception {
		HashMap<String, Object> param = RequestUtil.getParameter(request);
        List<?> list = kjbOjtService.KjbSeven_Select(param);
        CommonUtil.printTuiGridSet(param, list, response);
	}
	
	/**
	* 7단계 CUD (생성, 수정, 삭제)
	* @param request
	* @param response
	* @throws Exception
	*/
	@RequestMapping(value = "/kjb/KjbSeven_Control.do", method = RequestMethod.POST)
	public void KjbSeven_Control(HttpServletRequest request,  HttpServletResponse response) throws Exception {
	   JSONObject jsonObj = new JSONObject();
	   HashMap<String, Object> result = kjbOjtService.KjbSeven_Control(request);	
	   
	   jsonObj.put("result", result.get("O_RESULT"));
	   jsonObj.put("msg", result.get("O_MSG"));
	  
	   response.setContentType("application/json; charset=UTF-8");
	   PrintWriter out = response.getWriter();
	   out.print(jsonObj);
	   out.flush();
	   out.close();
	}
	
	
	
	
	
	

}
