
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
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
  	$("#search").click(function(){
  		var bookname=$("#bookname").val();
  		if(bookname==""){
  			alert("책 제목을 입력하세요");
  			return false;
  		}
  		// Kakao 책 검색 openAPI를 연동하기(키를발급)
  		// URL :https://dapi.kakao.com/v3/search/book?target=title
  		// H : Authorization: KakaoAK 260bf790c4b9969507dd7511de7de3ba
  		$.ajax({
  			url : "https://dapi.kakao.com/v3/search/book?target=title",
  			headers : {"Authorization": "KakaoAK 260bf790c4b9969507dd7511de7de3ba"},
  			type : "get",
  			data : {"query" : bookname},
  			dataType : "json",
  			success : bookPrint,
  			error : function(){ alert("error");}	
  		});
  		$(document).ajaxStart(function(){ $(".loading-progress").show(); });
  		$(document).ajaxStop(function(){ $(".loading-progress").hide(); });
  	});    	
  	// input box에 책 제목이 입려되면 자동으로 검색을하는 기능
  	$("#bookname").autocomplete({
  		source : function(){ 
  			var bookname=$("#bookname").val();
  			$.ajax({
      			url : "https://dapi.kakao.com/v3/search/book?target=title",
      			headers : {"Authorization": "KakaoAK 259d200e24c8640c7410790f8f22e5a4"},
      			type : "get",
      			data : {"query" : bookname},
      			dataType : "json",
      			success : bookPrint,
      			error : function(){ alert("error");}	
      		});
  		},
  	});  
  	 function bookPrint(data){
  	  	 var bList="<table class='table table-hover'>";
  	  	 bList+="<thead>";
  	  	 bList+="<tr>";
  	  	 bList+="<th>책이미지</th>";
  	  	 bList+="<th>책가격</th>";
  	  	 bList+="<th>출판사</th>";
  	  	 bList+="</tr>";
  	  	 bList+="</thead>";
  	  	 bList+="<tbody>";
  	  	 $.each(data.documents,function(index, obj){
  	  		 var image=obj.thumbnail;
  	  		 var price=obj.price;
  	  		 var url=obj.url;
  	  		 bList+="<tr>";
  	      	 bList+="<td><a href='"+url+"'><img src='"+image+"' width='50px' height='60px'/></a></td>";
  	      	 bList+="<td>"+price+"</td>";
  	  	     bList+="<td>"+obj.publisher+"</td>";
  	      	 bList+="</tr>";
  	  	 }); 
  	  	 bList+="</tbody>";
  	  	 bList+="</table>";
  	  	 $("#bookList").html(bList);
  	   }
})

</script>
<div class="card" style="min-height: 650px;max-height: 700px;">
   <div class="card-body">
   <div class="row">
   <div class="col-lg-12">
     <h4>BOOK SEARCH</h4>
     <div class="input-group mb-3">
             <input type="text" class="form-control" id="bookname" placeholder="Search"/>
             <div class="input-group-append">
             	 <c:if test="${!empty mvo}">
             		  <button type="button" class="btn btn-secondary" id="search">Go</a>             
            	  </c:if>	
             	  <c:if test="${empty mvo}">
             		  <button type="button" disabled="disabled" class="btn btn-secondary" id="search">Go</a>             
             	 </c:if>	
             </div>         
      	 </div>
      
      <div class="loading-progress" style="display: none">
        <div class="spinner-border text-secondary" role="status">
          <span class="sr-only">Loading...</span>
        </div>      
      </div>
      <div id="bookList" style="overflow: scroll; height: 500px; padding: 10px">
         여기에 검색된 책 목록을 출력하세요.
      </div>
   </div>
	</div>
</div>
</div>