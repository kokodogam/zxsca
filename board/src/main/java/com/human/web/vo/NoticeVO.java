package com.human.web.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class NoticeVO {
	private int nb_idx; //공지사항 번호(기본키)
	private String nb_writer; //작성자
	private String nb_title; //제목
	private String nb_content; //내용
	private int read_cnt; //조회수
	private Date post_date; //드옥일
	private Date update_date; //수정일
	private String nb_status; //공지사항 상태(N:삭제요청 없음, Y:삭제요청함)
	private int m_idx;
	
	//게시글 등록 폼에서 입력된 값을 커맨드 객체로 받기 위해서 첨부파일을
	//MultipartFile 타입의 필드로 정의해야 함
	private MultipartFile[] uploadFiles; //첨부 파일(최대 4개, 1개 최대 5MB, 1회 최대 20MB)
	
	private List<NoticeAttachedVO> attachedList;//첨부파일 리스트
}
