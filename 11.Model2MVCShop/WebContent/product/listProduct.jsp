<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="EUC-KR">
<title>��ǰ �����ȸ</title>

<!-- jQuery autoComplete -->
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
<!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>


<!-- jQuery UI toolTip ��� CSS-->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery UI toolTip ��� JS-->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
body {
	padding-top: 50px;
}
</style>

<script type="text/javascript">
	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage);
		var uri = "/product/listProduct?menu=${param.menu}";
		uri = $("form").attr("method", "POST").attr("action", uri);
		uri.submit();
	}

	$(function() {
		
////////////////�˻���ư ������ �� start...
		$('button.btn-block:contains("�˻�"),input[value="prodNo"],input[value="priceASC"],input[value="priceDESC"]').on(						"click",
						function() {
							$("#currentPage").val('1');
							var uri = "/product/listProduct?menu=${param.menu}";
							$("form").attr("method", "POST")
									.attr("action", uri).submit();
						})
////////////////�˻���ư ������ �� end...

///////////////��ǰ �������� ajax start...
		$(".ct_list_pop td:nth-child(3)")
				.on(
						"click",
						function() {
							var prodNo = $(this).next('td').next('td').next(
									'td').next('td').text().trim();
							//var uri = "/product/getProduct?prodNo="+prodNo+"&menu=search";
							var tran = $(this).next('td').next('td').next('td')
									.next('td').next('td').next('td').text()
									.trim();
							if ('${param.menu}' == 'manage' && tran == '�Ǹ���') {
								uri = "/product/getProduct?prodNo=" + prodNo
										+ "&menu=manage";
								self.location = uri;
							} else {
								if ($("#" + prodNo + "").html().length != 0) {
									$("#" + prodNo + "").empty();
								} else {
									$
											.ajax({
												url : "/product/json/getProduct/"
														+ prodNo,
												method : "GET",
												dataType : "json",
												headers : {
													"Accept" : "application/json",
													"Content-Type" : "application/json"
												},
												success : function(JSONData,
														status) {
													//alert(status);
													//alert("JSONData : \n"+JSONData);

													var displayValue = "<h3>"
															+ "��ǰ��ȣ: "
															+ JSONData.prodNo
															+ "<br>"
															+ "��ǰ��: "
															+ JSONData.prodName
															+ "<br>"
															+ "�� ����: "
															+ JSONData.prodDetail
															+ "<br>";
													if (JSONData.fileNames != null) {
														displayValue += "��ǰ �̹���:<br>"
														console
																.log(JSONData.fileNames);
														for ( var i in JSONData.fileNames) {
															console
																	.log(JSONData.fileNames[i])
															displayValue += "<img src='../images/uploadFiles/"+JSONData.fileNames[i]+"' width='500'/><br/>"
														}
													} else {
														displayValue += "��ǰ �̹���:<img src='../images/uploadFiles/"+JSONData.fileName+"' width='500'/>"
													}

													displayValue += "����: "
															+ JSONData.price
															+ "<br>" + "������: "
															+ JSONData.manuDate
															+ "<br>" + "�����: "
															+ JSONData.regDate
															+ "<br>" + "<hr>";
													if (JSONData.proTranCode == '1  ') {
														displayValue += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='/purchase/addPurchase?prodNo="
																+ JSONData.prodNo
																+ "'>"
																+ JSONData.prodName
																+ " �����ϱ�</a>"
													}
													displayValue += "</h3>"
													$("#" + prodNo + "").html(
															displayValue);
												},
												error : function(jqXHR) {
													alert("url:"
															+ "/product/json/getProduct/"
															+ prodNo)
													alert("error:"
															+ jqXHR.status);
												}
											})
								}
							}

						})
///////////////��ǰ �������� ajax start...

///////autoComplete start...
		$('input[name="searchKeyword"]').on("keyup", function() {
			//alert("success");
			var searchKeyword = $(this).val();
			var searchCondition = $('select[name=searchCondition]').val();
			//console.log("searchKeyword:"+searchKeyword+"\nsearchCondition:"+searchCondition);
			$.ajax({
				url : "/product/json/autoCompleteUser",
				method : "POST",
				data : JSON.stringify({
					"searchKeyword" : searchKeyword,
					"searchCondition" : searchCondition
				}),
				dataType : "text",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData, status) {

					//Debug...
					//alert(status);
					//Debug...
					//alert("JSONData : \n"+JSONData);
					//alert("list : \n"+JSON.stringify(JSONData))
					var jsonarr = $.parseJSON(JSONData);
					//alert("jsonarr:\n"+jsonarr)
					//var autoC = jsonarr;
					//alert("autoC : \n"+autoC);

					$('input[name="searchKeyword"]').autocomplete({
						source : jsonarr
					});
				}
			})
		})
/////////autoComplete end...

////////param.menu==manage �� �� ����ϱ� start...
		$('#deliver').on(
				"click",
				function() {
					var prodNo = $($(this).next('span').html()).val();
					console.log(prodNo);
					location = "/purchase/updateTranCodeByProd?prodNo="
							+ prodNo + "&tranCode=3"
				})
				
////////param.menu==manage �� �� ����ϱ� end...

///////Ÿ��Ʋ ������ �� reload start...
	$('h3').on("click", function(){
		location="/product/listProduct?menu=${param.menu}"
	})
///////Ÿ��Ʋ ������ �� reload end...
	})

</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">

		<div class="page-header text-info">
			<c:if test="${!empty param.menu && param.menu=='manage'}">
				<h3>��ǰ����</h3>
			</c:if>
			<c:if test="${!empty param.menu && param.menu=='search'}">
				<h3>��ǰ ��� ��ȸ</h3>
			</c:if>
		</div>
		<div class="row">
		<form class="form-inline">
			<div class="col-md-3 text-left">
				<p class="text-primary">��ü ${resultPage.totalCount } �Ǽ�, ����
					${resultPage.currentPage} ������</p>
	
					<div class="panel panel-default">
						<div class="panel-heading" style="height: 50px;">
							<h5 align="justify">���ı���</h5>
						</div>
						<div class="panel-body" style="height: 90px; padding: 10">
							<input type=radio name="sorting" value="prodNo"
								${empty search.sorting || (!empty search.sorting && search.sorting=='prodNo') ? "checked" : ""}>��ǰ��ȣ<br>
							<input type=radio name="sorting" value="priceASC"
								${!empty search.sorting && search.sorting=='priceASC' ? "checked" : ""}>���ݳ�����<br>
							<input type=radio name="sorting" value="priceDESC"
								${!empty search.sorting && search.sorting=='priceDESC' ? "checked" : ""}>���ݳ�����<br>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">��������</h3>
						</div>
						<div class="panel-body">
							<input style="width: 160px" class="form-control inline"
								type="text" name="searchKeyword1"
								value="${search.searchKeyword1!=0 ? search.searchKeyword1 : ''}">��
							~ <input style="width: 160px" class="form-control" type="text"
								name="searchKeyword2"
								value="${search.searchKeyword2!=0 ? search.searchKeyword2 : ''}">��
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="glyphicon glyphicon-remove"></i>�˻�����
							</h3>
						</div>
						<div class="panel-body">
							<select name="searchCondition" class="form-control"
								style="width: 160px">
								<option value="0"
									${!empty search.searchCondition && search.searchCondition=='0' ? "selected" : ""}>��ǰ��ȣ</option>
								<option value="1"
									${!empty search.searchCondition && search.searchCondition=='1' ? "selected" : ""}>��ǰ��</option>
								<option value="3"
									${!empty search.searchCondition && search.searchCondition=='3'? "selected" : ""}>�Ǹ���</option>
								<c:if test="${user.role=='admin'}">
								<option value="4"
										${!empty search.searchCondition && search.searchCondition=='4'? "selected" : ""}>���ſϷ�</option>
								<option value="5"
										${!empty search.searchCondition && search.searchCondition=='5'? "selected" : ""}>�����</option>
								<option value="6"
										${!empty search.searchCondition && search.searchCondition=='6'? "selected" : ""}>��ۿϷ�</option>
								</c:if>
							</select> <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"
								placeholder="�˻� Ű���带 �Է��ϼ���." style="width: 230px" value="${!empty search.searchKeyword ? search.searchKeyword : ''}">

						</div>
					</div>
					
					<button type="button" class="btn btn-primary btn-block">�˻�</button>
				</div>
				<input type="hidden" id="currentPage" name="currentPage" value="" />
			</form>

			<div class="col-md-9">

				<table class="table table-hover table-striped">

					<thead>
						<tr>
							<th align="center">No</th>
							<th align="left">��ǰ��</th>
							<th align="left">����</th>
							<th align="left">��ǰ ��ȣ</th>
							<th align="left">���� ����</th>
							<th align="left">��ǰ �̹���</th>
						</tr>
					</thead>

					<tbody>

						<c:set var="i" value="0" />
						<c:forEach var="product" items="${list}">
							<c:set var="i" value="${ i+1 }" />
							<tr>
								<td align="center">${ i }</td>
								<td align="left" title="Click : ��ǰ ������">${product.prodName}</td>
								<td align="left">${product.price}</td>
								<td align="left">${product.prodNo}</td>
								<td align="left"><c:choose>
										<c:when test="${product.proTranCode=='1  '}">
					�Ǹ���
					</c:when>
										<c:when
											test="${product.proTranCode=='2  '&& user.role=='admin'}">
					���� �Ϸ�
						<c:if test="${param.menu=='manage'}">
												<span id="deliver">����ϱ�</span>
												<span><input type="hidden" value=${product.prodNo}></span>
											</c:if>
										</c:when>
										<c:when
											test="${product.proTranCode=='3  '&& user.role=='admin'}">
					�����
					</c:when>
										<c:when
											test="${product.proTranCode=='4  '&& user.role=='admin'}">
					��� �Ϸ�
					</c:when>
										<c:otherwise>
					��� ����
					</c:otherwise>
									</c:choose></td>
								<td align="left"><c:if
										test="${empty product.fileNames && !empty product.fileName}">
										<p>
											<img src="../images/uploadFiles/${product.fileName}"
												width="100" height="100" />
										</p>
										<%--${product.fileName} --%>
									</c:if> <c:if test="${!empty product.fileNames}">
										<p>
											<img src="../images/uploadFiles/${product.fileNames[0]}"
												width="100" height="100" />
										</p>
										<%--${product.fileName} --%>
									</c:if> <c:if test="${empty product.fileName}">
										<p>
											<img src="http://placehold.it/100x100" />
										</p>
									</c:if></td>
							</tr>
						</c:forEach>

					</tbody>

				</table>

			</div>
		</div>
	</div>

	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp" />
	<!-- PageNavigation End... -->

	</form>

	</div>
</body>
</html>