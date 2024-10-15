package com.human.web.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.web.vo.BoardVO;

import lombok.AllArgsConstructor;
@Repository //DB와 관련된 작업을 하는 클래스에 붙여줌
@AllArgsConstructor
public class BoardDAO {
	
	//lombok API를 이용한 의존 자동주입: 생성자 방식
		private SqlSession sqlSession;
		
		//MyBatis의 Mapper를 이용하기 위해 사용되는 상수 정의
		public static final String MAPPER = "com.human.web.mapper.BoardMapper";

	//글등록
	public int insertBoard(BoardVO vo) {
		return sqlSession.insert(MAPPER+".insertBoard", vo);
	
	}

	//글목록 조회
	public List<BoardVO> getBoardList() {
		
		return sqlSession.selectList(MAPPER+".getBoardList");
	}
	//게시글 조회
	public BoardVO getBoard(int b_idx) {
		return sqlSession.selectOne(MAPPER+".getBoard", b_idx);
	}
	
	//조회수 증가시키기
	public void updateReadCount(int b_idx) {
		sqlSession.update(MAPPER+".updateReadCount", b_idx);
		
	}
	//글수정
	public int updateBoard(BoardVO vo) {
		return sqlSession.update(MAPPER+".updateBoard",vo);
	}

	public int deleteBoard(int b_idx) {
		return sqlSession.update(MAPPER+".deleteBoard", b_idx);
	}
}
