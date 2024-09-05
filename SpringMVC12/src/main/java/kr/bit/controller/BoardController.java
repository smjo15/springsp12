package kr.bit.controller;

import java.util.List;

import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.PageMaker;
import kr.bit.service.BoardService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller  // POJO
@RequestMapping("/board/")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	@RequestMapping("/list")
	public String getList(Criteria cri, Model model,RedirectAttributes rttr) { // type, keyword
		List<Board> list=boardService.getList(cri);
		// 객체바인딩
		model.addAttribute("list", list); // Model
		// 페이징 처리에 필요한 부분
		PageMaker pageMaker=new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.totalCount(cri));//totalCount=boardService.totalCount(cri)페이지계산 
		model.addAttribute("pageMaker", pageMaker);		  
		return "board/list" ; // View
 	}
	@GetMapping("/register")//등록폼으로
	public String register() {
		return "board/register";
	}
	@PostMapping("/register")//글쓰기기능 
	public String register(Board vo, RedirectAttributes rttr) { // 파라메터수집(vo)<-- 한글인코딩
		if(vo.getTitle()==null||vo.getTitle().equals("")) {
			rttr.addFlashAttribute("head","글작성");
			rttr.addFlashAttribute("message","글제목을 입력해주세요");
			return "redirect:/board/register";
		}
		else if(vo.getContent()==null||vo.getContent().equals("")) {
			rttr.addFlashAttribute("head","글작성");
			rttr.addFlashAttribute("message","글내용을 입력해주세요");
			return "redirect:/board/register";
		}
		else {//등록성공
		boardService.register(vo); //게시물등록(vo->idx, boardGroup)
		rttr.addFlashAttribute("head","글작성");
		rttr.addFlashAttribute("message",vo.getIdx()+"번 게시물이 추가되었습니다");
		return "redirect:/board/list ";
			}
	}
	@GetMapping("/get")//상세화면 매핑에 {idx}로 들오어면 @PathVariable으로 받아주고 매핑이 아닌경우는 @RequestParam으로받아옴
	public String get(int idx, Model model,Criteria cri) {
		boardService.boardCount(idx);//상세 조회수증가 ${vo.count}증가 update boradcount =boardcount +1 = idx={idx}
		Board vo=boardService.get(idx);
		model.addAttribute("cri", cri);
		model.addAttribute("vo", vo);						
		return "board/get"; //WEB-INF/views/board/get.jsp -> ${cri.page}
	}
	@GetMapping("/modify")//수정폼으로
	public String modify(@RequestParam int idx, Model model,Criteria cri) {
		Board vo=boardService.get(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("cri",cri);
		return "board/modify"; // /WEB-INF/views/board/modify.jsp
	}
	@PostMapping("/modify")
	public String modify(Board vo, Criteria cri , RedirectAttributes rttr,int idx) {
		if(vo.getContent()==null || vo.getContent()==("") || vo.getTitle()==null||vo.getTitle()==("")) {
			rttr.addFlashAttribute("head","글수정");
			rttr.addFlashAttribute("message","모든값을 입력해주세요");
			return "redirect:/board/modify";
		}
		boardService.modify(vo); //수정	
		//리다이텍트할떄 가져가는 파라미터
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());		
		//모달부분 
		rttr.addFlashAttribute("head", "글수정");//모달로 데이터 전송 
		rttr.addFlashAttribute("message",vo.getIdx()+"번 게시물이 수정되었습니다");
		return "redirect:/board/list";  // ?page=2&perPageNum=5 
	}
	@GetMapping("/remove")
	public String remove(Board vo , int idx, Criteria cri, RedirectAttributes rttr) {
		boardService.remove(idx);
		//리다이텍트할떄 가져가는 파라미터
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		//모달부분 
		rttr.addFlashAttribute("head","글삭제");
		rttr.addFlashAttribute("message",vo.getIdx()+"번 게시물이 삭제되었습니다");
		return "redirect:/board/list"; // ?page=2&perPageNum=5?type=''?keyword="" 
	}
	@GetMapping("/reply")//댓글상세 화면으로 
	public String reply(int idx, Model model, Criteria cri) {
		Board vo=boardService.get(idx);
		model.addAttribute("cri", cri);
		model.addAttribute("vo", vo);//{vo}을 모델링하여 전달 reply.jsp에서 ${vo.객채명}으로 받음 ${empty }
		return "board/reply"; // /WEB-INF/views/board/reply.jsp
	}
	@PostMapping("/reply")
	public String reply(Board vo, Criteria cri, RedirectAttributes rttr) {
		// 답글에 필요한 처리
		if(vo.getContent()==null || vo.getContent()==("") || vo.getTitle()==null||vo.getTitle()==("")) {
			rttr.addAttribute("page", cri.getPage());
			rttr.addAttribute("perPageNum", cri.getPerPageNum());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());	
			rttr.addFlashAttribute("head","답글작성");
			rttr.addFlashAttribute("message","모든내용을 입력해주세요");
			return "redirect:/board/reply";// /WEB-INF/views/board/reply.jsp
		}	
		boardService.replyProcess(vo); // 답글 저장됨 답글의 보드그룹부분자동생성 
		//리다이텍트할떄 가져가는 파라미터
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());		
		rttr.addFlashAttribute("head","답글작성");
		rttr.addFlashAttribute("message",vo.getWriter()+"님의 답글작성이 완료되었습니다.");
		return "redirect:/board/list";		
		}
}