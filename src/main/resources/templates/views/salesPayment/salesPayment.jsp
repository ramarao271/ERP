<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ERP Software</title>
<c:url value="/resources/js/global.js" var="globaljs" />
<script type="text/javascript" src="${globaljs}"></script>
<c:url value="/resources/js/Items.js" var="itemsjs" />
<script type="text/javascript" src="${itemsjs}"></script>
<c:url value="/resources/css/global.css" var="stylecss" />
<link href="${stylecss}" rel="stylesheet" />
<c:url value="/resources/js/datepickr.js" var="datejs" />
<script type="text/javascript" src="${datejs}"></script>
<c:url value="/resources/css/datepickr.css" var="datecss" />
<link href="${datecss}" rel="stylesheet" />
<c:url value="/resources/overlay/jquery-1.11.2.min.js" var="jqueryjs" />
<script type="text/javascript" src="${jqueryjs}"></script>
<c:url value="/resources/overlay/custom.js" var="customjs" />
<script type="text/javascript" src="${customjs}"></script>
<c:url value="/resources/overlay/overlaypopup.css" var="popcss" />
<link type="text/css" rel="stylesheet" href="${popcss}" />
<c:url value="/resources/autocomplete/jquery.ui.all.css" var="jquerycss" />
<link rel="stylesheet" href="${jquerycss}">
<c:url value="/resources/autocomplete/jquery.ui.core.js"
	var="jquerycorejs" />
<script src="${jquerycorejs}"></script>
<c:url value="/resources/autocomplete/jquery.ui.widget.js"
	var="jquerywidgetjs" />
<script src="${jquerywidgetjs}"></script>
<c:url value="/resources/autocomplete/jquery.ui.position.js"
	var="positionjs" />
<script src="${positionjs}"></script>
<c:url value="/resources/autocomplete/jquery.ui.menu.js" var="menujs" />
<script src="${menujs}"></script>
<c:url value="/resources/autocomplete/jquery.ui.autocomplete.js"
	var="autojs" />
<script src="${autojs}"></script>
<c:url value="/resources/autocomplete/demos.css" var="democss" />
<link rel="stylesheet" href="${democss}">
<c:url value="/resources/autocomplete/images/ui-anim_basic_16x16.gif"
	var="imag" />
<style>
.ui-autocomplete-loading {
	background: white url('${imag}') right center no-repeat;
}
</style>
<script>
	var serial = 0;
	function setSerialNo(val) {
		serial = val;
	}
	function setCustomerId(value) {
		var customerId = "customerId" + value;
		document.getElementById("customerBean.customerId").value = document
				.getElementById(customerId).value;
		//listInvoices(customerId,"sales");
	}

	$(function() {
		function log(message) {
			$("<div>").text(message).prependTo("#log");
			$("#log").scrollTop(0);
		}

		$("#cityx").autocomplete({
			source : function(request, response) {
				$.ajax({
					url : "/ERPSoftware/salesPayment/listSPCustomers.jsp",
					dataType : "json",
					data : {
						style : "full",
						maxRows : 12,
						name_startsWith : request.term
					},
					success : function(data) {
						response($.map(data, function(item) {
							return {
								value : item.companyName,
								id : item.customerId,
							};
						}));
					}
				});
			},
			minLength : 1,
			select : function(event, ui) {
				loadBranches(ui.item.value);
				$(".customerId").val(ui.item.id);
			},
			open : function() {
				$(this).removeClass("ui-corner-all").addClass("ui-corner-top");
			},
			close : function() {
				$(this).removeClass("ui-corner-top").addClass("ui-corner-all");
			}
		});
	});
	function loadBranches(branch) {
		var cusid="";
		var company = branch;
		var flag=0;
		if (company == undefined) {
			flag=1;
			company = $("#cityx").val();
		}
		var items = [];
		$
				.ajax({
					url : "/ERPSoftware/salesPayment/listSPCustomers.jsp",
					dataType : "json",
					data : {
						style : "full",
						maxRows : 12,
						company : company
					},
					success : function(data) {
						var items = [];
						var sids = [];
						var i = 0;
						$
								.each(
										data,
										function(key, val) {
											var sid = $(".customerId").val();
											cusid=sid;
											if (i == 0) {
												if (sid == undefined) {
													$(".customerId").val(
															val.customerId);
													cusid=val.customerId;
												}
												i++;
											}
											if(val.companyBranch!=undefined)
											{
										
											if (sid == val.customerId) {

												items
														.push("<option selected='true' value='" + val.companyBranch + "'>"
																+ val.companyBranch
																+ "</option>");

											} else {
												items
														.push("<option value='" + val.companyBranch + "'>"
																+ val.companyBranch
																+ "</option>");
											}
											sids
													.push("<input type='hidden' value='"+val.customerId+"' id='customerId"+val.companyBranch+"' />");
											}
										});
						$cname = $("select[class='branch']");
						$("select[class='branch'] option").remove();
						$(items.join("")).appendTo($cname);
						$("#branchSids").append(sids.join(""));
						if (flag==0) {
						listInvoices(cusid,"sales");
						}
					}
				});

	}
	function calculateCost()
	{
		var total=0.0;
		for(var i=0;;i++)
			{
				var totalCost="salesPaymentItemBeans"+i+".paid";
				if(document.getElementById(totalCost)==null || document.getElementById(totalCost)==undefined)
				{
					break;	
				}
				totalCost=(parseFloat(document.getElementById(totalCost).value) || 0); 
				total+=parseFloat(totalCost);
			}
		var advance=document.getElementById("advance").value;
		document.getElementById("totalCost").value=((parseFloat(total) || 0)+parseFloat(advance || 0)).toFixed(2);
	}
</script>
</head>
<body onload="loadBranches()">
	<h3>
		<b><c:if test="${!empty operation}">
				<c:out value="${operation}" />
			</c:if> Sales Payment</b>
	</h3>
	<br />
	<form:form name="paymentForm" method="POST"
		action="/ERPSoftware/salesPayment/saveSalesPayment.html"
		modelAttribute="salesPaymentBean">
		<form:hidden path="customerBean.customerId" class="customerId" />
		<table cellpadding="0" cellspacing="5">
			<tr>
				<td>Select Customer Company</td>
				<td colspan="3"><form:input path="customerBean.companyName"
						id="cityx" /></td>
			</tr>
			<tr>
				<td>Company Branch</td>
				<td colspan="3"><form:select path="customerBean.companyBranch"
						class="branch" onchange="setCustomerId(this.value)"></form:select>
					<div id="branchSids"></div></td>
			</tr>
			<tr>
				<td><form:label path="salesPaymentDate">Sales Payment Date:</form:label></td>
				<td><fmt:formatDate var="formattedDate" pattern="MM-dd-yyyy"
						value="${salesPaymentBean.salesPaymentDate}" /> <form:input
						path="salesPaymentDate" value="${formattedDate}" /> <script
						type="text/javascript">
							new datepickr('salesPaymentDate', {
								'dateFormat' : 'm-d-y'
							});
						</script> <form:errors path="salesPaymentDate" cssStyle="color: #ff0000;" /></td>
			</tr>
			<tr>
				<td>Payment Mode</td>
				<td><form:select path="paymentMode">
						<c:forEach items="${pTypes}" var="vTypes">
							<c:choose>
								<c:when test="${salesPaymentBean.paymentMode eq vTypes}">
									<form:option selected="true" value="${vTypes}" />
								</c:when>
								<c:otherwise>
									<form:option value="${vTypes}" />
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</form:select>
				</td>
			</tr>
			<tr><td>Advance</td>
			<td><form:input path="advance" value="${advance}" onkeyup="calculateCost()" onchange="calculateCost()"  /></td>
			</tr>
			<tr>
				<td colspan="2">
					<table border=1 cellpadding=0 cellspacing=2>
						<tr>
							<td>Invoice No</td>
							<td>Date</td>
							<td>Bill Amount</td>
							<td>Adjusted Amount</td>
							<td>Paid Amount</td>
							<td>Amount</td>
							<td>Processed</td>
						</tr>
						<c:forEach items="${salesInvoiceBeans}" var="salesInvoiceBean"
							varStatus="itemsRow">
							<tr>
								<td><form:hidden
										path="salesPaymentItemBeans[${itemsRow.index}].salesInvoiceId" value="${salesInvoiceBean.salesInvoiceId}"/>
									<form:hidden path="salesPaymentItemBeans[${itemsRow.index}].salesInvoiceFinYear" value="${salesInvoiceBean.finYear}" />
										<c:out value="${salesInvoiceBean.salesInvoiceId }"/>
								</td>
								<td><c:out value="${salesInvoiceBean.salesInvoiceDate }"/></td>
								<td><c:out value="${salesInvoiceBean.totalCost }"/></td>
								<td><c:out value="${salesInvoiceBean.returnAmount }"/></td>
								<td><c:out value="${salesInvoiceBean.paidAmount }"/></td>
								<td><form:input
										path="salesPaymentItemBeans[${itemsRow.index}].paid"
										value="${i.paid}" class="product_quantity" type="number"
										step="0.01" onkeyup="calculateCost()"
										onchange="calculateCost()" /> <form:errors
										path="salesPaymentItemBeans[${itemsRow.index}].paid"
										cssStyle="color: #ff0000;" /></td>
								<td><form:checkbox path="salesPaymentItemBeans[${itemsRow.index}].processed"></form:checkbox></td>
								<form:hidden path="salesPaymentItemBeans[${itemsRow.index}].srNo"
									value="${itemsRow.index}" class="product_Srno" />
									<form:hidden path="salesPaymentItemBeans[${itemsRow.index}].salesPaymentId"
									value="${i.salesPaymentId}" class="product_Srno" />
							</tr>
						</c:forEach>
					</table>
				</td>
			</tr>
			<tr>
				<td><form:label path="totalCost">Total Cost:</form:label></td>
				<td align="right"><form:input path="totalCost"
						value="${salesPaymentBean.totalCost}" class="totalCost"
						type="number" readonly="true" /></td>
			</tr>
		</table>
		<form:hidden path="salesPaymentId"
			value="${salesPaymentBean.salesPaymentId}" />
		<input type="submit" value="Submit" />&nbsp;<input type="button"
			name="cancel" value="Cancel" onclick="loadIndex('salesPayment')" />
	</form:form>

	<div class="overlay-bg"></div>
	<div class="overlay-content popup1">
		<iframe src="/ERPSoftware/product/ProductSelectionList/salesPaymentItemBeans"
			frameborder="0" scrolling="auto" width="95%" height="350px"></iframe>
	</div>
</body>
</html>