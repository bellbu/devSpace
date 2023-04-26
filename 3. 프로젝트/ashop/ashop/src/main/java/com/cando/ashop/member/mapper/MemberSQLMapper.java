package com.cando.ashop.member.mapper;

import com.cando.ashop.vo.MemberVo;

public interface MemberSQLMapper {
	
	//return 타입 : insert,update,delete - void , select - Vo
	
	public void joinMember(MemberVo vo); //insert...
	public MemberVo getMemberByIdAndPw(MemberVo abc); //select...
	
	public MemberVo getMemberByNo(int no);
	
}