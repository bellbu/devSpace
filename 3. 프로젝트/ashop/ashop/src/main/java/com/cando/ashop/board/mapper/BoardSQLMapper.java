package com.cando.ashop.board.mapper;

import java.util.ArrayList;

import com.cando.ashop.vo.BoardVo;

public interface BoardSQLMapper {
	
	public ArrayList<BoardVo> getBoardList();
	
	public void insertBoard(BoardVo vo); /* insert, update, delete의 리턴타입: void // select의 리턴 타입: vo */ 

	public void increaseReadCount(int no);

	public BoardVo getBoardByNo(int no); 
	
	public void deleteBoard(int no);
	
	public void updateBoard(BoardVo vo);
	
	
	
}
