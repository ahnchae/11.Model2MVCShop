
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%--
<%@page import="com.model2.mvc.service.domain.Purchase"%>
<% Purchase purchase = (Purchase)request.getAttribute("purchase");%>
 --%>


<html>
<head>
	<meta charset="EUC-KR">
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">	
		$(function(){
			$('td.ct_btn01:contains("Ȯ��")').on("click", function(){
				location="/product/listProduct?menu=search";
			})
		});
	</script>
	
<title>���ſϷ�</title>
</head>

<body>

<form name="updatePurchase" action="/listProduct?menu=search" method="post">

������ ���� ���Ű� �Ǿ����ϴ�.

<table border=1>
	<tr>
		<td>��ǰ��ȣ</td>
		<td>${purchase.purchaseProd.prodNo}<%--<%= purchase.getPurchaseProd().getProdNo() --%></td>
		
		<td></td>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<td>${purchase.buyer.userId}<%--<%= purchase.getBuyer().getUserId() --%></td>
		<td></td>
	</tr>
	<tr>
		<td>���Ź��</td>
		<td>
		
		<c:if test="${param.paymentOption=='1'}">
		���ݰ���
		</c:if>
		<c:if test="${param.paymentOption=='2'}">
		�ſ����
		</c:if>
		
		</td>
		<td></td>
	</tr>
	<tr>
		<td>��ǰ ����</td>
		<td>${purchase.purchaseProd.price}</td>
		<td></td>
	</tr>
	<tr>
		<td>���� ����</td>
		<td>${purchase.soldPrice}</td>
		<td></td>
	</tr>
	<tr>
		<td>�������̸�</td>
		<td>${purchase.buyer.userName}<%--<%= purchase.getBuyer().getUserName() --%></td>
		<td></td>
	</tr>
	<tr>
		<td>�����ڿ���ó</td>
		<td>${purchase.receiverPhone}<%--<%= purchase.getBuyer().getPhone() --%></td>
		<td></td>
	</tr>
	<tr>
		<td>�������ּ�</td>
		<td>${purchase.divyAddr}<%--<%= purchase.getBuyer().getAddr() --%></td>
		<td></td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<td>${purchase.divyRequest}<%--<%= purchase.getDivyRequest()--%></td>
		<td></td>
	</tr>
	<tr>
		<td>����������</td>
		<td>${purchase.divyDate}<%--<%=purchase.getDivyDate()--%></td>
		<td></td>
	</tr>
	

</table>
	<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="30"></td>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						Ȯ��
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif"width="14" height="23"/>
					</td>
				</tr>
	</table>
</form>

</body>
</html>