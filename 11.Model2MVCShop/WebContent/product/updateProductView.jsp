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
<title>��ǰ��������</title>

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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
</script>

<script type="text/javascript">

function fncAddProduct(num){
	//Form ��ȿ�� ����
	var name = $('input[name="prodName"]').val()
	var detail = $('input[name="prodDetail"]').val()
	var manuDate =  $('input[name="manuDate"]').val()
	var price =  $('input[name="price"]').val()

	if(name == null || name.length<1){
		alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(price == null || price.length<1){
		alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(num=='1'){
		$('form').attr("action", "/product/deleteProduct").attr("enctype", "multipart/form-data").submit();
	}else{	
		$('form').attr("action", "/product/updateProduct").attr("enctype", "multipart/form-data").submit();
	}
}


$(function(){
	$('#deleteButton').on("click", function(){
		if(confirm('���� �����Ͻðڽ��ϱ�? \n������ ��ǰ�� ������ �� �����ϴ�.')){
			fncAddProduct('1');
		}else{
			return;
		}
	})
})

$(function(){
	$('updateButton').on("click", function(){
		fncAddProduct();
	})
})

$(function(){
	$('td.ct_btn01:contains("���")').on("click", function(){
		history.go(-1);
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
		<div class="page-header text-info">
	       <h3>��ǰ���</h3>
	    </div>
      <!--  table Start /////////////////////////////////////-->
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" value="${product.manuDate}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" value="${product.price}">
		    </div>
		    <span id="helpBlock" class="help-block">
		      	��&nbsp;&nbsp;&nbsp;<small class="text-primary">���ڸ� �Է����ּ���.</small>
		    </span>
		  </div>
		  
		  <div class="form-group">
		    <label for="fileNameForReal" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
		    <div class="col-sm-4">
		      <input multiple="multiple" type="file" class="form-control" id="fileNameForReal" name="fileNameForReal">
		    </div>
		  </div>
		  
		  <div class="form-group">
		  	<div class="col-sm-offset-4  col-sm-4 text-left">
		      <button id="deleteButton" type="button" class="btn btn-primary"  >��ǰ ����</button>
		    </div>
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button id="updateButton" type="button" class="btn btn-primary"  >�� &nbsp;��</button>
		      <button id="reset" type="button" class="btn btn-primary"  >�� &nbsp;��</button>
		    </div>
		  </div>
		</form>
</div>
</body>
</html>