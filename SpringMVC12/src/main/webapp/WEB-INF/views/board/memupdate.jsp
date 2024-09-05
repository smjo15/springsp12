<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="${cpath}/resources/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <script type="text/javascript">
 $(document).ready(function(){ 
 	 if(${!empty message}){
		$("#myModal").modal("show");	  
  	} 
 });		 
  </script>
  
  <style>
        
  </style>
</head>
<body>

  <div class="card">
    <div class="card-header">
	    <div class="jumbotron">
		  <div class="container">
		    <h1 class="animate">Spring Framework~~</h1>
		    <p>카카오api게시판만들기</p>
		  </div>
		</div>
    </div>
    <div class="card-body">
		<div class="row">
		  <div class="col-lg-2">
		   	 <jsp:include page="left.jsp"/>
		  </div>
	 <div class="col-lg-7">
		<form action="${cpath}/login/memupdate?memId=${mvo.memID}" method="post">
          <input type="hidden" name="memID"id="memID" value="${mvo.memID}">
          <div class="form-group">
             <label>아이디</label>
             <input type="text" name="memID" class="form-control"  id="memID" value="${mvo.memID}">
          </div>
          <div class="form-group">
             <label>비밀번호</label>
             <input name="memPwd" id="memPwd" class="form-control" value="${mvo.memPwd}">
          </div>
           <div class="form-group">
             <label>회원이름</label>
             <input name="memName" class="form-control" value="${mvo.memName}">
          </div>             
      	<span id="error" style="color: red"></span>
        <div align="center">
          <button type="reset" class="btn btn-secondary btn-sm">취소</button>
          <button type="submit" class="btn btn-secondary btn-sm btn-info" id="memreg">회원정보수정</button>
          <button type="button" class="btn btn-secondary btn-sm btn-info"  onclick="location.href='${cpath}/login';">목록</button>	
       </div>
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
		    <jsp:include page="right.jsp"/>
		  </div>
		</div>
    </div> 
    <div class="card-footer">인프런_스프2탄_박매일</div>
  </div>
</body>