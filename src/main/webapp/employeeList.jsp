<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="com.fssa.leavemanagement.model.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fresh Leave</title>
<link rel="stylesheet" href="./assets/css/header.css">
<link rel="stylesheet" href="./assets/css/employeeList.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins&family=Roboto&display=swap"
	rel="stylesheet">
</head>
<body>


	<jsp:include page="header.jsp"></jsp:include>
	<main>

		<div class="addEmployeeDiv">
			<div>
				<h1 class="titleList">Employee List</h1>
			</div>
			<div style="display: flex; padding-right: 10px" class="secDiv">
				<form>
					<input type="search" name="searchname" id="search"
						placeholder="Search names">
				</form>
				<button class="add-button" id="addEmployeeButton">Add
					Employee</button>
			</div>
		</div>

		<div id="addPopupContainer">
			<div id="popup">
				<form action="EmployeeServlet1" method="post">
					<label for="name">Name:</label> <input type="text" name="name"
						id="name" required> <label for="email">Email:</label> <input
						type="email" name="email" id="email" required
						pattern="^[A-Za-z0-9+_.-]+@([A-Za-z0-9+_.-]+\\.)?freshworks\\.com$"
						title="email should be freshworks email"> <label
						for="password">Password:</label> <input type="password"
						name="password" id="password" required> <label
						for="manager">Manager:</label> <input list="managerList"
						name="manager" id="manager" required>
					<datalist id="managerList">
						<%
						List<Employee> employeeList = (List<Employee>) request.getAttribute("EMPLOYEE_LIST");
						List<Role> roleList = (List<Role>) request.getAttribute("ROLE_LIST");
						if (employeeList != null) {
							for (Employee e : employeeList) {
						%>

						<option value="<%=e.getEmail()%>"><%=e.getEmail()%></option>

						<%
						}
						}
						%>
					</datalist>
					<label for="role">Role:</label> <select name="role" id="role">

						<%
						if (roleList != null) {
							for (Role e : roleList) {
						%>
						<option value="<%=e.getName()%>"><%=e.getName()%></option>
						<%
						}
						}
						%>
					</select>
					<button type="submit" class="submit-button">Add</button>
				</form>
				<button class="cancel-button" id="closePopup">Cancel</button>
			</div>
		</div>

		<table class="styled-table">
			<thead>
				<tr>
					<th>S.No</th>
					<th>Name</th>
					<th>Email</th>
					<th>Manager</th>
					<th>Date of Joining</th>
					<th>Active</th>
					<th>Date of Relieving</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
				Integer sNo = (Integer) session.getAttribute("sNo");

				if (employeeList != null) {
					for (Employee e : employeeList) {
				%>
				<tr>
					<td><%=++sNo%></td>
					<td><%=e.getName()%></td>
					<td><%=e.getEmail()%></td>

					<%
					if (e.getManager() == null) {
					%>
					<td>-</td>
					<%
					} else {
					%>

					<td><%=e.getManager()%></td>
					<%
					}
					%>
					<td><%=e.getDateOfJoining()%></td>
					<%
					if (e.isStatus()) {
					%>
					<td>Working</td>
					<%
					} else {
					%>
					<td>Not Working</td>
					<%
					}
					if (e.getDateOfRelieving() == null) {
					%>
					<td>-</td>
					<%
					} else {
					%>
					<td><%=e.getDateOfRelieving()%></td>
					<%
					}
					%>


					<td><a
						href="./EmployeeServlet1?action=edit&email=<%=e.getEmail()%>"
						class="edit-button">Edit</a></td>


					<%
					}
					}
					%>
				
			</tbody>
		</table>

		<%
		Employee emp = (Employee) request.getAttribute("employee");
		if (emp != null) {
		%>

		<div class="edit-popup" id="editPopup">
			<div class="edit-popup-content">
				<form id="updateForm" method="post">

					<label for="name">Name:</label> <input type="text" name="name"
						id="nameUpdate" value="<%=emp.getName()%>"> <label
						for="email">Email:</label> <input type="email" name="email"
						id="emailUpdate" value="<%=emp.getEmail()%>"> <label
						for="password">Password:</label> <input type="password"
						name="password" id="passwordUpdate" value="<%=emp.getPassword()%>">
					<label for="manager">Manager:</label> <input list="brow"
						id="managerUpdate" name="manager" value="<%=emp.getManager()%>"
						type="email">
					<datalist id="brow">
						<%
						if (employeeList != null) {
							for (Employee e : employeeList) {
						%>

						<option value="<%=e.getEmail()%>">

							<%
							}
							}
							%>
						
					</datalist>
					<button class="add-button" onclick="setFormUpdate()">
						Update</button>
					<button onclick="setFormDelete()" class="add-button">Delete</button>
				</form>
				<button class="cancel-button" id="closeEditPopup">Close</button>
			</div>
		</div>

		<script>
			const dis = document.querySelector(".edit-popup");
			dis.style.display = "block";
		</script>
		<%
		}
		%>
	</main>
	<footer> </footer>

	<script src="./assets/js/employeeList.js"></script>

	<%
	String error = (String) request.getAttribute("errorMsg");
	if (error != null) {
	%>
	<script>
	
	swal("Failed !","<%=error%>", "error");
	</script>

	<%
	}
	%>
	<jsp:include page="./alertMsg.jsp"></jsp:include>
</body>
</html>