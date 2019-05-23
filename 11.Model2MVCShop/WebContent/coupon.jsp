<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

<title>쿠폰 등록</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('input[value="등록"]').on("click", function(){
			console.log($('input[name="couponId"]').val())
			var inputCouponId = $('input[name="couponId"]').val();
			$.ajax({
				url : "/user/json/addCoupon?couponId="+inputCouponId+"",
				method : "GET",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData, status){
					//alert(status);
					alert("JSONData : \n"+JSONData);
					//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
					//alert( JSONData != null );
					if(JSONData.message=="ok"){
						//alert("사용 가능한 아이디입니다.")
						$('h5').html("쿠폰이 발급되었습니다.<br> 중복 발급되지 않습니다.<br><br>");
					}else if(JSONData.message=="no good"){
						$('h5').html("알맞지 않은 쿠폰 번호입니다.<br> 다시 입력해주세요.<br><br>");
					}
				}
			})
		})
	})

</script>
</head>
<form name="detailForm" method="post" action="/user/addCoupon">
<body>
	쿠폰 번호를 등록하세요
<br>
<br>
<c:if test="${user.coupon!=null && user.coupon.discountCoupon10=='1' }">
<h5>쿠폰이 발급되었습니다.<br> 중복 발급되지 않습니다.<br><br></h5>
</c:if>
<c:if test="${user.coupon==null}">
<h5>등록된 쿠폰이 없습니다.<br> 쿠폰 번호를 입력해주세요.<br><br></h5>
</c:if>
<input type="text" name="couponId"> <input type="button" value="등록">
</body>
</form>

</html>