<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/style.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a98f72dc32457bc77b826311c2353c3e"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js" ></script>
<script type="text/javascript" >
  $(document).ready(function(){ 	 
	  if(${!empty message}){
		$("#myModal").modal("show");	
	  }  	
  	$("#regBtn").on("click",function(){
  		location.href="${cpath}/board/register";
  	});  	
  	//페이지 번호 클릭시 이동 하기
  	//히든폼가져오기
  	var pageFrm=$("#pageFrm");
  	$(".page-link").on("click", function(e){
  		e.preventDefault(); // a tag의 기능을 막는 부분
  		var page=$(this).attr("href"); //페이지번호찾기 
  		$("#page").val(page);//id=page의 값에 page를 주입  
  		pageFrm.submit(); // /sp08/board/list   		
  	});    	
  	// 상세보기 클릭시 이동 하기 idx값 추가해주기 (상세화면이동)
  	$(".move").on("click", function(e){ 	
  		e.preventDefault(); // a tag의 기능을 막는 부분 				   
  		var idx =$(this).attr("href");
  		cosole.log(idx);
  		var tag="<input type='hidden' name='idx' value='"+idx+"'/>";
  		pageFrm.append(tag);
  		pageFrm.attr("action","${cpath}/board/get");//get매핑에대한url경로
  		pageFrm.attr("method","get");//get 타입 
  		pageFrm.submit();		
  	});
  })
  </script>
<style>
.dataRow {
	cursor:auto; 
}
</style>
</head>
<body> 
	<div class="card">
		<div class="card-header">
			<div class="jumbotron jumbotron-fluid">
				<div class="container">
					<h1>전자정부프레임워크 게시판만들기</h1>
					<p>카카오api게시판만들기</p>
				</div>
			</div>
		</div>
		<div class="card-body">
			<div class="row">
				<div class="col-lg-2">
					<jsp:include page="left.jsp" />
				</div>
				<div class="col-lg-7">
					<table class="table table-hover" id="tableId">
						<thead>
							<tr>
								<th>번호</th>							
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<c:forEach var="vo" items="${list}">
							<tr class="dataRow">								
								<td>${vo.idx}</td>
								<!--댓글시작  -->
								<td>
								<!--댓글이 입력될떄마다 들여쓰기  boardAvailable=0 삭제 boardSequence최근에 작성한글 위로올리기 boardGroup끼리묵기--> 
									<c:if test="${vo.boardLevel>=1}">
										<c:forEach begin="1" end="${vo.boardLevel}">
											<span style="padding-left: 15px"></span>
										</c:forEach>
										<i class="bi bi-arrow-return-right"></i><!--화살표  -->
									</c:if> 
								<!--댓글이 입력될떄마다 들여쓰기  boardLevel=1 댓글 =0 댓글x   boardSequence최근에 작성한글 위로올리기 boardGroup끼리묵기--> 			
									<c:if test="${vo.boardLevel>=1}"> 
										<c:if test="${vo.boardAvailable==1}">
											<a class="move" href="${vo.idx}"><c:out value='[RE]${vo.title}'/></a>
										</c:if>
										<c:if test="${vo.boardAvailable==0}">
											<a href="javascript:goMsg()">[RE]삭제된 게시물입니다.</a>
										</c:if>
									</c:if> 
									<c:if test="${vo.boardLevel==0}">
										<c:if test="${vo.boardAvailable==1}">
											<a class="move" href="${vo.idx}"><c:out value='${vo.title}' /></a>
										</c:if>
										<c:if test="${vo.boardAvailable==0}">
											<a href="javascript:goMsg()">삭제된 게시물입니다.</a>
										</c:if>
									</c:if>
								</td>
								<!-- 댓글끝 -->
								<td>${vo.writer}</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.indate}"/></td>
								<td>${vo.count}</td>
							</tr>
					</c:forEach>						
       			 </tr>																					
						<!-- 로그인시 -->
						<c:if test="${!empty mvo}">							
								<td colspan="6">
									<button id="regBtn" class="btn btn-sm btn-secondary pull-right">글쓰기</button>
								</td>
						</c:if>
					</table>
					<!-- 검색메뉴 -->
					<form class="form-inline" >
						<div class="container">
							<div class="input-group mb-3">
								<div class="input-group-append">
								<select name="type" class="form-control">
										<option value="title"${pageMaker.cri.type=='title' ? 'selected' : ''}>제목</option>			
										<option value="writer" ${pageMaker.cri.type=='writer' ? 'selected' : ''}>이름</option>
										<option value="content"	${pageMaker.cri.type=='content' ? 'selected' : ''}>내용</option>
									</select>
								</div>
								<input type="text" class="form-control" name="keyword"value="${pageMaker.cri.keyword}" id="keyword">
								<div class="input-group-append">
									<c:if test="${empty mvo}">
										<button disabled="disabled"class="btn btn-success" type="submit" id="keywordbtn">검색</button>
									</c:if>
									<c:if test="${!empty mvo}">
										<button class="btn btn-success" type="submit" id="keywordbtn">검색</button>
									</c:if>					
								</div>
							</div>
						</div>
					</form>
					<!-- 페이징 START -->
					<ul class="pagination justify-content-center">
						<!-- 이전처리 -->
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous page-item"><a class="page-link" href="${pageMaker.startPage-1}">Previous</a></li>
						</c:if>
						<!-- 페이지번호 처리 -->
						<c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class="paginate_button ${pageMaker.cri.page==pageNum ? 'active' : ''} page-item"><a class="page-link" href="${pageNum}">${pageNum}</a></li>
						</c:forEach>
						<!-- 다음처리 -->
						<c:if test="${pageMaker.next}">
							<li class="paginate_button next page-item"><a class="page-link" href="${pageMaker.endPage+1}">Next</a></li>
						</c:if>
					</ul>
					<!-- END -->
					<form id="pageFrm" action="${cpath}/board/list" method="post">
						<!-- 상세로갈떄게시물 번호(idx)추가 -->
							<input type="hidden" id="page" name="page" value="${pageMaker.cri.page}" /> 
							<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}" /> 
							<input type="hidden" name="type" value="${pageMaker.cri.type}" /> 
							<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
					</form>
					<!-- Modal 추가 -->
					<div id="myModal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title">${head}</h4>
									<button type="button" class="close" data-dismiss="modal">&times;</button>
								</div>
								<div class="modal-body">${message}</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>
					<!-- Modal END -->
				</div>
				<div class="col-lg-3">
					<jsp:include page="right.jsp" />
				</div>
			</div>
		</div>
		<div class="card-footer">카카오api게시판만들기</div>
	</div>
</body>
</html>