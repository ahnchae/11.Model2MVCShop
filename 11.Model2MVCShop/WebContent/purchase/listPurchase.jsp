<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%--
<%@page import="com.model2.mvc.common.util.CommonUtil"%>
<%@page import="com.model2.mvc.common.Search"%>
<%@page import="com.model2.mvc.common.Page"%>
<%@page import="com.model2.mvc.service.domain.Purchase"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%
	List<Purchase> list= (List<Purchase>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");
	
	Search search = (Search)request.getAttribute("search");
	//==> null �� ""(nullString)���� ����
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
%>
--%>

<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage);
	   	$('form[name=detailForm]').attr("method", "POST").attr("action", "/purchase/listPurchase").submit();		
	}
	
	$(function(){
		$('.ct_list_pop td:nth-child(1)').on("click", function(){
			var tranNo = $($(this).next('td').html()).val();
			//location="/purchase/getPurchase?tranNo="+tranNo;
			
			if($( "#"+tranNo+"" ).html().length!=0){
				$( "#"+tranNo+"" ).empty();
			}else{$.ajax({
				url:"/purchase/json/getPurchase/"+tranNo,
				method:"POST",
				dataType:"json",
				headers:{
					"Accept" : "application/json",
					"Content-Type":"application/json"
				},
				success: function(JSONData, status){
					//alert(status);
					//alert("JSONData : \n"+JSONData);
				
					var displayValue= "<h3>"+"�ֹ���: "+JSONData.orderDate+"<br>"
											+"��ǰ��: "+JSONData.purchaseProd.prodName+"<br>"
											+"������: "+JSONData.buyer.userId+"<br>";
							   displayValue += "��� �޴� ��: ";
			 				   displayValue += (JSONData.receiverName==null) ? "<br>" : JSONData.receiverName+"<br>"
			 						   
							   displayValue +=  "����ó: ";	   
							   displayValue += (JSONData.receiverPhone==null) ? "<br>" : JSONData.receiverPhone+"<br>"
									   
							   displayValue += "���Ű���: "+JSONData.soldPrice+"&nbsp;(���� : "+JSONData.purchaseProd.price+")<br>"
							   
							   displayValue +=  "��� ������ ��¥: ";	   
							   displayValue += (JSONData.divyDate==null) ? "<br>" : JSONData.divyDate+"<br>"
									   
							   displayValue +=   "��û����: ";
							   displayValue += (JSONData.divyRequest==null) ? "<br>" : JSONData.divyRequest+"<br>"
							   displayValue += "<hr>";
					if(JSONData.tranCode=='2  '){
						displayValue += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='/purchase/deletePurchase?tranNo="+JSONData.tranNo+"'>"+JSONData.purchaseProd.prodName+" ���� ���</a>";
						displayValue += "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='/purchase/updatePurchase?tranNo="+JSONData.tranNo+"'>������������</a>";
					}
					displayValue += "</h3>"
					$("#"+tranNo+"").html(displayValue);

				},
				error:function(jqXHR){
					alert("error : "+jqXHR.status);
				}
			})
			}
		})
		
		$('.ct_list_pop td:nth-child(3)').on("mousedown", function(){
			var prodNo = $($(this).next('td').html()).val();
			//location="/product/getProduct.do?prodNo="+prodNo;
			var tranNo = $($(this).prev('td').html()).val();
			console.log("tranNo : "+tranNo);
			if($( "#"+prodNo+"" ).html().length!=0){
				$("#"+prodNo+"").empty();	
			}else{
			$.ajax({
				url:"/product/json/getProduct/"+prodNo,
				method:"GET",
				dataType:"json",
				headers:{
					"Accept" : "application/json",
					"Content-Type":"application/json"
				},
				success: function(JSONData, status){
					//alert(status);
					//alert("JSONData : \n"+JSONData);
				
					var displayValue= "<h3><hr>"+"��ǰ��ȣ: "+JSONData.prodNo+"<br>"
															+"��ǰ��: "+JSONData.prodName+"<br>"
															+"�� ����: "+JSONData.prodDetail+"<br>"
															+"��ǰ �̹���: <img src='../images/uploadFiles/"+JSONData.fileName+"' width=200/><br>"
															+"����: "+JSONData.price+"<br>"
															+"������: "+JSONData.manuDate+"<br>"
															+"�����: "+JSONData.regDate+"<br>"
															+"<hr></h3>";

					$("#"+prodNo+"").html(displayValue);

				},
				error:function(jqXHR){
					alert("error : "+jqXHR.status);
				}
			})
			}
		})
		
		
		$('.ct_list_pop td:nth-child(11):contains("���ǵ���")').on("click", function(){
			var tranNo = $($(this).next('td').html()).val();
			location="/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=4";
		})
	})
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">��ü  ${resultPage.totalCount } �Ǽ�, ����${resultPage.currentPage } ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">�ֹ�����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��û����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">����Ȯ��</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

<c:set var="i" value="0" />
<c:forEach items="${list}" var="purchase">	
	<tr class="ct_list_pop">
			<td align="center">${i+1}</td>
			<%--<a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">${i+1}</a> --%>
		<c:set var="i" value="${i+1}"/>
		<td><input type="hidden" value="${purchase.tranNo}"/></td>
		<td align="left">
			${purchase.purchaseProd.prodName}
		</td>
		<td><input type="hidden" value="${purchase.purchaseProd.prodNo}"/></td>
		<td align="left">${purchase.orderDate}</td>
		<td></td>
		<td align="left">${purchase.divyRequest}</td>
		<td></td>
		<td align="left">����
				
				<c:choose>
				<c:when test="${purchase.tranCode=='2  '}">
				���� �Ϸ�
				</c:when>
				<c:when test="${purchase.tranCode=='3  '}">
				�����
				</c:when>
				<c:when test="${purchase.tranCode=='4  '}">
				��� �Ϸ�
				</c:when>
			</c:choose>
				���� �Դϴ�.</td>
		<td></td>
		<td align="left">
		<c:if test="${purchase.tranCode=='3  '}">
		���ǵ���
		</c:if>
		<c:if test="${purchase.tranCode=='4  '}">
		��ۿϷ�
		</c:if>
		</td>
		<td><input type="hidden" value="${purchase.tranNo}"/></td>
	</tr>
	<tr>
		<td id="${purchase.tranNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<tr>
		<td id="${purchase.purchaseProd.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
</c:forEach>

	
<%--<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr> --%>	
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>