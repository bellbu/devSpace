package com.cando.ashop.comment.mapper;

import java.util.ArrayList;

import com.cando.ashop.vo.CommentVo;

public interface CommentSQLMapper {
	
	public void insertComment(CommentVo vo);
	
	public ArrayList<CommentVo> getCommentList(int no);
	
	public void deleteComment(int no);

}
