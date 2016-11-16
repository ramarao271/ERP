<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:url value="/resources/css/global.css" var="stylecss" />
<link href="${stylecss}" rel="stylesheet" />
<c:url value="/resources/js/global.js" var="confirmjs" />
<script type="text/javascript" src="${confirmjs}"></script>
<c:url value="/resources/reports/table.css" var="tablecss" />
<link href="${tablecss}" rel="stylesheet" />

<title>All Products</title>
<script type="text/javascript">
	function load() {
		var msg = '<c:if test="${!empty message}"><c:out value="${message}" /></c:if>';
		if (msg != "")
			alert(msg);
	}
</script>
<c:url value="/resources/img/b_delete.png" var="deleteImg" />
<c:url value="/resources/img/b_edit.png" var="editImg" />
<c:url value="/resources/img/b_add.png" var="addImg" />
<c:url value="/resources/img/add-small.png" var="variantImg" />

</head>
<body onload="load()">
	<c:if test="${!empty customers}">
	<h3>Accounts Receivable</h3>
		<div class="scrollingtable">
			<div>
				<div>
					<table>
						<thead>
							<tr>
								<th><div label="Company"></div></th>
								<th><div label="Bill Amount"></div></th>
								<th><div label="Returned Amount"></div></th>
								<th><div label="Final Amount"></div></th>
								<th><div label="Paid Amount"></div></th>
								<th><div label="Balance"></div></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${customers}" var="customer">
								<tr>
									<td><c:out value="${customer.companyName}" /></td>
									<td><c:out value="${customer.totalAmount}" /></td>
									<td><c:out value="${customer.returnAmount}" /></td>
									<td><c:choose><c:when test="${customer.returnAmount >0 }" ><c:out value="${customer.adjustedAmount}" /></c:when><c:otherwise><c:out value="${customer.totalAmount}" /></c:otherwise></c:choose></td>
									<td><c:out value="${customer.paidAmount}" /></td>
									<td><c:out value="${customer.currentBalance}" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</c:if>
</body>
</html>