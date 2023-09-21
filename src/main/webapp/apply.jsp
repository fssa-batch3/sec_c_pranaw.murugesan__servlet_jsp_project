<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Fresh Leave</title>
<link rel="stylesheet" href="./asserts/css/header.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="./asserts/css/employeeHeader.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins&family=Roboto&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="./asserts/css/apply.css">
</head>

<body>
	<jsp:include page="employeeHeader.jsp"></jsp:include>
	<main>
		<h1 id="title">Apply for Leave</h1>
		<form action="ApplyLeave" method="post">
			<label for="leaveType">Leave Type</label> <select name="leaveType"
				id="leaveType">
				<option value="CASUAL">Casual Leave</option>
				<option value="SICK">Sick Leave</option>
				<option value="EARNED">Earned Leave</option>
			</select> <label for="startDate">Start Date</label> <input type="date"
				name="startDate" id="startDate"> <label for="endDate">End
				Date</label> <input type="date" name="endDate" id="endDate"> <label
				for="noOfDays">No of Days:</label> <input type="number"
				name="noOfDays" id="noOfDays"> <label for="reason">Reason</label>
			<textarea name="reason" id="reason" cols="30" rows="10">Type Reason</textarea>
			<button>Submit</button>
		</form>
	</main>
</body>

</html>
