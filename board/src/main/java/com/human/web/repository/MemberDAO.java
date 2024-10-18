package com.human.web.repository;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.human.web.vo.MemberVO;

import lombok.AllArgsConstructor;

@Repository //DB와 관련된 작업을 하는 클래스에 붙여줌
@AllArgsConstructor
public class MemberDAO{
	
	//MyBatis의 sqlSession객체를 이용해서 DBCP 이용
	//sqlSession객체를 필드로 정의 
	//lombok API를 이용한 의존 자동주입: 생성자 방식
	private SqlSession sqlSession;
	
	//비밀번호 암호화 관련 객체 의존자동주입 받기
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	//MyBatis의 Mapper를 이용하기 위해 사용되는 상수 정의
	public static final String MAPPER = "com.human.web.mapper.MemberMapper";
	
	//아이디 중복검사: ajax통신
	public int checkId(String member_id) {
		int result = 0;//중복된 아이디가 없는 경우 결과값
		
		try {
			result = sqlSession.selectOne(MAPPER+".checkId", member_id);//1:조회된 데이터의 첫번째 컬럼
		} catch (Exception e) {
			System.out.println("아이디 중복검사 중 예외 발생");
		}
		
		return result;
	}
		
	//회원가입
	public int insertMember(MemberVO vo) {
		int result = 0;//입력 실패 시 결과값
		
		try {
			result = sqlSession.insert(MAPPER+".insertMember", vo);
		} catch (Exception e) {
			System.out.println("회원가입 중 예외 발생");
			e.printStackTrace();
		} 
		
		return result;
	}

//	//로그인(비밀번호 암호화 전)
//	public MemberVO login(Map<String, String> map) {
//		MemberVO vo = null;//로그인 실패시 결과값
//		try {
//			vo = sqlSession.selectOne(MAPPER+".login", map);
//		} catch (Exception e) {
//			System.out.println("로그인 중 예외발생");
//		}
//		
//		return vo;
//	}
	//로그인(비밀번호 암호화 후)
	public MemberVO login(Map<String, String> map) {
		MemberVO vo = null;//로그인 실패시 결과값
		try {
			
			//아이디를 이용해서 회원이 비밀번호를 가져와서 비밀번호의 일치여부를 확인한 후
			//아이디에 대한 회원정보를 MemberVO 객체로 반환하도록 변경함 
			String encodePassword = sqlSession.selectOne(MAPPER+".getPassword", map.get("member_id"));
			boolean flag = bCryptPasswordEncoder.matches(map.get("member_pw"), encodePassword);
			if(flag) {//비밀번호가 일치하는 경우
				vo = sqlSession.selectOne(MAPPER+".login", map.get("member_id"));
			}
			
			
			
		} catch (Exception e) {
			System.out.println("로그인 중 예외발생");
			e.printStackTrace();
		}
		
		return vo;
	}

	public int updateMember(MemberVO vo) {
		int result = 0; //회원정보변경 실패시 결과값
		
		try {
			result = sqlSession.update(MAPPER+".updateMember", vo);
		} catch (Exception e) {
			System.out.println("회원정보 변경 중 예외발생");
			e.printStackTrace();
			
		}
		
		return result;
	}

	//회원정보 조회
	public MemberVO getMember(int m_idx) {
		MemberVO vo = null;//회원정보 조회 실패시 결과값
		
		try {
			
			vo = sqlSession.selectOne(MAPPER+".getMember", m_idx);
			
		} catch (Exception e) {
			System.out.println("회원정보 조회 중 예외발생");
		}
		
		return vo;
	}

	//회원탈퇴
	public int cancel(int m_idx) {
		int result = 0;//회원탈퇴 실패시 결과값
		
		try {
			
			result = sqlSession.update(MAPPER+".cancel", m_idx);
			
		} catch (Exception e) {
			System.out.println("회원탈퇴 중 예외발생");
		}
		
		return result;
	}

	
	
	
	

}
