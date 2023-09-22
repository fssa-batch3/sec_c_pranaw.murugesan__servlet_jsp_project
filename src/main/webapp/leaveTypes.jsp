<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.fssa.leavemanagement.model.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="./assets/css/admin.css">
<link rel="stylesheet" href="./assets/css/header.css">
<style>
a {
	color: white;
	text-decoration: none;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<main>
		<h1 class="titleList">Leave List</h1>
		<table class="styled-table">
			<thead>
				<tr>
					<th>S.No</th>
					<th>Name</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%

				%>
				<tr>
					<td>1</td>
					<td><%=LeaveTypes.CASUAL.getName()%></td>
					<td>Edit</td>
				</tr>
				<tr>
					<td>2</td>
					<td><%=LeaveTypes.SICK.getName()%></td>
					<td>Edit</td>
				</tr>
				<tr>
					<td>3</td>
					<td><%=LeaveTypes.EARNED.getName()%></td>
					<td>Edit</td>
				</tr>

			</tbody>
		</table>
	</main>
</body>
</html>