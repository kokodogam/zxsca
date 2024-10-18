package com.human.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.human.web.service.MemberService;
import com.human.web.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/member") //공통으로 적용되는 URL 정의
//lombok을 적용해서 생성자를 이용한 의존 자동주입 
@RequiredArgsConstructor
public class MemberController {
	
	//요청을 처리하는데 사용되는 MemberServiceImpl클래스를 의존 자동 주입받음
	//lombok API를 적용한 경우 final 수정자를 추가해줌
	private final MemberService memberServiceImpl;
	
	/* lombok API를 적용하지 않은 경우 : 생성자를 이용한 의존 자동 주입
	  @Autowired
	  public MemberController(MemberService memberServiceImpl){
	  	this.memberServiceImpl = memberServiceImpl;
	  }
	 */
	
	//회원가입 페이지 요청
	@GetMapping("/join.do")
	public String join() {
		//뷰이름과 경로인 memebr/join만 반환하면 ViewResolver가 
		//servlet-context.xml에 정의된 대로 실제 웹페이지 경로와 파일명을 정함
		//: /WEB-INF/views/ + member/join + .jsp => /WEB-INF/views/member/join.jsp 
		return "member/join";
	}
	
	//회원가입 요청
	@PostMapping("/joinProcess.do")
	public String joinProcess(MemberVO vo, Model model) {
		//커맨드 객체: 폼의 입력값 전송을 처리하는 메소드에서 파라미터들을 저장하는데 사용되는 자바 객체
		//- 파라미터 값들을 전달받을 수 있도록 setter메소드를 포함하고 있어야 함
		//- 폼의 name 속성값과 일치하는 필드에 대해 파라미터 값을 저장함
		//- 뷰에서 커맨드 객체를 사용하려면 첫글자를 소문자로 바꾼 클래스명을 참조변수로 사용할 수 있음
		String viewName = "member/join"; //회원가입 실패 시 뷰이름
		
		//MemberServiceImpl클래스를 통해서 요청 처리
		int result = memberServiceImpl.insertMember(vo);
		
		if(result == 1) {//회원가입 성공
			viewName = "redirect:/index.do"; //index.do 재요청
			
		}else {//회원가입 실패
			//안내메시지를 Model객체에 저장함
			model.addAttribute("msg", "회원가입이 정상적으로 이루어지지 않았습니다");
		}
		
		return viewName;
	}
	
	//로그인 페이지 요청
	@GetMapping("/login.do")
	public String login() {

		return "member/login";
	}
	
	//로그인 처리 요청
	@PostMapping("/loginProcess.do")
	public String loginProcess(String member_id, String member_pw,
			HttpServletRequest request, Model model) {
		
		String viewName = "member/login"; //로그인 실패시 뷰이름
		
		MemberVO vo = memberServiceImpl.login(member_id, member_pw);
		
		//로그인 성공여부를 vo객체에 저장된 값으로 판단
		if(vo != null) {//로그인 성공
			//세션객체에 회원정보를 저장함(request객체의 getSession()메소드 이용)
			HttpSession session = request.getSession();
			session.setAttribute("member", vo);
			viewName = "redirect:/index.do";//메인 페이지 재요청
			
		}else {//로그인 실패
			model.addAttribute("msg", "아이디나 비밀번호가 일치하지 않습니다");
		}
		
		return viewName;
	}
	
	
	//로그아웃 요청
	@GetMapping("logout.do")
	public String logout(HttpServletRequest request) {
		//세션객체를 초기화 시킴(request객체의 getSession()메소드 이용해서 세션객체 얻음)
		HttpSession session = request.getSession();
		session.invalidate();
		
		return "redirect:/index.do";				
	}
	
	
	//회원정보 변경 페이지 요청
	@GetMapping("/update.do")
	public String update() {
		return "member/update";
	}
	
	//회원정보 변경 처리 요청
	@PostMapping("/updateProcess.do")
	public String updateProcess(MemberVO vo, HttpServletRequest request, Model model) {
		
		String viewName = "member/update"; //회원정보변경 실패시 뷰이름
		
		MemberVO newVo = memberServiceImpl.updateMember(vo);
		 
		//회원정보변경 성공여부를 newVo객체에 저장된 값으로 판단
		if(newVo != null) {//회원정보변경 성공
			//세션객체에 저장된 기존의 회원정보를 삭제하고 새로운 회원정보를 저장함
			//(request객체의 getSession()메소드 이용)
			HttpSession session = request.getSession();
			session.removeAttribute("member");
			session.setAttribute("member", newVo);
			viewName = "redirect:/index.do";//메인 페이지 재요청
			
		}else {//회원정보변경 실패
			model.addAttribute("msg", "회원정보 변경시 오류가 발생했습니다. 변경내용을 확인해 주세요");
		}
		
		return viewName;
	}
	
	
	//회원탈퇴 요청
	@GetMapping("cancelProcess.do")
	public String cancelProcess(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MemberVO vo = (MemberVO)session.getAttribute("member");
		int m_idx = vo.getM_idx();
		
		int result = memberServiceImpl.cancel(m_idx);
		
		String viewName = "member/update";//회원탈퇴 실패시 뷰이름
		
		if(result == 1) {//회원탈퇴 성공
			session.invalidate();//세션 초기화
			viewName = "redirect:/index.do";
			
		}else {//회원탈퇴 실패
			String msg = "시스템에 오류가 발생했습니다. 빠른 시일 내에 시스템을 정상화하도록 하겠습니다.";
			model.addAttribute("msg", msg);
		}
		
		return viewName;
	}
	
	
	
	
	
	
	
	
	
	
}
