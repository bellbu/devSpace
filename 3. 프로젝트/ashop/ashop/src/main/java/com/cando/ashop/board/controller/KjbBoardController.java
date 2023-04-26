package com.cando.ashop.board.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cando.ashop.board.service.BoardService;
import com.cando.ashop.comment.service.KjbCommentService;
import com.cando.ashop.vo.BoardVo;
import com.cando.ashop.vo.MemberVo;

@Controller
@RequestMapping("/board/*")
public class KjbBoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private KjbCommentService kjbCommentService;
	
	@RequestMapping("kjbMainPage")
	public String kjbMainPage(Model model) {
		
		ArrayList<HashMap<String, Object>> dataList = boardService.getBoardList();
		model.addAttribute("dataList", dataList);
		
		return "board/kjbMainPage";
		
	}
	
	@RequestMapping("kjbWriteContentPage")
	public String kjbWriteContentPage() {
		
		return "board/kjbWriteContentPage";
	}
	
	@RequestMapping("kjbWriteContentProcess")
	public String kjbWriteContentProcess(BoardVo param, HttpSession session) {
		
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		int memberNo = sessionUser.getMember_no();
		param.setMember_no(memberNo);
		
		boardService.writeContent(param);
		
		return "redirect:./kjbMainPage";
	}
	
	@RequestMapping("kjbReadContentPage")
	public String kjbReadContentPage(int board_no, Model model) {
		
		boardService.increaseReadCount(board_no);
		
		HashMap<String, Object> map = boardService.getBoard(board_no);
		model.addAttribute("data", map);
		
		ArrayList<HashMap<String, Object>> commentList = kjbCommentService.getCommentList(board_no);
		model.addAttribute("commentList", commentList);
		
		
		return "board/kjbReadContentPage";
	}
	
	@RequestMapping("kjbDeleteContentProcess")
	public String kjbDeleteContentProcess(int board_no) {
		
		boardService.deleteBoard(board_no);
		
		return "redirect:./kjbMainPage";
	}
	
	@RequestMapping("kjbUpdateContentPage")
	public String kjbUpdateContentPage(int board_no, Model model) {
		
		 HashMap<String, Object> map = boardService.getBoard(board_no);
		 model.addAttribute("data", map);
		 
		 return "board/kjbUpdateContentPage";
	}
	
	@RequestMapping("kjbUpdateContentProcess")
	public String kjbUpdateContentProcess(BoardVo param) {
		
		boardService.updateBoard(param);
		
		return "redirect:./kjbMainPage";
	}
	
	@RequestMapping("ashopMainPage")
	public String ashopMainPage() {
		
		return "board/ashopMainPage";
		
	}
	
	
	
}
