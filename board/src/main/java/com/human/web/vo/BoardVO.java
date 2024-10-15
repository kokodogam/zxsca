package com.human.web.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BoardVO {
	private int b_idx; //게시글 번호(기본키)
	private String b_writer; //작성자
	private String b_title; //제목
	private String b_content; //내용
	private int read_cnt; //조회수
	private Date post_date; //드옥일
	private Date update_date; //수정일
	private String b_status; //게시글 상태(
	private int m_idx;
}
