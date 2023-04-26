package com.cando.ashop.comment.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cando.ashop.comment.mapper.CommentSQLMapper;
import com.cando.ashop.member.mapper.MemberSQLMapper;
import com.cando.ashop.vo.CommentVo;
import com.cando.ashop.vo.MemberVo;

@Service
public class KjbCommentService {
	
	@Autowired
	private CommentSQLMapper commentSQLMapper;
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	
	public void writeComment(CommentVo vo) {
		
		commentSQLMapper.insertComment(vo);
		
	}
	
	public ArrayList<HashMap<String, Object>> getCommentList(int board_no) {
		
		ArrayList<HashMap<String, Object>> commentList = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<CommentVo> commentVoList = commentSQLMapper.getCommentList(board_no);
		
		for(CommentVo commentVo : commentVoList) {
			
			int memberNo = commentVo.getMember_no();
			MemberVo memberVo = memberSQLMapper.getMemberByNo(memberNo);
			
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			
			hashMap.put("memberVo", memberVo);
			hashMap.put("commentVo", commentVo);
			
			commentList.add(hashMap);
			
		}
		return commentList;
	}
	
	public void deleteComment(int comment_no) {
		
		commentSQLMapper.deleteComment(comment_no);
	}
	

}
