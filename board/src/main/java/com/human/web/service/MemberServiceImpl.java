package com.human.web.service;

import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.human.web.repository.MemberDAO;
import com.human.web.vo.MemberVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	//요청을 처리하기 위해서 MemberDAO 클래스를 필드로 정의
	//생성자 방식으로 의존 자동 주입을 받을 수 있도록 함(lombok적용)
	private final MemberDAO dao;
	
	//메일인증 관련 메일전송 객체 의존자둥주입 받기
	private JavaMailSenderImpl mailSender;
	
	//비밀번호 암호화 관련 객체 의존자동주입 받기
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	/*lombok API를 이용하지 않는 의존 자동 주입 요청: 생성자 방식
	@Autowired
	public MemberServiceImpl(MemberDAO dao) {
		this.dao = dao;
	}*/

	//아이디 중복검사
	@Override
	public int checkId(String member_id) {
		return dao.checkId(member_id);
	}
	
	//회원가입
	@Override
	public int insertMember(MemberVO vo) {
		
		//비밀번호 암호화 관련 구문 추가
		
		//사용자가 입력한 비밀번호
		String rawPassword = vo.getMember_pw();
		
		//비밀번호 암호화 객체를 이용해서 암호화한 비밀번호
		String encodePassword = bCryptPasswordEncoder.encode(rawPassword);
		System.out.println("암호화된 비밀번호: "+encodePassword);
		
		//암호화 전 비밀번호의 암호화 후 비밀번호가 일치하는지 확인
		System.out.println("암호화 전 비밀번호와 암호화 후 비밀번호의 일치여부: "+bCryptPasswordEncoder.matches(rawPassword, encodePassword));
		
		//암호화된 비밀번호를 MemberVO에 세팅하기
		vo.setMember_pw(encodePassword);
		
		return dao.insertMember(vo);
	}

	//로그인
	@Override
	public MemberVO login(String member_id, String member_pw) {
		//MyBatis의 SQL문에서 입력값을 2개로 넣을 수 없으므로
		//Map객체를 생성하고 거기에 저장해서 SQL문으로 전달함
		Map<String, String> map = new HashMap<>();
		map.put("member_id", member_id);
		map.put("member_pw", member_pw);
		
		return dao.login(map);
	}

//	//회원정보 변경(비밀번호 암호화 전)
//	@Override
//	public MemberVO updateMember(MemberVO vo) {
//		MemberVO newVo = null; //회원정보 변경 실패시 결과값
//		
//		if(dao.updateMember(vo) == 1) {
//			newVo = dao.getMember(vo.getM_idx());
//		}
//		
//		return newVo;
//	}
	
	//회원정보 변경(비밀번호 암호화 후)
		@Override
		public MemberVO updateMember(MemberVO vo) {
			MemberVO newVo = null; //회원정보 변경 실패시 결과값
			
			//비밀번호 암호화 후 MemberVO 객체에 세팅하기
			String rawPassword = vo.getMember_pw();
			String encodePassword = bCryptPasswordEncoder.encode(rawPassword);
			vo.setMember_pw(encodePassword);
			
			if(dao.updateMember(vo) == 1) {//회원정보 변경 성공
				newVo = dao.getMember(vo.getM_idx());
			}
			
			return newVo;
		}

	//회원탈퇴
	@Override
	public int cancel(int m_idx) {
		return dao.cancel(m_idx);
	}

	
	//메일인증
	@Override
	public String authEmail(String email) {
		//메일인증 코드 6자리 생성하기: Math.random() (111111 <= r < 1000000)
		int authNumber = (int)(Math.random()*888889)+111111;
		
		String setFrom = "kokodogam20@gmail.com"; //송신자의 메일주소
		String toMail = email;//수신자의 메일주소
		String title = "회원가입 인증 메일입니다";//제목
		String content = "홈페이지를 방문해주셔서 감사합니다. <br><br>"
				+ "인증번호: "+authNumber+"<br>"
				+ "해당 인증번호를 인증번호 확인란에 입력해 주세요";
		mailSend(setFrom, toMail, title, content);
		return Integer.toString(authNumber);
	}
	
	//이메일 전송 메소드
	private void mailSend(String setFrom, String toMail, String title, String content) {
		MimeMessage message = mailSender.createMimeMessage();
		
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			//true: multipart 형식의 메시지 전달
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true); //true: html형식으로 전송, true를 입력하지 않으면 text로 전송
			mailSender.send(message);
			
		} catch (Exception e) {
			System.out.println("메일전송 중 예외발생");
			e.printStackTrace();
		}
		
	}


}
