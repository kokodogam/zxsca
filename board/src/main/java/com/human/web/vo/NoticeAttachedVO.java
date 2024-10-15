package com.human.web.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class NoticeAttachedVO {
	private int na_idx; //공지사항 첨부파일 번호
	private String origin_filename; //원본 파일명
	private String save_filename; //저장 파일명
	private int nb_idx; //공지사항 번호
	
}
