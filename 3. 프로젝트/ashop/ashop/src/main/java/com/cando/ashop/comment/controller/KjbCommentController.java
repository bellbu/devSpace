package com.cando.ashop.comment.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cando.ashop.comment.service.KjbCommentService;
import com.cando.ashop.vo.CommentVo;

@Controller
@RequestMapping("/board/*")
public class KjbCommentController {

	@Autowired
	private KjbCommentService kjbCommentService;

	@RequestMapping("kjbWriteCommentProcess")
	public String kjbWriteCommentProcess(CommentVo vo) {

		kjbCommentService.writeComment(vo);

		return "redirect:./kjbReadContentPage?board_no=" + vo.getBoard_no();

	}

	 // 댓글 삭제 
	 @RequestMapping("deleteCommentProcess")
	 public String deleteCommentProcess(int comment_no, int board_no) {
		 
		 
		 kjbCommentService.deleteComment(comment_no);
	  
		 return "redirect:./kjbReadContentPage?board_no=" + board_no;
	  
	 }
	 

}
