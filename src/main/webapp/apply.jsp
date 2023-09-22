<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Fresh Leave</title>
<link rel="stylesheet" href="./assets/css/header.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="./assets/css/employeeHeader.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/suryaumapathy2812/notify__js/notify.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins&family=Roboto&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="./assets/css/apply.css">




</head>
<body>
	<jsp:include page="employeeHeader.jsp"></jsp:include>
	<main>
		<%
		String success = (String) request.getAttribute("successMsg");
		if (success != null) {
		%>
		<h1 id="title" style="color: green">Applied Successfully, apply another ?</h1>
		<%
		}
		%>
		<h1 id="title">Apply for Leave</h1>
		<%
		String error = (String) request.getAttribute("error");
		if (error != null) {
		%>
		<h2 id="errMsg">
			<%=error%>
		</h2>
		<%
		}
		%>
		<form action="ApplyLeave" method="post">
			<label for="leaveType">Leave Type</label> <select name="leaveType"
				id="leaveType">
				<option value="CASUAL">Casual Leave</option>
				<option value="SICK">Sick Leave</option>
				<option value="EARNED">Earned Leave</option>
			</select> <label for="startDate">Start Date</label> <input type="date"
				name="startDate" id="startDate" required> <label
				for="endDate">End Date</label> <input type="date" name="endDate"
				id="endDate" required> <label for="noOfDays">No of
				Days:</label> <label style="color: red;">If it a half day, change
				accordingly</label> <input type="number" name="noOfDays" id="noOfDays"
				required> <label for="reason">Reason</label>
			<textarea name="reason" id="reason" cols="30" rows="10" required
				placeholder="Type Reason"></textarea>
			<br>
			<button type="submit">Submit</button>
		</form>
	</main>
	<script
		src="https://cdn.jsdelivr.net/gh/suryaumapathy2812/notify__js/notify.js">
		
	</script>
	<script>
		let startDateInput = document.getElementById("startDate");
		let endDateInput = document.getElementById("endDate");
		let noOfDaysInput = document.getElementById("noOfDays");

		function calculateDaysDifference() {
			let startDate = new Date(startDateInput.value);
			let endDate = new Date(endDateInput.value);

			// Calculate time difference
			let time_difference = endDate.getTime() - startDate.getTime();

			// Calculate days difference by dividing total milliseconds in a day
			let days_difference = time_difference / (1000 * 60 * 60 * 24);
			noOfDaysInput.value = days_difference + 1;
		}

		endDateInput.addEventListener("input", calculateDaysDifference);
		calculateDaysDifference();
	</script>
</body>

</html>
