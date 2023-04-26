package com.cando.ashop.board.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cando.ashop.board.mapper.BoardSQLMapper;
import com.cando.ashop.member.mapper.MemberSQLMapper;
import com.cando.ashop.vo.BoardVo;
import com.cando.ashop.vo.MemberVo;

@Service
public class BoardService {
	
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	@Autowired
	private BoardSQLMapper boardSQLMapper;
	
	public ArrayList<HashMap<String, Object>> getBoardList() {
		
		ArrayList<HashMap<String, Object>> dataList = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<BoardVo> boardVoList = boardSQLMapper.getBoardList();
		
		for(BoardVo boardVo : boardVoList) {
			
			int memberNo = boardVo.getMember_no();
			MemberVo memberVo = memberSQLMapper.getMemberByNo(memberNo);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberVo", memberVo);
			map.put("boardVo", boardVo);
			
			dataList.add(map);
		}
		return dataList;
		
	}

	/* 제거 */
	public void writeContent(BoardVo vo) {
		boardSQLMapper.insertBoard(vo);
	}
	
	public HashMap<String, Object> getBoard(int board_no) {
		
		BoardVo boardVo = boardSQLMapper.getBoardByNo(board_no);
		int memberNo = boardVo.getMember_no();
		MemberVo memberVo = memberSQLMapper.getMemberByNo(memberNo);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("boardVo", boardVo);
		map.put("memberVo", memberVo);
		
		return map;
	}
	
	public void increaseReadCount(int board_no) {
		boardSQLMapper.increaseReadCount(board_no);
	}
	
	public void deleteBoard(int board_no) {
		//예외 처리
		boardSQLMapper.deleteBoard(board_no);
	}
	
	public void updateBoard(BoardVo vo) {
		boardSQLMapper.updateBoard(vo);
	}
	
	
}
