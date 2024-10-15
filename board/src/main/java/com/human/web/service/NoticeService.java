package com.human.web.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.human.web.vo.NoticeVO;
import com.human.web.vo.SearchPageVO;

public interface NoticeService {


	List<NoticeVO> getNoticeList();

	int insertNotice(NoticeVO vo, HttpServletRequest request);

	void updateReadCount(int nb_idx);

	NoticeVO getNotice(int nb_idx);

	void download(String origin_filename, String save_filename, HttpServletRequest request,
			HttpServletResponse response);

	int deleteAttached(int na_idx);

	List<NoticeVO> getNoticeList(SearchPageVO vo);

	int getTotalRows(SearchPageVO vo);

	int deleteNotice(int nb_idx);


	

}
