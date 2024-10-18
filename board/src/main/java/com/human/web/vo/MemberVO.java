package com.human.web.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {
	
	private int m_idx;//회원번호(시퀀스를 이용)
	private String member_name;//회원이름
	private String member_id;//회원아이디(이메일을 이용)
	private String member_pw;//비밀번호
	private String birthday;//생일(YYYYMMDD형식의 8자리)
	private String phone;//핸드폰번호(010다음의 -을 포함한 9자리)
	private Date reg_date;//가입일
	private Date update_date;//수정일
	private String member_status;//회원상태(삭제요청여부:N(미요청), Y(요청))
	private int member_grade;//회원등급(1:일반, 2:관리자, 3:슈퍼관리자(시스템운영자))

}
