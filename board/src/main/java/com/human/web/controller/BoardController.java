package com.human.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.human.web.service.BoardService;
import com.human.web.vo.BoardVO;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/board")
@AllArgsConstructor
public class BoardController {
	
	//일반게시판 요청 처리를 위한 객체 정의(lombok에 의한 의존자동주입: 생성자 이용)
	private BoardService boardServiceImpl;
	
	//글등록 페이지 요청
	@GetMapping("/write.do")
	public String write() {
		return "board/write";
	}
	
	//글등록 요청
	@PostMapping("/writeProcess.do")
	public String writeProcess(BoardVO vo) {
		String viewName = "board/write";//글등록 실패시 뷰이름
		
		int result = boardServiceImpl.insertBoard(vo);
		if(result ==1) {//글등록 성공
			viewName = "redirect:/index.do"; //메인 페이지 재요청
		}
		
		return viewName;
	}
	
	//상세보기 페이지 요청
	@GetMapping("/view.do")
	public String view(int b_idx, Model model) {
		//조회수 증가시키기
		boardServiceImpl.updateReadCount(b_idx);
		//상세페이지 정보를 저장하고 있는 BoardVO 객체 얻기
		BoardVO vo =boardServiceImpl.getBoard(b_idx);
		model.addAttribute("boardVO", vo);
		return "board/view";
	}
	
	//수정 페이지 요청
	@GetMapping("/update.do")
	public String update(int b_idx, Model model) {
		//상세페이지 정보를 저장하고 있는 BoardVO 객체 얻기
		BoardVO vo =boardServiceImpl.getBoard(b_idx);
		model.addAttribute("boardVO", vo);
		return "board/update";
	}
	
	//글수정 요청
		@PostMapping("/updateProcess.do")
		public String updateBoard(BoardVO vo, Model model) {
			String viewName = "board/update";//글수정 실패시 뷰이름
			
			int result = boardServiceImpl.updateBoard(vo);
			if(result ==1) {//글등록 성공
				//viewName = "redirect:/index.do"; //메인 페이지 재요청
				
				//board/view 를 뷰이름으로 반환하는 경우
				//게시글에 대한 변경된 내용을 BoardVO객체에 저장해서 Model객체에 추가함
				BoardVO newVo = boardServiceImpl.getBoard(vo.getB_idx());
				model.addAttribute("boardVO", newVo);
				viewName = "board/view";
				
			}
			
			return viewName;
		}
		
		//글삭제 요청
		@GetMapping("deleteProcess.do")
		public String deleteProcess(int b_idx) {
			String viewName = "board/view"; //글삭제 실패시 뷰이름
			int result = boardServiceImpl.deleteBoard(b_idx);
			if(result == 1) {//글삭제 성공
				viewName = "redirect:/index.do";
				
			}
			return viewName;
		}

}
