package com.human.web.controller;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.human.web.service.BoardService;
import com.human.web.service.NoticeService;
import com.human.web.util.PagingManager;
import com.human.web.vo.BoardVO;
import com.human.web.vo.NoticeVO;
import com.human.web.vo.PagingVO;
import com.human.web.vo.SearchPageVO;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class HomeController {
	
	//게시판 관련해서 요청을 처리할 수 있는 객체 정의
	private BoardService boardServiceImpl; //일반 게시판
	private NoticeService noticeServiceImpl; //공지사항 게시판
	private PagingManager pagingManager;
	private PagingVO pagingVO;
	
	//기타 요청URL에 대한 처리 메소드
	@GetMapping("/")
	public String home(@ModelAttribute("spVO") SearchPageVO vo, Model model) {
		//글목록을 가지고 index.jsp 페이지를 출력되게 함
		//게시글 목록을 Model객체에 저장
		//검색과 페이징 관련 파라미터를 SearchPageVo객체에 저장함
		//@ModelAttribute(참조변수명): 커멘드객체를 View 페이지에서 사용할 때 사용할 수 있는 참조변수명 정의
		
		//게시글 조회시 시작번호를 정할 때 사용
		if(vo.getPageNum() == 0) {
			vo.setPageNum(1);
		}
		
		List<BoardVO> boardList = boardServiceImpl.getBoardList();
		model.addAttribute("boardList", boardList);
		
		//공지사항 목록을 Model객체에 저장
		List<NoticeVO> noticeList = noticeServiceImpl.getNoticeList(vo);
	
		model.addAttribute("noticeList", noticeList);
		
		//페이징 처리를 위해 PageManager클래스를 이용해서 PagingVO에 값을 세팅하고 Model에 저장
		//PagingManager, PagingVO 클래스를 필드에 정의해서 의존 자동 주입 받음
		pagingVO.setTotalRows(noticeServiceImpl.getTotalRows(vo));
		PagingVO pVO = pagingManager.setPagingVO(pagingVO, vo.getPageNum(), vo.getBlockNum());
		model.addAttribute("pagingVO", pVO);
					
		return "index";
	}
	
	@GetMapping("/index.do")
	public String index(@ModelAttribute("spVO") SearchPageVO vo, Model model) {
		//글목록을 가지고 index.jsp 페이지를 출력되게 함
		//게시글 목록을 Model객체에 저장
		
		//게시글 조회시 시작번호를 정할 때 사용
		if(vo.getPageNum() == 0) {
			vo.setPageNum(1);
		}
		
		List<BoardVO> boardList = boardServiceImpl.getBoardList();
		model.addAttribute("boardList", boardList);
		
		//공지사항 목록을 Model객체에 저장
		List<NoticeVO> noticeList = noticeServiceImpl.getNoticeList(vo);
		model.addAttribute("noticeList", noticeList);
		
		//페이징 처리를 위해 PageManager클래스를 이용해서 PagingVO에 값을 세팅하고 Model에 저장
		//PagingManager, PagingVO 클래스를 필드에 정의해서 의존 자동 주입 받음
		pagingVO.setTotalRows(noticeServiceImpl.getTotalRows(vo));
		PagingVO pVO = pagingManager.setPagingVO(pagingVO, vo.getPageNum(), vo.getBlockNum());
		model.addAttribute("pagingVO", pVO);
		
		return "index";
	}

	
	@GetMapping("/error/error500.do")
	public String error500(Exception e, HttpServletRequest request, Model model) {
		
		//예외 정보 구성
		model.addAttribute("time", Calendar.getInstance().getTime()); //예외 발생 시간
		model.addAttribute("url", request.getServletPath()); //예외 발생 URL
		model.addAttribute("message", e.getMessage()); //예외 메시지
		//예외 상세내용
		StringWriter sw = new StringWriter();
		PrintWriter pw = new PrintWriter(sw);
		e.printStackTrace(pw); //스택 트레이스를 PrintWriter로 출력
		String stackTrace = sw.toString(); //문자열로 변환
		model.addAttribute("stackTrace", stackTrace);
		
		return "error/error";
	}
	
}
