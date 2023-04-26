package com.cando.ashop.board.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cando.ashop.board.service.BoardService;
import com.cando.ashop.vo.BoardVo;
import com.cando.ashop.vo.MemberVo;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	private BoardService boardService; 
	
	
	@RequestMapping("mainPage")
	public String mainPage(Model model) {
		
		ArrayList<HashMap<String, Object>> dataList = boardService.getBoardList();
		
		model.addAttribute("dataList", dataList);
				
		return "board/mainPage";
	}
	
	
	@RequestMapping("writeContentPage")
	public String writeContentPage() {
		return "board/writeContentPage";
	}
	
	@RequestMapping("writeContentProcess")
	public String writeContentProcess(BoardVo param , HttpSession session) {
		
		//파라미터로 2개값 + 세션(행위자)에서 회원 번호 뽑아서 param메모리에 세팅해서 총 3개값 세팅...
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser"); //(중요)
		int memberNo = sessionUser.getMember_no();
		param.setMember_no(memberNo);
		
		//service(class) -> mapper(xml,interface) -> insert
		boardService.writeContent(param);
		
		return "redirect:./mainPage";
	}
	
	@RequestMapping("readContentPage")
	public String readContentPage(int board_no ,Model model) {
		
		boardService.increaseReadCount(board_no);
		
		HashMap<String, Object> map = boardService.getBoard(board_no);
		model.addAttribute("data" , map);
		
		
		return "board/readContentPage";
	}
	
	@RequestMapping("deleteContentProcess")
	public String deleteContentProcess(int board_no) {
		
		boardService.deleteBoard(board_no);
		
		return "redirect:./mainPage";
	}
	
	
	@RequestMapping("updateContentPage")
	public String updateContentPage(int board_no , Model model) {
		
		HashMap<String, Object> map = boardService.getBoard(board_no);
		model.addAttribute("data" , map);
		
		
		return "board/updateContentPage";
	}
	
	@RequestMapping("updateContentProcess")
	public String updateContentProcess(BoardVo param) {
		
		boardService.updateBoard(param);
		
		return "redirect:./mainPage";
	}
	
	
}
