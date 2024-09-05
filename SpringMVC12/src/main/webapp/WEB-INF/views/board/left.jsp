<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a98f72dc32457bc77b826311c2353c3e"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js" ></script>

 <script type="text/javascript">
 $(document).ready(function(){ 	
	 // 책 검색 버튼이 클릭 되었을때 처리 책감색은 소문자 search	
	  	// 지도 mapBtn 클릭시 지도가 보이도록 하기
	  	$("#mapBtn").click(function(){
	  		var address=$("#address").val();
	  		if(address==''){
	  			alert("주소를 입력하세요");
	  			return false;
	  		}
	  		$.ajax({
	  			url : "https://dapi.kakao.com/v2/local/search/address.json",
	  			headers : {"Authorization": "KakaoAK 259d200e24c8640c7410790f8f22e5a4"},
	  			type : "get",
	  			data : {"query" : address},
	  			dataType : "json",
	  			success : mapView,
	  			error : function() { alert("error"); }  			
	  		});
	  	});  
 }); 
   function mapView(data){
	 var x=data.documents[0].x; // 경도
	 var y=data.documents[0].y; // 위도
  	 var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
  	    mapOption = { 
  	        center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
  	        level: 2 // 지도의 확대 레벨
  	    };
  	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
  	var map = new kakao.maps.Map(mapContainer, mapOption); 
  	// 마커가 표시될 위치입니다 
  	var markerPosition  = new kakao.maps.LatLng(y, x); 
  	// 마커를 생성합니다
  	var marker = new kakao.maps.Marker({
  	    position: markerPosition
  	});
     
  	// 마커가 지도 위에 표시되도록 설정합니다
  	marker.setMap(map);
  	// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
  	var iwContent = '<div style="padding:5px;">${mvo.memName}</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
  	    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
  	// 인포윈도우를 생성합니다
  	var infowindow = new kakao.maps.InfoWindow({
  	    content : iwContent,
  	    removable : iwRemoveable
  	});
  	// 마커에 클릭이벤트를 등록합니다
  	kakao.maps.event.addListener(marker, 'click', function() {
  	      // 마커 위에 인포윈도우를 표시합니다
  	      infowindow.open(map, marker);  
  	});
   }
   
</script>
<div class="card" style="min-height: 650px; max-height: 700px;">
	<div class="row">
		<div class="col-lg-12">
			<div class="card-body">
			<!-- 로그인시 -->
				<c:if test="${empty mvo}">
					<h4 class="card-title">GUEST</h4>
					<p class="card-text">회원님 Welcome!</p>
					<form action="${cpath}/login/loginProcess" method="post">
						<div class="form-group">
							<label for="memID">아이디:</label> 
							<input type="text"class="form-control" name="memID" id="memID"  value="" >
						</div>
						<div class="form-group">
							<label for="memPwd">비밀번호:</label> 
							<input type="password" class="form-control" name="memPwd" id="memPwd">
						</div>
						<span id="error" style="color: red"></span>
						<button type="submit" class="btn btn-primary form-control" id="logbutton" >로그인</button>
						 <button type="button" class="btn btn-primary form-control" onClick="location.href='${cpath}/login/memreg'">회원가입</button>
						<button type='button' class='btn btn-primary form-control' id='kakao' onClick="alert();" >카카오로그인</button>
				</form>
				</c:if>
				<c:if test="${!empty mvo}">
					<h4 class="card-title">${mvo.memName}</h4>
					<p class="card-text">${mvo.memName}님 Welcome!</p>
					<form action="${cpath}/login/logoutProcess" method="post">
					<button type="submit" class="btn btn-primary form-control" id="logout">로그아웃</button>
					<button type="button" class="btn btn-primary form-control"  id="Memlist"onClick= "location.href='${cpath}/login/all'">회원목록</button>
					<button type='button' class='btn btn-primary form-control' id='list' onClick= "location.href='${cpath}/board/list'">글목록</button>
					</form>
				</c:if>
			</div>
		</div>
		<div class="col-lg-12">
			<div class="card-body">
				<p class="card-text">MAP VIEW</p>
				<div class="input-group mb-3">
					<input type="text" class="form-control" id="address" placeholder="Search" />
				<div class="input-group-append">
					<c:if test="${empty mvo}">
						<button type="button" disabled="disabled" class="btn btn-secondary" id="mapBtn">Go</button>
					</c:if>
					<c:if test="${!empty mvo}">
						<button type="button" class="btn btn-secondary" id="mapBtn">Go</button>
					</c:if>
				</div>	
				</div>
					<div id="map" style="width: 100%; height: 200px;"></div>
			</div>
		</div>
	</div>
</div>