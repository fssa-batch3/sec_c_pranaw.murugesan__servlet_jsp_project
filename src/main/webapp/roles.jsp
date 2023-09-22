<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.fssa.leavemanagement.model.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Roles</title>
<link rel="stylesheet" href="./assets/css/header.css">
<style>
body {
	background-color: #f9f7f7;
	overflow-x: hidden;
}

.titleList {
	margin-top: 2%;
	margin-left: 2%;
}
/* table for every page in admin section */
table {
	border-collapse: collapse;
	width: 100%;
	margin-top: 2%;
	/* max-width: 800px; Adjust as needed */
	/* margin: 0 auto; */
}

aside a {
	color: white;
	text-decoration: none;
}

aside button {
	margin-top: 20px;
}

.styled-table th {
	background-color: #f2f2f2;
	color: #333;
	font-weight: bold;
	padding: 10px;
	text-align: left;
	border-top: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
	/* padding-left: 50px; */
	text-align: center;
}

/* Alternating row colors */
.styled-table tbody tr:nth-child(even) {
	background-color: #f2f2f2;
}

/* Table data cell */
.styled-table td {
	padding: 20px;
	border-top: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
	text-align: center;
}

/* Edit button styling */
.edit-button {
	background-color: #007bff;
	color: white;
	border: none;
	padding: 8px 15px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px;
}

.edit-button:hover {
	background-color: #0056b3;
}

form {
	display: flex;
	flex-direction: column;
}
/* The top corner button (Add Employee) */
.addEmployeeDiv {
	background-color: #f5f5f5; /* Light background color */
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px;
}

.titleList {
	color: #333; /* Dark text color */
	margin: 0;
	font-size: 24px;
}

.add-button, .cancel-button, .submit-button {
	background-color: #007bff;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s;
}

.cancel-button {
	margin-top: 5%;
}

.add-button:hover {
	background-color: #0056b3;
}

/* Popup for add employee popup */
#popupContainer, #addPopupContainer {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	display: none;
	justify-content: center;
	align-items: center;
}

#popup {
	background-color: white;
	padding: 100px;
	width: 50%;
	/* Increased padding */
	border-radius: 10px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
}

form {
	display: grid;
	gap: 15px;
	/* Increased gap */
	font-size: 20px;
}

form>input {
	padding: 3%;
}

#closeForm {
	background-color: #007bff;
	color: white;
	border: none;
	padding: 12px 24px;
	/* Adjusted padding */
	border-radius: 5px;
	cursor: pointer;
}

#openForm {
	background-color: #007bff;
	color: white;
	border: none;
	padding: 12px 24px;
	/* Adjusted padding */
	border-radius: 5px;
	cursor: pointer;
}
/* Popup for adding a role */
.popup-container {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	justify-content: center;
	align-items: center;
}

.popup {
	background-color: white;
	padding: 20px;
	width: 60%;
	max-width: 400px;
	border-radius: 10px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
}

.popup h2 {
	font-size: 24px;
	margin-bottom: 20px;
}

.popup label {
	display: block;
	margin-bottom: 10px;
	font-weight: bold;
}

.popup input[type="text"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 16px;
}

.popup button.submit-button {
	background-color: #007bff;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s;
}

.popup button.submit-button:hover {
	background-color: #0056b3;
}

.popup button.cancel-button {
	background-color: #ccc;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s;
}

.popup button.cancel-button:hover {
	background-color: #999;
}

.delete-button {
	background-color: red;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s;
}

a {
	color: white;
	text-decoration: none;
	'
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<main>
		<!-- Popup for adding a role -->
		<div id="addRolePopupContainer" class="popup-container">
			<div id="addRolePopup" class="popup">
				<h2>Add Role</h2>
				<form action="EmployeeRoleServlet1" method="post">
					<label for="roleName">Role Name:</label> <input type="text"
						id="roleName" name="roleName" required>
					<button type="submit" class="submit-button">Submit</button>
					<button type="button" class="cancel-button" id="cancelAddRole">Cancel</button>
				</form>
			</div>
		</div>

		<div class="addEmployeeDiv">
			<h1 class="titleList">Roles List</h1>
			<button class="add-button" id="addEmployeeButton">Add Role</button>
		</div>
		<table class="styled-table">
			<thead>
				<tr>
					<th>S.No</th>
					<th>Role</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
				List<Role> roles = (List<Role>) request.getAttribute("ROLE_LIST");
				if (roles != null) {
					for (Role e : roles) {
				%>
				<%!static int sNo = 0;%>
				<tr>
					<td><%=++sNo%></td>
					<td><%=e.getName()%></td>
					<td><button class="delete-button">
							<a href="DeleteRoleServlet?name=<%=e.getName()%>">Delete</a>
						</button></td>
				</tr>
				<%
				}
				}
				%>


			</tbody>
		</table>
	</main>
	<footer> </footer>

	<script>
		//JavaScript to show and hide the add role popup
		document.addEventListener("DOMContentLoaded", function() {
			const addRoleButton = document.getElementById("addEmployeeButton");
			const addRolePopupContainer = document
					.getElementById("addRolePopupContainer");
			const cancelAddRoleButton = document
					.getElementById("cancelAddRole");

			addRoleButton.addEventListener("click", function() {
				addRolePopupContainer.style.display = "flex";
			});
			cancelAddRoleButton.addEventListener("click", function() {
				addRolePopupContainer.style.display = "none";
			});
		});
	</script>
</body>
</html>