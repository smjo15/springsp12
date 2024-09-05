
package kr.bit.service;

import java.util.List;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.Member;

public interface BoardService {
	public List<Board> getList(Criteria cri);
	public Member login(String memID);//로그인확인
	public Member MemCo(Member vo);//로그인확인
	public Member getMem(String memId);
	public void register(Board vo);//등록
	public Board get(int idx);//상세 
	public void modify(Board vo);
	public void remove(int idx);
	public void replyProcess(Board vo);
	public int totalCount(Criteria cri);
	public int MembertotalCount( );
	public void boardCount(int idx);//조회수
	public void memupdate(Member vo);
	public void insertmember(Member vo);
	public void memdelete(String memId);
	public List<Member> getmemall(Criteria cri);
}