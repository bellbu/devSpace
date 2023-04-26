package skPinxPms.kjb.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import skPinxPms.kjb.mapper.kjbOjtPopupMapper;


@Service
public class kjbOjtPopupService {
	protected final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
    private kjbOjtPopupMapper kjbOjtPopupMapper;

	/**
	 * 영업장메뉴관리 - 영업장리스트 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public List<?> KjbRetrieveSchoolCodeListPop_Select(HashMap<String, Object> param) throws Exception {
		return kjbOjtPopupMapper.KjbRetrieveSchoolCodeListPop_Select(param);
	}
	
	
}