package kr.bit.entity;
import lombok.Data;
@Data
public class Criteria {
  private int page; //현재 페이지 번호
  private int perPageNum; // 한페이지에 보여줄 게시글의 수
  // 검색기능에 필요한 변수
  private String type;
  private String keyword;
  public Criteria() {
	  this.page=1;//페이지 기본값 1
	  this.perPageNum=5; // 1페이지에 데이터가 5게   
  }
  // 현재 페이지의 게시글의 시작번호(한페이지에 출력될 데이터의 개수)
  public int getPageStart() {     // 1page  2page  3page
	  return (page-1)*perPageNum; // 0~     5~    10~   : limit ${pageStart},#{perPageNum} 리스트 하나에 데이터 5개씩출력  
  }  
}