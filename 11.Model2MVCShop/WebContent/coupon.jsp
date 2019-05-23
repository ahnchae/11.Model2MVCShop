<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

<title>���� ���</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('input[value="���"]').on("click", function(){
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
						//alert("��� ������ ���̵��Դϴ�.")
						$('h5').html("������ �߱޵Ǿ����ϴ�.<br> �ߺ� �߱޵��� �ʽ��ϴ�.<br><br>");
					}else if(JSONData.message=="no good"){
						$('h5').html("�˸��� ���� ���� ��ȣ�Դϴ�.<br> �ٽ� �Է����ּ���.<br><br>");
					}
				}
			})
		})
	})

</script>
</head>
<form name="detailForm" method="post" action="/user/addCoupon">
<body>
	���� ��ȣ�� ����ϼ���
<br>
<br>
<c:if test="${user.coupon!=null && user.coupon.discountCoupon10=='1' }">
<h5>������ �߱޵Ǿ����ϴ�.<br> �ߺ� �߱޵��� �ʽ��ϴ�.<br><br></h5>
</c:if>
<c:if test="${user.coupon==null}">
<h5>��ϵ� ������ �����ϴ�.<br> ���� ��ȣ�� �Է����ּ���.<br><br></h5>
</c:if>
<input type="text" name="couponId"> <input type="button" value="���">
</body>
</form>

</html>