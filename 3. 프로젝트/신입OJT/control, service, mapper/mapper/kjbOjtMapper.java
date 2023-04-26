package skPinxPms.kjb.mapper;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import skPinxPms.uSqlSession;

@Component   
public class kjbOjtMapper { 
	
	@Autowired
	private uSqlSession kjbOjt;
	
	/* 1단계 원그리드 조회 */      
	public List<?> KjbOneGrid_Select(HashMap<String, Object> param) {
		return kjbOjt.selectList("KjbOneGrid.Select", param);  /* param : {perPage=, sStDate=20220525, O_LIST=[{userSex=F, insDate=2022-10-25, userAddr2=1111, userHp=11111111111, userPw=1111, userAddr1=11111, userBirth=20221006, corpCode=01, userId=1111, updDate=null}, 
																          ~ {userSex=M, insDate=2022-10-24, userAddr2=1234, userHp=11113123123, userPw=1111, userAddr1=유서브, userBirth=20221002, corpCode=01, userId=테스트4, updDate=2022-10-24}], sUserId=, 
																		  loginVO=LoginVO [corpCode=01, empId=3076, empIp=0:0:0:0:0:0:0:1, empNo=3119, empName=김종부, passwordCode=qpfqn1986^^, passwordPos=, useYn=Y, posLoginDate=, backLoginDate=, loginFlag=, passwordCheck=, authGroupCode=00001, perUpjangCode=null, loginLockYn=, authCode=, lastLoginDate=2022-11-23 14:54, lastLoginIp=192.168.31.50], 
																		  sSexName=, page=1, sEdDate=20221125} */
	}
	
	
	/*2단계 CUD */
	public HashMap<String, Object> KjbOneGridBind_Insert(HashMap<String, Object> param)throws Exception  {
		return kjbOjt.selectOne("KjbOneGridBind.Insert",param);
	}
	public HashMap<String, Object> KjbOneGridBind_Update(HashMap<String, Object> param)throws Exception  {
		return kjbOjt.selectOne("KjbOneGridBind.Update",param);
	}
	public HashMap<String, Object> KjbOneGridBind_Delete(HashMap<String, Object> param)throws Exception  {
		return kjbOjt.selectOne("KjbOneGridBind.Delete",param);
	}
	
	
	/* 3단계 성적 조회 */
	public List<?> KjbTwoGridBind_Select(HashMap<String, Object> param) {
		return kjbOjt.selectList("KjbTwoGridBind.Select", param);
	}
	/*3단계 CUD */
	public HashMap<String, Object> KjbTwoGridBind_Insert(HashMap<String, Object> param)throws Exception  {
		return kjbOjt.selectOne("KjbTwoGridBind.Insert",param);
	}
	public HashMap<String, Object> KjbTwoGridBind_Update(HashMap<String, Object> param)throws Exception  {
		return kjbOjt.selectOne("KjbTwoGridBind.Update",param);
	}
	public HashMap<String, Object> KjbTwoGridBind_Delete(HashMap<String, Object> param)throws Exception  {
		return kjbOjt.selectOne("KjbTwoGridBind.Delete",param);
	}
	
	
	/*4단계 CUD */
	public HashMap<String, Object> KjbGridCrud_Insert(HashMap<String, Object> param)throws Exception {
		return kjbOjt.selectOne("KjbGridCrud.Insert",param);
	}
	public HashMap<String, Object> KjbGridCrud_Update(HashMap<String, Object> param)throws Exception  {
		return kjbOjt.selectOne("KjbGridCrud.Update",param);
	}
	public HashMap<String, Object> KjbGridCrud_Delete(HashMap<String, Object> param)throws Exception  {
		return kjbOjt.selectOne("KjbGridCrud.Delete",param);
	}
	
	
	/* 5단계 조회 */
	public List<?> KjbFive_Select(HashMap<String, Object> param) {
		return kjbOjt.selectList("KjbFive.Select", param);
	}
	
	/*5단계 CU */
	public HashMap<String, Object> KjbFive_Insert(HashMap<String, Object> param)throws Exception  {
		return kjbOjt.selectOne("KjbFive.Insert",param);
	}
	public HashMap<String, Object> KjbFive_Update(HashMap<String, Object> param)throws Exception  {
		return kjbOjt.selectOne("KjbFive.Update",param);
	}
	
	
	/* 6단계 학교리스트 조회 */
	public List<?> KjbSchoolList_Select(HashMap<String, Object> param) {
		return kjbOjt.selectList("KjbSix.Select_SchoolList", param);
	}
	
	/* 6단계 유저리스트 조회 */
	public List<?> KjbUserList_Select(HashMap<String, Object> param) {
		return kjbOjt.selectList("KjbSix.Select_UserList", param);
	}
	
	/* 6단계 성적리스트 조회 */
	public List<?> KjbScoreList_Select(HashMap<String, Object> param) {
		return kjbOjt.selectList("KjbSix.Select_ScoreList", param);
	}
	
	
	/* 7단계 조회 */
	public List<?> KjbSeven_Select(HashMap<String, Object> param) {
		return kjbOjt.selectList("KjbSeven.Select", param);
	}
	
	/*7단계 CUD */
	public HashMap<String, Object> KjbSeven_Insert(HashMap<String, Object> param)throws Exception  {
		return kjbOjt.selectOne("KjbSeven.Insert",param);
	}
	
	public HashMap<String, Object> KjbSeven_Update(HashMap<String, Object> param)throws Exception  {
		return kjbOjt.selectOne("KjbSeven.Update",param);
	}


}
