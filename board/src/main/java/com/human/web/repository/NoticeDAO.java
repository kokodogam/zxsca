package com.human.web.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.human.web.vo.NoticeAttachedVO;
import com.human.web.vo.NoticeVO;
import com.human.web.vo.SearchPageVO;

import lombok.AllArgsConstructor;
@Repository //DB와 관련된 작업을 하는 클래스에 붙여줌
@AllArgsConstructor
public class NoticeDAO {
	
	//lombok API를 이용한 의존 자동주입: 생성자 방식
		private SqlSession sqlSession;
		
		//MyBatis의 Mapper를 이용하기 위해 사용되는 상수 정의
		public static final String MAPPER = "com.human.web.mapper.NoticeMapper";
		
		//트랜잭션 작업 관련 객체
		private PlatformTransactionManager transactionManager;

	//공지사항 목록
	public List<NoticeVO> getNoticeList() {
		List<NoticeVO> noticeList = sqlSession.selectList(MAPPER+".getNoticeList");
		
		//해당 공지사항에 대한 첨부파일들을 attachedList에 세팅하기
		for(NoticeVO notice : noticeList) {
			List<NoticeAttachedVO> attachedList = 
					sqlSession.selectList(MAPPER+".getAttachedList", notice.getNb_idx());
			notice.setAttachedList(attachedList);	
		}
		
		return noticeList;
	}
	
	//공지사항 등록: 공지사항 입력 + 첨부파일 입력 : 트랜잭션 처리 필요
	@Transactional //트랜잭션을 적용하는 메소드에 붙여줌
	public int insertNotice(NoticeVO vo) throws RuntimeException{
		int result = 0; //입력실패시 결과값
		
		//트랜잭션을 처리할 수 있는 트랜잭션 상태 객체 정의
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try {
			
			sqlSession.insert(MAPPER+".insertNotice", vo);
			
			//아직 공지사항 테이블에 입력값이 반영이 되지 않아서 nb_idx값이 생성되지 않은 상태이므로
			//기존에 저장된 공지사항 번호 중 최고값을 조회해서 1을 더해서 첨부파일의 nb_idx로 세팅함
			int nb_idx = sqlSession.selectOne(MAPPER+".getMaxNb_idx");
			
			List<NoticeAttachedVO> attachedList = vo.getAttachedList();
			for(NoticeAttachedVO naVo : attachedList) {
				naVo.setNb_idx(nb_idx);
				sqlSession.insert(MAPPER+".insertAttached", naVo);
			}
			
			result = 1; //입력성공시 결과값
			
		} catch (Exception e) {
			System.out.println("공지사항 입력 중 예외발생");
			
			transactionManager.rollback(txStatus); //예외 발생 시 롤백 처리
			throw e; //예외 발생시킴 - throws RuntimeException으로 처리
		}
		
		transactionManager.commit(txStatus);//정상적으로 처리되면 커밋 처리
		
		return result;
	}
	//조회수 증가시키기
	public void updateReadCount(int nb_idx) {
		sqlSession.update(MAPPER+".updateReadCount", nb_idx);
		
	}
	//공지사항 가져오기
	public NoticeVO getNotice(int nb_idx) {
		//공지사항 가져오기
		NoticeVO vo = sqlSession.selectOne(MAPPER+".getNotice", nb_idx);
		
		//첨부파일 가져오기
		List<NoticeAttachedVO> attachedList = sqlSession.selectList(MAPPER+".getAttachedList",nb_idx);
		vo.setAttachedList(attachedList);
		return vo;
	}
	
	//첨부파일 삭제
	public int deleteAttached(int na_idx) {
		return sqlSession.delete(MAPPER+".deleteAttached", na_idx);
	}

	public List<NoticeVO> getNoticeList(SearchPageVO vo) {
		List<NoticeVO> noticeList = sqlSession.selectList(MAPPER+".getNoticeList2", vo);
		//해당 공지사항에 대한 첨부파일들을 attachedList에 세팅하기
				for(NoticeVO notice : noticeList) {
					List<NoticeAttachedVO> attachedList = 
							sqlSession.selectList(MAPPER+".getAttachedList", notice.getNb_idx());
					notice.setAttachedList(attachedList);	
				}
			
		
		return noticeList;
		
	}
	//총 게시글 수 조회(검색조건 포함)
	public int getTotalRows(SearchPageVO vo) {
		return sqlSession.selectOne(MAPPER+".getTotalRows", vo);
	}

	public int deleteNotice(int nb_idx) {
		return sqlSession.update(MAPPER+".deleteNotice", nb_idx);
	}
}
