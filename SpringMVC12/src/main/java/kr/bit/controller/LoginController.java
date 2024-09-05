package kr.bit.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.bit.entity.Criteria;
import kr.bit.entity.Member;
import kr.bit.entity.PageMaker;
import kr.bit.service.BoardService;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/login")
public class LoginController {

	@Autowired
	BoardService boardService;

	@RequestMapping("/loginProcess")
	public String login(Member vo, HttpSession session,RedirectAttributes red, String memPwd ,String memID ) {			
		int size=vo.getMemID().length();
		int pwdsize=vo.getMemPwd().length();
		Member mvo=boardService.login(memID);
		System.out.println(memPwd);
		System.out.println(mvo.getMemPwd());
		if(vo.getMemID()==null||vo.getMemID().equals("")||vo.getMemPwd()==null||vo.getMemPwd().equals("")){
			red.addFlashAttribute("head","로그인실패");
			red.addFlashAttribute("message"," 아이디또는 비밀번호를 입력해주세요");
		}
		else if(size<=4) {
			red.addFlashAttribute("head","로그인실패");
			red.addFlashAttribute("message","아이디는 5글자이상입니다");
		}
		else if(pwdsize<=4) {
			red.addFlashAttribute("head","로그인실패");
			red.addFlashAttribute("message","비밀번호는는 5글자이상입니다");
		}
		else if(mvo.getMemPwd()!= memPwd) {// 비밓번호 불일치 
			red.addFlashAttribute("head","로그인실패");
			red.addFlashAttribute("message","비밀번호를 다시 확인해주세요");
		}
	if(mvo!=null) {
		session.setAttribute("mvo", mvo); // 객체바인딩 -> ${!empty mvo}
		log.info("로그인"+mvo);
		red.addFlashAttribute("head","로그인성공");
		red.addFlashAttribute("message",mvo.getMemName()+"님 로그인에 성공하였습니다");	
			}
		return "redirect:/board/list";
	};
	@RequestMapping("/logoutProcess")
	public String logout(HttpSession session,RedirectAttributes red,Member mvo, String memId ) {
		session.invalidate(); // 세션 무효화(로그아웃) 
		boardService.memdelete(memId);
		red.addFlashAttribute("head","로그아웃");//${head}
		red.addFlashAttribute("message","로그아웃되었습니다");
		return "redirect:/board/list";
	}
	@GetMapping("/memreg")//글쓰시 폼으로 가기 
	public String memreg(Model model,Member vo,HttpSession session) {		
		return"board/memreg"; 	
	}
	@PostMapping("/memreg")
	public Object memregpost(Member vo, Model model,HttpSession session,RedirectAttributes red,String memID) {		
		int size=vo.getMemID().length();	
		int pwdsize=vo.getMemPwd().length();
		int Stringsize=vo.getMemName().length();
		if(size<=4) {
			red.addFlashAttribute("head","회원가입실패");
			red.addFlashAttribute("message","아이디는 5글자이상입니다");
			return"redirect:/login/memreg";
		}
		else if(pwdsize<=4) {
			red.addFlashAttribute("head","회원가입실패");
			red.addFlashAttribute("message","비밀번호는 5글자이상입니다");
			return"redirect:/login/memreg";
		}
		else if(Stringsize<=4) {
			red.addFlashAttribute("head","회원가입실패");
			red.addFlashAttribute("message","회원이름는 5글자이상입니다");
			return"redirect:/login/memreg";
		}
		//회원목록추가
		boardService.insertmember(vo);	
		Member mvo=boardService.login(memID);
		if(mvo!=null) {
				session.setAttribute("mvo", mvo); // 객체바인딩 -> ${!empty mvo}
				log.info("로그인"+mvo);
				red.addFlashAttribute("head","회원가입성공");
				red.addFlashAttribute("message",mvo.getMemName()+"님 회원가입에 성공하였습니다");
			return "redirect:/board/list"; 	
			}
		return "redirect:/";
	}
	@GetMapping("/memupdate")
	public String memupdate(Model model,Member vo,HttpSession session, String memId) {		
		Member mvo=boardService.getMem(memId);
		model.addAttribute("mvo", mvo);
		return"board/memupdate"; 	
	}
	@PostMapping("/memupdate")
	public String memupdatepost(Model model,Member vo,HttpSession session,RedirectAttributes red , String memId) {	
		boardService.memupdate(vo);
		Member vo1=boardService.getMem(memId);
		session.setAttribute("mvo", vo1);
		red.addFlashAttribute("head","회원수정성공");
		red.addFlashAttribute("message","회원수정처리되었습니다");	
		return "redirect:/board/list"; 	
	}
	@GetMapping("/delete")
		public String deletemem(Model model,Member vo,HttpSession session,RedirectAttributes red, String memId ) {	
		boardService.memdelete(memId);
		session.invalidate();
		log.info("회원탈퇴");
		red.addFlashAttribute("head","회원탈퇴성공");
		red.addFlashAttribute("message","회원탈퇴퇴었습니다");
		return "redirect:/board/list";  	
	}
	@GetMapping("/all")
	public String all(Model model,Criteria cri,Member member1) {
		List<Member> member=boardService.getmemall(cri);
		model.addAttribute("member",member);
		PageMaker pageMaker=new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.MembertotalCount());//totalCount=boardService.totalCount(cri)
		model.addAttribute("pageMaker", pageMaker);		
		return"board/memAll"; 		
	}		
		
}	