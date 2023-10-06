<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login Page</title>
</head>

<body>

	<div class="login-card">
		<h2>FreshLeave Login</h2>
		<form action="LoginServlet" method="post" id="login-form">
			<label for="user-type">Select User Type:</label> <select
				id="user-type" name="user-type">
				<option value="admin">Admin</option>
				<option value="employee">Employee</option>
			</select> <label for="email">Email:</label> <input type="email" id="email"
				name="email" required> <label for="password">Password:</label>
			<input type="password" id="password" name="password" required
				pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$"
				title="password must contain Uppercase,lowercase, 8 characters">
			<button type="submit">Login</button>
		</form>
	</div>

	<style>
/* Your existing CSS styles can be used with slight modifications. */
body {
	font-family: Arial, sans-serif;
	background-color: #f0f0f0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.login-card {
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	padding: 100px;
	text-align: center;
	width: 30%;
	margin: 10px;
}

.login-card h2 {
	margin-bottom: 20px;
	color: #333;
}

form {
	display: flex;
	flex-direction: column;
	align-items: center;
}

label {
	font-weight: bold;
	margin-bottom: 5px;
}

input[type="email"], input[type="password"], select {
	width: 100%;
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

button {
	background-color: #007BFF;
	color: #fff;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

button:hover {
	background-color: #0056b3;
}
</style>
	<jsp:include page="./alertMsg.jsp"></jsp:include>
</body>

</html>