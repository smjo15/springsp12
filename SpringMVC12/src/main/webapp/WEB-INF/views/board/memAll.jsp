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
  })
  </script>
<style>
.move{
	cursor: auto;
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
					<table class="table table-hover">
						<thead>
							<tr>
								<th>회원번호</th>		
								<th>아이디</th>							
								<th>비밀번호</th>
								<th>고객이름</th>
							    <th>가입일</th>
							</tr>
						</thead>
					<c:forEach var="vo" items="${member}">
							<tr class="dataRow">																
								<td><a class="move" href="${cpath}/login/memupdate?memId=${mvo.memID}"><c:out value='${vo.meidx}' /></a></td>
								<td>${vo.memID}</td>
								<td>${vo.memPwd}</td>
								<td>${vo.memName}</td>
								<td>${vo.date}</td>
							</tr>
					</c:forEach>						
       			 </tr>																											
					</table>
			<div class="d-grid gap-2 d-md-block">
			<c:if test="${!empty mvo}">
			<button type="button" class="btn btn-primary btn-lg" onClick="location.href='${cpath}/login/memupdate?memId=${mvo.memID}'">정보수정</button>
			<button type="button" class="btn btn-primary btn-lg"  onClick= "location.href='${cpath}/login/delete?memId=${mvo.memID}'"; >회원탈퇴</button>
			</div>	
			</c:if>
				<!-- 페이징 START -->
					<ul class="pagination justify-content-center">
						<!-- 이전처리 -->
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous page-item"><a class="page-link" href="${cpath}/login?page=${pageMaker.startPage-1}">Previous</a></li>
						</c:if>
						<!-- 페이지번호 처리 -->
						<c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="paginate_button ${pageMaker.cri.page==pageNum ? 'active' : ''} page-item"><a class="page-link" href="${cpath}/login?page=${pageNum}">${pageNum}</a></li>
						</c:forEach>
						<!-- 다음처리 -->
						<c:if test="${pageMaker.next}">
							<li class="paginate_button next page-item"><a class="page-link" href="${cpath}/login?page=${pageMaker.endPage+1}">Next</a></li>
						</c:if>
					</ul>			
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