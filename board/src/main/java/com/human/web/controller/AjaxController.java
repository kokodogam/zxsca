package com.human.web.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.human.web.service.MemberService;
import com.human.web.service.NoticeService;

import lombok.AllArgsConstructor;

@RestController //@Controller + @ResponseBody
@AllArgsConstructor
public class AjaxController {
	
	//필드 정의
	private MemberService memberServiceImpl;
	private NoticeService noticeServiceImpl;
	
	//아이디 중복검사
	@PostMapping("/member/checkId.do")
	public String checkId(String member_id) {
		String result = "PASS";//중복된 아이디가 없는 경우 결과값
		
		if(memberServiceImpl.checkId(member_id) == 1) {//중복 아이디가 있는 경우
			result = "FAIL";
		}
		return result;
	}
	
	//이메일 인증
	@PostMapping("/member/checkEmail.do")
	public String checkEmail(String email) {
		System.out.println("이메일 인증 이메일: "+email);
		return memberServiceImpl.authEmail(email);
	}
	
	//첨부파일 삭제 요청
	@PostMapping("/notice_board/deleteAttached.do")
	public String deleteAttached(int na_idx) {
		String result = "FAIL";
		
		if(noticeServiceImpl.deleteAttached(na_idx) == 1) {
			result = "OK";
		}
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
