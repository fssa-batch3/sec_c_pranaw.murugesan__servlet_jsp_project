<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.fssa.leavemanagement.model.EmployeeLeaveBalance"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Leave Balance</title>
<link rel="stylesheet" href="./asserts/css/employeeHeader.css">
<link rel="stylesheet" href="./asserts/css/employeeLeaveBalance.css">
</head>

<body>
	<jsp:include page="employeeHeader.jsp"></jsp:include>
	<main>
		<h1>Leave Balance</h1>
		<div class="range-container">
			<div class="range">
				<div class="range-fill" style="width: 20%;"></div>
			</div>
			<p class="range-label">Value: 50%</p>
		</div>
		<table class="styled-table">
			<thead>
				<tr>
					<th>Casual Leave</th>
					<th>Sick Leave</th>
					<th>Earned Leave</th>
				</tr>
			</thead>
			<tbody>
				<%
				EmployeeLeaveBalance elb = (EmployeeLeaveBalance) request.getAttribute("leaveBalance");
				if (elb != null) {
				%>
				<tr>
					<td><%=elb.getCasualLeaveBalance()%></td>
					<td><%=elb.getSickLeaveBalance()%></td>
					<td><%=elb.getEarnedLeaveBalance()%></td>
				</tr>
				<%
				}
				%>

			</tbody>
			</main>
</body>
</html>