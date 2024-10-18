package com.human.web.util;

import org.springframework.stereotype.Component;

import com.human.web.vo.PagingVO;

@Component
public class PagingManager {
	
	public PagingVO setPagingVO(PagingVO pVO, int pageNum, int blockNum) {
		
		int totalRows = pVO.getTotalRows(); //총 게시물 수
		int pageRows = 10; //페이지 당 게시물 수
		int blockPages = 5; //블록 당 페이지 수
		
		pVO.setPageRows(pageRows);
		pVO.setBlockPages(blockPages);
		
		int pNum = 0;
		if(pageNum == 0) {
			pNum = 1;	
		}else {
			pNum = pageNum;
		}
		pVO.setPageNum(pNum); //현재 페이지 번호
		
		int bNum = 0;
		if(blockNum == 0) {
			bNum = 1;
		}else {
			bNum = blockNum;
		}
		pVO.setBlockNum(bNum); //현재 블록 번호
		
		int startNum = (pNum-1)*pageRows +1; //게시물 시작 번호
		int endNum = pNum*pageRows; //게시물 끝 번호
		int totalPages = (int)Math.ceil((double)totalRows/pageRows);//총 페이지수
		int lastBlock = (int)Math.ceil((double)totalPages/blockPages);//마지막 블록 번호
		
		pVO.setStartNum(startNum);
		pVO.setEndNum(endNum);
		pVO.setTotalPages(totalPages);
		pVO.setLastBlock(lastBlock);
		
		return pVO;
	}
}
