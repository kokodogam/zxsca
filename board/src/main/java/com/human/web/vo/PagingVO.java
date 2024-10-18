package com.human.web.vo;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component //페이징 처리를 하는데 있어서 프로그램 내에서 사용하려고
//@Component 어노테이션으로 빈 등록해줌
@Data
public class PagingVO {
	private int totalRows; //총 게시물수
	private int pageRows; //페이지 당 게시물수
	private int blockPages; //블록 당 페이지수
	private int pageNum; //현재 페이지 번호
	private int startNum; //게시물 시작번호
	private int endNum; //게시물 끝번호
	private int totalPages; //총 페이지수
	private int blockNum; //현재 블록번호
	private int lastBlock; //마지막 블록번호


}
