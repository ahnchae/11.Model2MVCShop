<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%--
<%@page import="com.model2.mvc.service.domain.Product"%>
<%
	Product product=(Product)request.getAttribute("product");
%>
 --%>
<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="../javascript/calendar.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- jQueryCalendar -->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
			<style>
 		body {
            padding-top : 50px;
        }
     </style>

<script type="text/javascript">

function fncAddProduct(num){
	//Form 유효성 검증
	var name = $('input[name="prodName"]').val()
	var detail = $('input[name="prodDetail"]').val()
	var manuDate =  $('input[name="manuDate"]').val()
	var price =  $('input[name="price"]').val()

	if(name == null || name.length<1){
		alert("상품명은 반드시 입력하여야 합니다.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("상품상세정보는 반드시 입력하여야 합니다.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("제조일자는 반드시 입력하셔야 합니다.");
		return;
	}
	if(price == null || price.length<1){
		alert("가격은 반드시 입력하셔야 합니다.");
		return;
	}
	if(num=='1'){
		$('form').attr("action", "/product/deleteProduct").attr("enctype", "multipart/form-data").submit();
	}else{	
		$('form').attr("method", "POST").attr("action", "/product/updateProduct").attr("enctype", "multipart/form-data").submit();
	}
}


$(function(){
	$('#deleteButton').on("click", function(){
		if(confirm('정말 삭제하시겠습니까? \n삭제된 상품은 복구할 수 없습니다.')){
			fncAddProduct('1');
		}else{
			return;
		}
	})
})

$(function(){
	$('#updateButton').on("click", function(){
		fncAddProduct();
	})
})

$(function(){
	$('#reset').on("click", function(){
		history.go(-1);
	})
})

</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<div class="page-header text-info">
	       <h3>상품등록</h3>
	    </div>
      <!--  table Start /////////////////////////////////////-->
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" value="${product.manuDate}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" value="${product.price}">
		    </div>
		    <span id="helpBlock" class="help-block">
		      	원&nbsp;&nbsp;&nbsp;<small class="text-primary">숫자만 입력해주세요.</small>
		    </span>
		  </div>
		  
		  <div class="form-group">
		    <label for="fileNameForReal" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    <div class="col-sm-4">
		      <input multiple="multiple" type="file" class="form-control" id="fileNameForReal" name="fileNameForReal">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <span class="col-sm-offset-4  col-sm-4 text-center">
		      <button id="deleteButton" type="button" class="btn btn-danger"  >상품 삭제</button>
		      <button id="updateButton" type="button" class="btn btn-primary"  >수 &nbsp;정</button>
		      <button id="reset" type="button" class="btn btn-primary"  >취 &nbsp;소</button>
		    </span>
		  </div>
		  
		  <input type="hidden" name="prodNo" value="${product.prodNo}"/>
		</form>
</div>
</body>
</html>