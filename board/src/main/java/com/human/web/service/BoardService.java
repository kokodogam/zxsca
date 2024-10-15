package com.human.web.service;

import java.util.List;

import com.human.web.vo.BoardVO;

public interface BoardService {

	int insertBoard(BoardVO vo);

	List<BoardVO> getBoardList();

	BoardVO getBoard(int b_idx);

	void updateReadCount(int b_idx);

	int updateBoard(BoardVO vo);

	int deleteBoard(int b_idx);

}
