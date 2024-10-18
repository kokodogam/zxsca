package com.human.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.human.web.service.NoticeService;
import com.human.web.vo.BoardVO;
import com.human.web.vo.NoticeVO;
import com.human.web.vo.SearchPageVO;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/notice_board")
@AllArgsConstructor
public class NoticeController {
	
	//일반게시판 요청 처리를 위한 객체 정의(lombok에 의한 의존자동주입: 생성자 이용)
	private NoticeService noticeServiceImpl;
	
	//글등록 페이지 요청
	@GetMapping("/write.do")
	public String write() {
		return "notice_board/notice_write";
	}
	
	//글등록 요청
	@PostMapping("/writeProcess.do")
	public String writeProcess(NoticeVO vo, HttpServletRequest request) {
		//업로드된 파일을 resources/uploads폴더에 저장하기 위해 필요한 request객체를 매개변수로 정의
		
		String viewName = "notice_board/notice_write";//글등록 실패시 뷰이름
		
		int result = noticeServiceImpl.insertNotice(vo, request);
		
		if(result ==1) {//공지사항 등록 성공
			viewName = "redirect:/index.do"; //메인 페이지 재요청
		}
		
		return viewName;
	}
	
	//공지사항 상세보기 페이지 요청
	@GetMapping("/view.do")
	public String view(int nb_idx, Model model) {
		String viewName = "index"; //상세보기 실패시 뷰이름
		
		//조회수 증가시키기
		noticeServiceImpl.updateReadCount(nb_idx);
		//상세페이지 정보를 저장하고 있는 NoticeVO 객체 얻기
		NoticeVO vo =noticeServiceImpl.getNotice(nb_idx);
		if(vo != null) {
			model.addAttribute("noticeVO", vo);
			viewName = "notice_board/notice_view"; //상세보기 성공시 뷰이름
		}
		return viewName;
	}
		
	
	//다운로드 요청
	@GetMapping("/download.do")
	public void download(String origin_filename, String save_filename,
			HttpServletRequest request, HttpServletResponse response) {
		//request: 파일의 실제 경로를 알아내는데 사용됨
		//response: 파일을 출력하는데 사용됨
		
		noticeServiceImpl.download(origin_filename, save_filename, request, response);
	}
	
	//공지사항 수정 페이지 요청
	@GetMapping("/update.do")
	public String update(int nb_idx, Model model) {
		String viewName = "notice_board/notice_view";//실패시 뷰이름
		
		NoticeVO vo = noticeServiceImpl.getNotice(nb_idx);
		
		if(vo != null) {
			model.addAttribute("noticeVO", vo);
			viewName = "notice_board/notice_update";
		}
		
		
		return viewName;
	}
	
	//글삭제 요청
	@GetMapping("deleteProcess.do")
	public String deleteProcess(int nb_idx) {
		String viewName = "notice_board/view"; //글삭제 실패시 뷰이름
		int result = noticeServiceImpl.deleteNotice(nb_idx);
		if(result == 1) {//글삭제 성공
			viewName = "redirect:/index.do";
			
		}
		return viewName;
	}
	
	
}