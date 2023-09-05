<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="com.fssa.leavemanagement.model.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fresh Leave</title>
<link rel="stylesheet" href="./asserts/css/header.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins&family=Roboto&display=swap"
	rel="stylesheet">

<style>
/* Main Content Styles */
/* Reset some default styles */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: "Roboto", sans-serif;
}

/* Header Styles */
header {
	display: flex;
	justify-content: space-between;
	background-color: #007BFF;
	color: #fff;
	padding: 20px 0;
	text-align: center;
}

header h1 {
	margin-left: 20px;
	font-family: 'Roboto', sans-serif;
}

/* Signout button in the header */
.signout {
	background-color: transparent;
	border: none;
	color: #fff;
	cursor: pointer;
	font-size: 16px;
	margin-right: 30px;
}

header .signout:hover {
	text-decoration: none;
}
/* Sidebar Styles */
aside {
	background-color: #333;
	color: #fff;
	min-height: 100vh;
	position: absolute;
	width: 13%;
	padding: 20px 0;
	text-align: center;
}

aside ul {
	list-style-type: none;
	padding: 0;
}

aside li {
	margin: 0;
	padding: 0;
	list-style: none;
	padding-top: 10%;
}

aside button {
	background-color: transparent;
	border: none;
	color: #fff;
	padding: 10px 0;
	width: 100%; /* Full-width buttons */
	cursor: pointer;
	transition: background-color 0.3s ease;
	font-size: 16px;
}

aside button:hover {
	background-color: #555;
}

.signout {
	font-size: larger;
	background-color: transparent;
	border: none;
}

main {
	margin-left: 14%;
	margin-right: 2%;
	padding-top: 1%;
}

.addEmployeeDiv {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.titleList {
	font-size: 24px;
	color: #333;
}

.add-button {
	background-color: #007BFF;
	color: #fff;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	cursor: pointer;
	font-size: 16px;
}

.add-button:hover {
	background-color: #0056b3;
}

#addPopupContainer {
	display: none;
	justify-content: center;
	align-items: center;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 1;
}

#popup {
	background-color: #fff;
	padding: 30px;
	border-radius: 5px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

form label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

form input[type="text"], form input[type="email"], form input[type="password"],
	form select {
	width: 100%;
	padding: 10px;
	margin-bottom: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.submit-button {
	background-color: #007BFF;
	color: #fff;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	cursor: pointer;
	font-size: 16px;
}
/* Edit Popup Styles */
.edit-popup {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 2;
}

.edit-popup-content {
	background-color: #fff;
	width: 70%;
	max-width: 600px;
	margin: 10% auto;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

.cancel-button {
	margin-top: 10px;
	display: block; /* Ensure the button takes up the full width */
	width: 100%; /* Make the button full-width */
	background-color: #ccc;
	color: #fff;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	cursor: pointer;
	font-size: 16px;
	margin-top: 10px;
}

.cancel-button:hover {
	background-color: #999;
}

.styled-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

.styled-table th, .styled-table td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

.styled-table th {
	background-color: #007BFF;
	color: #fff;
}

.edit-button {
	background-color: #007BFF;
	color: #fff;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	cursor: pointer;
	font-size: 16px;
}

.edit-button:hover {
	background-color: #0056b3;
}
</style>

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
		<div class="addEmployeeDiv">
			<h1 class="titleList">Employee List</h1>
			<button class="add-button" id="addEmployeeButton">Add
				Employee</button>
		</div>
		<div id="addPopupContainer">
			<div id="popup">
				<form action="EmployeeServlet1" method="post">
					<label for="name">Name:</label> <input type="text" name="name"
						id="name" required> <label for="email">Email:</label> <input
						type="email" name="email" id="email" required> <label
						for="password">Password:</label> <input type="password"
						name="password" id="password" required> <label
						for="manager">Manager:</label> <input type="text" name="manager"
						id="manager"> <label for="cars">Role:</label> <select
						name="role" id="role">
						<option value="CEO">CEO</option>
						<option value="HR">HR</option>
						<option value="MANAGER">MANAGER</option>
						<option value="TEAMLEAD">TEAMLEAD</option>
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
				List<Employee> employeeList = (List<Employee>) request.getAttribute("EMPLOYEE_LIST");

				if (employeeList != null) {
					for (Employee e : employeeList) {
				%>
				<%!int sNo = 0;%>
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
					<label for="manager">Manager:</label> <input type="text"
						name="manager" id="managerUpdate" value="<%=emp.getManager()%>">
					<button class="add-button" onclick="setFormUpdate()">
						Update</button>
					<button class="add-button">Delete</button>
					<button onclick="setFormDelete()" class="cancel-button"
						id="closeEditPopup">Close</button>



				</form>
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

	<script>
		// Function to open the Add Employee popup
		function openAddEmployeePopup() {
			const addPopupContainer = document
					.getElementById("addPopupContainer");
			addPopupContainer.style.display = "flex";
		}

		// Function to close the Add Employee popup
		function closeAddEmployeePopup() {
			const addPopupContainer = document
					.getElementById("addPopupContainer");
			addPopupContainer.style.display = "none";
		}

		// Function to close the Edit popup
		function closeEditPopup() {
			const editPopup = document.querySelector(".edit-popup");
			editPopup.style.display = "none";
		}

		// Event listeners
		const addEmployeeButton = document.getElementById("addEmployeeButton");
		const closePopupButton = document.getElementById("closePopup"); // Use the correct ID
		const closeEditPopupButton = document.getElementById("closeEditPopup");

		if (addEmployeeButton) {
			addEmployeeButton.addEventListener("click", openAddEmployeePopup);
		}

		if (closePopupButton) { // Use the correct button variable
			closePopupButton.addEventListener("click", closeAddEmployeePopup);
		}

		if (closeEditPopupButton) {
			closeEditPopupButton.addEventListener("click", closeEditPopup);
		}

		const updateForm = document.getElementById("updateForm");
		function setFormUpdate() {
			const email = document.getElementById("emailUpdate").value;
			const name = document.getElementById("nameUpdate").value;
			const manager = document.getElementById("managerUpdate").value;
			const password = document.getElementById("passwordUpdate").value;

			updateForm.action = `UpdateServlet?email=${email}&name=${name}&manager=${manager}&password=${password}`;
		}
		function setFormDelete() {
			const email = document.getElementById("emailUpdate").value;
			updateForm.action = `DeleteServlet?email=${email}`;
		}
	</script>




</body>
</html>