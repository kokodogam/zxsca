package com.human.web.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class NoticeVO {
	private int n_idx; //게시글 번호(기본키)
	private String n_category; //구분
	private String n_title; //제목
	private String n_content; //내용
	private Date n_regdate; //등록일
	private Date n_update; //수정일
	private String n_status; //게시글 상태(
}
