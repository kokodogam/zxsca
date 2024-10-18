package com.human.web.service;

import com.human.web.vo.MemberVO;

public interface MemberService {

	int insertMember(MemberVO vo);

	int checkId(String member_id);

	MemberVO login(String member_id, String member_pw);

	MemberVO updateMember(MemberVO vo);

	int cancel(int m_idx);

	String authEmail(String email);

}
