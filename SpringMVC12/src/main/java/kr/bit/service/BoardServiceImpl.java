package kr.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.Member;
import kr.bit.mapper.BoardMapper;


@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public List<Board> getList(Criteria cri) {
		// 반영할 로직~~~
		List<Board> list=boardMapper.getList(cri);
		return list;
	}

	@Override
	public Member login(String memID) {
		Member mvo=boardMapper.login(memID);
		return mvo;
	}

	@Override
	public void register(Board vo) {
		boardMapper.insertSelectKey(vo);
	}

	@Override
	public Board get(int idx) {
		Board vo=boardMapper.read(idx);
		return vo;
	}

	@Override
	public void modify(Board vo) {
		boardMapper.update(vo);		
	}

	@Override
	public void remove(int idx) {
		boardMapper.delete(idx);		
	}

	@Override
	public void replyProcess(Board vo) {
		// - 답글만들기
		// 1. 부모글(원글)의 모든정보를 가져와서 Board parent만들기 (vo->idx) 
		Board parent=boardMapper.read(vo.getIdx());
		// 2. 부모글의 boardGroup의 값을->답글(vo)정보에 저장하기 0에서 시작 
		vo.setBoardGroup(parent.getBoardGroup());
		// 3. 부모글의 boardSequence의 값을 1을 더해서 ->답글(vo)정보에 저장하기 BoardSequence은 vo의 위치 만들어주기 boardGroup asc, boardSequence asc 로 게시판을 데이티출력 
		vo.setBoardSequence(parent.getBoardSequence()+1);
		// 4. 부모글의 boardLevel의 값을 1을 더해서 ->답글(vo)정보에 저장하기 BoardLevel은 댓글안으로 들어가는 값(부모의 레벨에서 한칸 이동) 
        vo.setBoardLevel(parent.getBoardLevel()+1);
        // 5. 같은 boardGroup에 있는 글 중에서
        //    부모글의 boardSequence보다 큰 값들을 모두 1씩 업데이트하기
		boardMapper.replySeqUpdate(parent); 
		// 6. 답글(vo)을 저정하기 boardSequence으로 오름차순 
		boardMapper.replyInsert(vo);
	}

	@Override
	public int totalCount(Criteria cri) {		
		return boardMapper.totalCount(cri);
	}
	@Override
	public void boardCount(int idx) {//조회수증가
		 boardMapper.boardCount(idx);
	}

	@Override
	public void memupdate(Member vo) {
		boardMapper.memupdate(vo);
	}

	
	@Override
	public void insertmember(Member vo) {
		// TODO Auto-generated method stub 
		boardMapper.insertmember(vo);
	}
	@Override
	public void memdelete(String memId) {
		boardMapper.memdelete(memId);
	}
	@Override
	public List<Member> getmemall(Criteria cri) {
		// 반영할 로직~~~
		List<Member> member=boardMapper.getmemall(cri);
		return member;
	}
	@Override
	public int MembertotalCount() {
		return boardMapper.MembertotalCount();
	}


	@Override
	public Member getMem(String memId) {
		// TODO Auto-generated method stub
		Member mvo= boardMapper.getMem(memId);
		return mvo;
	}

	@Override
	public Member MemCo(Member vo) {
		// TODO Auto-generated method stub
		return null;
	}
}