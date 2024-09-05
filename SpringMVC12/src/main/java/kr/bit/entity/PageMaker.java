package kr.bit.entity;

import lombok.Data;

// 페이징 처리를 만드는 클래스(vo)
@Data
public class PageMaker {
  private Criteria cri;//현제보는 페이지, 페이지에 출력될 데이터개수 
  private int totalCount; // 총게시글의 수 
  private int startPage; // 시작페이지번호
  private int endPage; // 끝페이지번호(조정이 되어야 한다)1
  private boolean prev; // 이전버튼(true, false)
  private boolean next; // 다음버튼(true, false)
  private int displayPageNum=5; // 1 2 3 4 5 6 7 8 9 10 페이지개수 
  // 총게시글의 수를 구하는 메서드
  public void setTotalCount(int totalCount) { 
	  this.totalCount=totalCount;//서비스에서가져옴 
	  makePaging();
  }  
  private void makePaging(){
	// 1.화면에 보여질 마지막 페이지 번호
	endPage=(int)(Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum);//displayPageNum 으로 cri에서 고정 
	// 2.화면에 보여질 시작 페이지 번호
	startPage=(endPage-displayPageNum)+1;//5-5+1  마지막페이지-출력페이지수 
	if(startPage<=0) startPage=1;
	// 3.전체 마지막 페이지 계산
	int tempEndPage=(int)(Math.ceil(totalCount/(double)cri.getPerPageNum()));//총리스트개수/ 페이지수=실제 페이지개수 
	// 4.화면에 보여질 마지막 페이지 유효성 체크
	if(tempEndPage<endPage) {//실제 페이지수 하고 마지막페이지 비교  
		endPage=tempEndPage;		
	}
	// 5.이전페이지 버튼(링크)존재 여부
	prev=(startPage==1) ? false : true;
	// 6.다음페이지 버튼(링크)존재 여부
	next=(endPage<tempEndPage)? true : false;
  }
}