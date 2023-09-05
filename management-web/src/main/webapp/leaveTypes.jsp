<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.fssa.leavemanagement.model.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="./asserts/css/admin.css">
<link rel="stylesheet" href="./asserts/css/header.css">
</head>
<body>
	<header>
		<div>
			<h1>Fresh Leave</h1>
		</div>
		<div>
			<button class="signout">sign out</button>
		</div>
	</header>
	<aside>
		<ul>
			<button type="button" class="btn btn-light">
				<a href="EmployeeServlet1">Employees</a>
			</button>
			<button type="button" class="btn btn-light">
				<a href="EmployeeRoleServlet1">Roles</a>
			</button>
			<button type="button" class="btn btn-light">
				<a href="leaveTypes.jsp">Leave Types</a>
			</button>
		</ul>
	</aside>
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
	<footer> </footer>
</body>
</html>