package com.human.web.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.web.vo.NoticeVO;

import lombok.AllArgsConstructor;
@Repository //DB와 관련된 작업을 하는 클래스에 붙여줌
@AllArgsConstructor
public class NoticeDAO {
	
	
		private SqlSession sqlSession;
		
		//MyBatis의 Mapper를 이용하기 위해 사용되는 상수 정의
		public static final String MAPPER = "com.human.web.mapper.NoticeMapper";

	//글등록
	public int insertNotice(NoticeVO vo) {
		return sqlSession.insert(MAPPER+".insertNotice", vo);
	
	}

	//글목록 조회
	public List<NoticeVO> getNoticeList() {
		
		return sqlSession.selectList(MAPPER+".getNoticeList");
	}
	//게시글 조회
	public NoticeVO getNotice(int n_idx) {
		return sqlSession.selectOne(MAPPER+".getNotice", n_idx);
	}
}

