package com.human.web.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.human.web.service.NoticeService;
import com.human.web.vo.NoticeVO;
import com.human.web.vo.SearchPageVO;

import lombok.AllArgsConstructor;

@Controller

@AllArgsConstructor
public class NoticeController {

    private NoticeService noticeServiceImpl;

    // 기존의 Notice 메서드와 역할이 중복되었다면 아래 메서드 하나만 남김
    @GetMapping("/")
    public String home(SearchPageVO vo, Model model) {
        // 글목록을 가지고 index.jsp 페이지를 출력되게 함
       

        // 게시글 목록 가져오기
        List<NoticeVO> noticeList = noticeServiceImpl.getNoticeList();
        model.addAttribute("noticeList", noticeList);

        // index.jsp로 반환
        return "index";
    }
    
  //글등록 페이지 요청
  	@GetMapping("/write.do")
  	public String write() {
  		return "notice/notice_write";
  	}

 
	//글등록 요청
	@PostMapping("/writeProcess.do")
	public String writeProcess(NoticeVO vo) {
		//업로드된 파일을 resources/uploads폴더에 저장하기 위해 필요한 request객체를 매개변수로 정의
		
		String viewName = "notice/notice_write";//공지사항 등록 실패시 뷰이름
		
		int result = noticeServiceImpl.insertNotice(vo);
		
		if(result == 1) {//공지사항 등록 성공
			viewName = "redirect:/";//메인 페이지 재요청
		}
		
		return viewName;
	}
}	
		
