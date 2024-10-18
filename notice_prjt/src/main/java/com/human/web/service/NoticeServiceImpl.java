package com.human.web.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.human.web.repository.NoticeDAO;
import com.human.web.vo.NoticeVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class NoticeServiceImpl implements NoticeService {

	//게시판 관련 DB와 작업할 수 있는 DAO객체 정의(lombok에 의한 의존자동주입: 생성자 이용)
	private NoticeDAO dao;
	
	@Override
	public int insertNotice(NoticeVO vo) {
		return dao.insertNotice(vo);
	}
	
	@Override
	public List<NoticeVO> getNoticeList() {
		return dao.getNoticeList();
	}

	@Override
	public NoticeVO getNotice(int n_idx) {
		return dao.getNotice(n_idx);
}
}