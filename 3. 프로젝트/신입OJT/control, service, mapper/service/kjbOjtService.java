package skPinxPms.kjb.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import skPinxPms.CommonUtil;
import skPinxPms.RequestUtil;
import skPinxPms.kjb.mapper.kjbOjtMapper;

@Service
public class kjbOjtService {
	protected final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
    private kjbOjtMapper kjbOjtMapper;
	
	/**
	 * 1단계 원그리드 조회
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	
	public List<?> KjbOneGrid_Select(HashMap<String, Object> param) throws Exception {
		return kjbOjtMapper.KjbOneGrid_Select(param); // param : {perPage=, sStDate=20220525, sUserId=, sSexName=, page=1, sEdDate=20221125}
	}
	
	
	/**
	 * 2단계 원그리드 바인드 - C U D (생성, 수정, 삭제)
	 * @param param
	 * @return
	 * @throws Exception
	 */
 
    @Transactional public HashMap<String, Object> KjbOneGridBind_Control(HttpServletRequest request) throws Exception {
		HashMap<String, Object> result = new HashMap<String, Object>();
		HashMap<String, Object> param = RequestUtil.getParameter(request);
		
		// 비밀번호 암호화
		param.put("userPw", CommonUtil.SDBConvertSha256(param.get("userPw").toString())); // ??암호화 안됨??
		
		if(param.get("type").equals("add")) {
			result = kjbOjtMapper.KjbOneGridBind_Insert(param);
		} else if (param.get("type").equals("edit")) {
			result = kjbOjtMapper.KjbOneGridBind_Update(param);
		} 
		else if(param.get("type").equals("del")) {
			result = kjbOjtMapper.KjbOneGridBind_Delete(param);
		}
		
		if(result.get("O_RESULT").equals("0")){
			result.put("O_MSG", result.get("O_MSG"));
		}
		
		return result;

	}
    
    
	/**
	 * 3단계 성적 조회
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	
	public List<?> KjbTwoGridBind_Select(HashMap<String, Object> param) throws Exception {
		return kjbOjtMapper.KjbTwoGridBind_Select(param);
	}

	/**
	* 3단계 C U D (생성, 수정, 삭제)
	* @param param
	* @return
	* @throws Exception
	*/

	@Transactional public HashMap<String, Object> KjbTwoGridBind_Control(HttpServletRequest request) throws Exception {
	   HashMap<String, Object> result = new HashMap<String, Object>();
	   HashMap<String, Object> param = RequestUtil.getParameter(request);
	   
	   
	   if(param.get("type").equals("input")) {
		   result = kjbOjtMapper.KjbTwoGridBind_Insert(param);
	   } else if (param.get("type").equals("edit")) {
		   result = kjbOjtMapper.KjbTwoGridBind_Update(param);
	   } else if(param.get("type").equals("del")) {
		   result = kjbOjtMapper.KjbTwoGridBind_Delete(param);
	   }
	   
	   if(result.get("O_RESULT").equals("0")){
		   result.put("O_MSG", result.get("O_MSG"));
	   }
	   
	   return result;

	}
	
	
	/**
	 * 4단계 그리드 CRUD - C U D (생성, 수정, 삭제)
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@Transactional 
	public HashMap<String, Object> KjbGridCrud_Control(HttpServletRequest request) throws Exception {
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		JSONArray grids = CommonUtil.parseGridToJArr(request) ;
		
		for(int i = 0 ; i < grids.size() ; i++) {
			JSONObject data = grids.getJSONObject(i);
			
			HashMap<String, Object> param = CommonUtil.jsonToMap(data);
			
			   System.out.println("===========파라미터============");
			   System.out.println(param);
			
			if(param.containsKey("type")) {
				if(param.get("type").equals("add")){
					result = kjbOjtMapper.KjbGridCrud_Insert(param);
				}else if(param.get("type").equals("edit")){
					result = kjbOjtMapper.KjbGridCrud_Update(param);
				}else if(param.get("type").equals("del")){
					result = kjbOjtMapper.KjbGridCrud_Delete(param);
					System.out.println("===============삭제===========");
					System.out.println(param);
				}
			}
			
			if(!result.get("O_RESULT").toString().equals("1")) {
	    		break;
	    	}
		}
		return result;		
	}
	
	
	/**
	 * 5단계 조회
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	
	public List<?> KjbFive_Select(HashMap<String, Object> param) throws Exception {
		return kjbOjtMapper.KjbFive_Select(param);
	}
	
	/**
	 * 5단계 - C U (생성, 수정)
	 * @param param
	 * @return
	 * @throws Exception
	 */
 
    @Transactional public HashMap<String, Object> KjbFive_Control(HttpServletRequest request) throws Exception {
		HashMap<String, Object> result = new HashMap<String, Object>();
		HashMap<String, Object> param = RequestUtil.getParameter(request);
		
		// 비밀번호 암호화
		param.put("userPw", CommonUtil.SDBConvertSha256(param.get("userPw").toString())); 
		
		if(param.get("type").equals("add")) {
			result = kjbOjtMapper.KjbFive_Insert(param);
		} else if (param.get("type").equals("edit")) {
			result = kjbOjtMapper.KjbFive_Update(param);
		} 
		
		
		if(result.get("O_RESULT").equals("0")){
			result.put("O_MSG", result.get("O_MSG"));
		}
		
		return result;

	}
    
    
	/**
	 * 6단계 학교리스트 조회
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	
	public List<?> KjbSchoolList_Select(HashMap<String, Object> param) throws Exception {
		return kjbOjtMapper.KjbSchoolList_Select(param);
	}
	
	/**
	 * 6단계 유저리스트 조회
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	
	public List<?> KjbUserList_Select(HashMap<String, Object> param) throws Exception {
		return kjbOjtMapper.KjbUserList_Select(param);
	}

	/**
	 * 6단계 성적리스트 조회
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	
	public List<?> KjbScoreList_Select(HashMap<String, Object> param) throws Exception {
		return kjbOjtMapper.KjbScoreList_Select(param);
	}
	
	/**
	 * 7단계 조회
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	
	public List<?> KjbSeven_Select(HashMap<String, Object> param) throws Exception {
		return kjbOjtMapper.KjbSeven_Select(param);
	}
	
	
	/**
	* 7단계 C U D (생성, 수정, 삭제)
	* @param param
	* @return
	* @throws Exception
	*/

	@Transactional public HashMap<String, Object> KjbSeven_Control(HttpServletRequest request) throws Exception {
	   HashMap<String, Object> result = new HashMap<String, Object>();
	   HashMap<String, Object> param = RequestUtil.getParameter(request);
	   
	   
	   if(param.get("type").equals("add")) {
		   result = kjbOjtMapper.KjbSeven_Insert(param);
	   } else if (param.get("type").equals("edit")) {
		   result = kjbOjtMapper.KjbSeven_Update(param);
	   } 
	   
	   if(result.get("O_RESULT").equals("0")){
		   result.put("O_MSG", result.get("O_MSG"));
	   }
	   
	   return result;

	}
	
	
}
