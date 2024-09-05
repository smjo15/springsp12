<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<!--get에서 modify로올떄 idx값을 들고옴  -->
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
    	$("button").click(function(e){
    		var formData=$("#frm");    
    		var btn=$(this).data("btn"); // data-btn="list"                
    		if(btn=='modify'){
    			formData.attr("action", "${cpath}/board/modify");//Post컨트롤러로매핑
    			formData.submit();    	
    		}else if(btn=='remove'){
    			formData.attr("action", "${cpath}/board/remove");
    			formData.attr("method", "get");
    			formData.submit();    	
    		}else if(btn=='list'){
    			formData.attr("action", "${cpath}/board/list");//목록으로 돌아가기 
    			formData.attr("method", "get")
    			formData.submit();    	
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
		    <jsp:include page="left.jsp"/>
		  </div>
	  <div class="col-lg-7">
		 <form id="frm" method="post">
	      <table class="table table-bordered">
	         <tr>
	          <td>번호</td>
	          <td><input type="text" class="form-control" name="idx"  value="${vo.idx}"/></td>
	         </tr>
	         <tr>
	          <td>제목</td>
	          <td><input type="text" class="form-control" name="title" value='<c:out value="${vo.title}"></c:out>'/></td>          
	         </tr>
	         <tr>
	          <td>내용</td>
	          <td><textarea rows="10" class="form-control" name="content"><c:out value='${vo.content}'/></textarea> </td>
	         </tr>
	         <tr>
	          <td>작성자</td>
	          <td><input type="text" class="form-control" name="writer"  readonly="readonly" value="${vo.writer}"/></td>
	         </tr>
	         <tr>
	           <td colspan="2" style="text-align: center;">
	           	<!--널체크 and 회원아이다하고 작성자 아이디 체크  -->
	              <c:if test="${!empty mvo && mvo.memID eq vo.memID}">
	                <button type="button" data-btn="modify" class="btn btn-sm btn-primary">수정</button>
	                <button type="button" data-btn="remove" class="btn btn-sm btn-warning">삭제</button> 
	              </c:if>
	              <c:if test="${empty mvo || mvo.memID ne vo.memID}">
	                <button disabled="disabled" type="button" class="btn btn-sm btn-primary">수정</button>
	                <button disabled="disabled" type="button" class="btn btn-sm btn-warning">삭제</button> 
	              </c:if>
	              <button type="button" data-btn="list" class="btn btn-sm btn-info">목록</button>
	           </td>
        	 </tr>
      </table>	
      	  <!--리스트로갈떄 가지고가는 파리미터  -->	
      	  <input type="hidden" id="idx" name="idx" value="<c:out value='${vo.idx}'/>"/> 
          <input type="hidden" name="page" value="<c:out value='${cri.page}'/>"/>
          <input type="hidden" name="perPageNum" value="<c:out value='${cri.perPageNum}'/>"/>
          <input type="hidden" name="type" value="<c:out value='${cri.type}'/>"/>
          <input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>"/>
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