<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.fssa.leavemanagement.model.EmployeeLeaveBalance"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Leave Balance</title>
<link rel="stylesheet" href="./assets/css/header.css">
<link rel="stylesheet" href="./assets/css/admin.css">
<style>
a {
	color: white;
	text-decoration: none;
}

main {
	padding-top: 100px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<main>
		<h1>Leave Balance</h1>
		<table class="styled-table">
			<thead>
				<tr>
					<th>Name</th>
					<th>Email</th>
					<th>Sick Leave</th>
					<th>Casual Leave</th>
					<th>Earned Leave</th>
				</tr>
			</thead>
			<tbody>

				<%
				List<EmployeeLeaveBalance> elb = (List<EmployeeLeaveBalance>) request.getAttribute("leaveBalance");
				if (elb != null) {
					for (EmployeeLeaveBalance e : elb) {
				%>
				<tr>
					<td><%=e.getName()%></td>
					<td><%=e.getEmail()%></td>
					<td><%=e.getSickLeaveBalance()%></td>
					<td><%=e.getCasualLeaveBalance()%></td>
					<td><%=e.getEarnedLeaveBalance()%></td>
				</tr>
				<%
				}
				}
				%>
			</tbody>
		</table>
	</main>
</body>
</html>