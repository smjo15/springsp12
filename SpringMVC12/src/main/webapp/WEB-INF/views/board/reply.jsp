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
    	$("button").on("click", function(e){
    		var formData=$("#frm");
    		var btn=$(this).data("btn");
    		if(btn=='reply'){//@Postmapping 리스트로 리다이렉트어트리뷰트로 파라미터전달 
    			formData.attr("action", "${cpath}/board/reply");//
    			formData.submit();
    		}else if(btn=='list'){//리스트로   
    			formData.attr("action", "${cpath}/board/list");    		   
    			formData.attr("method","get");
    			formData.submit();   
    			return;
    		}else if(btn=='reset'){
    			formData[0].reset();
    			return;
    		}		
    	});    	
    });
  </script>
</head>
<body>
  <div class="card">
    <div class="card-header">
	    <div class="jumbotron jumbotron-fluid">
		  <div class="container">
		    <h1>Spring Framework~~</h1>
		    <p>카카오api게시판만들기</p>
		  </div>
		</div>
    </div>
    <div class="card-body">
		<div class="row">
		  <div class="col-lg-2">
		    <jsp:include jsp="left.jsp"/>
		  </div>
	<div class="col-lg-7">
		<form id="frm" method="post"> 
		  <!--list로 갈떄 포스트 매핑으로-->	
          <input type="hidden" name="page" value="<c:out value='${cri.page}'/>"/>
          <input type="hidden" name="perPageNum" value="<c:out value='${cri.perPageNum}'/>"/>          
          <input type="hidden" name="type" value="<c:out value='${cri.type}'/>"/>
          <input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>"/>
          <!--  idx(원글,부모글) boardparent생성할때사용 memID replyInsert.xml에서 사용  -->
          <input type="hidden" name="idx" value="${vo.idx}" id="idx"/>         
          <input type="hidden" name="memID" value="${mvo.memID}" id="memID"/>
          <div class="form-group">
             <label>제목</label>
             <input type="text" name="title" class="form-control" value="<c:out value='${vo.title}'/>">
          </div>
          <div class="form-group">
             <label>답변</label>
             <textarea rows="10" name="content" class="form-control"></textarea>
          </div>
       <div class="form-group">
             <label>작성자</label>
             <!-- ${mvo}세센으로 받아옴 -->
             <input type="text" readonly="readonly" name="writer" class="form-control" value="${vo.writer}">
       </div>
       <div align="center">
          <button type="button" data-btn="reply" class="btn btn-secondary btn-sm">답변</button>
          <button type="button" data-btn="list" class="btn btn-secondary btn-sm">목록</button>
		  <button type="button" data-btn="reset" class="btn btn-secondary btn-sm">취소</button>	
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
</html>

