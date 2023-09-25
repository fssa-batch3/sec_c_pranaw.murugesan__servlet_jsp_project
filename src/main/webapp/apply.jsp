<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.time.LocalDate"%>
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
		String EXCEEDS_LEAVE_BALANCE = "Number of days exceeds the leave balance";
		String success = (String) request.getAttribute("successMsg");
		if (success != null) {
		%>
		<h1 id="title" style="color: green">Applied Successfully, apply
			another ?</h1>
		<%
		}
		%>
		<h1 id="title">Apply for Leave</h1>
		<%
		String error = (String) request.getAttribute("error");
		if (error != null) {
			if (EXCEEDS_LEAVE_BALANCE.equals(error)) {
		%>
		<h2 id="errMsg">
			<%=error%>
			, Check your Balance <a id="checkHere" href="Dashboard">Here!</a>
		</h2>
		<%
		} else {
		%>
		<h2 id="errMsg">
			<%=error%>
		</h2>
		<%
		}
		}
		%>
		<form action="ApplyLeave" method="post">
			<label for="leaveType">Leave Type</label> <select name="leaveType"
				id="leaveType">
				<option value="CASUAL">Casual Leave</option>
				<option value="SICK">Sick Leave</option>
				<option value="EARNED">Earned Leave</option>
			</select> <label for="startDate">Start Date</label> <input type="date"
				name="startDate" id="startDate" class="date" required> <label
				for="endDate">End Date</label> <input type="date" name="endDate"
				id="endDate" class="date" required> <label for="noOfDays">No
				of Days:</label> <label style="color: red;">If it is a half day,
				change accordingly (ex. 0.5)</label> <input type="text" name="noOfDays"
				id="noOfDays" required readonly> <label for="reason">Reason</label>
			<textarea name="reason" id="reason" cols="30" rows="10" required
				placeholder="Type Reason"></textarea>
			<br>
			<button id="sumbit" type="submit">Submit</button>
		</form>
	</main>
	<script
		src="https://cdn.jsdelivr.net/gh/suryaumapathy2812/notify__js/notify.js">
		
	</script>
	<script>
		let startDateInput = document.getElementById("startDate");
		let endDateInput = document.getElementById("endDate");
		let noOfDaysInput = document.getElementById("noOfDays");
		let submitBtn = document.getElementById("sumbit");

		// Get all date input fields
		let dateInputs = document.querySelectorAll(".date");

		const today = new Date(Date.now() - new Date().getTimezoneOffset()
				* 60000).toISOString().split("T")[0];
		// Set the minimum date for each date input field
		dateInputs.forEach(function(dateInput) {
			dateInput.setAttribute("min", today);
		});

		function calculateDaysDifference() {
			let startDate = new Date(startDateInput.value);
			let endDate = new Date(endDateInput.value);

			if (endDate != "Invalid Date"
					&& startDate.getDate() == endDate.getDate()) {
				noOfDaysInput.removeAttribute("readonly");
				document.addEventListener("change",
						function() {
							if (noOfDaysInput.value != 1
									&& noOfDaysInput.value != 0.5) {
								alert("Please Enter no of Days 1 or 0.5");
								submitBtn.setAttribute("disabled", "");
							} else {
								submitBtn.removeAttribute("disabled");
							}
						});
			} else {
				noOfDaysInput.setAttribute("readonly", "");
			}

			// Calculate time difference
			let timeDifference = endDate.getTime() - startDate.getTime();

			// Calculate days difference by dividing total milliseconds in a day
			let daysDifference = timeDifference / (1000 * 60 * 60 * 24);

			let weekendDays = 0;

			for (let i = 0; i <= daysDifference; i++) {
				let currentDate = new Date(startDate);
				currentDate.setDate(startDate.getDate() + i);

				// Check if the current day is a Saturday or Sunday
				if (currentDate.getDay() === 0 || currentDate.getDay() === 6) {
					weekendDays++;
				}
			}

			// Subtract weekend days from the total days
			let totalDaysWithoutWeekends = daysDifference - weekendDays + 1;

			noOfDaysInput.value = totalDaysWithoutWeekends;
		}

		endDateInput.addEventListener("input", calculateDaysDifference);
		calculateDaysDifference();
	</script>

</body>

</html>
