package skPinxPms.kjb.mapper;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import skPinxPms.uSqlSession;


@Component
public class kjbOjtPopupMapper {

	@Autowired
	private uSqlSession sptMenu;
	
	
	public List<?> KjbRetrieveSchoolCodeListPop_Select(HashMap<String, Object> param)  throws Exception  {
		return sptMenu.selectList("KjbRetrieveSchoolCodeListPop.Select",param);
	}
	
}
