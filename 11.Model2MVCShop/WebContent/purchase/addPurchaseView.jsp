<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>

<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- jQueryCalendar -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	

	<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <!-- jQuery UI toolTip ��� JS-->
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    


<script type="text/javascript">

function fncAddPurchase() {
	$('form').attr("method", "POST").attr("action", "/purchase/addPurchase?prodNo=${product.prodNo}&buyerId=${user.userId}").submit();
}

$(function(){
	$('#divyDate').datepicker({
		dateFormat: 'yy-mm-dd'
	})
})

$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#reset").on("click" , function() {
				$("form")[0].reset();
			});
			
			$("#addPurchase").on("click" , function() {
				fncAddPurchase();
			});
});
		
$(function(){
	
	$('input[type="checkbox"][name="couponPrice"]').on("click", function(){
		console.log($('input[type="checkbox"][name="couponPrice"]').is(":checked"))
		console.log($('#originalPrice'))
		if($('input[type="checkbox"][name="couponPrice"]').is(":checked")){
			$('#originalPrice').empty()
			$('small.text-primary').text("���ε� �����Դϴ�.")
		}else{
			$('#originalPrice').html('${product.price}<br><hr>')
			$('small.text-primary').text("��ǰ�� ���� �����Դϴ�.")
		}
	})
	
	
})



</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		<form  name="addPurchase" class="form-horizontal">
		<div class="page-header text-info">
	       <h3>�����ϱ�</h3>
	    </div>
		
		<!-- form Start /////////////////////////////////////-->

		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
		    <div class="col-sm-4">
		      <u id="prodName" name="prodNo">${product.prodNo}</u>
		    </div>
		  </div>
		 <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		    <div class="col-sm-4">
		      <u id="prodName" name="prodName">${product.prodName}</u>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    <div class="col-sm-4">
		      <u id="prodDetail" name="prodDetail" >${product.prodDetail}</u>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4">
		      <u id="manuDate" name="manuDate">${product.manuDate}</u>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">
		      <u id="originalPrice" name="price">${product.price}<br><hr></u>		
		     	 <c:if test="${user.coupon.discountCoupon10=='1'}">
					10% ���������� �����մϱ�?<input type="checkbox" name="couponPrice"/> 
				<fmt:parseNumber var="price" value="${product.price*0.9}" integerOnly="true" />
				<br>���� ����� ����: ${price}
				</c:if>
			  
		    </div>
		    <span id="helpBlock" class="help-block">
		      	��&nbsp;&nbsp;&nbsp;<small class="text-primary">��ǰ�� ���� �����Դϴ�.</small>
		    </span>
		  </div>
		  
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
		    <div class="col-sm-4">
		      <select id="paymentOption" name="paymentOption" class="form-control">
				<option value="1" selected="selected">���ݱ���</option>
				<option value="2">�ſ뱸��</option>
			  </select>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="receiverName" value="${user.userName}" />
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">����ó</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="receiverPhone" value="${user.phone}" />
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">�����ּ�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="divyAddr" value="${user.addr}" />
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="divyRequest" />
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyDate" name="divyDate" placeholder="ex) 2019-05-22">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button id="addPurchase" type="button" class="btn btn-primary"  >����</button>
		      <button id="reset" type="button" class="btn btn-primary"  >���</button>
		    </div>
		  </div>
		  
		</form>
		<!-- form end /////////////////////////////////////-->
	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->


</body>
</html>