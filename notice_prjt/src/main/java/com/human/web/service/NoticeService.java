package com.human.web.service;

import java.util.List;

import com.human.web.vo.NoticeVO;

public interface NoticeService {

	int insertNotice(NoticeVO vo);

	List<NoticeVO> getNoticeList();

	NoticeVO getNotice(int n_idx);

}
